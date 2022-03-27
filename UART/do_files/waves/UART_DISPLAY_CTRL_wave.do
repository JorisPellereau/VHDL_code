onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/clk
add wave -noupdate -expand -group {TOP DUT} /tb_top/i_dut/rst_n
add wave -noupdate -expand -group {TOP DUT} -expand -group {UART I/F} /tb_top/i_dut/i_rx
add wave -noupdate -expand -group {TOP DUT} -expand -group {UART I/F} /tb_top/i_dut/o_tx
add wave -noupdate -expand -group {TOP DUT} -expand -group {MAX7219 Outputs} /tb_top/i_dut/o_max7219_load
add wave -noupdate -expand -group {TOP DUT} -expand -group {MAX7219 Outputs} /tb_top/i_dut/o_max7219_data
add wave -noupdate -expand -group {TOP DUT} -expand -group {MAX7219 Outputs} /tb_top/i_dut/o_max7219_clk
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_static_dyn
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_new_display
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_config_done
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_display_test
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_decod_mode
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_intensity
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_scan_limit
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_shutdown
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_new_config_val
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_en_static
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_rdata_static
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_me_static
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_we_static
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_addr_static
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_wdata_static
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_start_ptr_static
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_last_ptr_static
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_ptr_equality_static
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_static_busy
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_scroller_busy
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_ram_start_ptr_scroller
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_msg_length_scroller
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_max_tempo_cnt_scroller
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_rdata_scroller
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_me_scroller
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_we_scroller
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_addr_scroller
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} /tb_top/i_dut/s_wdata_scroller
add wave -noupdate -divider <NULL>
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/clk
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/rst_n
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_static_dyn
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_new_display
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_display_test
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_decod_mode
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_intensity
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_scan_limit
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_shutdown
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_new_config_val
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/o_config_done
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_en_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_me_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_we_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_addr_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_wdata_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/o_rdata_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_start_ptr_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_last_ptr_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_loop_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/o_ptr_equality_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/o_static_busy
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_ram_start_ptr_scroller
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_msg_length_scroller
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_max_tempo_cnt_scroller
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/o_scroller_busy
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_me_scroller
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_we_scroller
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_addr_scroller
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/i_wdata_scroller
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/o_rdata_scroller
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/o_max7219_load
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/o_max7219_data
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/o_max7219_clk
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_start_ptr_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_last_ptr_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_ptr_val_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_loop_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_ram_start_ptr_scroller
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_msg_length_scroller
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_start_scroll
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_done_config
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_start_config
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_en_load_config
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_data_config
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_config_done
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_done_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_start_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_en_load_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_data_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_ptr_equality_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_ptr_equality_static_p1
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_discard_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_status_static
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_busy_scroller
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_done_scroller
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_start_scroller
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_en_load_scroller
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_data_scroller
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_start
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_en_load
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_data
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_load
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_data
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_clk
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_max7219_if_done
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_mux_sel
add wave -noupdate -group DISPLAY_CTRL_TOP /tb_top/i_dut/i_max7219_display_controller_0/s_new_config_val
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/clk
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/rst_n
add wave -noupdate -group UART_SEQ -expand /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_cmd_pulses
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_cmd_discard
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/o_rx_data_sel
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_init_static_ram_done
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_run_pattern_scroller_rdy
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_run_pattern_scroller_done
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_run_pattern_scroller_discard
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_load_tempo_scroller_done
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/o_init_static_ram
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/o_load_pattern_static
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_load_pattern_static_done
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_init_scroller_ram_done
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/o_init_scroller_ram
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/o_load_pattern_scroller
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_load_pattern_scroller_done
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/o_load_config
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_load_config_done
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/o_update_config
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_update_config_done
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/o_run_pattern_static
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_run_pattern_static_rdy
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_run_pattern_static_done
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_run_pattern_static_discard
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/o_run_pattern_scroller
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/o_load_tempo_scroller
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/i_tx_done
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/o_tx_uart_start
add wave -noupdate -group UART_SEQ -radix ascii /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/o_tx_data
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_init_static_ram
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_init_scroller_ram
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_load_pattern_static
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_load_pattern_scroller
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_tx_uart_start
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_tx_data
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_resp_ongoing
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_cnt_tx_data
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_resp_done
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_rx_data_sel
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_tx_done
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_tx_done_r_edge
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_first_access
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_index_resp
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_load_matrix
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_update_matrix
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_run_pattern_static
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_run_pattern_scroller
add wave -noupdate -group UART_SEQ /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_sequencer_uart_cmd_0/s_load_tempo_scroller
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/clk
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/rst_n
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/i_rdata_static
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/i_init_static_ram
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/i_load_static_ram
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/o_me_static
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/o_we_static
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/o_addr_static
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/o_wdata_static
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/o_init_static_ram_done
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/o_load_static_ram_done
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/i_rx_data
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/i_rx_done
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/s_wr_ptr
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/s_init_ram_ongoing
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/s_init_static_ram_done
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/s_load_static_ram_ongoing
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/s_load_static_ram_done
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/s_me_static
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/s_we_static
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/s_wdata_static
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/s_cnt_rx_data
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/s_cnt_2
add wave -noupdate -group STATIC_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_static_ram_mngr/s_data_rdy
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/clk
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/rst_n
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/i_rdata_dyn
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/o_me_dyn
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/o_we_dyn
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/o_addr_dyn
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/o_wdata_dyn
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/i_init_dyn_ram
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/o_init_dyn_ram_done
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/i_load_dyn_ram
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/o_load_dyn_ram_done
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/i_rx_data
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/i_rx_done
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/s_wr_ptr
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/s_init_ram_ongoing
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/s_init_dyn_ram_done
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/s_load_dyn_ram_ongoing
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/s_load_dyn_ram_done
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/s_me_dyn
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/s_we_dyn
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/s_wdata_dyn
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/s_cnt_rx_data
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/s_start_ptr
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/s_last_ptr
add wave -noupdate -group SCROLLER_RAM_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_dyn_ram_mngr_0/s_data_rdy
add wave -noupdate -group {UART CMD DECOD} /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_uart_cmd_decod_0/clk
add wave -noupdate -group {UART CMD DECOD} /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_uart_cmd_decod_0/rst_n
add wave -noupdate -group {UART CMD DECOD} /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_uart_cmd_decod_0/i_data
add wave -noupdate -group {UART CMD DECOD} /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_uart_cmd_decod_0/i_data_valid
add wave -noupdate -group {UART CMD DECOD} -expand /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_uart_cmd_decod_0/o_commands
add wave -noupdate -group {UART CMD DECOD} /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_uart_cmd_decod_0/o_discard
add wave -noupdate -group {UART CMD DECOD} /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_uart_cmd_decod_0/s_cmd_2_store
add wave -noupdate -group {UART CMD DECOD} /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_uart_cmd_decod_0/s_cnt_data
add wave -noupdate -group {UART CMD DECOD} /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_uart_cmd_decod_0/s_cnt_data_done
add wave -noupdate -group {UART CMD DECOD} /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_uart_cmd_decod_0/s_commands
add wave -noupdate -group {UART CMD DECOD} /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_uart_cmd_decod_0/s_discard
add wave -noupdate -group {UART CMD DECOD} /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_uart_cmd_decod_0/s_cmd_check
add wave -noupdate -group {UART CMD DECOD} /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_uart_cmd_decod_0/s_raz_cnt
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/clk
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/rst_n
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/i_config_done
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/i_load_config
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/o_load_config_done
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/i_update_config
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/o_update_config_done
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/o_display_test
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/o_decod_mode
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/o_intensity
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/o_scan_limit
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/o_shutdown
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/i_rx_data
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/i_rx_done
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/s_load_config_ongoing
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/s_update_config_ongoing
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/s_update_config_done
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/s_cnt_5
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/s_load_config_done
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/s_display_test
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/s_decod_mode
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/s_intensity
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/s_scan_limit
add wave -noupdate -expand -group MATRIX_CONFIG_MNGR /tb_top/i_dut/i_uart_max7219_display_ctrl_0/i_matrix_config_mngr_0/s_shutdown
add wave -noupdate -divider <NULL>
add wave -noupdate -label v_ram_STATIC /tb_top/i_dut/i_max7219_display_controller_0/max7219_cmd_decod_inst_0/tdpram_inst_0/v_ram
add wave -noupdate -label v_ram_SCROLLER /tb_top/i_dut/i_max7219_display_controller_0/max7219_scroller_ctrl_inst_0/tdpram_inst_0/v_ram
add wave -noupdate -divider <NULL>
add wave -noupdate -expand -group {UART Checker} /tb_top/i_uart_checker_wrapper/s_rx_done_r_edge
add wave -noupdate -expand -group {UART Checker} -expand /tb_top/i_uart_checker_wrapper/o_tx
add wave -noupdate -expand -group {UART Checker} -expand /tb_top/i_uart_checker_wrapper/i_rx
add wave -noupdate -expand -group {UART Checker} /tb_top/i_uart_checker_wrapper/rst_n
add wave -noupdate -expand -group {UART Checker} /tb_top/i_uart_checker_wrapper/clk
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/clk
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/rst_n
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/i_start
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/i_en_load
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/i_data
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/o_max7219_load
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/o_max7219_data
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/o_max7219_clk
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/o_done
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_data
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_en_load
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_start
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_init_data
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_en_clk
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_max7219_data
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_max7219_clk
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_max7219_clk_p
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_max7219_clk_f_edge
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_max7219_clk_r_edge
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_max7219_load
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_start_r_edge
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_done
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_cnt_15
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_cnt_16
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_cnt_half_period
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_load_px
add wave -noupdate -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_display_controller_0/max7219_if_inst_0/s_end_frame
add wave -noupdate -expand -group {UART CHECKER IF} /tb_top/i_uart_checker_wrapper/uart_checker_if/clk
add wave -noupdate -expand -group {UART CHECKER IF} /tb_top/i_uart_checker_wrapper/uart_checker_if/G_BUFFER_ADDR_WIDTH
add wave -noupdate -expand -group {UART CHECKER IF} /tb_top/i_uart_checker_wrapper/uart_checker_if/G_DATA_WIDTH
add wave -noupdate -expand -group {UART CHECKER IF} /tb_top/i_uart_checker_wrapper/uart_checker_if/G_NB_UART_CHECKER
add wave -noupdate -expand -group {UART CHECKER IF} /tb_top/i_uart_checker_wrapper/uart_checker_if/parity_rcvd
add wave -noupdate -expand -group {UART CHECKER IF} /tb_top/i_uart_checker_wrapper/uart_checker_if/rx_data
add wave -noupdate -expand -group {UART CHECKER IF} /tb_top/i_uart_checker_wrapper/uart_checker_if/rx_done
add wave -noupdate -expand -group {UART CHECKER IF} -subitemconfig {{/tb_top/i_uart_checker_wrapper/uart_checker_if/s_buffer_rx_soft[0]} -expand} /tb_top/i_uart_checker_wrapper/uart_checker_if/s_buffer_rx_soft
add wave -noupdate -expand -group {UART CHECKER IF} /tb_top/i_uart_checker_wrapper/uart_checker_if/s_rd_ptr_soft
add wave -noupdate -expand -group {UART CHECKER IF} /tb_top/i_uart_checker_wrapper/uart_checker_if/s_wr_ptr_soft
add wave -noupdate -expand -group {UART CHECKER IF} /tb_top/i_uart_checker_wrapper/uart_checker_if/start_tx
add wave -noupdate -expand -group {UART CHECKER IF} /tb_top/i_uart_checker_wrapper/uart_checker_if/tx_data
add wave -noupdate -expand -group {UART CHECKER IF} /tb_top/i_uart_checker_wrapper/uart_checker_if/tx_done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {561109500 ps} 0}
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
WaveRestoreZoom {0 ps} {5611095 ns}
