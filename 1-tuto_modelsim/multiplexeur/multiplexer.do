quit -sim

vlib work

vcom multiplexer.vhd
vcom multiplexer_tb.vhd

vsim -c work.multiplexer_tb

# INPUTS
add wave -divider Inputs:
add wave -color yellow uut/i_sel
add wave -color yellow uut/i_data_0
add wave -color yellow uut/i_data_1

# OUTPUTS
add wave -divider Outputs:
add wave -color blue uut/o_data

run -all