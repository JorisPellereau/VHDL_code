onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_nb_data
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_cnt_nb_data
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_scl_in_r_edge
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_sampling_cnt
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_sampling_cnt_done
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_sampling_cnt_en
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/C_QUARTER_SCL_PERIOD
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/G_SCL_FREQ
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/G_CLOCK_FREQ
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/clk
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/rst_n
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/i_start
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/i_rw
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/i_chip_addr
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/i_nb_data
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/i_wdata
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/o_rdata
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/o_rdata_valid
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/o_next_wdata_rdy
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/o_sack_error
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/scl
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/sda
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_scl_cnt_en
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_scl_cnt
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_scl_cnt_done
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_current_state
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_start
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_next_state
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_start_r_edge
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_scl_in
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_sda_in
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_scl_out
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_sda_out
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_en_sda
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/C_MAX_SCL_PERIOD
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/C_HALF_SCL_PERIOD
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_cnt_9
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_cnt_9_done
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_start_gen_done
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_scl_in_p
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_scl_in_f_edge
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_ctrl_byte
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_scl_cnt_stop
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_stop_gen_cnt
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_stop_gen_cnt_done
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_stop_gen_cnt_en
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_wdata
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_wdata_shift
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_next_wdata_rdy
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_en_scl
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_cnt_nb_data_done
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_wdata_done
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_cnt_nb_data
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/clk
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/rst_n
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/i_nb_data
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/i_chip_addr
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/i_wdata
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/o_wdata_valid
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/o_rdata
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/o_rdata_valid
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/o_chip_addr_ok
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/scl
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/sda
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_current_state
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_next_state
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_scl
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_scl_r_edge
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_sda
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_sda_f_edge
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_chip_addr_ok
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_chip_addr_chk
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_read_or_write
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_start_detected
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_chip_addr
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_cnt_9
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_cnt_9_done
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_en_sda
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_sda_out
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_sack_done
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_stop_detected
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_rdata
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_rdata_valid
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_state_ctrl_byte_chk_done
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_stop_en
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_cnt_nb_data
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_nb_data
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_scl_f_edge
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_stop_en
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_cnt_rdata
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_rdata_valid_p
add wave -noupdate -expand -group {I2C Checker} /tb_top/i_i2c_slave_checker_0/s_rdata_valid_r_edge
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {22970000 ps} 1} {{Cursor 2} {25490000 ps} 1} {{Cursor 3} {43130000 ps} 1} {{Cursor 4} {243355457 ps} 0}
quietly wave cursor active 4
configure wave -namecolwidth 282
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
WaveRestoreZoom {241111382 ps} {251277398 ps}
