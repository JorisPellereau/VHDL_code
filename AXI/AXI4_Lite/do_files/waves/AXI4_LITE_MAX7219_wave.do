onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB_Master_AXI4_Lite /tb_top/i_master_axi4lite_0/clk
add wave -noupdate -group TB_Master_AXI4_Lite /tb_top/i_master_axi4lite_0/rst_n
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group CTRL_ITF /tb_top/i_master_axi4lite_0/start
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group CTRL_ITF /tb_top/i_master_axi4lite_0/addr
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group CTRL_ITF /tb_top/i_master_axi4lite_0/rnw
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group CTRL_ITF /tb_top/i_master_axi4lite_0/strobe
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group CTRL_ITF /tb_top/i_master_axi4lite_0/master_wdata
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group CTRL_ITF /tb_top/i_master_axi4lite_0/done
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group CTRL_ITF /tb_top/i_master_axi4lite_0/master_rdata
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group CTRL_ITF /tb_top/i_master_axi4lite_0/access_status
add wave -noupdate -group TB_Master_AXI4_Lite -group Write_Channels /tb_top/i_master_axi4lite_0/awvalid
add wave -noupdate -group TB_Master_AXI4_Lite -group Write_Channels /tb_top/i_master_axi4lite_0/awaddr
add wave -noupdate -group TB_Master_AXI4_Lite -group Write_Channels /tb_top/i_master_axi4lite_0/awprot
add wave -noupdate -group TB_Master_AXI4_Lite -group Write_Channels /tb_top/i_master_axi4lite_0/awready
add wave -noupdate -group TB_Master_AXI4_Lite -group Write_Channels /tb_top/i_master_axi4lite_0/wvalid
add wave -noupdate -group TB_Master_AXI4_Lite -group Write_Channels /tb_top/i_master_axi4lite_0/wdata
add wave -noupdate -group TB_Master_AXI4_Lite -group Write_Channels /tb_top/i_master_axi4lite_0/wstrb
add wave -noupdate -group TB_Master_AXI4_Lite -group Write_Channels /tb_top/i_master_axi4lite_0/wready
add wave -noupdate -group TB_Master_AXI4_Lite -group Write_Channels /tb_top/i_master_axi4lite_0/bready
add wave -noupdate -group TB_Master_AXI4_Lite -group Write_Channels /tb_top/i_master_axi4lite_0/bvalid
add wave -noupdate -group TB_Master_AXI4_Lite -group Write_Channels /tb_top/i_master_axi4lite_0/bresp
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group Read_Channel /tb_top/i_master_axi4lite_0/arvalid
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group Read_Channel /tb_top/i_master_axi4lite_0/araddr
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group Read_Channel /tb_top/i_master_axi4lite_0/arprot
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group Read_Channel /tb_top/i_master_axi4lite_0/arready
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group Read_Channel /tb_top/i_master_axi4lite_0/rready
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group Read_Channel /tb_top/i_master_axi4lite_0/rvalid
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group Read_Channel /tb_top/i_master_axi4lite_0/rdata
add wave -noupdate -group TB_Master_AXI4_Lite -expand -group Read_Channel /tb_top/i_master_axi4lite_0/rresp
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/clk
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/rst_n
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/i_max7219_clk
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/i_max7219_din
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/i_max7219_load
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/o_frame_received
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/o_load_received
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/o_data_received
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/s_max7219_clk
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/s_max7219_load
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/s_frame_received
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/s_max7219_data
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/s_cnt_15
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/s_cnt_15_done
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/s_max7219_clk_r_edge
add wave -noupdate -group MAX7219_SPI_CHECKER /tb_top/i_max7219_spi_checker_0/s_max7219_load_f_edge
add wave -noupdate -divider DUT
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/clk_sys
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/rst_n_sys
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/awvalid
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/awaddr
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/awprot
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/wvalid
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/wdata
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/wstrb
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/bready
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/arvalid
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/araddr
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/arprot
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/rready
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/awready
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/wready
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/bvalid
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/bresp
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/arready
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/rvalid
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/rdata
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/rresp
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_max7219_load
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_max7219_data
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_max7219_clk
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/slv_start
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/slv_rw
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/slv_addr
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/slv_wdata
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/slv_strobe
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/slv_done
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/slv_rdata
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/slv_status
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/enable
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/cmd_start
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/cmd
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/cmd_data
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/matrix_idx
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/fifo_full
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/fifo_empty
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/ctrl_status
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/ctrl_done
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_sp_ram_0/clk
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_sp_ram_0/data_in
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_sp_ram_0/wr_addr
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_sp_ram_0/rd_addr
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_sp_ram_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_sp_ram_0/we
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_sp_ram_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_sp_ram_0/data_out
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/clk
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/rst_n
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/wr_en
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/rd_en
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/wdata
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/rdata_in
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/rdata
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/rdata_val
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/wdata_out
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/we
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/wr_addr
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/rd_addr
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/fifo_empty
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/fifo_full
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/write_ptr
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/read_ptr
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/fifo_full_int
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/fifo_empty_int
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/rd_en_p
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group i_fifo_sp_ram_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/i_fifo_sp_ram_0/we_int
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/clk
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/rst_n
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/wr_en
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/rd_en
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/wdata
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/rdata
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/rdata_val
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/fifo_empty
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/fifo_full
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/ram_data_in
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/ram_we
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/wr_addr
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/rd_addr
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_fifo_sp_ram_wrapper_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_fifo_sp_ram_wrapper_0/ram_data_out
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/clk_sys
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/rst_n_sys
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/enable
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/cmd_start
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/cmd
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/cmd_data
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/matrix_idx
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/ctrl_done
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/ctrl_status
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/fifo_full
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/fifo_empty
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/o_max7219_load
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/o_max7219_data
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/o_max7219_clk
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/wr_en
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/rd_en
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/wdata
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/rdata
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/rdata_val
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/fifo_full_int
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/fifo_empty_int
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/max7219_if_done
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_start_max7219_if_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_start_max7219_if_0/clk_sys
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_start_max7219_if_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_start_max7219_if_0/rst_n_sys
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_start_max7219_if_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_start_max7219_if_0/fifo_empty
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_start_max7219_if_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_start_max7219_if_0/enable
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_start_max7219_if_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_start_max7219_if_0/done
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_start_max7219_if_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_start_max7219_if_0/rd_en
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_start_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_start_max7219_if_0/fsm_cs
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_start_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_start_max7219_if_0/fsm_ns
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/clk
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/rst_n
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/i_start
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/i_en_load
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/i_data
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/o_max7219_load
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/o_max7219_data
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/o_max7219_clk
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/o_done
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_data
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_en_load
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_start
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_init_data
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_en_clk
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_max7219_data
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_max7219_clk
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_max7219_clk_p
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_max7219_clk_f_edge
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_max7219_clk_r_edge
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_max7219_load
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_start_r_edge
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_done
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_cnt_15
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_cnt_16
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_cnt_half_period
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_load_px
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_end_frame
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_max7219_if_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_max7219_if_0/s_ongoing
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/clk_sys
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/rst_n_sys
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/cmd_start
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/cmd
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/cmd_data
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/matrix_idx
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/fifo_full
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Inputs /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/fifo_empty
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/wr_en
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/wdata
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/done
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Outputs /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/status
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/addr_reg
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/cmd_data_p
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/matrix_idx_p
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/cnt_wr_en
add wave -noupdate -expand -group i_dut -group i_max7219_ctrl_0 -group i_wr_fifo_mngt_0 -group Internal /tb_top/i_dut/i_max7219_ctrl_0/i_wr_fifo_mngt_0/load_en
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/clk
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/rst_n
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/awvalid
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/awaddr
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/awprot
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/wvalid
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/wdata
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/wstrb
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/bready
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/arvalid
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/araddr
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/arprot
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/rready
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/slv_done
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/slv_rdata
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/slv_status
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/awready
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/wready
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/bvalid
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/bresp
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/arready
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/rvalid
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/rdata
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/rresp
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/slv_start
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/slv_rw
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/slv_addr
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/slv_wdata
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut/i_axi4_lite_slave_itf_0/slv_strobe
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut/i_axi4_lite_slave_itf_0/s_arvalid
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut/i_axi4_lite_slave_itf_0/s_araddr
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut/i_axi4_lite_slave_itf_0/s_arready
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut/i_axi4_lite_slave_itf_0/s_rvalid
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut/i_axi4_lite_slave_itf_0/s_rd_ongoing
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut/i_axi4_lite_slave_itf_0/s_wr_ongoing
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut/i_axi4_lite_slave_itf_0/s_awvalid
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut/i_axi4_lite_slave_itf_0/s_awaddr
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut/i_axi4_lite_slave_itf_0/s_awready
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut/i_axi4_lite_slave_itf_0/s_wvalid
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut/i_axi4_lite_slave_itf_0/s_wready
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut/i_axi4_lite_slave_itf_0/s_wdata
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut/i_axi4_lite_slave_itf_0/s_wstrb
add wave -noupdate -expand -group i_dut -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut/i_axi4_lite_slave_itf_0/s_bvalid
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Inputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/clk
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Inputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/rst_n
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Inputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/slv_start
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Inputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/slv_rw
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Inputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/slv_addr
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Inputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/slv_wdata
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Inputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/slv_strobe
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Inputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/ctrl_done
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Inputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/ctrl_status
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Inputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/fifo_full
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Inputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/fifo_empty
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Outputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/slv_done
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Outputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/slv_rdata
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Outputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/slv_status
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Outputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/enable
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Outputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/cmd_start
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Outputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/cmd
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Outputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/cmd_data
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Outputs /tb_top/i_dut/i_axi4_lite_max7219_registers_0/matrix_idx
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Internal /tb_top/i_dut/i_axi4_lite_max7219_registers_0/reg_wr_sel
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Internal /tb_top/i_dut/i_axi4_lite_max7219_registers_0/reg_wr_sel_error
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Internal /tb_top/i_dut/i_axi4_lite_max7219_registers_0/ctrl_register
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Internal /tb_top/i_dut/i_axi4_lite_max7219_registers_0/cmd_register
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Internal /tb_top/i_dut/i_axi4_lite_max7219_registers_0/status_register
add wave -noupdate -expand -group i_dut -group i_axi4_lite_max7219_registers_0 -group Internal /tb_top/i_dut/i_axi4_lite_max7219_registers_0/slv_wr_access_error
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {338815 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 201
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
WaveRestoreZoom {0 ps} {1669500 ps}
