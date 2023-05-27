`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2022/05/18 16:22:30
// Design Name: 
// Module Name: decode32
// Description: 
//////////////////////////////////////////////////////////////////////////////////

module decode32(read_data_1,read_data_2,Instruction,mem_data,ALU_result,
                 Jal,RegWrite,MemtoReg,RegDst,Sign_extend,clock,reset,opcplus4);
       output[31:0] read_data_1;               // ����ĵ�һ������??
       output[31:0] read_data_2;               // ����ĵڶ�������??
       input[31:0]  Instruction;               // ȡָ��Ԫ����ָ��
       input[31:0]  mem_data;                  //  ��DATA RAM or I/O portȡ��������
       input[31:0]  ALU_result;                 // ��ִ�е�Ԫ��������Ľ��
       input        Jal;                        //  ���Կ��Ƶ�Ԫ��˵����JALָ�� 
       input        RegWrite;                  // ���Կ��Ƶ�Ԫ
       input        MemtoReg;                  // ���Կ��Ƶ�Ԫ
       input        RegDst;             
       output[31:0] Sign_extend;               // ��չ���??32λ������
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

    assign Sign_extend[31:0] = (opcode==6'b001100 || opcode==6'b001101||opcode==6'b001110||opcode==6'b001011)
     ? {{16{1'b0}}, immediate} : {{16{Instruction[15]}}, immediate};
    assign read_data_1 = register[rs];
    assign read_data_2 = register[rt];

    //update register 
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            register[0] <= 32'b0;
            register[1] <= 32'b0;
            register[2] <= 32'b0;
            register[3] <= 32'b0;
            register[4] <= 32'b0;
            register[5] <= 32'b0;
            register[6] <= 32'b0;
            register[7] <= 32'b0;
            register[8] <= 32'b0;
            register[9] <= 32'b0;
            register[10] <= 32'b0;
            register[11] <= 32'b0;
            register[12] <= 32'b0;
            register[13] <= 32'b0;
            register[14] <= 32'b0;
            register[15] <= 32'b0;
            register[16] <= 32'b0;
            register[17] <= 32'b0;
            register[18] <= 32'b0;
            register[19] <= 32'b0;
            register[20] <= 32'b0;
            register[21] <= 32'b0;
            register[22] <= 32'b0;
            register[23] <= 32'b0;
            register[24] <= 32'b0;
            register[25] <= 32'b0;
            register[26] <= 32'b0;
            register[27] <= 32'b0;
            register[28] <= 32'b0;
            register[29] <= 32'b0;
            register[30] <= 32'b0;
            register[31] <= 32'b0;
        end
        else if (RegWrite) begin
            if (write_register != 5'b0)
                register[write_register] <= write_data;
        end
    end


    always@* begin
        if(RegWrite==1'b1)begin
            if(opcode==6'b000011)begin
                if(Jal==1'b1)begin
                    write_register = 5'b11111;//jal
                end
            end
            else if(RegDst==1'b1)begin
                write_register = rd;
            end
            else begin
                write_register = rt;
            end
        end
     end



    always@* begin
        if(MemtoReg==1'b0&&Jal==1'b0) begin
            write_data = ALU_result;
        end
        else if(Jal==1'b1)begin
            write_data =opcplus4;
        end
        else begin
            write_data = mem_data;
        end
    end

    //j...?

endmodule
