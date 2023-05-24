`timescale 1ns / 1ps

module divider (
    input clk,
    input rst,
    input [31:0] frequency,
    output reg clk_out
);
    wire [31:0] period = 10 ** 8 / frequency;
    reg [31:0] cnt;
    always @(posedge clk, negedge rst) begin
        if (rst) begin
            cnt <= 0;
        end

        else if (cnt == period - 1) begin
            cnt <= 0;
            clk_out <= ~clk_out;
        end

        else
            cnt <= cnt + 1;
        
    end
    
endmodule