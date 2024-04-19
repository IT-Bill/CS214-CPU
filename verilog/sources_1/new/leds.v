`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 2022/05/29 17:37:24
// Design Name: 
// Module Name: leds
// Project Name: 
//////////////////////////////////////////////////////////////////////////////////

module leds(led_clk, ledrst, ledwrite, ledcs, ledaddr,ledwdata, ledout);
    input led_clk;    		    
    input ledrst; 		       
    input ledwrite;		       
    input ledcs;		      	
    input[1:0] ledaddr;	       
    input[15:0] ledwdata;	  	
    output[23:0] ledout;		
  
    reg [23:0] ledout;
    
    always@(negedge led_clk or posedge ledrst) begin
        if(ledrst) begin
            ledout <= 24'h000000;
        end
		else if(ledcs && ledwrite) begin
			if(ledaddr == 2'b00)
				ledout[23:0] <= { ledout[23:16], ledwdata[15:0] };
			else if(ledaddr == 2'b10 )
				ledout[23:0] <= { ledwdata[7:0], ledout[15:0] };
			else
				ledout <= ledout;
        end
		else begin
            ledout <= ledout;
        end
    end
endmodule