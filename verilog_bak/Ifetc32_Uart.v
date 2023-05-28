`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2022/05/27 20:31:24
//////////////////////////////////////////////////////////////////////////////////


module Ifetc32_Uart (
input clock,reset, // Clock and reset
// from ALU
input[31:0] Addr_result, // the calculated address from ALU // ��Ҫ*4
input Zero, // while Zero is 1, it means the ALUresult is zero
// from Decoder
input[31:0] Read_data_1, // the address of instruction used by jr instruction // ��Ҫ*4
// from controller
input Branch, // while Branch is 1,it means current instruction is beq
input nBranch, // while nBranch is 1,it means current instruction is bnq
input Jmp, // while Jmp 1,it means current instruction is jump
input Jal, // while Jal is 1,it means current instruction is jal
input Jr, // while Jr is 1,it means current instruction is jr
input [31:0] Instruction_i,

output[31:0] branch_base_addr, // (pc+4) to ALU which is used by branch type instruction
output reg [31:0] link_addr, // (pc+4) to decoder which is used by jal instruction
output [13:0] rom_adr_o
);

reg[31:0] PC, Next_PC;


always @(*) begin
    if(((Branch == 1) && (Zero == 1 )) || ((nBranch == 1) && (Zero == 0))) // beq, bne
        Next_PC = Addr_result; // the calculated new value for PC 
    else if(Jr == 1)
        Next_PC = Read_data_1; // the value of $31 register
    else if (Jal == 1 || Jmp == 1)
        Next_PC = {PC[31:28], Instruction_i[25:0],2'b00};
    else 
        Next_PC = PC+32'd4; // PC+4
end

always @(negedge clock or posedge reset) begin
    if(reset) begin
        PC <= 32'h0000_0000;
    end
    else if(Jmp == 1) begin  //[����]ָ����Ҫ�������л�ȡҪ��ת���ĵ�ַ��Ȼ��ֻ��26λ��������Ҫƴ��
        PC <= {PC[31:28], Instruction_i[25:0],2'b00};
    end
    else if(Jal == 1) begin
        PC <= {PC[31:28], Instruction_i[25:0],2'b00};
        link_addr <= PC + 32'h4;
    end
    else PC <= Next_PC;
end

assign branch_base_addr = PC+32'd4;
assign rom_adr_o = PC[15:2];
 
endmodule