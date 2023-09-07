onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider DUT
add wave -noupdate -expand -group i_dut_0 -group Inputs /tb_top/i_dut_0/clk
add wave -noupdate -expand -group i_dut_0 -group Inputs /tb_top/i_dut_0/rst_n
add wave -noupdate -expand -group i_dut_0 -group Outputs /tb_top/i_dut_0/o_seg0
add wave -noupdate -expand -group i_dut_0 -group Outputs /tb_top/i_dut_0/o_seg1
add wave -noupdate -expand -group i_dut_0 -group Outputs /tb_top/i_dut_0/o_seg2
add wave -noupdate -expand -group i_dut_0 -group Outputs /tb_top/i_dut_0/o_seg3
add wave -noupdate -expand -group i_dut_0 -group Outputs /tb_top/i_dut_0/o_seg4
add wave -noupdate -expand -group i_dut_0 -group Outputs /tb_top/i_dut_0/o_seg5
add wave -noupdate -expand -group i_dut_0 -group Outputs /tb_top/i_dut_0/o_seg6
add wave -noupdate -expand -group i_dut_0 -group Outputs /tb_top/i_dut_0/o_seg7
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/tck
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/tdi
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/tdo
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/cdr
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/e1dr
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/e2dr
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/pdr
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/sdr
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/udr
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/uir
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/cir
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/ir_in
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/rst_n_synch
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/start_clk_jtag
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/addr
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/rnw
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/strobe
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/master_wdata
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/master_rdata
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/access_status
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/awvalid
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/awaddr
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/awprot
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/awready
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/wvalid
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/wdata
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/wstrb
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/wready
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/bready
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/bvalid
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/bresp
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/arvalid
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/araddr
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/arprot
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/arready
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/rready
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/rvalid
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/rdata
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/rresp
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/start_clk
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/start_clk_p1
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/start_clk_p2
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/start_clk_r_edge
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/done_clk
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/done_extended
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/done_extended_clk_jtag_p1
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/done_extended_clk_jtag_p2
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/done_extended_clk_jtag
add wave -noupdate -expand -group i_dut_0 -group Internal /tb_top/i_dut_0/done_extended_clk_jtag_r_edge
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_5 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_5/i_digit
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_5 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_5/o_seg
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_7 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_7/i_digit
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_7 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_7/o_seg
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_0/i_digit
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_0/o_seg
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_2 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_2/i_digit
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_2 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_2/o_seg
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_4 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_4/i_digit
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_4 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_4/o_seg
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_6 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_6/i_digit
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_6 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_6/o_seg
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_1 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_1/i_digit
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_1 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_1/o_seg
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_3 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_3/i_digit
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group i_seg7_lut_3 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_seg7_lut_3/o_seg
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/i_digits
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/o_seg0
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/o_seg1
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/o_seg2
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/o_seg3
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/o_seg4
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/o_seg5
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/o_seg6
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_seg7x8 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_seg7x8/o_seg7
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/clk
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/rst_n
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/awvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/awaddr
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/awprot
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/wvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/wdata
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/wstrb
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/bready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/arvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/araddr
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/arprot
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/rready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/slv_done
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/slv_rdata
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/slv_status
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/awready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/wready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/bvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/bresp
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/arready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/rvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/rdata
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/rresp
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/slv_start
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/slv_rw
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/slv_addr
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/slv_wdata
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/slv_strobe
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/s_arvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/s_araddr
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/s_arready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/s_rvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/s_rd_ongoing
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/s_wr_ongoing
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/s_awvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/s_awaddr
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/s_awready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/s_wvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/s_wready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/s_wdata
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/s_wstrb
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_slave_itf_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_slave_itf_0/s_bvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/clk
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/rst_n
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/awvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/awaddr
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/awprot
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/wvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/wdata
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/wstrb
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/bready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/arvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/araddr
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/arprot
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/rready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/awready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/wready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/bvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/bresp
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/arready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/rvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/rdata
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/rresp
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/o_seg0
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/o_seg1
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/o_seg2
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/o_seg3
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/o_seg4
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/o_seg5
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/o_seg6
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/o_seg7
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/digits_int
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/slv_start
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/slv_rw
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/slv_addr
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/slv_wdata
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/slv_strobe
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/slv_done
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/slv_rdata
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/slv_status
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_7segs_registers_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_7segs_registers_0/clk
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_7segs_registers_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_7segs_registers_0/rst_n
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_7segs_registers_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_7segs_registers_0/slv_start
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_7segs_registers_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_7segs_registers_0/slv_rw
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_7segs_registers_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_7segs_registers_0/slv_addr
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_7segs_registers_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_7segs_registers_0/slv_wdata
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_7segs_registers_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_7segs_registers_0/slv_strobe
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_7segs_registers_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_7segs_registers_0/slv_done
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_7segs_registers_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_7segs_registers_0/slv_rdata
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_7segs_registers_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_7segs_registers_0/slv_status
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_7segs_registers_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_7segs_registers_0/digits
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_7segs_registers_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_7segs_registers_0/reg_wr_sel
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_7segs_registers_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_7segs_registers_0/reg_wr_sel_error
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_7segs_0 -group i_axi4_lite_7segs_registers_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_7segs_0/i_axi4_lite_7segs_registers_0/digits_int
add wave -noupdate -expand -group i_dut_0 -group i_reset_gen_0 -group Inputs /tb_top/i_dut_0/i_reset_gen_0/clk
add wave -noupdate -expand -group i_dut_0 -group i_reset_gen_0 -group Inputs /tb_top/i_dut_0/i_reset_gen_0/arst_n
add wave -noupdate -expand -group i_dut_0 -group i_reset_gen_0 -group Outputs /tb_top/i_dut_0/i_reset_gen_0/o_rst_n
add wave -noupdate -expand -group i_dut_0 -group i_reset_gen_0 -group Internal /tb_top/i_dut_0/i_reset_gen_0/s_rst_n_p1
add wave -noupdate -expand -group i_dut_0 -group i_reset_gen_0 -group Internal /tb_top/i_dut_0/i_reset_gen_0/s_rst_n_p2
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/tdo
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/ir_out
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/tck
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/tdi
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/virtual_state_cdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/virtual_state_sdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/virtual_state_e1dr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/virtual_state_pdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/virtual_state_e2dr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/virtual_state_udr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/virtual_state_cir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/virtual_state_uir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_tlr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_rti
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_sdrs
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_cdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_sdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_e1dr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_pdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_e2dr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_udr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_sirs
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_cir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_sir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_e1ir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_pir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_e2ir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_uir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/tms
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/ir_in
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/tck_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/tms_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/tdi_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_usr1_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/tdo_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_tdo_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_tck_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_tms_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_tdi_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_tlr_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_rti_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_drs_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_cdr_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_sdr_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_e1dr_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_pdr_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_e2dr_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_udr_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_irs_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_cir_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_sir_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_e1ir_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_pir_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_e2ir_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag_state_uir_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_tck
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_tdi
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_tms
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_usr1
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_tlr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_rti
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_drs
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_cdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_sdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_e1dr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_pdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_e2dr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_udr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_irs
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_cir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_sir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_e1ir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_pir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_e2ir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_state_uir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_tdo
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/virtual_ir_out
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_tdo
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_tck
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_tdi
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_tms
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_tlr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_rti
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_drs
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_cdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_sdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_e1dr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_pdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_e2dr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_udr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_irs
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_cir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_sir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_e1ir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_pir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_e2ir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_state_uir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/virtual_state_cdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/virtual_state_sdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/virtual_state_e1dr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/virtual_state_pdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/virtual_state_e2dr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/virtual_state_udr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/virtual_state_cir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/virtual_state_uir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/virtual_ir_in
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/capture_ir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/jtag_tdo_reg
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_tdi_reg
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/dummy_tck_reg
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/ir_srl
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/ir_srl_tmp
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group hub -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/hub/ir_srl_hold
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/tck
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/tms
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/tdi
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_tdo
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/tdo
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_tck
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_tms
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_tdi
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_tlr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_rti
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_drs
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_cdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_sdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_e1dr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_pdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_e2dr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_udr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_irs
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_cir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_sir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_e1ir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_pir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_e2ir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_state_uir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_usr1
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/tdo_reg
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/tdo_rom_reg
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_usr1_reg
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/jtag_reset_i
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/cState
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/nState
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/ir_srl
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/ir_srl_hold
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/cState_tmp
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -group jtag -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/jtag/ir_srl_tmp
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/jtag_usr1
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/tdo
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/tck
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/tms
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/tdi
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/char_idx
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/value_idx
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/value_idx_old
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/value_idx_cur
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/length_idx
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/length_idx_old
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/length_idx_cur
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/last_length_idx
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/type_idx
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/type_idx_old
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/type_idx_cur
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/time_idx
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/time_idx_old
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/time_idx_cur
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/scan_length
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/scan_values
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/scan_type
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/scan_time
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/two_character
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/c_state
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/hex_value
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/last_length
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/tms_reg
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -expand -group virtual_jtag_0 -expand -group user_input -expand -group Internal /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/tdi_reg
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/tdo
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -group Inputs /tb_top/i_dut_0/i_altera_vjtag_0/ir_out
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/tdi
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/ir_in
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_state_cdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_state_sdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_state_e1dr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_state_pdr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_state_e2dr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_state_udr
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_state_cir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/virtual_state_uir
add wave -noupdate -expand -group i_dut_0 -expand -group i_altera_vjtag_0 -group Outputs /tb_top/i_dut_0/i_altera_vjtag_0/tck
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Inputs /tb_top/i_dut_0/i_vjtag_intf_0/clk_jtag
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Inputs /tb_top/i_dut_0/i_vjtag_intf_0/rst_n_jtag
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Inputs /tb_top/i_dut_0/i_vjtag_intf_0/tdi
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Inputs /tb_top/i_dut_0/i_vjtag_intf_0/ir_in
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Inputs /tb_top/i_dut_0/i_vjtag_intf_0/sdr
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Inputs /tb_top/i_dut_0/i_vjtag_intf_0/udr
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Inputs /tb_top/i_dut_0/i_vjtag_intf_0/data_in
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Inputs /tb_top/i_dut_0/i_vjtag_intf_0/data_in_val
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Outputs /tb_top/i_dut_0/i_vjtag_intf_0/tdo
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Outputs /tb_top/i_dut_0/i_vjtag_intf_0/addr
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Outputs /tb_top/i_dut_0/i_vjtag_intf_0/data_out
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Outputs /tb_top/i_dut_0/i_vjtag_intf_0/rnw
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Outputs /tb_top/i_dut_0/i_vjtag_intf_0/start
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Internal /tb_top/i_dut_0/i_vjtag_intf_0/select_DR0
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Internal /tb_top/i_dut_0/i_vjtag_intf_0/select_DR1
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Internal /tb_top/i_dut_0/i_vjtag_intf_0/select_DR2
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Internal /tb_top/i_dut_0/i_vjtag_intf_0/select_DR3
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Internal /tb_top/i_dut_0/i_vjtag_intf_0/select_DR4
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Internal /tb_top/i_dut_0/i_vjtag_intf_0/select_DR5
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Internal /tb_top/i_dut_0/i_vjtag_intf_0/addr_int
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Internal /tb_top/i_dut_0/i_vjtag_intf_0/data_out_int
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Internal /tb_top/i_dut_0/i_vjtag_intf_0/rnw_int
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Internal /tb_top/i_dut_0/i_vjtag_intf_0/data_in_int
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Internal /tb_top/i_dut_0/i_vjtag_intf_0/shift_data
add wave -noupdate -expand -group i_dut_0 -group i_vjtag_intf_0 -group Internal /tb_top/i_dut_0/i_vjtag_intf_0/start_int
add wave -noupdate -expand -group i_dut_0 -group i_bit_extender_0 -group Inputs /tb_top/i_dut_0/i_bit_extender_0/clk_sys
add wave -noupdate -expand -group i_dut_0 -group i_bit_extender_0 -group Inputs /tb_top/i_dut_0/i_bit_extender_0/rst_n
add wave -noupdate -expand -group i_dut_0 -group i_bit_extender_0 -group Inputs /tb_top/i_dut_0/i_bit_extender_0/pulse_in
add wave -noupdate -expand -group i_dut_0 -group i_bit_extender_0 -group Outputs /tb_top/i_dut_0/i_bit_extender_0/pulse_out
add wave -noupdate -expand -group i_dut_0 -group i_bit_extender_0 -group Internal /tb_top/i_dut_0/i_bit_extender_0/counter_pulse
add wave -noupdate -expand -group i_dut_0 -group i_bit_extender_0 -group Internal /tb_top/i_dut_0/i_bit_extender_0/en_cnt
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_master_0/clk
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_master_0/rst_n
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_master_0/start
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_master_0/addr
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_master_0/rnw
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_master_0/strobe
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_master_0/master_wdata
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_master_0/awready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_master_0/wready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_master_0/bvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_master_0/bresp
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_master_0/arready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_master_0/rvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_master_0/rdata
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Inputs /tb_top/i_dut_0/i_axi4_lite_master_0/rresp
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_master_0/done
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_master_0/master_rdata
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_master_0/access_status
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_master_0/awvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_master_0/awaddr
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_master_0/awprot
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_master_0/wvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_master_0/wdata
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_master_0/wstrb
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_master_0/bready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_master_0/arvalid
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_master_0/araddr
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_master_0/arprot
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Outputs /tb_top/i_dut_0/i_axi4_lite_master_0/rready
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_master_0/current_state
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_master_0/next_state
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_master_0/arvalid_int
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_master_0/rready_int
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_master_0/awvalid_int
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_master_0/wvalid_int
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_master_0/bready_int
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_master_0/addr_int
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_master_0/master_wdata_int
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_master_0/rnw_int
add wave -noupdate -expand -group i_dut_0 -group i_axi4_lite_master_0 -group Internal /tb_top/i_dut_0/i_axi4_lite_master_0/start_p
add wave -noupdate /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/sld_node_ir_width
add wave -noupdate /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/sld_node_n_scan
add wave -noupdate -radix ascii /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/sld_node_sim_action
add wave -noupdate /tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/sld_node_total_length
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1005869625 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 257
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
WaveRestoreZoom {0 ps} {15235132500 ps}
