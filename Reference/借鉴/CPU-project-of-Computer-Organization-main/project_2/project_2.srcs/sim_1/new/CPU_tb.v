`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/16 10:50:33
// Design Name: 
// Module Name: CPU_tb
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


module CPU_tb();
reg clk;
reg rst;
reg[23:0] switch;
wire[23:0] led;
wire [3:0] col;
//wire [7:0] seg_en;
//wire [7:0] seg_out;
cpu tt(clk,rst,switch,led,col);

always #1 clk = ~clk;
initial begin
clk = 1'b0;
rst = 1'b1;
switch = 0;
#1 rst = 1'b0;
repeat(5000000)
#10 switch = switch+1;
#10 $finish;
end
endmodule