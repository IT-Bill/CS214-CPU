// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Sun May 28 02:19:02 2023
// Host        : Bill running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               p:/CS214-Computer-Organization/Project-scene1/verilog/verilog.srcs/sources_1/ip/clk_wiz/clk_wiz_stub.v
// Design      : clk_wiz
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz(cpu_clk, upg_clk, clk_in)
/* synthesis syn_black_box black_box_pad_pin="cpu_clk,upg_clk,clk_in" */;
  output cpu_clk;
  output upg_clk;
  input clk_in;
endmodule
