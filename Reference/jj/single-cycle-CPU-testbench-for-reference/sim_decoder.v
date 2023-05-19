`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/30 11:10:28
// Design Name: 
// Module Name: sim_decoder
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


module sim_decoder();
    reg [31:0]Instruction,mem_data,ALU_result,opcplus4;
    wire [31:0]read_data_1,read_data_2,Sign_extend;
    reg clock,reset,Jal,RegWrite,MemtoReg,RegDst;
    decoder32 u3(.read_data_1(read_data_1),.read_data_2(read_data_2),.Instruction(Instruction),.mem_data(mem_data),.ALU_result(ALU_result),
    .Jal(Jal),.RegWrite(RegWrite),.MemtoReg(MemtoReg),.RegDst(RegDst),.Sign_extend(Sign_extend),.clock(clock),.reset(reset),.opcplus4(opcplus4));
    
    initial #390 $finish;
    initial begin
        clock = 1'b0;
        forever #5 clock = ~clock;
    end
    initial begin
        reset =1'b1;
        mem_data=32'h0;
        ALU_result=32'h0;
        opcplus4=32'h0;
        Instruction = 32'h35290000;
    end
	integer i=0;
    initial begin
         #10 i=i+1; 
        //andi $t0, $t0, 0xFF
        //关键参数 
        Instruction = 32'h310800ff;
        RegWrite=1'b1;
        MemtoReg=1'b0; 
        Jal=1'b0; 
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);
         #10 i=i+1; 

         #10 i=i+1; 
        //andi $t7, $t7, 0xFFFF - t7(15)
        //关键参数 
        Instruction = 32'h31efffff;
        RegWrite=1'b1;
        MemtoReg=1'b0; 
        Jal=1'b0; 
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);
         #10 i=i+1; 

        //jump
        //j 0x0040000
        //关键参数 
        // Instruction = 32'h08100000; //原0BFFFFFF
        // RegWrite=1'b0;
        // MemtoReg=1'b0;
        // Jal=1'b0;
        // RegDst=1'b0;
        // $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        // $strobe($time,",0x%8x 0x%8x %d",read_data_1,read_data_2,Sign_extend);
        // #10 i=i+1; 
        //jump
        //j 0x00400004
        //关键参数 
        // Instruction = 32'h08100001;
        // RegWrite=1'b0;
        // MemtoReg=1'b0;
        // Jal=1'b0;
        // RegDst=1'b0;
        // $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        // $strobe($time,",0x%8x 0x%8x %d",read_data_1,read_data_2,Sign_extend);
        
        #10 i=i+1;
        //ORI $t1 $t1 0xffff
        //关键参数 RegWrite=1'b1;
        Instruction = 32'h3529ffff;
        ALU_result=32'h0101;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        reset =1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x 0x%8x",read_data_1,Sign_extend);
		
		#10 i=i+1;
        //ORI $t1 $t1 0x1111
        //关键参数 RegWrite=1'b1;
        Instruction = 32'h35291111;
        ALU_result=32'h0101;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        reset =1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x %d",read_data_1,Sign_extend);
    
        #10 i=i+1;
        //XORI $t1 $t1 0x1111
        //关键参数 RegWrite=1'b1;
        Instruction = 32'h39291111;
        ALU_result=32'h0202;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);
		
		#10 i=i+1;
        //XORI $t1 $t1 0xffff
        //关键参数 RegWrite=1'b1;
        Instruction = 32'h3929ffff;
        ALU_result=32'h0202;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);

        #10 i=i+1;
        //SLTIU $t1 $t1 0x1111
        //关键参数 RegWrite=1'b1;
        Instruction = 32'h2d291111;
        ALU_result=32'h0303;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);
		
		 #10 i=i+1;
        //SLTIU $t1 $t1 0xffff
        //关键参数 RegWrite=1'b1;
        Instruction = 32'h2d29ffff;
        ALU_result=32'h0303;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);
		
	       
        #10 i=i+1;
        //addi $t1, $t2, 0x1111
        //关键参数 RegWrite=1'b1;
        Instruction = 32'h21491111;
        ALU_result=32'h0404;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);
     	
        #10 i=i+1;
        //addiu $t1,$t2, 0x1111
        //关键参数 RegWrite=1'b1;
        Instruction = 32'h25491111;
        ALU_result=32'h0505;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);
         
        #10 i=i+1;
        //slti $t1, $t2, 0xffff
        //关键参数 RegWrite=1'b1;
        Instruction = 32'h2949ffff;
        ALU_result=32'h0606;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);
        
        /*#10 i=i+1;
        //lui $t1, 0xffff
        //关键参数 RegWrite=1'b1;
        Instruction = 32'h3c09ffff;
        ALU_result=32'h0707;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);*/
      
        #10 i=i+1; 
        //beq $t2, $t1, 0x0000
        //关键参数 RegWrite=1'b1;
        Instruction = 32'h11490000;
        ALU_result=32'h0808;
        RegWrite=1'b0;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
       
        #10 i=i+1;
        //bne $t2, $t1, 0x8000
        //关键参数 RegWrite=1'b1;
        Instruction = 32'h15498000;
        ALU_result=32'h0909;
        RegWrite=1'b0;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
       
        #10 i=i+1;
        //SLL $t1 $t1 0xa
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h00094A80;
        ALU_result=32'h1010;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
      
        #10 i=i+1;
        //srl $t1 $t1 0xa
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h00094A82;
        ALU_result=32'h1111;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
  
        #10 i=i+1; 
        //SRA $t1 $t1 0xa
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h00094A83;
        ALU_result=32'h1212;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
   
        #10 i=i+1; 
        //SRLV $t1 $t1 $t1
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h01294806;
        ALU_result=32'h1313;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
 
        #10 i=i+1; 
        //SLLV $t1 $t1 $t1
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h01294804;
        ALU_result=32'h1414;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
  
        #10 i=i+1; 
        //SRAV $t1 $t1 $t1
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h01294807;
        ALU_result=32'h1515;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);

        #10 i=i+1; 
        //ADD $t1 $t1 $t1
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h01294820;
        ALU_result=32'h1616;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
 
        #10 i=i+1; 
        //ADDU $t1 $t1 $t1
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h01294821;
        ALU_result=32'h1717;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);

        #10 i=i+1; 
        //SUB $t1 $t1 $t1
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h01294822;
        ALU_result=32'h1818;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
  
        #10 i=i+1; 
        //SUBU $t1 $t1 $t1
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h01294823;
        ALU_result=32'h1919;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
 
        #10 i=i+1; 
        //AND $t1 $t1 $t1
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h01294824;
        ALU_result=32'h2020;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
   
        #10 i=i+1; 
        //OR $t1 $t1 $t1
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h01294825;
        ALU_result=32'h2121;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
       $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
 
        #10 i=i+1;
        //XOR $t1 $t1 $t1
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h01294826;
        ALU_result=32'h2222;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
       $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);

        #10 i=i+1; 
        //NOR $t1 $t1 $t1
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h01294827;
        ALU_result=32'h2323;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
  
        #10 i=i+1; 
        //SLT $t1 $t1 $t1
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h0129482A;
        ALU_result=32'h2424;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
       $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);

        #10 i=i+1; 
        //SLTU $t1 $t1 $t1
        //关键参数 RegWrite=1'b1; RegDst=1'b1;
        Instruction = 32'h0129482B;
        ALU_result=32'h2525;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b1;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
 
        #10 i=i+1; 
        //JAL 0x0000021
        //关键参数 RegWrite=1'b1; Jal=1'b1;
        Instruction = 32'h0c000021;
        opcplus4=32'h2626;
        ALU_result=32'h0;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b1;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
 
        #10 i=i+1; 
        //sw $ra,100($t1)
        //关键参数 
        Instruction = 32'hAD3F0064;
        RegWrite=1'b0;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);
 
        #10 i=i+1; 
        //jal 0x0000ffff
        //关键参数 RegWrite=1'b1; Jal=1'b1;
        Instruction = 32'h0C00FFFF;
        opcplus4=32'h2828;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b1;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);
  
        #10 i=i+1; 
        //sw $ra,100($t1)
        //关键参数 
        Instruction = 32'hAD3F0064;
        RegWrite=1'b0;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
       $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);
 
        #10 i=i+1; 
        //jr $ra
        //关键参数
        Instruction = 32'h03e00008;
        RegWrite=1'b0;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,read_data_2);

        #10 i=i+1; 
        //lw $t1, 100($t1)
        //关键参数 RegWrite=1'b1; MemtoReg=1'b1;
        Instruction = 32'h8d290064;
        mem_data=32'h3131;
        opcplus4=32'h0;
        RegWrite=1'b1;
        MemtoReg=1'b1;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);

        #10 i=i+1; 
        //sw $t1,100($t1)
        //关键参数
        Instruction = 32'hAD290064;
        RegWrite=1'b0;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);
 
        #10 i=i+1; 
        //lw $t1, -100($t1)
        //关键参数 RegWrite=1'b1; MemtoReg=1'b1;
        Instruction = 32'h8d29ff9c;
        mem_data=32'h3333;
        RegWrite=1'b1;
        MemtoReg=1'b1;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);
   
        #10 i=i+1; 
        //sw $t1,100($t1)
        //关键参数 
        Instruction = 32'hAD290064;
        RegWrite=1'b0;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);
  
        #10 i=i+1; 
        //ADDI $zero,$zero,0x8000
        //关键参数 RegWrite=1'b1; MemtoReg=1'b1;
        Instruction = 32'h20008000;
        ALU_result=32'h8000;
        RegWrite=1'b1;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x  0x%8x",read_data_1,Sign_extend);
 
        #10 i=i+1; 
        //sw $zero,100($t1)
        //关键参数 
        Instruction = 32'hAD200064;
        RegWrite=1'b0;
        MemtoReg=1'b0;
        Jal=1'b0;
        RegDst=1'b0;
        $strobe("@@@@@@@@@@%d@@@@@@@@@@",i);
        $strobe($time,",0x%8x %8x",read_data_1,Sign_extend);

       

       
        
    end   
endmodule
