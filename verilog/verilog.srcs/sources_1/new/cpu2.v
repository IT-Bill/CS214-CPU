`timescale 1ns / 1ps

module cpu (
    input clock,
    input rst,
    input [3:0] row,
    input [23:0] switch,
    output [23:0] led,
    output reg [3:0] col,
    output [7:0] seg_en,
    output [7:0] seg_out
);

    wire clk;
    clkout cf (
        .clk(clock),
        .rst(rst),
        .clk_out(clk)
    );

    // input of ifetch
    wire [31:0] Addr_result;
    wire [31:0] Zero;  // ????
    wire [31:0] Read_data_1;
    wire Branch;
    wire nBranch;
    wire Jmp;
    wire Jal;
    wire Jr;

    // output of ifetch
    wire [31:0] Instruction;
    wire [31:0] branch_base_addr;
    wire [31:0] link_addr;
    
    Ifetc32 ifetch (
        .clock(clk),
        .reset(rst),
        .Addr_result(Addr_result),
        .Zero(Zero),
        .Read_data_1(Read_data_1),
        .Branch(Branch),
        .nBranch(nBranch),
        .Jmp(Jmp),
        .Jal(Jal),
        .Jr(Jr),
        
        .Instruction(Instruction),
        .branch_base_addr(branch_base_addr),
        .link_addr(link_addr)
    );

    // input of decoder
    wire [31:0] r_wdata;  // from MemOrIO
    wire [31:0] ALU_result;
    wire RegWrite, MemtoReg, RegDst;
    // output of decoder
    wire [31:0] read_data_1, read_data_2;
    wire [31:0] imme_extend;

    decode32 idecode(
        .Instruction(Instruction),
        .mem_data(r_wdata),
        .ALU_result(ALU_result),
        .Jal(Jal),
        .RegWrite(RegWrite),
        .MemtoReg(MemtoReg),
        .RegDst(RegDst),
        .clock(clk),
        .reset(rst),
        .opcplus4(link_addr),

        .read_data_1(read_data_1), 
        .read_data_2(read_data_2), 
        .Sign_extend(imme_extend)  
    );

    // input of control32
    wire [5:0] Opcode;
    wire [5:0] Function_opcode;
    wire [21:0] Alu_resultHigh;
    // output of control32
    wire MemWrite;
    wire ALUSrc;
    wire I_format;
    wire Sftmd;
    wire[1:0] ALUOp;
    wire MemorIOtoReg;     // 1 indicates that data needs to be read from memory or I/O to the register
    wire MemRead;          // 1 indicates that the instruction needs to read from the memory
    wire IORead;           // 1 indicates I/O read
    wire IOWrite;

    assign Opcode          = Instruction[31:26];
    assign Function_opcode = Instruction[5:0];
    assign Alu_resultHigh  = ALU_result[31:10];

    control32 ctrl(
        .Opcode(Opcode), 
        .Function_opcode(Function_opcode), 
        .Alu_resultHigh(Alu_resultHigh), 

        .Jr(Jr),
        .Jmp(Jmp),
        .Jal(Jal),
        .Branch(Branch),
        .nBranch(nBranch),
        .RegDST(RegDst),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .I_format(I_format),
        .Sftmd(Sftmd),
        .ALUOp(ALUOp),
        .MemorIOtoReg(MemorIOtoReg),
        .MemRead(MemRead),
        .IORead(IORead),
        .IOWrite(IOWrite)
    );

    wire [4:0] Shamt = Instruction[10:6];
    executs32 alu(
        //from decoder
        .Read_data_1(read_data_1),
        .Read_data_2(read_data_2),
        .Sign_extend(imme_extend),
        //from ifetch
        .Function_opcode(Function_opcode),
        .PC_plus_4(branch_base_addr),
        .Shamt(Shamt),
        .Exe_opcode(Opcode),
        //from controller
        .ALUOp(ALUOp),
        .Sftmd(Sftmd),
        .ALUSrc(ALUSrc),
        .I_format(I_format),
        .Jr(Jr),
        //output
        .Zero(Zero),
        .ALU_Result(ALU_result),
        .Addr_Result(Addr_result)
    );

    //input of memory
    wire[31:0] addr_out;    //from memio
    wire[31:0] write_data;  //from memio
    //output
    wire[31:0] read_data;
    dmemory32 memory(
        .clock(clk),
        .memWrite(MemWrite),
        .address(addr_out),
        .writeData(write_data),
        .readData(read_data)   //output: to memroio
    );

    //input
    wire[15:0] iodata;
    wire[15:0] switchrdata; //data from switchio
    assign iodata = switchrdata;
    
    //output of memorio
    wire LEDCtrl; // LED Chip Select
    wire SwitchCtrl; // Switch Chip Select

    MemOrIO memio(
        .mRead(MemRead),    // read memory, from control32
        .mWrite(MemWrite),  // write memory, from control32
        .ioRead(IORead),    // read IO, from control32
        .ioWrite(IOWrite),  // write IO, from control32
        .addr_in(ALU_result),   //from alu
        .m_rdata(read_data),    //from memory
        .io_rdata(iodata),    //data read from hardware, switch or something
        .r_rdata(read_data_2), // data read from idecode32(register file)(read_data_2)!!!!!!!!!?

        .r_wdata(r_wdata),
        .addr_out(addr_out),    //output and follows are they
        .write_data(write_data),    //io_wdata, output
        .LEDCtrl(LEDCtrl),
        .SwitchCtrl(SwitchCtrl)
    );

    leds ledoutput(
        .led_clk(clk),
        .ledrst(rst),
        .ledwrite(IOWrite),   //from controller(IOWrite)
        .ledcs(LEDCtrl),
        .ledaddr(addr_out[1:0]), // from memorio
        .ledwdata(write_data[15:0]),    //from memio(id_rdata)
        .ledout(led[23:0])
    );

    switchs switchinput(
        .switclk(clk),
        .switrst(rst),
        .switchcs(SwitchCtrl),
        .switchaddr(addr_out[1:0]), //
        .switchread(IORead),  //from controller (IORead)
        .switchrdata(switchrdata), //output
        .switch_i(switch[23:0])
    );

    show sst( 
        .clk(clk),
        .rst(rst),
        .ledwdata(led[23:0]),
        .seg_en(seg_en),
        .seg_out(seg_out)
    );


endmodule