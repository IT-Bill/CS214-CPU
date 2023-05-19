`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2022/05/27 20:51:47
// Design Name: 
// Module Name: top
//////////////////////////////////////////////////////////////////////////////////


module top(
    input fpga_clk,
    input fpga_rst,
    input [23:0]switchIn,
    output [23:0]ledout,
    // UART
    // start Uart communicate at hight level
    input mode, // Active high
    input rx,       // recieve data by uart          Y19
    output tx     // send data by uart	         V18
);
wire cpu_clk;
wire upg_clk;
cpuclk uclk(.clk_in1(fpga_clk),.clk_out1(cpu_clk),.clk_out2(upg_clk));


wire strong_mode;
BUFG U1(.I(mode), .O(strong_mode)); // de-twitter
    // Generate UART Programmer reset signal
    reg upg_rst;
    always @ (posedge fpga_clk) begin
        if (strong_mode) upg_rst <= 0;
        if (fpga_rst) upg_rst <= 1;
    end
    //ifetch模块用这个rst，以及其他不需要uart的模块也都用这个uart
    wire rst = fpga_rst | !upg_rst;
    wire upg_clk_o;
    wire upg_wen_o;
    wire upg_done_o;
    wire [31:0] upg_dat_o;
    wire [14:0] upg_adr_o;
    wire [31:0] Instruction_o;
    
    uart_bmpg_0 Uuart(.upg_clk_i(upg_clk), .upg_rst_i(upg_rst), .upg_rx_i(rx),
            .upg_clk_o(upg_clk_o), .upg_wen_o(upg_wen_o), .upg_adr_o(upg_adr_o), .upg_dat_o(upg_dat_o),
            .upg_done_o(upg_done_o), .upg_tx_o(tx));
    
   
    wire [13:0] rom_adr_o;
    ProgramROM_UART Uprogramrom_0(
    .rom_clk_i(cpu_clk),
    .rom_adr_i(rom_adr_o),
    .upg_rst_i(upg_rst),
    .upg_clk_i(upg_clk_o),
    .upg_wen_i(upg_wen_o),
    .upg_adr_i(upg_adr_o),
    .upg_dat_i(upg_dat_o),
    .upg_done_i(upg_done_o),
    .Instruction_o(Instruction_o));
                    
    //ALU
    wire [31:0]Add_result_o;
    wire [31:0]Read_data_1_o;
    wire [31:0]Executs32_0_ALU_Result;
    wire Zero;
  
    //Controller，复位键用rst，clock用cpu_clk
    wire Jmp;
    wire Jal;
    wire Jr;
    wire nBranch;
    wire Branch;
    wire [31:0] link_addr;
    wire [31:0] branch_base_addr;
    wire [31:0] Instruction_o2;//传给controller和alu的指令用这个
    ifetc32_Uart Uifetc32(
    .reset(rst),
    .clock(cpu_clk),
    .Addr_result(Add_result_o),
    .Read_data_1(Read_data_1_o),
    .Branch(Branch),
    .nBranch(nBranch),
    .Jmp(Jmp),
    .Jal(Jal),
    .Jr(Jr),
    .Zero(Zero),
    .Instruction_i(Instruction_o),
    .Instruction_o(Instruction_o2),
    .link_addr(link_addr),
    .branch_base_addr(branch_base_addr),
    .rom_adr_o(rom_adr_o));
    
     wire [1:0]control32_0_ALUOp;
     wire control32_0_ALUSrc;
     wire control32_0_IORead;
     wire control32_0_IOWrite;
     wire control32_0_I_format;
     wire control32_0_MemRead;
     wire control32_0_MemWrite;
     wire control32_0_MemorIOtoReg;
     wire control32_0_RegDST;
     wire control32_0_RegWrite;
     wire control32_0_Sftmd;
     control32 Control(        .ALUOp(control32_0_ALUOp),
                               .ALUSrc(control32_0_ALUSrc),
                               .Alu_resultHigh(Executs32_0_ALU_Result[31:10]),
                               .Branch(Branch),
                               .Function_opcode(Instruction_o2[5:0]),
                               .IORead(control32_0_IORead),
                               .IOWrite(control32_0_IOWrite),
                               .I_format(control32_0_I_format),
                               .Jal(Jal),
                               .Jmp(Jmp),
                               .Jr(Jr),
                               .MemRead(control32_0_MemRead),
                               .MemWrite(control32_0_MemWrite),
                               .MemorIOtoReg(control32_0_MemorIOtoReg),
                               .Opcode(Instruction_o2[31:26]),
                               .RegDST(control32_0_RegDST),
                               .RegWrite(control32_0_RegWrite),
                               .Sftmd(control32_0_Sftmd),
                               .nBranch(nBranch));  
               ////decoder
     wire [31:0]decode32_0_imme_extend;
     wire [31:0]decode32_0_read_data_2;
     wire MemOrIO_0_LEDCtrl;
     wire MemOrIO_0_SwitchCtrl;
     wire MemOrIO_0_ScanCtrl;
     wire [31:0]MemOrIO_0_addr_out;
     wire [31:0]MemOrIO_0_r_wdata;
     wire [31:0]MemOrIO_0_write_data;
     wire [23:0]switchs_0_switchrdata;
     decode32 Decode32(                .ALU_result(Executs32_0_ALU_Result),
                                       .Instruction(Instruction_o2),
                                       .Jal(Jal),
                                       .MemtoReg(control32_0_MemorIOtoReg),
                                       .RegDst(control32_0_RegDST),
                                       .RegWrite(control32_0_RegWrite),
                                       .clock(cpu_clk),
                                       .Sign_extend(decode32_0_imme_extend),
                                       .opcplus4(link_addr),
                                       .mem_data(MemOrIO_0_r_wdata),
                                       .read_data_1(Read_data_1_o),
                                       .read_data_2(decode32_0_read_data_2),
                                       .reset(rst));
       
       ///executaion
       
       executs32 alu_u (
           .Read_data_1(Read_data_1_o),
           .Read_data_2(decode32_0_read_data_2),
           .Sign_extend(decode32_0_imme_extend),
           .Function_opcode(Instruction_o2[5:0]),
           .Exe_opcode(Instruction_o2[31:26]),
           .ALUOp(control32_0_ALUOp), 
           .Shamt(Instruction_o2[10:6]), 
           .ALUSrc(control32_0_ALUSrc),
           .I_format(control32_0_I_format),
           .Zero(Zero),
            .Jr(Jr),
            .Sftmd(control32_0_Sftmd), 
            .ALU_Result(Executs32_0_ALU_Result),
            .Addr_Result(Add_result_o),
            .PC_plus_4(branch_base_addr)
       );
       
       ///MemoryIO..
       
       wire [31:0]dmemory32_0_read_data;
       dmem32_uart udmem(.ram_clk_i(cpu_clk), // from CPU top
                         .ram_wen_i(control32_0_MemWrite), // from controller
                         .ram_adr_i(Executs32_0_ALU_Result), // from alu_result of ALU
                         .ram_dat_i(decode32_0_read_data_2), // from read_data_2 of decoder
                         .ram_dat_o(dmemory32_0_read_data), // the data read from ram
                         .upg_rst_i(upg_rst), // UPG reset (Active High)
                         .upg_clk_i(upg_clk_o), // UPG ram_clk_i (10MHz)
                         .upg_wen_i((upg_wen_o & upg_adr_o[14])), // UPG write enable
                         .upg_adr_i(upg_adr_o[13:0]), // UPG write address
                         .upg_dat_i(upg_dat_o), // UPG write data
                         .upg_done_i(upg_done_o));
       MemOrIO  Memorio
              (.LEDCtrl(MemOrIO_0_LEDCtrl),
               .SwitchCtrl(MemOrIO_0_SwitchCtrl),
               .addr_in(Executs32_0_ALU_Result),
               .addr_out(MemOrIO_0_addr_out),
               .ioRead(control32_0_IORead),
               .ioWrite(control32_0_IOWrite),
               .io_rdata(switchs_0_switchrdata[15:0]),
               .mRead(control32_0_MemRead),
               .mWrite(control32_0_MemWrite),
               .m_rdata(dmemory32_0_read_data),
               .r_rdata(decode32_0_read_data_2),
               .r_wdata(MemOrIO_0_r_wdata),
               .write_data(MemOrIO_0_write_data)
               // new add
   ///            .ScanCtrl(MemOrIO_0_ScanCtrl)
               );
        
        wire [23:0]ledout_0;
        assign ledout[23:0]=ledout_0;                                                          
           ///led
      leds leds_0
                  (.led_clk(cpu_clk),
                   .ledaddr(MemOrIO_0_addr_out[1:0]),
                   .ledcs(MemOrIO_0_LEDCtrl),
                   .ledout(ledout_0),
                   .ledrst(rst),
                   .ledwdata(decode32_0_read_data_2),  //change, wrong before.
                   .ledwrite(control32_0_IOWrite));
                
        wire [23:0]switchIn_1;
        assign switchIn_1=switchIn[23:0];   
     ///switch
     switchs switchs_0
            (.switch_i(switchIn_1),
             .switchaddr(Executs32_0_ALU_Result[1:0]),
             .switchcs(MemOrIO_0_SwitchCtrl),
             .switchrdata(switchs_0_switchrdata),
             .switchread(control32_0_IORead),
             .switclk(cpu_clk),
             .switrst(rst));
endmodule