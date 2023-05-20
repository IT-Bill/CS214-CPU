vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv \
"E:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"E:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 \
"../../../../verilog.srcs/sources_1/ip/uart_bmpg_0_1/uart_bmpg.v" \
"../../../../verilog.srcs/sources_1/ip/uart_bmpg_0_1/upg.v" \
"../../../../verilog.srcs/sources_1/ip/uart_bmpg_0_1/sim/uart_bmpg_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

