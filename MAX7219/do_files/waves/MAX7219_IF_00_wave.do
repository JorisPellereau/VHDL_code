onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {MAX7219 IF} /tb_top/i_dut/G_MAX_HALF_PERIOD
add wave -noupdate -expand -group {MAX7219 IF} /tb_top/i_dut/G_LOAD_DURATION
add wave -noupdate -expand -group {MAX7219 IF} /tb_top/i_dut/clk
add wave -noupdate -expand -group {MAX7219 IF} /tb_top/i_dut/rst_n
add wave -noupdate -expand -group {MAX7219 IF} -expand -group Inputs /tb_top/i_dut/i_start
add wave -noupdate -expand -group {MAX7219 IF} -expand -group Inputs /tb_top/i_dut/i_en_load
add wave -noupdate -expand -group {MAX7219 IF} -expand -group Inputs /tb_top/i_dut/i_data
add wave -noupdate -expand -group {MAX7219 IF} -expand -group Outputs /tb_top/i_dut/o_max7219_load
add wave -noupdate -expand -group {MAX7219 IF} -expand -group Outputs /tb_top/i_dut/o_max7219_data
add wave -noupdate -expand -group {MAX7219 IF} -expand -group Outputs /tb_top/i_dut/o_max7219_clk
add wave -noupdate -expand -group {MAX7219 IF} -expand -group Outputs /tb_top/i_dut/o_done
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_data
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_en_load
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_start
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_init_data
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_en_clk
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_max7219_data
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_max7219_clk
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_max7219_clk_p
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_max7219_clk_f_edge
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_max7219_clk_r_edge
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_max7219_load
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_start_r_edge
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_done
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_cnt_15
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_cnt_16
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_cnt_half_period
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_load_px
add wave -noupdate -expand -group {MAX7219 IF} -group {internal signals} /tb_top/i_dut/s_end_frame
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {312991 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 275
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
configure wave -timelineunits ns
update
WaveRestoreZoom {308245 ps} {329385 ps}
