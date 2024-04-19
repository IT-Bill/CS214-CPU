`timescale 1ns / 1ps

module test_sim(
);

    reg fpga_clk;
    reg fpga_rst;
    reg start_pg;
    wire spg_bufg;
    BUFG U1(.I(start_pg), .O(spg_bufg));
//    assign spg_bufg = start_pg;
    
    reg upg_rst;
    always @ (posedge fpga_clk) begin
        if (spg_bufg) upg_rst = 0;
        if (fpga_rst) upg_rst = 1;
    end
    wire rst = fpga_rst | !upg_rst;
    
    initial begin
        {fpga_clk, fpga_rst, start_pg} = 3'b0;
    end
    
    always begin
//        repeat(1000) #10 {fpga_rst, start_pg, upg_rst} = {fpga_rst, start_pg, upg_rst} + 1'b1;
        repeat(1000) #10 {start_pg, fpga_rst} = {start_pg, fpga_rst} + 1'b1;
    end
    
    always begin
        repeat(10000) #1 fpga_clk = ~fpga_clk;
    end
    
endmodule
