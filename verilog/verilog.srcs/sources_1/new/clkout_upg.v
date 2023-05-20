`timescale 1ns / 1ps
module clkout_upg(
input clk,
inout rst,
output reg clk_out
    );
    reg [31:0]cnt;
    parameter period = 500000;
    always@(posedge clk,negedge rst)
    begin
    if(rst)
    begin
        cnt<=0;
    end
    else if(cnt==(period>>1)-1) 
    begin
    cnt<=0;
    clk_out<=~clk_out;
    end
    else
    cnt<=cnt+1;

    end
endmodule