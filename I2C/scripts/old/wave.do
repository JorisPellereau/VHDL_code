onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/reset_n
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/clock
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/start_i2c
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/rw
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/chip_addr
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/nb_data
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/wdata
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/i2c_done
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/rdata
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/scl
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/sda
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/start_i2c_old
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/start_i2c_re
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/i2c_master_fsm
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/tick_clock
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/start_gen_done
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/en_scl_old
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/en_scl_re
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/rw_s
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/chip_addr_s
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/nb_data_s
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/sack_ok
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/tick_data
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/cnt_tick_clock
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/cnt_start_stop
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/cnt_9
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/en_cnt_9
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/scl_in
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/sda_in
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/scl_out
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/sda_out
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/en_scl
add wave -noupdate -expand -group {I2C Master} /test_master_i2c/inst_master_i2c/en_sda
add wave -noupdate /test_master_i2c/p_slave_emul/cnt_9
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {70900000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 198
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
configure wave -timeline 1
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {1050 us}
