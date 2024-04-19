`timescale 1ns / 1ps

module music_generate(clk, rst, pwm, beep);
input clk, rst;
input [31:0] pwm;

output reg beep;

reg [31:0] cnt;

always @(posedge clk, negedge rst) begin
    if(rst) begin
        cnt <= 32'd0;
    end
    else if(cnt < pwm - 1'b1) 
    begin
    cnt <= cnt + 1'b1;
    end
    else
    cnt<=32'b0;
end

always @(posedge clk, negedge rst) begin
    if(rst) 
        beep <= 1'b0;
    else
        if(cnt < pwm[31:1])
            beep <= 1'b0;
        else 
            beep <= 1'b1;
    end
endmodule