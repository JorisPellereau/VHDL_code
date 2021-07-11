onerror {resume}
quietly WaveActivateNextPane {} 0
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
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_next_state
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_start
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_start_r_edge
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_scl_in
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_sda_in
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_scl_out
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_sda_out
add wave -noupdate -expand -group {MASTER 2C TOP} /tb_top/i_dut/s_en_scl
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14313244 ps} 0}
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
WaveRestoreZoom {0 ps} {105283500 ps}
