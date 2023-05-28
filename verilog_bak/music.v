`timescale 1ns / 1ps

module music(
    input clk,
    input rst, 
    input musiccs,
    input [4:0] music_data,
    input music_uart_enable,

    output beep
);
wire [4:0] music_hard;
wire [31:0] div;
wire music_rst = rst | ~musiccs;

wire [4:0] music = music_uart_enable ? music_data : music_hard;

wire [5:0] cnt;

music_ctrl ctrl(
    .clk(clk),
    .rst(rst),
    .cnt(cnt)
);

music_mem mem(
    .clk(clk),
    .rst(rst),
    .cnt(cnt),
    
    .music(music_hard)
);

music_pwm pwm(
    .clk(clk),
    .rst(rst),
    .music(music),
    
    .pwm(div)
);

music_generate flow(
    .clk(clk),
    .rst(rst),
    .pwm(div),
    
    .beep(beep)
);

endmodule