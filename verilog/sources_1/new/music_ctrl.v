`timescale 1ns / 1ps

module music_ctrl(clk,rst,cnt);
input clk, rst;// rst active low
output reg [5:0] cnt;

parameter period = 1250000; // every 1/8 second
reg        [25:0] count;
wire                flag;
always @(posedge clk, negedge rst) begin
    if(rst)
        count <= 26'b0;
    else begin
        if(count == period-1'b1) 
            count <= 26'b0;
        else
            count <= count + 1'b1; 
    end
end

assign flag = (count == period - 1'b1);
always @(posedge clk, negedge rst) begin
    if(rst)
        cnt <= 6'b0;
    else begin
        if(flag) 
            cnt <= cnt + 1'b1;
        else
            cnt <= cnt;
    end
end   

endmodule