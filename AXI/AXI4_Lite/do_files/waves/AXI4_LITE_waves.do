onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group Clock /tb_top/i_clk_gen/clk_tb
add wave -noupdate -group Clock /tb_top/i_clk_gen/rst_n
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/arready
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/awready
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/bresp
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/bvalid
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/clk
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/rdata
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/rresp
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/rst_n
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/rvalid
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/wready
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/araddr
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/arprot
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/arvalid
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/awaddr
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/awprot
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/awvalid
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/bready
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/rready
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/wdata
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/wstrb
add wave -noupdate -group {MASTER AXI4} /tb_top/i_osvvm_axi4lite_manager_wrapper/wvalid
add wave -noupdate /tb_top/i_osvvm_axi4lite_manager_wrapper/wr_req
add wave -noupdate /tb_top/i_osvvm_axi4lite_manager_wrapper/axi_data
add wave -noupdate /tb_top/i_osvvm_axi4lite_manager_wrapper/axi_addr
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/araddr
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/arprot
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/arvalid
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/awaddr
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/awprot
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/awvalid
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/bready
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/clk
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/G_AXI4_LITE_ADDR_WIDTH
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/G_AXI4_LITE_DATA_WIDTH
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/rready
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/rst_n
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/slv_reg_arready
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/slv_reg_awready
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/slv_reg_bresp
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/slv_reg_rdata
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/slv_reg_rresp
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/slv_reg_wready
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/wdata
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/wstrb
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/wvalid
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/arready
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/awready
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/bresp
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/bvalid
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/master_bready
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/rdata
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/rresp
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/rvalid
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/slv_reg_raddr
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/slv_reg_rden
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/slv_reg_waddr
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/slv_reg_wdata
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/slv_reg_wren
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/wready
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/s_awaddr
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/s_awvalid
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/s_wdata
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/s_wvalid
add wave -noupdate -expand -group DUT_TOP /tb_top/i_dut/slv_reg_bvalid
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/reg_0
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/slv_reg_bvalid
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/waddr_ok
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/raddr_ok
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/clk
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/G_AXI4_LITE_ADDR_WIDTH
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/G_AXI4_LITE_DATA_WIDTH
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/master_bready
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/rst_n
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/slv_reg_raddr
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/slv_reg_rden
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/slv_reg_waddr
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/slv_reg_wdata
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/slv_reg_wren
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/slv_reg_arready
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/slv_reg_awready
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/slv_reg_bresp
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/slv_reg_rdata
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/slv_reg_rresp
add wave -noupdate -expand -group {SLAVE REG} /tb_top/i_axi4_lite_slave_reg_0/slv_reg_wready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2265821 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 464
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
WaveRestoreZoom {1911687 ps} {2628313 ps}
