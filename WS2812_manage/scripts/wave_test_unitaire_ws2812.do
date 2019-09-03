onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group WS2812 /test_unitaire_ws2812/ws2812_inst/clock_i
add wave -noupdate -expand -group WS2812 /test_unitaire_ws2812/ws2812_inst/reset_n
add wave -noupdate -expand -group WS2812 /test_unitaire_ws2812/ws2812_inst/start_i
add wave -noupdate -expand -group WS2812 -radix hexadecimal /test_unitaire_ws2812/ws2812_inst/led_config_i
add wave -noupdate -expand -group WS2812 /test_unitaire_ws2812/ws2812_inst/frame_done_o
add wave -noupdate -expand -group WS2812 /test_unitaire_ws2812/ws2812_inst/d_out_o
add wave -noupdate -expand -group WS2812 /test_unitaire_ws2812/ws2812_inst/cnt_pwm
add wave -noupdate -expand -group WS2812 /test_unitaire_ws2812/ws2812_inst/TH_s
add wave -noupdate -expand -group WS2812 /test_unitaire_ws2812/ws2812_inst/pwm_done
add wave -noupdate -expand -group WS2812 /test_unitaire_ws2812/ws2812_inst/cnt_24
add wave -noupdate -expand -group WS2812 /test_unitaire_ws2812/ws2812_inst/start_init_s
add wave -noupdate -expand -group WS2812 /test_unitaire_ws2812/ws2812_inst/frame_done_s
add wave -noupdate -expand -group WS2812 /test_unitaire_ws2812/ws2812_inst/frame_gen
add wave -noupdate -expand -group WS2812 /test_unitaire_ws2812/ws2812_inst/start_s
add wave -noupdate -expand -group WS2812 /test_unitaire_ws2812/ws2812_inst/start_re
add wave -noupdate -expand -group WS2812 -radix hexadecimal /test_unitaire_ws2812/ws2812_inst/led_config_s
add wave -noupdate -expand -group WS2812 /test_unitaire_ws2812/ws2812_inst/d_out_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3908222 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 183
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
WaveRestoreZoom {0 ps} {36196495 ps}
