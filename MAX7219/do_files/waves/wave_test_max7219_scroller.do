onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {TOP SCROLLER} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/clk
add wave -noupdate -group {TOP SCROLLER} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/rst_n
add wave -noupdate -group {TOP SCROLLER} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/i_start_scroll
add wave -noupdate -group {TOP SCROLLER} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/o_me
add wave -noupdate -group {TOP SCROLLER} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/o_we
add wave -noupdate -group {TOP SCROLLER} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/o_addr
add wave -noupdate -group {TOP SCROLLER} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/i_rdata
add wave -noupdate -group {TOP SCROLLER} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/o_start
add wave -noupdate -group {TOP SCROLLER} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/o_en_load
add wave -noupdate -group {TOP SCROLLER} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/o_data
add wave -noupdate -group {TOP SCROLLER} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/i_done
add wave -noupdate -group {TOP SCROLLER} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_msg2scroll_array
add wave -noupdate -group {TOP SCROLLER} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_shift_nb
add wave -noupdate -group {TOP SCROLLER} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/s_start
add wave -noupdate -radix hexadecimal /test_max7219_scroller/tdpram_inst_0/v_ram
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/clk
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/rst_n
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/i_start_scroll
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/o_me
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/o_we
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/o_addr
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/i_rdata
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/o_msg2scroll_array
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/o_shift_nb
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/o_start
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/s_start_scroll
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/s_start_scroll_r_edge
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/s_me
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/s_we
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/s_addr
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/s_msg_length
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/s_read_msg_length
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/s_read_ram
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/s_read_done
add wave -noupdate -group {SCROLLER RD MEM} -radix hexadecimal /test_max7219_scroller/max7219_scroller_inst_0/max7219_scroller_rd_mem_inst_0/s_shift_nb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {362040 ns}
