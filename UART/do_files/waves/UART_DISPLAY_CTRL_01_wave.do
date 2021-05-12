onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/clk
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/rst_n
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/i_rx
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/o_tx
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/o_max7219_load
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/o_max7219_data
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/o_max7219_clk
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_static_dyn
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_new_display
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_config_done
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_display_test
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_decod_mode
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_intensity
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_scan_limit
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_shutdown
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_new_config_val
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_en_static
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_rdata_static
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_me_static
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_we_static
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_addr_static
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_wdata_static
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_start_ptr_static
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_last_ptr_static
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_ptr_equality_static
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_static_busy
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_scroller_busy
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_ram_start_ptr_scroller
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_msg_length_scroller
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_max_tempo_cnt_scroller
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_rdata_scroller
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_me_scroller
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_we_scroller
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_addr_scroller
add wave -noupdate -group {TOP DUT - Wrapper} -radix hexadecimal /tb_top/i_dut/s_wdata_scroller
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/clk
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/rst_n
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_rx
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_tx
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_static_dyn
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_new_display
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_config_done
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_display_test
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_decod_mode
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_intensity
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_scan_limit
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_shutdown
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_new_config_val
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_en_static
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_rdata_static
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_me_static
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_we_static
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_addr_static
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_wdata_static
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_start_ptr_static
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_last_ptr_static
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_ptr_equality_static
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_busy
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_scroller_busy
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_ram_start_ptr_scroller
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_msg_length_scroller
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_max_tempo_cnt_scroller
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_rdata_scroller
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_me_scroller
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_we_scroller
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_addr_scroller
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/o_wdata_scroller
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_rx_meta
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_rx_stable
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_rx
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_rx_data
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_rx_done
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_parity_rcvd
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_start_tx
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_tx_data
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_tx
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_tx_done
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_data_decod
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_data_valid
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_commands
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_discard
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_rx_data_sel
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_data_static
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_data_static_done
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_data_dyn
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_data_dyn_done
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_data_config
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_data_config_done
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_rx_done_p1
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_rx_done_r_edge
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_init_static_ram_done
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_init_static_ram
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_init_scroller_ram_done
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_init_scroller_ram
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_load_pattern_static
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_load_pattern_static_done
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_load_pattern_scroller
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_load_pattern_scroller_done
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_load_config
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_load_config_done
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_update_config
add wave -noupdate -group {UART CTRL} -radix hexadecimal /tb_top/i_dut/i_uart_max7219_display_ctrl_0/s_update_config_done
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/clk
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/rst_n
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_static_dyn
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_new_display
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_display_test
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_decod_mode
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_intensity
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_scan_limit
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_shutdown
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_new_config_val
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/o_config_done
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_en_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_me_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_we_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_addr_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_wdata_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/o_rdata_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_start_ptr_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_last_ptr_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_loop_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/o_ptr_equality_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/o_static_busy
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_ram_start_ptr_scroller
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_msg_length_scroller
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_max_tempo_cnt_scroller
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/o_scroller_busy
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_me_scroller
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_we_scroller
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_addr_scroller
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/i_wdata_scroller
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/o_rdata_scroller
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/o_max7219_load
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/o_max7219_data
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/o_max7219_clk
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_start_ptr_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_last_ptr_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_ptr_val_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_loop_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_ram_start_ptr_scroller
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_msg_length_scroller
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_start_scroll
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_done_config
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_start_config
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_en_load_config
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_data_config
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_config_done
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_done_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_start_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_en_load_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_data_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_ptr_equality_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_ptr_equality_static_p1
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_discard_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_status_static
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_busy_scroller
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_done_scroller
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_start_scroller
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_en_load_scroller
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_data_scroller
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_start
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_en_load
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_data
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_load
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_data
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_clk
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_done
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_mux_sel
add wave -noupdate -group {Display CTRL} -radix hexadecimal /tb_top/i_dut/i_max7219_display_controller_0/s_new_config_val
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4372093677 ps} 0}
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
WaveRestoreZoom {0 ps} {23051374500 ps}
