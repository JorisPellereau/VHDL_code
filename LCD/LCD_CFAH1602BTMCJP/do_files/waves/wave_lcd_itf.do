onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group LCD_emul_checker /tb_top/i_LCD_CFAH_emul/clk
add wave -noupdate -group LCD_emul_checker /tb_top/i_LCD_CFAH_emul/rst_n
add wave -noupdate -group LCD_emul_checker /tb_top/i_LCD_CFAH_emul/i_rs
add wave -noupdate -group LCD_emul_checker /tb_top/i_LCD_CFAH_emul/i_rw
add wave -noupdate -group LCD_emul_checker /tb_top/i_LCD_CFAH_emul/i_en
add wave -noupdate -group LCD_emul_checker /tb_top/i_LCD_CFAH_emul/io_data
add wave -noupdate -group LCD_emul_checker /tb_top/i_LCD_CFAH_emul/i_wdata
add wave -noupdate -group LCD_emul_checker /tb_top/i_LCD_CFAH_emul/o_rdata
add wave -noupdate -group LCD_emul_checker /tb_top/i_LCD_CFAH_emul/o_rdata_val
add wave -noupdate -group LCD_emul_checker /tb_top/i_LCD_CFAH_emul/s_en
add wave -noupdate -group LCD_emul_checker /tb_top/i_LCD_CFAH_emul/s_en_f_edge
add wave -noupdate -group LCD_emul_checker /tb_top/i_LCD_CFAH_emul/time_rs
add wave -noupdate -group LCD_emul_checker /tb_top/i_LCD_CFAH_emul/time_en_r_edge
add wave -noupdate -group LCD_emul_checker /tb_top/i_LCD_CFAH_emul/time_en_r_edge_p
add wave -noupdate -group LCD_emul_checker /tb_top/i_LCD_CFAH_emul/time_en_f_edge
add wave -noupdate -divider DUT
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/clk
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/rst_n
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_wdata
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_lcd_data
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_rs
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_rw
add wave -noupdate -expand -group i_dut -group Inputs /tb_top/i_dut/i_start
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_lcd_wdata
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_lcd_rdata
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_lcd_rw
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_lcd_en
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_lcd_rs
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_bidir_sel
add wave -noupdate -expand -group i_dut -group Outputs /tb_top/i_dut/o_done
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_cnt
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_wdata
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_rdata
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_ongoing
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_rs
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_rw
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_en
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_cnt_tcycen_done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {396428 ps} 0}
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
WaveRestoreZoom {0 ps} {472500 ps}
