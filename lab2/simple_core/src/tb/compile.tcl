# ModelSim 10.4b bug: need to delete library if it already exists because vlib work will
# seg fault otherwise.  
if {[file isdirectory work]} {
    vdel -all -lib work
}

# Create library
vlib work

# Compile .sv files.
vlog -work work "../simple_definitions.sv"
vlog -work work "../simple_alu.sv"
vlog -work work "../simple_core.sv"
vlog -work work "../simple_imem.sv"
vlog -work work "../simple_reg_file.sv"
vlog -work work "simple_core_tb.sv"