onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /test_uint_division/uint_division_inst_0/G_WIDTH
add wave -noupdate -radix hexadecimal /test_uint_division/uint_division_inst_0/clk
add wave -noupdate -radix hexadecimal /test_uint_division/uint_division_inst_0/rst_n
add wave -noupdate -radix hexadecimal /test_uint_division/uint_division_inst_0/i_start
add wave -noupdate -color Pink -radix hexadecimal /test_uint_division/uint_division_inst_0/i_q
add wave -noupdate -color Pink -radix hexadecimal /test_uint_division/uint_division_inst_0/i_m
add wave -noupdate -radix hexadecimal /test_uint_division/uint_division_inst_0/i_n
add wave -noupdate -color {Medium Slate Blue} -radix hexadecimal /test_uint_division/uint_division_inst_0/o_q
add wave -noupdate -color {Medium Slate Blue} -radix hexadecimal /test_uint_division/uint_division_inst_0/o_r
add wave -noupdate -radix hexadecimal /test_uint_division/uint_division_inst_0/o_done
add wave -noupdate -radix hexadecimal /test_uint_division/uint_division_inst_0/s_current_state
add wave -noupdate -radix hexadecimal /test_uint_division/uint_division_inst_0/s_next_state
add wave -noupdate -radix hexadecimal -childformat {{/test_uint_division/uint_division_inst_0/s_reg(7) -radix hexadecimal} {/test_uint_division/uint_division_inst_0/s_reg(6) -radix hexadecimal} {/test_uint_division/uint_division_inst_0/s_reg(5) -radix hexadecimal} {/test_uint_division/uint_division_inst_0/s_reg(4) -radix hexadecimal} {/test_uint_division/uint_division_inst_0/s_reg(3) -radix hexadecimal} {/test_uint_division/uint_division_inst_0/s_reg(2) -radix hexadecimal} {/test_uint_division/uint_division_inst_0/s_reg(1) -radix hexadecimal} {/test_uint_division/uint_division_inst_0/s_reg(0) -radix hexadecimal}} -subitemconfig {/test_uint_division/uint_division_inst_0/s_reg(7) {-height 15 -radix hexadecimal} /test_uint_division/uint_division_inst_0/s_reg(6) {-height 15 -radix hexadecimal} /test_uint_division/uint_division_inst_0/s_reg(5) {-height 15 -radix hexadecimal} /test_uint_division/uint_division_inst_0/s_reg(4) {-height 15 -radix hexadecimal} /test_uint_division/uint_division_inst_0/s_reg(3) {-height 15 -radix hexadecimal} /test_uint_division/uint_division_inst_0/s_reg(2) {-height 15 -radix hexadecimal} /test_uint_division/uint_division_inst_0/s_reg(1) {-height 15 -radix hexadecimal} /test_uint_division/uint_division_inst_0/s_reg(0) {-height 15 -radix hexadecimal}} /test_uint_division/uint_division_inst_0/s_reg
add wave -noupdate -radix hexadecimal /test_uint_division/uint_division_inst_0/s_m
add wave -noupdate -radix hexadecimal /test_uint_division/uint_division_inst_0/s_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1029382 ps} 0}
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
WaveRestoreZoom {0 ps} {2100 ns}
