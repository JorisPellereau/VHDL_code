onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/clk
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/rst_n
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/i_en
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/i_me
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/i_we
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/i_addr
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/i_wdata
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/o_rdata
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/i_start_ptr
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/i_last_ptr
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/i_ptr_val
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/i_loop
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/o_ptr_equality
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/o_max7219_load
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/o_max7219_data
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/o_max7219_clk
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/s_start
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/s_en_load
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/s_data
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/s_done
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/s_max7219_load
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/s_max7219_clk
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/s_max7219_data
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/s_me_decod
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/s_we_decod
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/s_addr_decod
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/s_wdata_decod
add wave -noupdate -group {TOP MAX7219 CMD DECOD} -radix hexadecimal /test_max7219_cmd_decod/max7219_cmd_decod_inst/s_rdata_decod
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {238 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
