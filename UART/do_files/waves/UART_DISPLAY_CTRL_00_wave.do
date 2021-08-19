onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {TOP DUT} -radix hexadecimal /tb_top/i_dut/clk
add wave -noupdate -group {TOP DUT} -radix hexadecimal /tb_top/i_dut/rst_n
add wave -noupdate -group {TOP DUT} -radix hexadecimal /tb_top/i_dut/i_rx
add wave -noupdate -group {TOP DUT} -radix hexadecimal /tb_top/i_dut/o_tx
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/clk
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/rst_n
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/i_rx
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/o_tx
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/o_max7219_load
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/o_max7219_data
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/o_max7219_clk
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_static_dyn
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_new_display
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_config_done
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_display_test
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_decod_mode
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_intensity
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_scan_limit
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_shutdown
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_new_config_val
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_en_static
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_rdata_static
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_me_static
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_we_static
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_addr_static
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_wdata_static
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_start_ptr_static
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_last_ptr_static
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_ptr_equality_static
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_static_busy
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_scroller_busy
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_ram_start_ptr_scroller
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_msg_length_scroller
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_max_tempo_cnt_scroller
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_rdata_scroller
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_me_scroller
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_we_scroller
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_addr_scroller
add wave -noupdate -group {TOP DUT} /tb_top/i_dut/s_wdata_scroller
add wave -noupdate -divider <NULL>
add wave -noupdate -group {UART Checker} /tb_top/i_uart_checker_wrapper/s_rx_done_r_edge
add wave -noupdate -group {UART Checker} /tb_top/i_uart_checker_wrapper/o_tx
add wave -noupdate -group {UART Checker} /tb_top/i_uart_checker_wrapper/i_rx
add wave -noupdate -group {UART Checker} /tb_top/i_uart_checker_wrapper/rst_n
add wave -noupdate -group {UART Checker} /tb_top/i_uart_checker_wrapper/clk
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/clk
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/rst_n
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/i_start
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/i_en_load
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/i_data
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/o_max7219_load
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/o_max7219_data
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/o_max7219_clk
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/o_done
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_data
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_en_load
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_start
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_init_data
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_en_clk
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_max7219_data
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_max7219_clk
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_max7219_clk_p
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_max7219_clk_f_edge
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_max7219_clk_r_edge
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_max7219_load
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_start_r_edge
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_done
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_cnt_15
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_cnt_16
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_cnt_half_period
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_load_px
add wave -noupdate -expand -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_end_frame
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3251258626 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 296
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
WaveRestoreZoom {400043325 ps} {6529239825 ps}
