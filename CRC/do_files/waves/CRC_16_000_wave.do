onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {CRC CCIT TOP} /tb_top/i_dut/clk
add wave -noupdate -expand -group {CRC CCIT TOP} /tb_top/i_dut/rst_n
add wave -noupdate -expand -group {CRC CCIT TOP} /tb_top/i_dut/i_rst_crc
add wave -noupdate -expand -group {CRC CCIT TOP} /tb_top/i_dut/i_val
add wave -noupdate -expand -group {CRC CCIT TOP} /tb_top/i_dut/i_data
add wave -noupdate -expand -group {CRC CCIT TOP} /tb_top/i_dut/o_crc
add wave -noupdate -expand -group {CRC CCIT TOP} /tb_top/i_dut/s_crc
add wave -noupdate -expand -group {CRC CCIT TOP} /tb_top/i_dut/s_rst_crc
add wave -noupdate -expand -group {CRC CCIT TOP} /tb_top/i_dut/s_rst_crc_r_edge
add wave -noupdate -expand -group {DATA CHECKER} -expand /tb_top/data_checker_crc_0/clk
add wave -noupdate -expand -group {DATA CHECKER} -expand /tb_top/data_checker_crc_0/rst_n
add wave -noupdate -expand -group {DATA CHECKER} -expand /tb_top/data_checker_crc_0/i_data
add wave -noupdate -expand -group {DATA CHECKER} -expand /tb_top/data_checker_crc_0/i_data_valid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {264516 ps} 0}
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
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {5628 ns}
