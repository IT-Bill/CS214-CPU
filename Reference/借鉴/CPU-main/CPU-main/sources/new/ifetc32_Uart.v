`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2022/05/27 20:31:24
//////////////////////////////////////////////////////////////////////////////////


module ifetc32_Uart (
input clock,reset, // Clock and reset
// from ALU
input[31:0] Addr_result, // the calculated address from ALU // 需要*4
input Zero, // while Zero is 1, it means the ALUresult is zero
// from Decoder
input[31:0] Read_data_1, // the address of instruction used by jr instruction // 需要*4
// from controller
input Branch, // while Branch is 1,it means current instruction is beq
input nBranch, // while nBranch is 1,it means current instruction is bnq
input Jmp, // while Jmp 1,it means current instruction is jump
input Jal, // while Jal is 1,it means current instruction is jal
input Jr, // while Jr is 1,it means current instruction is jr
input [31:0] Instruction_i,

output[31:0] Instruction_o, // the instruction fetched from this module
output[31:0] branch_base_addr, // (pc+4) to ALU which is used by branch type instruction
output reg [31:0] link_addr, // (pc+4) to decoder which is used by jal instruction
output [13:0] rom_adr_o
);

reg[31:0] PC, Next_PC;

//prgrom instmem(
//    .clka(clock), // input wire clka
//    .addra(PC[15:2]), // input wire [13 : 0] addra
//    .douta(Instruction_o) // output wire [31 : 0] douta
//);

always @* begin
    if(((Branch == 1) && (Zero == 1 )) || ((nBranch == 1) && (Zero == 0))) // beq, bne
        Next_PC = Addr_result; // the calculated new value for PC 
    else if(Jr == 1)
        Next_PC = Read_data_1; // the value of $31 register
    else 
        Next_PC = PC+32'd4; // PC+4
end

always @(posedge clock) begin
    if(reset==1)
        PC <= 32'h0000_0000;
    else if(Jmp == 1) begin  /[表情]指令需要从输入中获取要跳转到的地址，然而只有26位，所以需要拼接
        PC <= {PC[31:28], Instruction_o[25:0],2'b00};
    end
    else if(Jal == 1) begin
        PC <= {PC[31:28], Instruction_o[25:0],2'b00};
        link_addr <= PC + 32'h4;
    end
   else PC <= Next_PC;
   end

assign branch_base_addr = PC+32'd4;
assign rom_adr_o = PC[15:2];
assign Instruction_o = Instruction_i;
 
endmodule