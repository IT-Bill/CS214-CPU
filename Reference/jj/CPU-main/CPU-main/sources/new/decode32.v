`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2022/05/18 16:22:30
// Design Name: 
// Module Name: decode32
// Description: 
//////////////////////////////////////////////////////////////////////////////////

module decode32(read_data_1,read_data_2,Instruction,mem_data,ALU_result,
                 Jal,RegWrite,MemtoReg,RegDst,Sign_extend,clock,reset,opcplus4);
       output[31:0] read_data_1;               // ����ĵ�һ������?
       output[31:0] read_data_2;               // ����ĵڶ�������?
       input[31:0]  Instruction;               // ȡָ��Ԫ����ָ��
       input[31:0]  mem_data;                  //  ��DATA RAM or I/O portȡ��������
       input[31:0]  ALU_result;                 // ��ִ�е�Ԫ��������Ľ��
       input        Jal;                        //  ���Կ��Ƶ�Ԫ��˵����JALָ�� 
       input        RegWrite;                  // ���Կ��Ƶ�Ԫ
       input        MemtoReg;                  // ���Կ��Ƶ�Ԫ
       input        RegDst;             
       output[31:0] Sign_extend;               // ��չ���?32λ������
       input         clock,reset;              // ʱ�Ӻ͸�λ
       input[31:0]  opcplus4;                 // ����ȡָ��Ԫ��JAL����
    
    wire[5:0] opcode;
    wire[4:0] rs;
    wire[4:0] rt;
    wire[4:0] rd;
    wire[15:0] immediate;
    reg[31:0] register[31:0];
    reg[4:0] write_register;
    reg[31:0] write_data;

    assign opcode=Instruction[31:26];
    assign rs=Instruction[25:21];
    assign rt=Instruction[20:16];
    assign rd=Instruction[15:11];
    assign immediate=Instruction[15:0];

    assign Sign_extend[31:0] = (opcode==6'b001100 || opcode==6'b001101||opcode==6'b001110||opcode==6'b001011)?{{16{1'b0}},immediate}:{{16{Instruction[15]}},immediate};
    assign read_data_1 = register[rs];
    assign read_data_2 = register[rt];

    //update register 
    integer i;
    always@(posedge clock)
    begin
        if(reset)
        begin
            for(i=0;i<32;i=i+1) 
                register[i] <= 0;
        end
        else if(RegWrite)
        begin
        if(write_register!=5'b0)
        begin
            register[write_register] <= write_data;
        end
        end
    end
    
    //write address
    always@(*)
    begin
    if (RegWrite)
    begin
    if(Jal)
    begin
        write_register=5'b11111;
    end
    else if(RegDst)
    begin
        write_register=rd;
    end
    else
    begin
        write_register=rt;
    end
    end
    end

    //write data
    always@(*)
    begin
        if(Jal)
        begin
            write_data=opcplus4;
        end
        else if(MemtoReg)
        begin
            write_data=mem_data;
        end
        else
        begin
            write_data=ALU_result;
        end
    end

    //j...?

endmodule
