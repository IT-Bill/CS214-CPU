`timescale 1ns / 1ps


module executs32(Read_data_1,Read_data_2,Sign_extend,Function_opcode,Exe_opcode,ALUOp,
                 Shamt,ALUSrc,I_format,Zero,Jr,Sftmd,ALU_Result,Addr_Result,PC_plus_4
                 );
    //from decoder
    input[31:0]  Read_data_1;		// 从译码单元的Read_data_1中来
    input[31:0]  Read_data_2;		// 从译码单元的Read_data_2中来
    input[31:0]  Sign_extend;   	// 从译码单元来的扩展后的立即数
    //from ifetch
    input[5:0]   Function_opcode;  	// 取指单元来的r-类型指令功能�?,r-form instructions[5:0]
    input[31:0]  PC_plus_4;         // 来自取指单元的PC+4
    input[4:0]   Shamt;             // 来自取指单元的instruction[10:6]，指定移位次�?
    input[5:0]   Exe_opcode;  		// 取指单元来的操作�?
    //from controller
    input[1:0]   ALUOp;             // 来自控制单元的运算指令控制编�?
    input  		 Sftmd;             // 来自控制单元的，表明是移位指�?
    input        ALUSrc;            // 来自控制单元，表明第二个操作数是立即数（beq，bne除外�?
    input        I_format;          // 来自控制单元，表明是除beq, bne, LW, SW之外的I-类型指令
    input        Jr;                // 来自控制单元，表明是JR指令
    //output
    output Zero;                // �?1表明计算值为0 
    output reg [31:0]  ALU_Result;        // 计算的数据结�?
    output [31:0] Addr_Result;		 // 计算的地�?结果        

    //输入数据
    wire [31:0] Ainput;
    wire [31:0] Binput;
    assign Ainput = Read_data_1;
    assign Binput = (ALUSrc == 0) ? Read_data_2 : Sign_extend[31:0];

    //alu_ctl
    wire [5:0] Exe_code;
    assign Exe_code = (I_format == 0) ? Function_opcode : { 3'b000 , Exe_opcode[2:0] };
    wire [2:0] ALU_ctl;
    assign ALU_ctl[0] = (Exe_code[0] | Exe_code[3]) & ALUOp[1];
    assign ALU_ctl[1] = ((!Exe_code[2]) | (!ALUOp[1]));
    assign ALU_ctl[2] = (Exe_code[1] & ALUOp[1]) | ALUOp[0];

    //
    reg signed [31:0] AlU_output_mux;
    always @(ALU_ctl or Ainput or Binput) begin
        case (ALU_ctl)
            3'b000:AlU_output_mux = Ainput & Binput;//and andi
            3'b001:AlU_output_mux = Ainput | Binput;//or ori
            3'b010:AlU_output_mux = $signed(Ainput) + $signed(Binput);//add addi lw sw
            3'b011:AlU_output_mux = Ainput + Binput;//addu addiu
            3'b100:AlU_output_mux = Ainput ^ Binput;//xor xori
            3'b101:AlU_output_mux = ~(Ainput | Binput);//nor lui
            3'b110:AlU_output_mux = $signed(Ainput) - $signed(Binput);//sub slti beq bne
            3'b111:AlU_output_mux = Ainput - Binput;//subu sltiu slt sltu
            default: AlU_output_mux = 32'h0000_0000;
        endcase
    end

    wire[2:0] Sftm;
    assign Sftm = Function_opcode[2:0]; //the code of shift operations 
    reg[31:0] Shift_Result; //the result of shift operation
    always @* begin // six types of shift instructions 
        if(Sftmd) begin
            case(Sftm[2:0]) 
                3'b000:Shift_Result = Binput << Shamt;        //Sll rd,rt,shamt 00000 
                3'b010:Shift_Result = Binput >> Shamt;        //Srl rd,rt,shamt 00010 
                3'b100:Shift_Result = Binput << Ainput;       //Sllv rd,rt,rs 00010 
                3'b110:Shift_Result = Binput >> Ainput;       //Srlv rd,rt,rs 00110 
                3'b011:Shift_Result = $signed(Binput) >>> Shamt;//Sra rd,rt,shamt 00011 
                3'b111:Shift_Result = $signed(Binput) >>> Ainput;//Srav rd,rt,rs 00111 
                default:Shift_Result = Binput; 
            endcase 
        end
        else begin 
            Shift_Result = Binput;
        end
    end

    always @* begin 
        if (((ALU_ctl == 3'b111) && (Exe_code[3] == 1)) ||((ALU_ctl == 3'b110) && (Exe_opcode == 6'b001010))|| ((ALU_ctl == 3'b111) && (Exe_opcode == 6'b001011))) begin
            ALU_Result = (AlU_output_mux[31] == 1)? 1 : 0; //set type operation (slt, slti, sltu, sltiu)
        end
        else if((ALU_ctl == 3'b101) && (I_format == 1)) begin
            ALU_Result = {Binput[15:0],16'b0};  //lui operation 
        end
        else if(Sftmd == 1) begin
            ALU_Result = Shift_Result; //shift operation
        end
        else begin
            ALU_Result = AlU_output_mux;//other types of operation in ALU (arithmatic or logic calculation)
        end
    end

    assign Zero = (AlU_output_mux == 32'b0)? 1 : 0;
    assign Addr_Result = PC_plus_4 + (Sign_extend<<2);
endmodule
