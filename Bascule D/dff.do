quit -sim

vlib work

vcom dff.vhd
vcom dff_tb.vhd

vsim -c work.dff_tb

# INPUTS
add wave -divider Inputs:
add wave -color yellow uut/i_clk
add wave -color yellow uut/i_rst_n
add wave -color yellow uut/i_en
add wave -color yellow uut/i_d

# OUTPUTS
add wave -divider Outputs:
add wave uut/o_q

run -all