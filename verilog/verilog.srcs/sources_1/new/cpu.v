`timescale 1ns / 1ps

module cpu (
    input fpga_clk,
    input fpga_rst, // Active High
    input play,
    input [3:0] row, 
    input [23:0] switch,
    output [23:0] led,
    output [3:0] col,
    output [7:0] seg_en,
    output [7:0] seg_out,
    
    input start_pg, // Active High
    input rx, // receive data from UART
    output tx, //  send data to UART
    output pwm // buzzer output pwm
);

    wire cpu_clk;
    wire show_clk;
    
   //UART
   wire upg_clk;
   wire upg_clk_o;
   reg upg_rst = 1; // initialize it with CPU mode
   wire upg_wen_o; //Uart write out enable
   wire upg_done_o; //Uart rx data have done
   wire [14:0] upg_adr_o;//data to which memory unit of program_rom/dmemory32
   wire [31:0] upg_dat_o;//data to program_rom or dmemory32
   
    clk_wiz cw (
        .clk_in(fpga_clk),
        .cpu_clk(cpu_clk),
        .upg_clk(upg_clk)
    );

    divider divider_show(
        .clk(fpga_clk),
        .rst(fpga_rst),
        .frequency(500),
        .clk_out(show_clk)
    );
     
    wire spg_bufg;
    BUFG bufg(.I(start_pg), .O(spg_bufg));
    
    always @ (posedge fpga_clk) begin
        if (spg_bufg) upg_rst = 0;
        if (fpga_rst) upg_rst = 1;
    end
       
    wire rst = fpga_rst | !upg_rst;
    
    uart_bmpg_0 uart(
        .upg_clk_i(upg_clk),
        .upg_rst_i(upg_rst),
        .upg_rx_i(rx),

        .upg_clk_o(upg_clk_o),
        .upg_dat_o(upg_dat_o),
        .upg_done_o(upg_done_o),
        .upg_tx_o(tx),
        .upg_wen_o(upg_wen_o),
        .upg_adr_o(upg_adr_o));
    
    // input of ifetch
    wire [31:0] Addr_result;
    wire [31:0] Zero;  
    wire [31:0] read_data_1, read_data_2;
    wire [31:0] Instruction;
    wire Branch;
    wire nBranch;
    wire Jmp;
    wire Jal;
    wire Jr;

    // output of ifetch
    wire [31:0] branch_base_addr;
    wire [31:0] link_addr;
    wire [13:0] rom_adr_o;

    Ifetc32_Uart Uifetc32(
        .reset(rst),
        .clock(cpu_clk),
        .Instruction_i(Instruction),
        .Addr_result(Addr_result),
        .Read_data_1(read_data_1),
        .Branch(Branch),
        .nBranch(nBranch),
        .Jmp(Jmp),
        .Jal(Jal),
        .Jr(Jr),
        .Zero(Zero),

        .link_addr(link_addr),
        .branch_base_addr(branch_base_addr),
        .rom_adr_o(rom_adr_o));
    
    ProgramROM_UART Uprogramrom_0(
    .rom_clk_i(cpu_clk),
    .rom_adr_i(rom_adr_o),
    .upg_rst_i(upg_rst),
    .upg_clk_i(upg_clk_o),
    .upg_wen_i(upg_wen_o & (!upg_adr_o[14])),
    .upg_adr_i(upg_adr_o[13:0]),
    .upg_dat_i(upg_dat_o),
    .upg_done_i(upg_done_o),
    .Instruction_o(Instruction));

    // input of decoder
    wire [31:0] r_wdata;  // from MemOrIO
    wire [31:0] ALU_result;
    wire RegWrite, MemtoReg, RegDst;
    // output of decoder
    // move to upper
    // ! btw, the lower case and upper case are wrong
    // wire [31:0] read_data_1, read_data_2;
    wire [31:0] imme_extend;
    wire [31:0] music_data;

    decode32 idecode(
        .Instruction(Instruction),
        .mem_data(r_wdata),
        .ALU_result(ALU_result),
        .Jal(Jal),
        .RegWrite(RegWrite),
        .MemtoReg(MemtoReg),
        .RegDst(RegDst),
        .clock(cpu_clk),
        .reset(rst),
        .opcplus4(link_addr),

        .read_data_1(read_data_1), 
        .read_data_2(read_data_2), 
        .Sign_extend(imme_extend),
        // ! for music
        .music_data_reg(music_data)
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
    dmem32_uart udmem(
           .ram_clk_i(cpu_clk), // from CPU top
           .ram_wen_i(MemWrite), // from controller
           .ram_adr_i(addr_out[13:0]), // from alu_result of ALU
           .ram_dat_i(write_data), // from read_data_2 of decoder
           .ram_dat_o(read_data), // the data read from ram
           .upg_rst_i(upg_rst), // UPG reset (Active High)
           .upg_clk_i(upg_clk_o), // UPG ram_clk_i (10MHz)
           .upg_wen_i((upg_wen_o & upg_adr_o[14])), // UPG write enable
           .upg_adr_i(upg_adr_o[13:0]), // UPG write address
           .upg_dat_i(upg_dat_o), // UPG write data
           .upg_done_i(upg_done_o));

    //input
    wire [15:0] iodata;
    wire [15:0] switchrdata; //data from switchio
    wire [15:0] kbrdata;
    wire kb_enable = (switch[23] == 1);
    
    assign iodata = kb_enable ? kbrdata : switchrdata;
    
    //output of memorio
    wire LEDCtrl; // LED Chip Select
    wire SwitchCtrl; // Switch Chip Select
    wire KBCtrl;  // Keyboard Chip Select
    wire MusicCtrl;

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
        .SwitchCtrl(SwitchCtrl),
        .KBCtrl(KBCtrl),
        .MusicCtrl(MusicCtrl)
    );

    leds ledoutput(
        .led_clk(cpu_clk),
        .ledrst(rst),
        .ledwrite(IOWrite),   //from controller(IOWrite)
        .ledcs(LEDCtrl),
        .ledaddr(addr_out[1:0]), // from memorio
        .ledwdata(write_data[15:0]),    //from memio(id_rdata)
        .ledout(led[23:0])
    );

    switchs switchinput(
        .switclk(cpu_clk),
        .switrst(rst),
        .switchcs(SwitchCtrl && ~kb_enable),
        .switchaddr(addr_out[1:0]), //
        .switchread(IORead),  //from controller (IORead)
        .switchrdata(switchrdata), //output
        .switch_i(switch[23:0])
    );

    keyboard kb(
        .clk(fpga_clk),
        .rst(rst),
        .row(row),
        .col(col),
        
        .kbrps(switch[22:21]),
        .kbcs(KBCtrl && kb_enable),
        .kbrdata(kbrdata),
        .switch_i(switch[23:0]),
        .low_addr(addr_out[1:0])
    );

    show sst( 
        .clk(show_clk),
        .rst(rst),
        .ledwdata(led[23:0]),
        .seg_en(seg_en),
        .seg_out(seg_out)
    );
    
    wire music_uart_enable = (switch[20] == 1);
    reg music_play = 0;
    wire play_bufg;
    BUFG pb(.I(play), .O(play_bufg));
    always @(posedge fpga_clk) begin
        if (rst) music_play = 0;
        else if (play_bufg) music_play = ~music_play;
    end

    music musicplayer(
        .clk(cpu_clk),
        .rst(~music_play),
        // .musiccs(MusicCtrl & music_uart_enable),
        // .music_play(music_play),
        .musiccs(music_play),
        .music_uart_enable(music_uart_enable),
        .music_data(music_data[4:0]),

        .beep(pwm)
    );
endmodule