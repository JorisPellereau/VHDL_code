onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider DUT
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/clk_sys
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/rst_n_sys
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/wr_en_fifo_tx
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/wdata_fifo_tx
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/rd_en_fifo_rx
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/start
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/nb_wr
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/nb_rd
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/full_duplex
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/cpha
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/cpol
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/clk_div
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/spi_di
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/rdata_fifo_rx
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/spi_clk
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/spi_cs_n
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/spi_do
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/spi_busy
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/rd_en_fifo_tx
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/rdata_fifo_tx
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/fifo_empty_fifo_tx
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/fifo_full_fifo_tx
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/wr_en_fifo_rx
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/wdata_fifo_rx
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/fifo_empty_fifo_rx
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/fifo_full_fifo_rx
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Inputs /tb_top/i_dut/i_spi_master_itf_0/clk_sys
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Inputs /tb_top/i_dut/i_spi_master_itf_0/rst_n_sys
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Inputs /tb_top/i_dut/i_spi_master_itf_0/fifo_tx_data
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Inputs /tb_top/i_dut/i_spi_master_itf_0/start
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Inputs /tb_top/i_dut/i_spi_master_itf_0/nb_wr
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Inputs /tb_top/i_dut/i_spi_master_itf_0/nb_rd
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Inputs /tb_top/i_dut/i_spi_master_itf_0/full_duplex
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Inputs /tb_top/i_dut/i_spi_master_itf_0/cpha
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Inputs /tb_top/i_dut/i_spi_master_itf_0/cpol
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Inputs /tb_top/i_dut/i_spi_master_itf_0/clk_div
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Inputs /tb_top/i_dut/i_spi_master_itf_0/spi_di
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Outputs /tb_top/i_dut/i_spi_master_itf_0/fifo_tx_rd_en
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Outputs /tb_top/i_dut/i_spi_master_itf_0/fifo_rx_wr_en
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Outputs /tb_top/i_dut/i_spi_master_itf_0/fifo_rx_data
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Outputs /tb_top/i_dut/i_spi_master_itf_0/spi_clk
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Outputs /tb_top/i_dut/i_spi_master_itf_0/spi_cs_n
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Outputs /tb_top/i_dut/i_spi_master_itf_0/spi_do
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -group Outputs /tb_top/i_dut/i_spi_master_itf_0/spi_busy
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/nb_wr_int
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/nb_rd_int
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/full_duplex_int
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/cpha_int
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/cpol_int
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/clk_div_int
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/cnt_clk_div
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/clk_en
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/fsm_cs
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/fsm_ns
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/cnt_bit_en
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/cnt_bit
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/cnt_data
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/cnt_data_done
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/clk_spi_int
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/clk_spi_int_p1
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/clk_spi_r_edge
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/clk_spi_f_edge
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/start_int
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/fifo_tx_rd_en_int
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/fifo_tx_rd_en_int_p1
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/fifo_tx_rd_en_int_p2
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/spi_tx_data_int
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/spi_rx_data_int
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/wr_ongoing
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/rd_ongoing
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/rw_ongoing
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/shift_tx
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/shift_rx
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/spi_di_p
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/fifo_rx_wr_en_int
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/en_cs
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/init_ongoing
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/rst_cnt_data
add wave -noupdate -expand -group i_dut -group i_spi_master_itf_0 -expand -group Internal /tb_top/i_dut/i_spi_master_itf_0/cnt_bit_done
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_sp_ram_0/clk
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_sp_ram_0/data_in
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_sp_ram_0/wr_addr
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_sp_ram_0/rd_addr
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_sp_ram_0/we
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_sp_ram_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_sp_ram_0/data_out
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_sp_ram_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/i_sp_ram_0/mem
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/clk
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/rst_n
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/wr_en
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/rd_en
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/wdata
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/rdata_in
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/rdata
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/wdata_out
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/we
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/wr_addr
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/rd_addr
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/fifo_empty
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/fifo_full
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/write_ptr
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/read_ptr
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/fifo_full_int
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/fifo_empty_int
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/rd_en_p
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/i_fifo_sp_ram_fast_0/we_int
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/clk
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/rst_n
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/wr_en
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/rd_en
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group Inputs /tb_top/i_dut/i_fifo_rx_0/wdata
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/rdata
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/fifo_empty
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group Outputs /tb_top/i_dut/i_fifo_rx_0/fifo_full
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/ram_data_in
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/ram_we
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/wr_addr
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/rd_addr
add wave -noupdate -expand -group i_dut -group i_fifo_rx_0 -group Internal /tb_top/i_dut/i_fifo_rx_0/ram_data_out
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_sp_ram_0/clk
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_sp_ram_0/data_in
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_sp_ram_0/wr_addr
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_sp_ram_0/rd_addr
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_sp_ram_0/we
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_sp_ram_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_sp_ram_0/data_out
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_sp_ram_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/i_sp_ram_0/mem
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/clk
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/rst_n
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/wr_en
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/rd_en
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/wdata
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/rdata_in
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/rdata
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/wdata_out
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/we
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/wr_addr
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/rd_addr
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/fifo_empty
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/fifo_full
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/write_ptr
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/read_ptr
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/fifo_full_int
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/fifo_empty_int
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/rd_en_p
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group i_fifo_sp_ram_fast_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/i_fifo_sp_ram_fast_0/we_int
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/clk
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/rst_n
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/wr_en
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/rd_en
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group Inputs /tb_top/i_dut/i_fifo_tx_0/wdata
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/rdata
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/fifo_empty
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group Outputs /tb_top/i_dut/i_fifo_tx_0/fifo_full
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/ram_data_in
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/ram_we
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/wr_addr
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/rd_addr
add wave -noupdate -expand -group i_dut -group i_fifo_tx_0 -group Internal /tb_top/i_dut/i_fifo_tx_0/ram_data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {284201 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 208
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
WaveRestoreZoom {0 ps} {1753500 ps}
