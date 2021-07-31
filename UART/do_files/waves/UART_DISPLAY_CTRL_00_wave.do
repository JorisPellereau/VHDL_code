onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {TOP DUT} -radix hexadecimal /tb_top/i_dut/clk
add wave -noupdate -expand -group {TOP DUT} -radix hexadecimal /tb_top/i_dut/rst_n
add wave -noupdate -expand -group {TOP DUT} -radix hexadecimal /tb_top/i_dut/i_rx
add wave -noupdate -expand -group {TOP DUT} -radix hexadecimal /tb_top/i_dut/o_tx
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/clk
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/rst_n
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/i_rx
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/o_tx
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/o_max7219_load
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/o_max7219_data
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/o_max7219_clk
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_static_dyn
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_new_display
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_config_done
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_display_test
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_decod_mode
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_intensity
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_scan_limit
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_shutdown
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_new_config_val
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_en_static
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_rdata_static
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_me_static
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_we_static
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_addr_static
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_wdata_static
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_start_ptr_static
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_last_ptr_static
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_ptr_equality_static
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_static_busy
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_scroller_busy
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_ram_start_ptr_scroller
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_msg_length_scroller
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_max_tempo_cnt_scroller
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_rdata_scroller
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_me_scroller
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_we_scroller
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_addr_scroller
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/s_wdata_scroller
add wave -noupdate -divider <NULL>
add wave -noupdate -group {UART Checker} /tb_top/i_uart_checker_wrapper/s_rx_done_r_edge
add wave -noupdate -group {UART Checker} /tb_top/i_uart_checker_wrapper/o_tx
add wave -noupdate -group {UART Checker} /tb_top/i_uart_checker_wrapper/i_rx
add wave -noupdate -group {UART Checker} /tb_top/i_uart_checker_wrapper/rst_n
add wave -noupdate -group {UART Checker} /tb_top/i_uart_checker_wrapper/clk
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
WaveRestoreZoom {441603025 ps} {447073525 ps}
