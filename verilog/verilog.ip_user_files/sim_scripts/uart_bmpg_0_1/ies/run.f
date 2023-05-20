-makelib ies_lib/xil_defaultlib -sv \
  "E:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "E:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../verilog.srcs/sources_1/ip/uart_bmpg_0_1/uart_bmpg.v" \
  "../../../../verilog.srcs/sources_1/ip/uart_bmpg_0_1/upg.v" \
  "../../../../verilog.srcs/sources_1/ip/uart_bmpg_0_1/sim/uart_bmpg_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

