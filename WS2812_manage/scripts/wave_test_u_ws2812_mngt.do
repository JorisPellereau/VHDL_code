onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/clock_i
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/reset_n
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/start_leds_i
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/frame_ws2812_done_i
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/led_config_array_i
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/start_ws2812_o
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/led_config_o
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/cnt_led_s
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/start_leds_i_s
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/start_leds_r_edge
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/frame_ws2812_done_s
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/setup_config_done_s
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/frame_ws2812_done_r_edge
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/led_config_array_s
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/run_config_s
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/start_ws2812_o_s
add wave -noupdate -expand -group {WS2812 MNGT} -radix hexadecimal /test_u_ws2812_mngt/ws2812_mngt_inst/led_config_o_s
add wave -noupdate -expand -group {WS2812 MNGT} /test_u_ws2812_mngt/ws2812_mngt_inst/config_done_s
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/clock_i
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/reset_n
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/start_i
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/led_config_i
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/frame_done_o
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/d_out_o
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/cnt_pwm
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/TH_s
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/pwm_done
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/cnt_24
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/start_init_s
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/frame_done_s
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/frame_gen
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/start_s
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/start_re
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/led_config_s
add wave -noupdate -group WS2812 -radix hexadecimal /test_u_ws2812_mngt/ws2812_inst/d_out_s
add wave -noupdate -radix hexadecimal /test_u_ws2812_mngt/clock
add wave -noupdate -radix hexadecimal /test_u_ws2812_mngt/reset_n
add wave -noupdate -radix hexadecimal /test_u_ws2812_mngt/d_out_s
add wave -noupdate -radix hexadecimal /test_u_ws2812_mngt/frame_ws2812_done_s
add wave -noupdate -radix hexadecimal /test_u_ws2812_mngt/start_leds_s
add wave -noupdate -radix hexadecimal /test_u_ws2812_mngt/start_ws2812_s
add wave -noupdate -radix hexadecimal /test_u_ws2812_mngt/led_config_array_s
add wave -noupdate -radix hexadecimal /test_u_ws2812_mngt/led_config_s
add wave -noupdate -radix hexadecimal /test_u_ws2812_mngt/C_HALF_CLK
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {44100000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 256
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
WaveRestoreZoom {0 ps} {126 us}
