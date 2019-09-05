onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /test_u_config_leds/config_leds_inst/clock_i
add wave -noupdate -radix hexadecimal /test_u_config_leds/config_leds_inst/reset_n
add wave -noupdate -radix hexadecimal /test_u_config_leds/config_leds_inst/sel_config_i
add wave -noupdate -radix hexadecimal /test_u_config_leds/config_leds_inst/config_led_o
add wave -noupdate -radix hexadecimal /test_u_config_leds/config_leds_inst/config_valid_o
add wave -noupdate -radix hexadecimal /test_u_config_leds/config_leds_inst/sel_config_i_s
add wave -noupdate -radix hexadecimal /test_u_config_leds/config_leds_inst/sel_config_i_ss
add wave -noupdate -radix hexadecimal /test_u_config_leds/config_leds_inst/config_led_o_s
add wave -noupdate -radix hexadecimal /test_u_config_leds/config_leds_inst/config_valid_o_s
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
