`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////
// Create Date: 2022/05/18 10:28:06
// Design Name: 
// Module Name: control32
// Description: 
// Revision 0.01 - File Created
/////////////////////////////////////////////////////////////////////////////

module control32(Opcode, Function_opcode, Jr, RegDST, ALUSrc, MemtoReg, RegWrite, MemWrite, Branch, nBranch, Jmp, Jal, I_format, Sftmd, ALUOp,MemorIOtoReg,MemRead,IORead,IOWrite,Alu_resultHigh);
    input[5:0]   Opcode;            // ����IFetchģ���ָ���6bit, instruction[31..26]
    input[5:0]   Function_opcode;  	// ����IFetchģ���ָ���6bit, ��������r-�����е�ָ��, instructions[5..0]
    output       Jr;         	 // Ϊ1������ǰָ����jr, Ϊ0��ʾ��ǰָ���jr
    output       RegDST;          // Ϊ1����Ŀ�ļĴ�����rd, ����Ŀ�ļĴ�����rt
    output       ALUSrc;          // Ϊ1�����ڶ�����������ALU�е�Binput������������beq, bne���⣩, Ϊ0ʱ��ʾ�ڶ������������ԼĴ���
    output       MemtoReg;       // Ϊ1������Ҫ�Ӵ洢����I/O�����ݵ��Ĵ���
    output       RegWrite;   	  // Ϊ1������ָ����Ҫд�Ĵ���
    output       MemWrite;       // Ϊ1������ָ����Ҫд�洢��
    output       Branch;        // Ϊ1������beqָ��, Ϊ0ʱ��ʾ����beqָ��
    output       nBranch;       // Ϊ1������Bneָ��, Ϊ0ʱ��ʾ����bneָ��
    output       Jmp;            // Ϊ1������Jָ��, Ϊ0ʱ��ʾ����Jָ��
    output       Jal;            // Ϊ1������Jalָ��, Ϊ0ʱ��ʾ����Jalָ��
    output       I_format;      // Ϊ1������ָ���ǳ�beq, bne, LW, SW֮�������I-����ָ��
    output       Sftmd;         // Ϊ1��������λָ��, Ϊ0����������λָ��
    output[1:0]  ALUOp;        // ��R-���ͻ�I_format=1ʱλ1����bitλ��Ϊ1,  beq��bneָ����λ0����bitλ��Ϊ1
    output MemorIOtoReg;    // 1 indicates that data needs to be read from memory or I/O to the register
    output MemRead;     // 1 indicates that the instruction needs to read from the memory
    output IORead ;     // 1 indicates I/O read
    output IOWrite;    // 1 indicates I/O write
    input [21:0] Alu_resultHigh;    // From the execution unit Alu_Result[31..10]
        
    wire R_format;wire Lw;wire Sw;
    assign Lw=(Opcode==6'b100011)? 1'b1:1'b0;
    assign Sw=(Opcode==6'b101011)?1'b1:1'b0;
    assign Jr =((Opcode==6'b000000)&&(Function_opcode==6'b001000)) ? 1'b1 : 1'b0;
    assign Jal = (Opcode==6'b000011)? 1'b1:1'b0;
    assign Jmp= (Opcode==6'b000010)? 1'b1:1'b0;
    assign R_format=(Opcode==6'b000000)? 1'b1:1'b0;
    assign RegDST = R_format;
    assign I_format = (Opcode[5:3]==3'b001)?1'b1:1'b0;
    assign ALUOp = {(R_format || I_format),(Branch || nBranch)};
    assign Sftmd = (((Function_opcode==6'b000000)||(Function_opcode==6'b000010)
    ||(Function_opcode==6'b000011)||(Function_opcode==6'b000100)
    ||(Function_opcode==6'b000110)||(Function_opcode==6'b000111))
    && R_format)? 1'b1:1'b0;
    assign RegWrite = (R_format || Lw || Jal || I_format) && !(Jr);
    assign Branch = (Opcode==6'b000100)? 1'b1:1'b0;
    assign nBranch = (Opcode==6'b000101)? 1'b1:1'b0;
    assign MemWrite = (Opcode==6'b101011)? 1'b1:1'b0;
    assign MemtoReg = Lw;
    assign ALUSrc = (Opcode==6'b101011||I_format||Opcode==6'b100011)? 1'b1:1'b0;
    
    assign MemRead = ((Lw==1) && (Alu_resultHigh[21:0] != 22'h3FFFFF)) ? 1'b1:1'b0;  // Read memory
    assign IORead = ((Lw==1) && (Alu_resultHigh[21:0] == 22'h3FFFFF)) ? 1'b1:1'b0;  // Read input port
    assign IOWrite = ((Sw==1) && (Alu_resultHigh[21:0] == 22'h3FFFFF)) ? 1'b1:1'b0;  // Write output port
    
        
    assign MemorIOtoReg = IORead || MemRead;
endmodule
