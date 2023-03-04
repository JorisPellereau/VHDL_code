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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {217633500 ps}
