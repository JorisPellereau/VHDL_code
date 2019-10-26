onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/clock_i
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/reset_n
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/start_i
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/led_config_i
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/frame_done_o
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/d_out_o
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/cnt_pwm
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/TH_s
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/pwm_done
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/cnt_24
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/start_init_s
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/frame_done_s
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/frame_gen
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/start_s
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/start_re
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/led_config_s
add wave -noupdate -expand -group ws2812 -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_inst/d_out_s
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/clock
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/rst_n
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_stat_dyn
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_conf_update
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_en
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_frame_done
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_max_cnt
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/o_led_config
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/o_start_frame
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_end_static
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_conf_update
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_conf_update_r_edge
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_frame_done
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_frame_done_r_edge
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_cnt_nb_leds
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_stat
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_rfrsh_cnt
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_rfrsh_cnt_done
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_max_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {128549383 ps} 0}
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
WaveRestoreZoom {0 ps} {781882716 ps}
