`timescale 1ns / 1ps


module cpu_sim(

    );
    reg fpga_clk;
    reg fpga_rst;
    reg [23:0] switch;
    wire [23:0] led;

    
    cpu CPU(
        .fpga_clk(fpga_clk),
        .fpga_rst(fpga_rst),
        .switch(switch),
        .start_pg(0),

        .led(led)
    );

    initial begin
        fpga_clk = 0;
        switch = 0;
    end

    always begin
        forever begin
            #1 fpga_clk <= ~fpga_clk;
        end
    end
    
    always begin
        forever begin
            #10 fpga_rst = 0;
            #10 fpga_rst = 1;
            #10 fpga_rst = 0;
            
            #100 switch = 24'h000400;
            
//            #2000 switch = 24'h000800;
            
            #200000;
        end
    end
    



endmodule
