onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider DUT
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Inputs /tb_top/i_dut_fifo_sp_ram/clk
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Inputs /tb_top/i_dut_fifo_sp_ram/rst_n
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Inputs /tb_top/i_dut_fifo_sp_ram/wr_en
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Inputs /tb_top/i_dut_fifo_sp_ram/rd_en
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Inputs /tb_top/i_dut_fifo_sp_ram/wdata
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Inputs /tb_top/i_dut_fifo_sp_ram/rdata_in
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Outputs /tb_top/i_dut_fifo_sp_ram/rdata
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Outputs /tb_top/i_dut_fifo_sp_ram/rdata_val
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Outputs /tb_top/i_dut_fifo_sp_ram/wdata_out
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Outputs /tb_top/i_dut_fifo_sp_ram/we
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Outputs /tb_top/i_dut_fifo_sp_ram/wr_addr
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Outputs /tb_top/i_dut_fifo_sp_ram/rd_addr
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Outputs /tb_top/i_dut_fifo_sp_ram/fifo_empty
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Outputs /tb_top/i_dut_fifo_sp_ram/fifo_full
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Internal /tb_top/i_dut_fifo_sp_ram/write_ptr
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Internal /tb_top/i_dut_fifo_sp_ram/read_ptr
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Internal /tb_top/i_dut_fifo_sp_ram/fifo_full_int
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Internal /tb_top/i_dut_fifo_sp_ram/fifo_empty_int
add wave -noupdate -expand -group i_dut_fifo_sp_ram -group Internal /tb_top/i_dut_fifo_sp_ram/rd_en_p
add wave -noupdate -expand -group i_sp_ram_0 -group Inputs /tb_top/i_sp_ram_0/clk
add wave -noupdate -expand -group i_sp_ram_0 -group Inputs /tb_top/i_sp_ram_0/data_in
add wave -noupdate -expand -group i_sp_ram_0 -group Inputs /tb_top/i_sp_ram_0/wr_addr
add wave -noupdate -expand -group i_sp_ram_0 -group Inputs /tb_top/i_sp_ram_0/rd_addr
add wave -noupdate -expand -group i_sp_ram_0 -group Inputs /tb_top/i_sp_ram_0/we
add wave -noupdate -expand -group i_sp_ram_0 -group Outputs -expand /tb_top/i_sp_ram_0/data_out
add wave -noupdate -expand -group i_sp_ram_0 /tb_top/i_sp_ram_0/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5255513 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {210220500 ps}
