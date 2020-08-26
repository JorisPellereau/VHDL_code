onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/clk
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/rst_n
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/i_seg_data
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/i_seg_data_valid
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/i_max_tempo_cnt
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/o_busy
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/i_max7219_if_done
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/o_max7219_if_start
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/o_max7219_if_en_load
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/o_max7219_if_data
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_matrix_array
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_shift_matrix
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_busy
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_segment_cnt
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_matrix_cnt
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_tempo_cnt
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_segment_addr
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_new_data_flag
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_max7219_start
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_max7219_en_load
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_max7219_data
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_max7219_if_done
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_max7219_if_done_r_edge
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_max7219_if_done_f_edge
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_matrix_updated_flag
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_start_tempo
add wave -noupdate -expand -group {MAX7219 SCROLLER I/F} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_tempo_done
add wave -noupdate -expand -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/clk
add wave -noupdate -expand -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/rst_n
add wave -noupdate -expand -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/i_start
add wave -noupdate -expand -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/i_en_load
add wave -noupdate -expand -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/i_data
add wave -noupdate -expand -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/o_max7219_load
add wave -noupdate -expand -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/o_max7219_data
add wave -noupdate -expand -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/o_max7219_clk
add wave -noupdate -expand -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/o_done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 230
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
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {935 ps}
