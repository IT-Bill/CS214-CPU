`timescale 1ns / 1ps


module top(
input clk,
input rst,
input[15:0] ledwdata,
output [7:0] seg_en,
output [7:0] seg_out
    );
    wire clk_out;
    clkout co(clk,rst,clk_out);
    show ss(clk_out,rst,seg_en,seg_out,ledwdata);
endmodule
