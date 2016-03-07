# Load simulation
vsim work.miner_tb

#                       Group Name                  Radix               Signal(s)
#add wave    -noupdate   -group {miner_tb}            -radix hexadecimal  /miner_tb/*
add wave    -noupdate   -group {core}               -radix hexadecimal  /miner_tb/dut/core1/*

add wave    -noupdate   -group {debug}              -radix unsigned     /miner_tb/cycle_counter_r
add wave    -noupdate   -group {debug}              -radix unsigned     /miner_tb/instruction_count

add wave    -noupdate   -group {PC}                 -radix decimal  /miner_tb/dut/core1/PC_n
add wave    -noupdate   -group {PC}                 -radix decimal  /miner_tb/dut/core1/PC_r
add wave    -noupdate   -group {PC}                 -radix decimal  /miner_tb/dut/core1/pc_plus1
add wave    -noupdate   -group {PC}                 -radix binary  /miner_tb/dut/core1/PC_wen

#add wave    -noupdate   -group {instr_mem}          -radix hexadecimal  /miner_tb/dut/core1/imem/*

# TODO: add waveform group for cl_decode here.

add wave    -noupdate   -group {reg_file}           -radix hexadecimal  /miner_tb/dut/core1/rf/*
add wave    -noupdate   -group {alu}                -radix hexadecimal  /miner_tb/dut/core1/alu_1/rd_i
add wave    -noupdate   -group {alu}                -radix hexadecimal  /miner_tb/dut/core1/alu_1/rs_i
add wave    -noupdate   -group {alu}                -radix hexadecimal  /miner_tb/dut/core1/alu_1/op_i
add wave    -noupdate   -group {alu}                -radix hexadecimal  /miner_tb/dut/core1/alu_1/result_o
add wave    -noupdate   -group {alu}                -radix hexadecimal  /miner_tb/dut/core1/alu_1/branch_taken_o

add wave    -noupdate   -group {dmem}               -radix hexadecimal  /miner_tb/dut/core1/to_mem_o
add wave    -noupdate   -group {dmem}               -radix hexadecimal  /miner_tb/dut/core1/from_mem_i
add wave    -noupdate   -group {dmem}               -radix symbolic     /miner_tb/dut/core1/mem_stage_n
add wave    -noupdate   -group {dmem}               -radix symbolic     /miner_tb/dut/core1/mem_stage_r


add wave 	-noupdate	-group {important}	       -radix hexadecimal  /miner_tb/dut/core1/clk
add wave    -noupdate   -group {important}         -radix symbolic     /miner_tb/dut/core1/imem_out_p
add wave    -noupdate   -group {important}         -radix decimal      /miner_tb/dut/core1/PC_n
add wave    -noupdate   -group {important}         -radix decimal      /miner_tb/dut/core1/PC_r

add wave    -noupdate   -group {pipe1}             -radix symbolic     /miner_tb/dut/core1/instruction_1_r_p
add wave    -noupdate   -group {pipe1}             -radix decimal      /miner_tb/dut/core1/PC_1_r

add wave    -noupdate   -group {pipe2}             -radix symbolic     /miner_tb/dut/core1/instruction_2_r_p
add wave    -noupdate   -group {pipe2}             -radix decimal      /miner_tb/dut/core1/PC_2_r
add wave    -noupdate   -group {pipe2}             -radix hexadecimal  /miner_tb/dut/core1/rs_addr_2_r
add wave    -noupdate   -group {pipe2}             -radix hexadecimal  /miner_tb/dut/core1/rd_addr_2_r
add wave    -noupdate   -group {pipe2}             -radix decimal      /miner_tb/dut/core1/rs_val_2_r
add wave    -noupdate   -group {pipe2}             -radix decimal      /miner_tb/dut/core1/rd_val_2_r

add wave    -noupdate   -group {pipe3}             -radix symbolic     /miner_tb/dut/core1/instruction_3_r_p
add wave    -noupdate   -group {pipe3}             -radix hexadecimal  /miner_tb/dut/core1/wd_addr_3_r
add wave    -noupdate   -group {pipe3}             -radix decimal      /miner_tb/dut/core1/wd_val_3_r

#add wave    -noupdate   -group {cl_state_machine}   -radix hexadecimal  /miner_tb/dut/core1/state_machine/*

# Use short names
configure wave -signalnamewidth 1
