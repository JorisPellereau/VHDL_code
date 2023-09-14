onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider DUT
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/clk
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/rst_n
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_char_wdata
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_char_wdata_val
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_char_position
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_line_sel
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_cgram_addr
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_cgram_wdata
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_cgram_wdata_val
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_dl_n_f
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_dcb
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_lcd_on
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_start_init
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_display_ctrl_cmd
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_clear_display_cmd
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_return_home_cmd
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_cursor_or_display_shift_cmd
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_sc_rl
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_update_lcd
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_lcd_all_char
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_lcd_line_sel
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_lcd_char_position
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_update_cgram
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_cgram_all_char
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_cgram_char_position
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_lcd_data
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_control_done
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_lcd_wdata
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_lcd_rw
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_lcd_en
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_lcd_rs
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_lcd_on
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_bidir_sel
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_o_lcd_on
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_init_ongoing
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_init_done
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_cmd_bus_cmd_generator
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_cmd_req_poll
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_id_sh_to_cmd_generator
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_dcb_to_cmd_generator
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_sc_rl
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_dl_n_f
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_data_bus
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_lcd_rdata_cmd_generator
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_done_cmd_generator
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_lcd_wdata
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_rw
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_rs
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_start
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_start_polling
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_lcd_rdata
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_lcd_itf_done
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/start_init
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_cmds
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_cmd_bus_poll
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_done_cmd_init
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_function_set_init
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_display_ctrl_init
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_entry_mode_set_init
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_clear_display_init
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_cmd_req_init
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_cmd_req_cmd_generator
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_done_cmd_poll
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/clk
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/rst_n
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_cmd_req
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_clear_display
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_return_home
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_entry_mode_set
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_id_sh
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_display_ctrl
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_dcb
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_cursor_display_shift
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_sc_rl
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_function_set
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_dl_n_f
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_set_gcram_addr
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_set_ddram_addr
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_read_busy_flag
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_wr_data
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_rd_data
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_data_bus
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_lcd_rdata
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/i_lcd_itf_done
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/o_lcd_rdata
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/o_done
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/o_rs
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/o_rw
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/o_lcd_wdata
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/o_start
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Internal /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/s_busy
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_cmd_generator_0 -group Internal /tb_top/i_dut/i_lcd_cfah_cmd_generator_0/s_lcd_wdata
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_init_0/clk_sys
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_init_0/rst_n_sys
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_init_0/i_start_init
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_init_0/i_cmd_done
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_init_0/o_cmd_req
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_init_0/o_function_set_cmd
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_init_0/o_display_ctrl
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_init_0/o_entry_mode_set
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_init_0/o_clear_display
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_init_0/o_init_done
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Internal /tb_top/i_dut/i_lcd_cfah_init_0/fsm_cs
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Internal /tb_top/i_dut/i_lcd_cfah_init_0/fsm_ns
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Internal /tb_top/i_dut/i_lcd_cfah_init_0/en_cnt
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Internal /tb_top/i_dut/i_lcd_cfah_init_0/s_duration_cnt
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Internal /tb_top/i_dut/i_lcd_cfah_init_0/s_duration_max
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Internal /tb_top/i_dut/i_lcd_cfah_init_0/s_duration_done
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Internal /tb_top/i_dut/i_lcd_cfah_init_0/s_duration_sel
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Internal /tb_top/i_dut/i_lcd_cfah_init_0/init_done
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Internal /tb_top/i_dut/i_lcd_cfah_init_0/wait_duration_ongoing
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Internal /tb_top/i_dut/i_lcd_cfah_init_0/func_set_init_ongoing
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Internal /tb_top/i_dut/i_lcd_cfah_init_0/func_set_ongoing
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Internal /tb_top/i_dut/i_lcd_cfah_init_0/display_clear_ongoing
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_init_0 -group Internal /tb_top/i_dut/i_lcd_cfah_init_0/display_ctrl_ongoing
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_main_fsm_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_main_fsm_0/clk_sys
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_main_fsm_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_main_fsm_0/rst_n_sys
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_main_fsm_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_main_fsm_0/i_lcd_on
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_main_fsm_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_main_fsm_0/init_done
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_main_fsm_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_main_fsm_0/start_init
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_main_fsm_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_main_fsm_0/init_ongoing
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_main_fsm_0 -group Internal /tb_top/i_dut/i_lcd_cfah_main_fsm_0/fsm_cs
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_main_fsm_0 -group Internal /tb_top/i_dut/i_lcd_cfah_main_fsm_0/fsm_ns
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_main_fsm_0 -group Internal /tb_top/i_dut/i_lcd_cfah_main_fsm_0/start_init_int
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_main_fsm_0 -group Internal /tb_top/i_dut/i_lcd_cfah_main_fsm_0/start_init_p
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_itf_0/clk
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_itf_0/rst_n
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_itf_0/i_wdata
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_itf_0/i_lcd_data
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_itf_0/i_rs
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_itf_0/i_rw
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_itf_0/i_start
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_itf_0/o_lcd_wdata
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_itf_0/o_lcd_rdata
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_itf_0/o_lcd_rw
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_itf_0/o_lcd_en
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_itf_0/o_lcd_rs
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_itf_0/o_bidir_sel
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_itf_0/o_done
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Internal /tb_top/i_dut/i_lcd_cfah_itf_0/s_cnt
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Internal /tb_top/i_dut/i_lcd_cfah_itf_0/s_wdata
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Internal /tb_top/i_dut/i_lcd_cfah_itf_0/s_ongoing
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Internal /tb_top/i_dut/i_lcd_cfah_itf_0/s_rs
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Internal /tb_top/i_dut/i_lcd_cfah_itf_0/s_rw
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Internal /tb_top/i_dut/i_lcd_cfah_itf_0/s_en
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_itf_0 -group Internal /tb_top/i_dut/i_lcd_cfah_itf_0/s_done
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_polling_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_polling_0/clk_sys
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_polling_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_polling_0/rst_n_sys
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_polling_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_polling_0/i_start
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_polling_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_polling_0/i_cmds
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_polling_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_polling_0/i_lcd_rdata
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_polling_0 -group Inputs /tb_top/i_dut/i_lcd_cfah_polling_0/i_done
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_polling_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_polling_0/o_cmd_req
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_polling_0 -group Outputs /tb_top/i_dut/i_lcd_cfah_polling_0/o_cmds
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_polling_0 -group Internal /tb_top/i_dut/i_lcd_cfah_polling_0/fsm_cs
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_polling_0 -group Internal /tb_top/i_dut/i_lcd_cfah_polling_0/fsm_ns
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_polling_0 -group Internal /tb_top/i_dut/i_lcd_cfah_polling_0/cmds
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_polling_0 -group Internal /tb_top/i_dut/i_lcd_cfah_polling_0/cmds_to_run
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_polling_0 -group Internal /tb_top/i_dut/i_lcd_cfah_polling_0/poll_ongoing
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_polling_0 -group Internal /tb_top/i_dut/i_lcd_cfah_polling_0/cmds_sel
add wave -noupdate -expand -group i_dut -group i_lcd_cfah_polling_0 -group Internal /tb_top/i_dut/i_lcd_cfah_polling_0/update_cmds
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16926061623 ps} 0} {{Cursor 2} {16750000 ps} 1}
quietly wave cursor active 1
configure wave -namecolwidth 220
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {25628200500 ps}
