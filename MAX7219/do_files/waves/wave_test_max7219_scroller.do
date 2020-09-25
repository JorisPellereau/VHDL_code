onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/clk
add wave -noupdate -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/rst_n
add wave -noupdate -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/i_start
add wave -noupdate -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/i_en_load
add wave -noupdate -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/i_data
add wave -noupdate -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/o_max7219_load
add wave -noupdate -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/o_max7219_data
add wave -noupdate -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/o_max7219_clk
add wave -noupdate -group {MAX7219 I/F} -radix hexadecimal /test_max7219_scroller/max7219_if_inst_0/o_done
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/clk
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/rst_n
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/i_me
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/i_we
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/i_addr
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/i_wdata
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/o_rdata
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/i_ram_start_ptr
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/i_msg_length
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/i_start_scroll
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/i_max7219_if_done
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/o_max7219_if_start
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/o_max7219_if_en_load
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/o_max7219_if_data
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/o_busy
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/s_me_b
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/s_we_b
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/s_addr_b
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/s_wdata_b
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/s_rdata_b
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/s_seg_data
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/s_seg_data_valid
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/s_max_tempo_cnt
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/s_scroller_if_busy
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/s_done
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/s_start
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/s_en_load
add wave -noupdate -group {MAX7219 SCROLLER CTRL} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/s_data
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/clk
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/rst_n
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/i_seg_data
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/i_seg_data_valid
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/i_max_tempo_cnt
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/o_busy
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/i_max7219_if_done
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/o_max7219_if_start
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/o_max7219_if_en_load
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/o_max7219_if_data
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_matrix_array
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_shift_matrix
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_busy
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_segment_cnt
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_matrix_cnt
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_tempo_cnt
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_segment_addr
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_new_data_flag
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_max7219_start
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_max7219_en_load
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_max7219_data
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_max7219_if_done
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_max7219_if_done_r_edge
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_max7219_if_done_f_edge
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_matrix_updated_flag
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_start_tempo
add wave -noupdate -group {SCROLLER IF} /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_scroller_if_inst_0/s_tempo_done
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/clk
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/rst_n
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/i_start
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/i_msg_length
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/i_ram_start_ptr
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/i_rdata
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/o_me
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/o_we
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/o_addr
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/o_seg_data
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/o_seg_data_valid
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/i_scroller_if_busy
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/o_busy
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_busy
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_start
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_start_r_edge
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_scroller_if_busy
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_scroller_if_busy_f_edge
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_inputs_val
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_we
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_me
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_me_p
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_rdata_valid
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_read_ram_done
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_scroller_access_done
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_msg_length
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_ram_start_ptr
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_ram_addr
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_rdata
add wave -noupdate -expand -group RAM2SCROLLER /test_max7219_scroller/max7219_scroller_ctrl_inst_0/max7219_ram2scroller_if_inst_0/s_access_cnt
add wave -noupdate /test_max7219_scroller/max7219_scroller_ctrl_inst_0/tdpram_inst_0/p_port_a/v_ram
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2067237158 ps} 0}
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
WaveRestoreZoom {0 ps} {4858423605 ps}
