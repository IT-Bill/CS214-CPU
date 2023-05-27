-makelib ies_lib/xil_defaultlib -sv \
  "D:/Softwares/Vivado/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Softwares/Vivado/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Softwares/Vivado/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../verilog.srcs/sources_1/ip/clk_wiz/clk_wiz_clk_wiz.v" \
  "../../../../verilog.srcs/sources_1/ip/clk_wiz/clk_wiz.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

