onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/clk
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/rst_n
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_en
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_me
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_we
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_addr
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_wdata
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/o_rdata
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_start_ptr
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_last_ptr
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_ptr_val
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_loop
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/o_ptr_equality
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/o_discard
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_max7219_if_done
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/o_max7219_if_start
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/o_max7219_if_en_load
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/o_max7219_if_data
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/s_me_decod
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/s_we_decod
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/s_addr_decod
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/s_wdata_decod
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/s_rdata_decod
add wave -noupdate -expand -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/clk
add wave -noupdate -expand -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_me_a
add wave -noupdate -expand -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_we_a
add wave -noupdate -expand -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_addr_a
add wave -noupdate -expand -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_wdata_a
add wave -noupdate -expand -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/o_rdata_a
add wave -noupdate -expand -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_me_b
add wave -noupdate -expand -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_we_b
add wave -noupdate -expand -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_addr_b
add wave -noupdate -expand -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_wdata_b
add wave -noupdate -expand -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/o_rdata_b
add wave -noupdate /tb_top/i_dut/tdpram_inst_0/v_ram
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 255
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
WaveRestoreZoom {5479050 ps} {5479945 ps}
