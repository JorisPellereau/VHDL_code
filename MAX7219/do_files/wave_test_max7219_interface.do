onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {MAX7219 INTERFACE} -radix hexadecimal /test_max7219_interface/max_7219_interface_inst/clk
add wave -noupdate -group {MAX7219 INTERFACE} -radix hexadecimal /test_max7219_interface/max_7219_interface_inst/rst_n
add wave -noupdate -group {MAX7219 INTERFACE} -radix hexadecimal /test_max7219_interface/max_7219_interface_inst/i_max7219_data
add wave -noupdate -group {MAX7219 INTERFACE} -radix hexadecimal /test_max7219_interface/max_7219_interface_inst/i_start
add wave -noupdate -group {MAX7219 INTERFACE} -radix hexadecimal /test_max7219_interface/max_7219_interface_inst/i_en_load
add wave -noupdate -group {MAX7219 INTERFACE} -radix hexadecimal /test_max7219_interface/max_7219_interface_inst/o_load_max7219
add wave -noupdate -group {MAX7219 INTERFACE} -radix hexadecimal /test_max7219_interface/max_7219_interface_inst/o_data_max7219
add wave -noupdate -group {MAX7219 INTERFACE} -radix hexadecimal /test_max7219_interface/max_7219_interface_inst/o_clk_max7219
add wave -noupdate -group {MAX7219 INTERFACE} -radix hexadecimal /test_max7219_interface/max_7219_interface_inst/o_max7219_done
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/G_MAX_HALF_PERIOD
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/clk
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/rst_n
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/i_start
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/i_en_load
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/i_data
add wave -noupdate -group {MAX7219 IF} /test_max7219_interface/max7219_if_inst/s_load_px
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/o_max7219_load
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/o_max7219_data
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/o_max7219_clk
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/o_done
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/s_data
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/s_init_data
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/s_en_load
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/s_start
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/s_en_clk
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/s_max7219_data
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/s_max7219_clk
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/s_max7219_clk_p
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/s_max7219_clk_f_edge
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/s_max7219_load
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/s_start_r_edge
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/s_done
add wave -noupdate -group {MAX7219 IF} /test_max7219_interface/max7219_if_inst/s_end_frame
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/s_cnt_half_period
add wave -noupdate -group {MAX7219 IF} /test_max7219_interface/max7219_if_inst/s_cnt_16
add wave -noupdate -group {MAX7219 IF} -radix hexadecimal /test_max7219_interface/max7219_if_inst/s_cnt_15
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {31667203 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 215
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {105 us}
