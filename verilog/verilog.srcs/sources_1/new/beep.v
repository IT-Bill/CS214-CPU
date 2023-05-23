`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 20:32:23
// Design Name: 
// Module Name: beep
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


module beep(
input clk,
input rst,
input en,
output reg pwm
    );
    reg [31:0]cnt;
    parameter period = 400000;
    always@(posedge clk,negedge rst)
    begin
    if(rst || en)
    begin
        cnt<=0;
    end
    else if(cnt==(period>>1)-1) 
    begin
    cnt<=0;
    pwm<=~pwm;
    end
    else
    cnt<=cnt+1;
    end
endmodule
