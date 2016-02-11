# Load simulation
vsim work.simple_core_tb

add wave -noupdate -group{core} -radix hexadecimal /core_tb/dut/*

configure wave -signalnamewidth 1
