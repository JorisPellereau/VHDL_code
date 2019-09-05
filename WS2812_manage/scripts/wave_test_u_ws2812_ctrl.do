onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group WS2812_ctrl -radix hexadecimal /test_u_ws2812_ctrl/ws2812_ctrl_inst/clock_i
add wave -noupdate -expand -group WS2812_ctrl -radix hexadecimal /test_u_ws2812_ctrl/ws2812_ctrl_inst/reset_n
add wave -noupdate -expand -group WS2812_ctrl -radix hexadecimal /test_u_ws2812_ctrl/ws2812_ctrl_inst/sel_config_i
add wave -noupdate -expand -group WS2812_ctrl -radix hexadecimal /test_u_ws2812_ctrl/ws2812_ctrl_inst/ws2812_leds_cmd_i
add wave -noupdate -expand -group WS2812_ctrl -radix hexadecimal /test_u_ws2812_ctrl/ws2812_ctrl_inst/ws2812_data_o
add wave -noupdate -expand -group WS2812_ctrl -radix hexadecimal /test_u_ws2812_ctrl/ws2812_ctrl_inst/config_led_s
add wave -noupdate -expand -group WS2812_ctrl -radix hexadecimal /test_u_ws2812_ctrl/ws2812_ctrl_inst/led_config_s
add wave -noupdate -expand -group WS2812_ctrl -radix hexadecimal /test_u_ws2812_ctrl/ws2812_ctrl_inst/config_valid_s
add wave -noupdate -expand -group WS2812_ctrl -radix hexadecimal /test_u_ws2812_ctrl/ws2812_ctrl_inst/start_leds_s
add wave -noupdate -expand -group WS2812_ctrl -radix hexadecimal /test_u_ws2812_ctrl/ws2812_ctrl_inst/frame_ws2812_done_s
add wave -noupdate -expand -group WS2812_ctrl -radix hexadecimal /test_u_ws2812_ctrl/ws2812_ctrl_inst/start_ws2812_s
add wave -noupdate -expand -group WS2812_ctrl -radix hexadecimal /test_u_ws2812_ctrl/ws2812_ctrl_inst/config_done_s
add wave -noupdate -expand -group WS2812_ctrl -radix hexadecimal /test_u_ws2812_ctrl/ws2812_ctrl_inst/en_start_s
add wave -noupdate -expand -group WS2812_ctrl -radix hexadecimal /test_u_ws2812_ctrl/ws2812_ctrl_inst/reset_gen_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {49979851 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 238
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
WaveRestoreZoom {49978245 ps} {49999907 ps}
