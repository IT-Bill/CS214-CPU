`timescale 1ns / 1ps

module music_pwm(clk, rst, music, pwm);
input clk, rst;
input [4:0] music;

output reg [31:0]  pwm;

reg [31:0] frequncy;
always @* begin
    case(music)
        5'd1 : frequncy = 32'd262; //_do
        5'd2 : frequncy = 32'd294; //_re
        5'd3 : frequncy = 32'd330; //_mi
        5'd4 : frequncy = 32'd349; //_fa
        5'd5 : frequncy = 32'd392; //_so
        5'd6 : frequncy = 32'd440; //_la
        5'd7 : frequncy = 32'd494; //_si

        5'd8 :  frequncy = 32'd523; //do
        5'd9 :  frequncy = 32'd587; //re
        5'd10 : frequncy = 32'd659; //mi
        5'd11 : frequncy = 32'd699; //fa
        5'd12 : frequncy = 32'd784; //so
        5'd13 : frequncy = 32'd880; //la
        5'd14 : frequncy = 32'd988; //si

        5'd15 : frequncy = 32'd1050; //#do
        5'd16 : frequncy = 32'd1175; //#re
        5'd17 : frequncy = 32'd1319; //#mi
        5'd18 : frequncy = 32'd1397; //#fa
        5'd19 : frequncy = 32'd1568; //#so
        5'd20 : frequncy = 32'd1760; //#la
        5'd21 : frequncy = 32'd1976; //#si

        default : frequncy = 32'd1;
    endcase
end

always @ (posedge clk, negedge rst) begin
    if(rst)
        pwm <= 10**7;
    else 
        pwm <= (10**7) / frequncy;
end

endmodule