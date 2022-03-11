onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {DUT TOP} /tb_top/i_dut/clk
add wave -noupdate -expand -group {DUT TOP} /tb_top/i_dut/rst_n
add wave -noupdate -expand -group {DUT TOP} /tb_top/i_dut/i_static_dyn
add wave -noupdate -expand -group {DUT TOP} /tb_top/i_dut/i_new_display
add wave -noupdate -expand -group {DUT TOP} /tb_top/i_dut/i_new_config_val
add wave -noupdate -expand -group {DUT TOP} -group {CONFIG I/F} /tb_top/i_dut/i_display_test
add wave -noupdate -expand -group {DUT TOP} -group {CONFIG I/F} /tb_top/i_dut/i_decod_mode
add wave -noupdate -expand -group {DUT TOP} -group {CONFIG I/F} /tb_top/i_dut/i_intensity
add wave -noupdate -expand -group {DUT TOP} -group {CONFIG I/F} /tb_top/i_dut/i_scan_limit
add wave -noupdate -expand -group {DUT TOP} -group {CONFIG I/F} /tb_top/i_dut/i_shutdown
add wave -noupdate -expand -group {DUT TOP} -expand -group {I CONTROL STATIC} /tb_top/i_dut/i_start_ptr_static
add wave -noupdate -expand -group {DUT TOP} -expand -group {I CONTROL STATIC} -radix unsigned /tb_top/i_dut/i_last_ptr_static
add wave -noupdate -expand -group {DUT TOP} -expand -group {I CONTROL STATIC} /tb_top/i_dut/i_loop_static
add wave -noupdate -expand -group {DUT TOP} -expand -group {I CONTROL STATIC} /tb_top/i_dut/i_en_static
add wave -noupdate -expand -group {DUT TOP} -group {RAM STATIC IF} /tb_top/i_dut/i_me_static
add wave -noupdate -expand -group {DUT TOP} -group {RAM STATIC IF} /tb_top/i_dut/i_we_static
add wave -noupdate -expand -group {DUT TOP} -group {RAM STATIC IF} /tb_top/i_dut/i_addr_static
add wave -noupdate -expand -group {DUT TOP} -group {RAM STATIC IF} /tb_top/i_dut/i_wdata_static
add wave -noupdate -expand -group {DUT TOP} -group {RAM STATIC IF} /tb_top/i_dut/o_rdata_static
add wave -noupdate -expand -group {DUT TOP} -group {RAM SCROLLER IF} /tb_top/i_dut/i_me_scroller
add wave -noupdate -expand -group {DUT TOP} -group {RAM SCROLLER IF} /tb_top/i_dut/i_we_scroller
add wave -noupdate -expand -group {DUT TOP} -group {RAM SCROLLER IF} /tb_top/i_dut/i_addr_scroller
add wave -noupdate -expand -group {DUT TOP} -group {RAM SCROLLER IF} /tb_top/i_dut/i_wdata_scroller
add wave -noupdate -expand -group {DUT TOP} -group {RAM SCROLLER IF} /tb_top/i_dut/o_rdata_scroller
add wave -noupdate -expand -group {DUT TOP} -group {I CONTROLS SCROLLER} /tb_top/i_dut/i_ram_start_ptr_scroller
add wave -noupdate -expand -group {DUT TOP} -group {I CONTROLS SCROLLER} /tb_top/i_dut/i_msg_length_scroller
add wave -noupdate -expand -group {DUT TOP} -group {I CONTROLS SCROLLER} /tb_top/i_dut/i_max_tempo_cnt_scroller
add wave -noupdate -expand -group {DUT TOP} /tb_top/i_dut/o_ptr_equality_static
add wave -noupdate -expand -group {DUT TOP} /tb_top/i_dut/o_static_busy
add wave -noupdate -expand -group {DUT TOP} /tb_top/i_dut/o_scroller_busy
add wave -noupdate -expand -group {DUT TOP} /tb_top/i_dut/o_config_done
add wave -noupdate -expand -group {DUT TOP} -group {MAX7219 IF} /tb_top/i_dut/o_max7219_load
add wave -noupdate -expand -group {DUT TOP} -group {MAX7219 IF} /tb_top/i_dut/o_max7219_data
add wave -noupdate -expand -group {DUT TOP} -group {MAX7219 IF} /tb_top/i_dut/o_max7219_clk
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_start_ptr_static
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_last_ptr_static
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_ptr_val_static
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_loop_static
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_ram_start_ptr_scroller
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_msg_length_scroller
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_start_scroll
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_done_config
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_start_config
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_en_load_config
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_data_config
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_config_done
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_done_static
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_start_static
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_en_load_static
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_data_static
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_ptr_equality_static
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_ptr_equality_static_p1
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_discard_static
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_status_static
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_busy_scroller
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_done_scroller
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_start_scroller
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_en_load_scroller
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_data_scroller
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_start
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_en_load
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_data
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_load
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_data
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_clk
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_max7219_if_done
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_mux_sel
add wave -noupdate -expand -group {DUT TOP} -group Internals /tb_top/i_dut/s_new_config_val
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/clk
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/rst_n
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/i_static_dyn
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/i_new_display
add wave -noupdate -group DISPLAY_SEQ -color Cyan /tb_top/i_dut/max7219_display_sequencer_inst_0/i_new_config_val
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/i_config_done
add wave -noupdate -group DISPLAY_SEQ -color Cyan /tb_top/i_dut/max7219_display_sequencer_inst_0/o_new_config_val
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/i_start_ptr
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/i_last_ptr
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/i_ptr_equality
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/o_start_ptr
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/o_last_ptr
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/o_static_val
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/i_ram_start_ptr
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/i_msg_length
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/i_busy_scroller
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/o_ram_start_ptr
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/o_msg_length
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/o_start_scroll
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/o_mux_sel
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_current_state
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_next_state
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_config_done
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_config_done_r_edge
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_new_config_val
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_new_config_val_r_edge
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_new_config_val_from_seq
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_new_display
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_new_display_r_edge
add wave -noupdate -group DISPLAY_SEQ -color Cyan /tb_top/i_dut/max7219_display_sequencer_inst_0/s_cmd_rd_ptr
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_cmd_fifo_cnt
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_cmd_rd_ptr_up
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_static_wr_ptr
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_static_rd_ptr
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_scroller_wr_ptr
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_scroller_rd_ptr
add wave -noupdate -group DISPLAY_SEQ -color Cyan /tb_top/i_dut/max7219_display_sequencer_inst_0/s_next_cmd_config
add wave -noupdate -group DISPLAY_SEQ -color Cyan /tb_top/i_dut/max7219_display_sequencer_inst_0/s_next_cmd_static
add wave -noupdate -group DISPLAY_SEQ -color Cyan /tb_top/i_dut/max7219_display_sequencer_inst_0/s_next_cmd_scroller
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_start_ptr_static_array
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_last_ptr_static_array
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_ram_start_scroller_array
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_msg_length_scroller_array
add wave -noupdate -group DISPLAY_SEQ -expand /tb_top/i_dut/max7219_display_sequencer_inst_0/s_cmd_array
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_fifo_empty
add wave -noupdate -group DISPLAY_SEQ -color Cyan /tb_top/i_dut/max7219_display_sequencer_inst_0/s_cmd_val
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_cmd_wr_ptr
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_cmd_wr_ptr_up
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_fifo_full
add wave -noupdate -group DISPLAY_SEQ -color Cyan /tb_top/i_dut/max7219_display_sequencer_inst_0/s_cmd_type
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_mux_sel
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_start_ptr
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_last_ptr
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_ram_start_ptr
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_msg_length
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_ptr_equality_r_edge
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_ptr_equality
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_busy_scroller
add wave -noupdate -group DISPLAY_SEQ /tb_top/i_dut/max7219_display_sequencer_inst_0/s_busy_scroller_f_edge
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/clk
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/rst_n
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/i_mux_sel
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/i_max7219_if_start_config
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/i_max7219_if_en_load_config
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/i_max7219_if_data_config
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/o_max7219_if_done_config
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/i_max7219_if_start_static
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/i_max7219_if_en_load_static
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/i_max7219_if_data_static
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/o_max7219_if_done_static
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/i_max7219_if_start_Scroller
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/i_max7219_if_en_load_Scroller
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/i_max7219_if_data_Scroller
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/o_max7219_if_done_Scroller
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/i_max7219_if_done
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/o_max7219_if_start
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/o_max7219_if_en_load
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/o_max7219_if_data
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/s_max7219_if_start
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/s_max7219_if_en_load
add wave -noupdate -group {MUX INST} /tb_top/i_dut/max7219_mux_sel_inst_0/s_max7219_if_data
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/clk
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/rst_n
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/i_decod_mode
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/i_intensity
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/i_scan_limit
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/i_shutdown
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/i_display_test
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/i_new_config_val
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/o_config_done
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/i_max7219_if_done
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/o_max7219_if_start
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/o_max7219_if_en_load
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/o_max7219_if_data
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_init_config
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_init_config_p
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_init_config_p2
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_new_config_val
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_new_config_val_r_edge
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_config_done
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_cnt_config
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_cnt_config_done
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_cnt_matrix
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_cnt_matrix_up
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_cnt_matrix_done
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_cnt_matrix_done_p1
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_max7219_if_start
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_max7219_if_en_load
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_max7219_if_data
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_max7219_if_done
add wave -noupdate -group {Config IF} /tb_top/i_dut/max7219_config_if_inst_0/s_max7219_if_done_r_edge
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/clk
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/rst_n
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/i_start
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/i_en_load
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/i_data
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/o_max7219_load
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/o_max7219_data
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/o_max7219_clk
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/o_done
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_data
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_en_load
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_start
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_init_data
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_en_clk
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_max7219_data
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_max7219_clk
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_max7219_clk_p
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_max7219_clk_f_edge
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_max7219_clk_r_edge
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_max7219_load
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_start_r_edge
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_done
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_cnt_15
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_cnt_16
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_cnt_half_period
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_load_px
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_end_frame
add wave -noupdate -group {MAX7219 IF} /tb_top/i_dut/max7219_if_inst_0/s_ongoing
add wave -noupdate -divider <NULL>
add wave -noupdate -label v_ram_static /tb_top/i_dut/max7219_cmd_decod_inst_0/tdpram_inst_0/v_ram
add wave -noupdate -divider <NULL>
add wave -noupdate -expand -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/clk
add wave -noupdate -expand -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/rst_n
add wave -noupdate -expand -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/i_max7219_clk
add wave -noupdate -expand -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/i_max7219_din
add wave -noupdate -expand -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/i_max7219_load
add wave -noupdate -expand -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/o_frame_received
add wave -noupdate -expand -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/o_load_received
add wave -noupdate -expand -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/o_data_received
add wave -noupdate -group {Set injector} /tb_top/i_set_injector_wrapper/clk
add wave -noupdate -group {Set injector} /tb_top/i_set_injector_wrapper/rst_n
add wave -noupdate -group {Set injector} /tb_top/i_set_injector_wrapper/i_set_injector_tb/clk
add wave -noupdate -group {Set injector} /tb_top/i_set_injector_wrapper/i_set_injector_tb/rst_n
add wave -noupdate -group {Set injector} -expand /tb_top/i_set_injector_wrapper/i_set_injector_tb/i_set_signals_asynch
add wave -noupdate -divider <NULL>
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[0]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[1]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[2]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[3]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[4]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[5]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[6]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[7]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {977246960 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 140
configure wave -valuecolwidth 467
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
WaveRestoreZoom {8637975 ps} {4115630103 ps}
