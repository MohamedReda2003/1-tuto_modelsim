quit -sim

vlib work

vcom counter.vhd
vcom counter_tb.vhd

vsim -c work.counter_tb

# INPUTS
add wave -divider Inputs:
add wave -color yellow uut/i_clk
add wave -color yellow uut/i_rst_n
add wave -color yellow uut/i_en

# OUTPUTS
add wave -divider Outputs:
add wave -radix unsigned uut/o_q

run -all