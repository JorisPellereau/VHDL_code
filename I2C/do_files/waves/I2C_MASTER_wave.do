onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {I2C Slave} /tb_top/i_i2c_slave_0/rst_n
add wave -noupdate -expand -group {I2C Slave} /tb_top/i_i2c_slave_0/nb_data
add wave -noupdate -expand -group {I2C Slave} /tb_top/i_i2c_slave_0/polling
add wave -noupdate -expand -group {I2C Slave} /tb_top/i_i2c_slave_0/max_polling
add wave -noupdate -expand -group {I2C Slave} /tb_top/i_i2c_slave_0/sclk
add wave -noupdate -expand -group {I2C Slave} /tb_top/i_i2c_slave_0/sda
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/bit_cnt
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/byte_received
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/chip_addr_ok
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/cnt_data
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/G_SLAVE_I2C_FIFO_DEPTH
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/i2c_ongoing
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/mack_ongoing
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/rw
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/sack_ctrl_byte_done
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/sclk_in
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/sda_en
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/sda_in
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/sda_out
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/sr_rdata
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/sr_wdata
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/start_condition
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/stop_condition
add wave -noupdate -expand -group {I2C Slave} -group internal /tb_top/i_i2c_slave_0/cnt_data_done
add wave -noupdate -expand -group {I2C Slave} -group ITF /tb_top/i_i2c_slave_0/i2c_slave_if/G_SLAVE_I2C_FIFO_DEPTH
add wave -noupdate -expand -group {I2C Slave} -group ITF /tb_top/i_i2c_slave_0/i2c_slave_if/mem_tx_data
add wave -noupdate -expand -group {I2C Slave} -group ITF /tb_top/i_i2c_slave_0/i2c_slave_if/mem_rx_data
add wave -noupdate -expand -group {I2C Slave} -group ITF /tb_top/i_i2c_slave_0/i2c_slave_if/ptr_write_tx
add wave -noupdate -expand -group {I2C Slave} -group ITF /tb_top/i_i2c_slave_0/i2c_slave_if/ptr_read_tx
add wave -noupdate -expand -group {I2C Slave} -group ITF /tb_top/i_i2c_slave_0/i2c_slave_if/ptr_write_rx
add wave -noupdate -expand -group {I2C Slave} -group ITF /tb_top/i_i2c_slave_0/i2c_slave_if/ptr_read_rx
add wave -noupdate -expand -group {I2C Slave} -group ITF /tb_top/i_i2c_slave_0/i2c_slave_if/i2c_slave_addr
add wave -noupdate -expand -group {I2C Slave} /tb_top/i_i2c_slave_0/G_NB_DATA
add wave -noupdate -expand -group {I2C Slave} /tb_top/i_i2c_slave_0/G_MAX_POLLING
add wave -noupdate -divider DUT
add wave -noupdate -group i_dut -group Inputs /tb_top/i_dut/clk_sys
add wave -noupdate -group i_dut -group Inputs /tb_top/i_dut/rst_n_sys
add wave -noupdate -group i_dut -group Inputs /tb_top/i_dut/start
add wave -noupdate -group i_dut -group Inputs /tb_top/i_dut/rw
add wave -noupdate -group i_dut -group Inputs /tb_top/i_dut/chip_addr
add wave -noupdate -group i_dut -group Inputs /tb_top/i_dut/nb_data
add wave -noupdate -group i_dut -group Inputs /tb_top/i_dut/polling
add wave -noupdate -group i_dut -group Inputs /tb_top/i_dut/wr_en_fifo_tx
add wave -noupdate -group i_dut -group Inputs /tb_top/i_dut/wdata_fifo_tx
add wave -noupdate -group i_dut -group Inputs /tb_top/i_dut/rd_en_fifo_rx
add wave -noupdate -group i_dut -group Inputs /tb_top/i_dut/sda_in
add wave -noupdate -group i_dut -group Outputs /tb_top/i_dut/fifo_empty_fifo_tx
add wave -noupdate -group i_dut -group Outputs /tb_top/i_dut/fifo_full_fifo_tx
add wave -noupdate -group i_dut -group Outputs /tb_top/i_dut/rdata_fifo_rx
add wave -noupdate -group i_dut -group Outputs /tb_top/i_dut/fifo_empty_fifo_rx
add wave -noupdate -group i_dut -group Outputs /tb_top/i_dut/fifo_full_fifo_rx
add wave -noupdate -group i_dut -group Outputs /tb_top/i_dut/sack_error
add wave -noupdate -group i_dut -group Outputs /tb_top/i_dut/busy
add wave -noupdate -group i_dut -group Outputs /tb_top/i_dut/sclk
add wave -noupdate -group i_dut -group Outputs /tb_top/i_dut/sclk_en
add wave -noupdate -group i_dut -group Outputs /tb_top/i_dut/sda_out
add wave -noupdate -group i_dut -group Outputs /tb_top/i_dut/sda_en
add wave -noupdate -group i_dut -group Internal /tb_top/i_dut/rd_en_fifo_tx
add wave -noupdate -group i_dut -group Internal /tb_top/i_dut/wr_en_fifo_rx
add wave -noupdate -group i_dut -group Internal /tb_top/i_dut/wdata_fifo_rx
add wave -noupdate -group i_dut -group Internal /tb_top/i_dut/rdata_fifo_tx
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Inputs /tb_top/i_dut/i_i2c_master_itf_0/clk_sys
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Inputs /tb_top/i_dut/i_i2c_master_itf_0/rst_n_sys
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Inputs /tb_top/i_dut/i_i2c_master_itf_0/fifo_tx_data
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Inputs /tb_top/i_dut/i_i2c_master_itf_0/start
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Inputs /tb_top/i_dut/i_i2c_master_itf_0/rw
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Inputs /tb_top/i_dut/i_i2c_master_itf_0/chip_addr
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Inputs /tb_top/i_dut/i_i2c_master_itf_0/nb_data
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Inputs /tb_top/i_dut/i_i2c_master_itf_0/polling
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Inputs /tb_top/i_dut/i_i2c_master_itf_0/sda_in
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Outputs /tb_top/i_dut/i_i2c_master_itf_0/fifo_tx_rd_en
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Outputs /tb_top/i_dut/i_i2c_master_itf_0/fifo_rx_wr_en
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Outputs /tb_top/i_dut/i_i2c_master_itf_0/fifo_rx_data
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Outputs /tb_top/i_dut/i_i2c_master_itf_0/sack_error
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Outputs /tb_top/i_dut/i_i2c_master_itf_0/busy
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Outputs /tb_top/i_dut/i_i2c_master_itf_0/sclk
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Outputs /tb_top/i_dut/i_i2c_master_itf_0/sclk_en
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Outputs /tb_top/i_dut/i_i2c_master_itf_0/sda_out
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Outputs /tb_top/i_dut/i_i2c_master_itf_0/sda_en
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/chip_addr_int
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/nb_data_int
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/rw_int
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/polling_int
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/fsm_cs
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/fsm_ns
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/sr_rdata
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/sr_wdata
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/sr_en
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/gen_start
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/gen_stop
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/cnt_bit
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/cnt_bit_done
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/ack_synch
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/sampling_pulse
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/sack_error_int
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/cnt_data
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/cnt_data_done
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/en_sclk_gen
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/sclk_cnt
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/sclk_int
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/sclk_int2
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/sclk_int_r_edge
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/sclk_int_f_edge
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/sclk_change
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/sclk_change_en
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/sclk_en_int
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/cnt_polling
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/cnt_polling_done
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/polling_done
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/polling_ok
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/wr_ongoing
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/rd_ongoing
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/end_ongoing
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/sack_ongoing
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/ctrl_byte_ongoing
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/idle_ongoing
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/start_ongoing
add wave -noupdate -group i_dut -group i_i2c_master_itf_0 -group Internal /tb_top/i_dut/i_i2c_master_itf_0/mack_ongoing
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_sp_ram_0/clk
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_sp_ram_0/data_in
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_sp_ram_0/wr_addr
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_sp_ram_0/rd_addr
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_sp_ram_0/we
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_sp_ram_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_sp_ram_0/data_out
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/clk
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/rst_n
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/wr_en
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/rd_en
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/wdata
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/rdata_in
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/rdata
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/wdata_out
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/we
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/wr_addr
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/rd_addr
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/fifo_empty
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/fifo_full
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/write_ptr
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/read_ptr
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/fifo_full_int
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/fifo_empty_int
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/rd_en_p
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/we_int
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/clk
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/rst_n
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/wr_en
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/rd_en
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/wdata
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/rdata
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/fifo_empty
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/fifo_full
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/ram_data_in
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/ram_we
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/wr_addr
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/rd_addr
add wave -noupdate -group i_dut -group i_fifo_rx_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/ram_data_out
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_sp_ram_0/clk
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_sp_ram_0/data_in
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_sp_ram_0/wr_addr
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_sp_ram_0/rd_addr
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_sp_ram_0/we
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_sp_ram_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_sp_ram_0/data_out
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/clk
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/rst_n
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/wr_en
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/rd_en
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/wdata
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/rdata_in
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/rdata
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/wdata_out
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/we
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/wr_addr
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/rd_addr
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/fifo_empty
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/fifo_full
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/write_ptr
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/read_ptr
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/fifo_full_int
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/fifo_empty_int
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/rd_en_p
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/we_int
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/clk
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/rst_n
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/wr_en
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/rd_en
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/wdata
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/rdata
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/fifo_empty
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/fifo_full
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/ram_data_in
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/ram_we
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/wr_addr
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/rd_addr
add wave -noupdate -group i_dut -group i_fifo_tx_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/ram_data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 5} {27653572 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {107404500 ps}
