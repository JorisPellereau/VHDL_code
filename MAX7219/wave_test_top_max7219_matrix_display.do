onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/clk
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/rst_n
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/o_max7219_load
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/o_max7219_data
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/o_max7219_clk
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/s_decod_mode
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/s_intensity
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/s_scan_limit
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/s_shutdown
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/s_new_config_val
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/s_score
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/s_score_val
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/s_max7219_load
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/s_max7219_data
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/s_max7219_clk
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/s_cnt
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/s_cnt_done
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/s_cnt_2digits
add wave -noupdate -expand -group {TOP DE0 NAN MATRIX ISPLAY} -radix hexadecimal /test_top_max7219_matrix_display/top_max7219_matrix_display_inst_0/s_config_score_sel
add wave -noupdate -expand -group MAX7219_Checker -radix hexadecimal /test_top_max7219_matrix_display/max7219_checker_0/clk
add wave -noupdate -expand -group MAX7219_Checker -radix hexadecimal /test_top_max7219_matrix_display/max7219_checker_0/rst_n
add wave -noupdate -expand -group MAX7219_Checker -radix hexadecimal /test_top_max7219_matrix_display/max7219_checker_0/i_max7219_clk
add wave -noupdate -expand -group MAX7219_Checker -radix hexadecimal /test_top_max7219_matrix_display/max7219_checker_0/i_max7219_data
add wave -noupdate -expand -group MAX7219_Checker -radix hexadecimal /test_top_max7219_matrix_display/max7219_checker_0/i_max7219_load
add wave -noupdate -expand -group MAX7219_Checker -radix hexadecimal /test_top_max7219_matrix_display/max7219_checker_0/s_max7219_data
add wave -noupdate -expand -group MAX7219_Checker -radix hexadecimal /test_top_max7219_matrix_display/max7219_checker_0/s_cnt_15
add wave -noupdate -expand -group MAX7219_Checker -radix hexadecimal /test_top_max7219_matrix_display/max7219_checker_0/s_max7219_clk
add wave -noupdate -expand -group MAX7219_Checker -radix hexadecimal /test_top_max7219_matrix_display/max7219_checker_0/s_max7219_clk_r_edge
add wave -noupdate -expand -group MAX7219_Checker -radix hexadecimal /test_top_max7219_matrix_display/max7219_checker_0/s_cnt_15_done
add wave -noupdate -expand -group MAX7219_Checker /test_top_max7219_matrix_display/max7219_checker_0/s_config_after_load
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {501887394 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 225
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
configure wave -timelineunits us
update
WaveRestoreZoom {555217596 ps} {599368583 ps}
