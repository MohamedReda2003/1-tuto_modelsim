quit -sim

vlib work

vcom hdmi_controler.vhd
vcom hdmi_controler_tb.vhd

vsim -c work.hdmi_controler_tb

# INPUTS
add wave -divider Inputs:
add wave -color yellow uut/i_clk
add wave -color yellow uut/i_rst_n

#HORIZONTAL
add wave -divider Horizontal:
add wave -color yellow uut/r_h_counter
add wave -color yellow uut/r_h_active

#ADV7513
add wave -divider ADV7513:
add wave -color yellow uut/o_hdmi_hs
add wave -color yellow uut/o_hdmi_vs
add wave -color yellow uut/o_hdmi_de

#PIXEL
add wave -divider PIXEL:
add wave -color yellow uut/o_pixel_en
add wave -color yellow uut/o_pixel_address
add wave -color yellow uut/o_x_counter
add wave -color yellow uut/o_y_counter



run -all