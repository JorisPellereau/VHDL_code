onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/clk
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/rst_n
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_static_dyn
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_new_display
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_display_test
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_decod_mode
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_intensity
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_scan_limit
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_shutdown
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_new_config_val
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/o_config_done
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_en_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_me_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_we_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_addr_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_wdata_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/o_rdata_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_start_ptr_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_last_ptr_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_ptr_val_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_loop_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/o_ptr_equality_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/o_static_busy
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_ram_start_ptr_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_msg_length_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_start_scroll
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_max_tempo_cnt_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/o_scroller_busy
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_me_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_we_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_addr_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/i_wdata_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/o_rdata_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/o_max7219_load
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/o_max7219_data
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/o_max7219_clk
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_start_ptr_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_last_ptr_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_ptr_val_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_loop_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_ram_start_ptr_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_msg_length_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_start_scroll
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max_tempo_cnt_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_done_config
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_start_config
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_en_load_config
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_data_config
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_config_done
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_done_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_start_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_en_load_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_data_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_ptr_equality_static
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_busy_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_done_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_start_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_en_load_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_data_scroller
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_start
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_en_load
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_data
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_load
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_data
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_clk
add wave -noupdate -expand -group {DISPLAY CONTROLLER TOP} -radix hexadecimal /tb_top/i_dut/s_max7219_if_done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {97 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 320
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
WaveRestoreZoom {0 ps} {105346500 ps}
