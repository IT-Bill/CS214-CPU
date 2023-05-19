`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/26 14:44:47
// Design Name: 
// Module Name: control32_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control32_tb();
    reg[5:0]   Opcode_tb;
    reg[5:0]   Function_opcode_tb;
    wire       Jr_tb;
    wire       RegDST_tb; 
    wire       ALUSrc_tb;
    wire       MemtoReg_tb;
    wire       RegWrite_tb;
    wire       MemWrite_tb;
    wire       Branch_tb; 
    wire       nBranch_tb; 
    wire       Jmp_tb;
    wire       Jal_tb; 
    wire       I_format_tb;
    wire       Sftmd_tb;
    wire[1:0]  ALUOp_tb;
    

control32 ctrl32(.Opcode (Opcode_tb),.Function_opcode (Function_opcode_tb),.Jr (Jr_tb),.RegDST (RegDST_tb),.ALUSrc (ALUSrc_tb),
    .MemtoReg (MemtoReg_tb),.RegWrite (RegWrite_tb),.MemWrite (MemWrite_tb),.Branch (Branch_tb),.nBranch (nBranch_tb),.Jmp (Jmp_tb),.Jal (Jal_tb),
    .I_format (I_format_tb),.Sftmd (Sftmd_tb),.ALUOp (ALUOp_tb));

    
    initial begin
        Opcode_tb = 6'b000000;
        Function_opcode_tb=6'b100000;
    end

    initial begin

        /*
        case 1: add 
        Jr = 0
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 0
        ALUOp = 10 - R type instruction (R类型指令)
        */
        #10 begin Function_opcode_tb=6'b100000; // add
        $strobe("@@@@@@@@@@1@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@1@@@@@@@@@@");
		end
        

        
        /*
        case 2: addu
        Jr = 0
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 0
        ALUOp = 10 - R type instruction (R类型指令)
        */
        #10 begin Function_opcode_tb=6'b100001; // addu
        $strobe("@@@@@@@@@@2@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@2@@@@@@@@@@");
		end
        
        /*
        case 3: sub
        Jr = 0
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 0
        ALUOp = 10 - R type instruction (R类型指令)
        */
        #10 begin Function_opcode_tb=6'b100010; // sub
        $strobe("@@@@@@@@@@3@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@3@@@@@@@@@@");
		end

        /*
        case 4: subu
        Jr = 0
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 0
        ALUOp = 10 - R type instruction (R类型指令)
        */
        #10 begin Function_opcode_tb=6'b100011; // subu
        $strobe("@@@@@@@@@@4@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@4@@@@@@@@@@");
		end


        /*
        case 5: or
        Jr = 0
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 0
        ALUOp = 10 - R type instruction (R类型指令)
        */
        #10 begin Function_opcode_tb=6'b100101; // or
        $strobe("@@@@@@@@@@5@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@5@@@@@@@@@@");
		end


        /*
        case 6: xor
        Jr = 0
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 0
        ALUOp = 10 - R type instruction (R类型指令)
        */
        #10 begin Function_opcode_tb=6'b100110; // xor
        $strobe("@@@@@@@@@@6@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@6@@@@@@@@@@");
		end


        /*
        case 7: nor
        Jr = 0
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 0
        ALUOp = 10 - R type instruction (R类型指令)
        */
        #10 begin Function_opcode_tb=6'b100111; // nor
        $strobe("@@@@@@@@@@7@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@7@@@@@@@@@@");
		end


        /*
        case 8: slt
        Jr = 0
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 0
        ALUOp = 10 - R type instruction (R类型指令)
        */
        #10 begin Function_opcode_tb=6'b101010; // slt
        $strobe("@@@@@@@@@@8@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@8@@@@@@@@@@");
		end


        /*
        case 9: sltu
        Jr = 0
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 0
        ALUOp = 10 - R type instruction (R类型指令)
        */
        #10 begin Function_opcode_tb=6'b101011; // sltu
        $strobe("@@@@@@@@@@9@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@9@@@@@@@@@@");
		end


        /*
        case 10: sll
        Jr = 0
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 1 - shift instruction (移位指令)
        ALUOp = 10
        */
        #10 begin Function_opcode_tb=6'b000000; // sll
        $strobe("@@@@@@@@@@10@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@10@@@@@@@@@@");
		end


        /*
        case 11: srl
        Jr = 0
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 1 - shift instruction (移位指令)
        ALUOp = 10
        */
        #10 begin Function_opcode_tb=6'b000010; // srl
        $strobe("@@@@@@@@@@11@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@11@@@@@@@@@@");
		end


        /*
        case 12: sra
        Jr = 0
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 1 - shift instruction (移位指令)
        ALUOp = 10
        */
        #10 begin Function_opcode_tb=6'b000011; // sra
        $strobe("@@@@@@@@@@12@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@12@@@@@@@@@@");
		end


        /*
        case 13: sllv
        Jr = 0
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 1 - shift instruction (移位指令)
        ALUOp = 10
        */
        #10 begin Function_opcode_tb=6'b000100; // sllv
        $strobe("@@@@@@@@@@13@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@13@@@@@@@@@@");
		end

        /*
        case 14: srlv
        Jr = 0
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 1 - shift instruction (移位指令)
        ALUOp = 10
        */
        #10 begin Function_opcode_tb=6'b000110; // srlv
        $strobe("@@@@@@@@@@14@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@14@@@@@@@@@@");
		end


        /*
        case 15: srav
        Jr = 0
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 1 - shift instruction (移位指令)
        ALUOp = 10
        */
        #10 begin Function_opcode_tb=6'b000111; // srav
        $strobe("@@@@@@@@@@15@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@15@@@@@@@@@@");
		end



        /*
        case 16: jr
        Jr = 1 - Jr instruction (是Jr指令)
        RegDST = x
        ALUSrc = x
        MemtoReg = 0
        RegWrite = 0
        MenWrite = 0
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 0
        ALUOp = 10
        */
        #10 begin Function_opcode_tb=6'b001000; // jr
        $strobe("@@@@@@@@@@16@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@16@@@@@@@@@@");
		end



        /*
        case 17: and
        Jr = 0 - 不是Jr类型指令
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 0
        ALUOp = 10 - R type instruction (R类型指令)
        */
        #10 begin Function_opcode_tb=6'b100100; // and
        $strobe("@@@@@@@@@@17@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@17@@@@@@@@@@");
		end

        /*
        case 18: sub
        Jr = 0 - 不是Jr类型指令
        RegDST = 1 - write result to register rd (写入rd上的寄存器)
        ALUSrc = 0 - oeprates come from registers (操作数来自寄存器)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0
        Sftmd = 0
        ALUOp = 10 - R type instruction (R类型指令)
        */
        #10 begin Function_opcode_tb=6'b100010; // sub
        $strobe("@@@@@@@@@@18@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@18@@@@@@@@@@");
		end

//////////////////////////////////////////////////////////////////////////////////

        /*
        case 19: addi
        Jr = 0
        RegDST = 0 - write result to register rt (写入rt上的寄存器)
        ALUSrc = 1 - oeprates come from immediate (操作数来自立即数)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 1 - I type instruction (I类型指令)
        Sftmd = 0
        ALUOp = 10 - I-format instruction (I-format指令)
        */
        #10 begin Opcode_tb = 6'b001000; // addi
        Function_opcode_tb=6'b000000;
        $strobe("@@@@@@@@@@19@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@19@@@@@@@@@@");
		end


        /*
        case 20: andi
        Jr = 0
        RegDST = 0 - write result to register rt (写入rt上的寄存器)
        ALUSrc = 1 - oeprates come from immediate (操作数来自立即数)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 1 - I type instruction (I类型指令)
        Sftmd = 0
        ALUOp = 10 - I-format instruction (I-format指令)
        */
        #10 begin Opcode_tb = 6'b001100; // andi
        $strobe("@@@@@@@@@@20@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@20@@@@@@@@@@");
		end


        /*
        case 21: ori
        Jr = 0
        RegDST = 0 - write result to register rt (写入rt上的寄存器)
        ALUSrc = 1 - oeprates come from immediate (操作数来自立即数)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 1 - I type instruction (I类型指令)
        Sftmd = 0
        ALUOp = 10 - I-format instruction (I-format指令)
        */
        #10 begin Opcode_tb = 6'b001101; // ori
        $strobe("@@@@@@@@@@21@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@21@@@@@@@@@@");
		end


        /*
        case 22: xori
        Jr = 0
        RegDST = 0 - write result to register rt (写入rt上的寄存器)
        ALUSrc = 1 - oeprates come from immediate (操作数来自立即数)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 1 - I type instruction (I类型指令)
        Sftmd = 0
        ALUOp = 10 - I-format instruction (I-format指令)
        */
        #10 begin Opcode_tb = 6'b001110; // xori
        $strobe("@@@@@@@@@@22@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@22@@@@@@@@@@");
		end


        /*
        case 23: lw
        Jr = 0
        RegDST = 0 - write result to register rt (写入rt上的寄存器)
        ALUSrc = 1 - oeprates come from immediate (操作数来自立即数)
        MemtoReg = 1 - write result from memory to register (从储存器写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0 - ruled out by I-format (I-format排除lw)
        Sftmd = 0
        ALUOp = 00 - lw instruction (lw指令)
        */
        #10 begin Opcode_tb = 6'b100011; // lw
        $strobe("@@@@@@@@@@23@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@23@@@@@@@@@@");
		end


        /*
        case 24: sw
        Jr = 0
        RegDST = x
        ALUSrc = 1 - oeprates come from immediate (操作数来自立即数)
        MemtoReg = 0 - no need to write result from memory to register (不需要从储存器写入寄存器)
        RegWrite = 0 - no need to write to register(不需要写入寄存器)
        MenWrite = 1 - write to memroy is need (需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0 - ruled out by I-format (I-format排除sw)
        Sftmd = 0
        ALUOp = 00 - sw instruction (sw指令)
        */
        #10 begin Opcode_tb = 6'b101011; // sw
        $strobe("@@@@@@@@@@24@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@24@@@@@@@@@@");
		end


        /*
        case 25: beq
        Jr = 0
        RegDST = x
        ALUSrc = 0 - beq is a special case, although the immediate number is used, 
        the immediate number is not directly entered into the ALU module
        (beq是特例，虽然使用立即数，但是立即数不直接输入ALU模块)
        MemtoReg = x
        RegWrite = x
        MenWrite = 0
        Branch = 1 - beq
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 0 - ruled out by I-format (I-format排除beq)
        Sftmd = 0
        ALUOp = 01 - beq
        */
        #10 begin Opcode_tb = 6'b000100; // beq
        $strobe("@@@@@@@@@@25@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@25@@@@@@@@@@");
		end
 


        /*
        case 26: bne
        Jr = 0
        RegDST = x
        ALUSrc = 0 - bne is a special case, although the immediate number is used, 
        the immediate number is not directly entered into the ALU module
        (bne是特例，虽然使用立即数，但是立即数不直接输入ALU模块)
        MemtoReg = x
        RegWrite = x
        MenWrite = 0 - 不需要写入储存器
        Branch = 0
        nBranch = 1 - bne
        Jmp = 0
        Jal = 0
        I_format = 0 - ruled out by I-format (I-format排除bne)
        Sftmd = 0
        ALUOp = 01 - bne
        */
        #10 begin Opcode_tb = 6'b000101; // bne
        $strobe("@@@@@@@@@@26@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@26@@@@@@@@@@");
		end


        /*
        case 27: lui
        Jr = 0
        RegDST = 0 - write result to register rt (写入rt上的寄存器)
        ALUSrc = 1 - oeprates come from immediate (操作数来自立即数)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 1 - I-type instruction (I-type指令)
        Sftmd = 0
        ALUOp = 10 - I-format instruciton (I-format指令)
        */
        #10 begin Opcode_tb = 6'b001111; // lui
        $strobe("@@@@@@@@@@27@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@27@@@@@@@@@@");
		end


        /*
        case 28: slti
        Jr = 0
        RegDST = 0 - write result to register rt (写入rt上的寄存器)
        ALUSrc = 1 - oeprates come from immediate (操作数来自立即数)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 1 - I-type instruction (I-type指令)
        Sftmd = 0
        ALUOp = 10 - I-format instruciton (I-format指令)
        */
        #10 begin Opcode_tb = 6'b001010; // slti
        $strobe("@@@@@@@@@@28@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@28@@@@@@@@@@");
		end

        /*
        case 29: sltiu
        Jr = 0
        RegDST = 0 - write result to register rt (写入rt上的寄存器)
        ALUSrc = 1 - oeprates come from immediate (操作数来自立即数)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 1 - I-type instruction (I-type指令)
        Sftmd = 0
        ALUOp = 10 - I-format instruciton (I-format指令)
        */
        #10 begin Opcode_tb = 6'b001011; // sltiu
        $strobe("@@@@@@@@@@29@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@29@@@@@@@@@@");
		end

        /*
        case 30: addiu
        Jr = 0
        RegDST = 0 - write result to register rt (写入rt上的寄存器)
        ALUSrc = 1 - oeprates come from immediate (操作数来自立即数)
        MemtoReg = 0 - write result from ALU to register (从ALU写入寄存器)
        RegWrite = 1 - write to register is needed (需要写入寄存器)
        MenWrite = 0 - do not need to write to memory (不需要写入储存器)
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 0
        I_format = 1 - I-type instruction (I-type指令)
        Sftmd = 0
        ALUOp = 10 - I-format instruciton (I-format指令)
        */
        #10 begin Opcode_tb = 6'b001001; // addiu
        $strobe("@@@@@@@@@@30@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@30@@@@@@@@@@");
		end

//////////////////////////////////////////////////////////////////////////////////



        /*
        case 31: j
        Jr = 0
        RegDST = x
        ALUSrc = x
        MemtoReg = x
        RegWrite = x
        MenWrite = 0
        Branch = 0
        nBranch = 0
        Jmp = 1 - J instruciton
        Jal = 0
        I_format = 0 - not I type instruction (非I类型指令)
        Sftmd = 0
        ALUOp = xx
        */
        #10 begin Opcode_tb = 6'b000010; // j
        $strobe("@@@@@@@@@@31@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@31@@@@@@@@@@");
		end


        /*
        case 32: jal
        Jr = 0
        RegDST = x
        ALUSrc = x
        MemtoReg = x
        RegWrite = 1 - jal need to wirte to a specific register (需要写入特定寄存器)
        MenWrite = 0
        Branch = 0
        nBranch = 0
        Jmp = 0
        Jal = 1 - Jal instruction
        I_format = 0 - not I type instruction (非I类型指令)
        Sftmd = 0
        ALUOp = xx
        */
        #10 begin Opcode_tb = 6'b000011; // jal
        $strobe("@@@@@@@@@@32@@@@@@@@@@");
		$strobe("%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",Opcode_tb,Function_opcode_tb,Jr_tb,RegDST_tb,ALUSrc_tb,MemtoReg_tb,RegWrite_tb,MemWrite_tb,Branch_tb,nBranch_tb,Jmp_tb,Jal_tb,I_format_tb,Sftmd_tb,ALUOp_tb);
        $strobe("@@@@@@@@@@32@@@@@@@@@@");
		end
		
		#10 $finish;
    end
endmodule
