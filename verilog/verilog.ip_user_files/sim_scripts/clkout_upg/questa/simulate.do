onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib clkout_upg_opt

do {wave.do}

view wave
view structure
view signals

do {clkout_upg.udo}

run -all

quit -force
