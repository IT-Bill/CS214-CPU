-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Fri May 26 14:37:31 2023
-- Host        : Bill running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               P:/CS214-Computer-Organization/CS214-Computer-Organization-Project/verilog/verilog.srcs/sources_1/ip/clkout_upg/clkout_upg_stub.vhdl
-- Design      : clkout_upg
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tfgg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clkout_upg is
  Port ( 
    clk_out1 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clkout_upg;

architecture stub of clkout_upg is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out1,reset,locked,clk_in1";
begin
end;
