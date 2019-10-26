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
add wave -noupdate -expand -group ws2812 -radix decimal /tu_ws2812_leds_mngt/ws2812_inst/cnt_24
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
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal -childformat {{/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(0) -radix hexadecimal} {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(1) -radix hexadecimal} {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(2) -radix hexadecimal} {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(3) -radix hexadecimal} {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(4) -radix hexadecimal} {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(5) -radix hexadecimal} {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(6) -radix hexadecimal} {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(7) -radix hexadecimal}} -subitemconfig {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(0) {-radix hexadecimal} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(1) {-radix hexadecimal} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(2) {-radix hexadecimal} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(3) {-radix hexadecimal} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(4) {-radix hexadecimal} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(5) {-radix hexadecimal} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(6) {-radix hexadecimal} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config(7) {-radix hexadecimal}} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/i_leds_config
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
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal -childformat {{/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(0) -radix hexadecimal} {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(1) -radix hexadecimal} {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(2) -radix hexadecimal} {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(3) -radix hexadecimal} {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(4) -radix hexadecimal} {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(5) -radix hexadecimal} {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(6) -radix hexadecimal} {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(7) -radix hexadecimal}} -expand -subitemconfig {/tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(0) {-height 15 -radix hexadecimal} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(1) {-height 15 -radix hexadecimal} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(2) {-height 15 -radix hexadecimal} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(3) {-height 15 -radix hexadecimal} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(4) {-height 15 -radix hexadecimal} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(5) {-height 15 -radix hexadecimal} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(6) {-height 15 -radix hexadecimal} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn(7) {-height 15 -radix hexadecimal}} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_leds_config_dyn
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_rfrsh_cnt
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_rfrsh_cnt_done
add wave -noupdate -expand -group {ws2812 leds mngt} -radix hexadecimal /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_max_cnt
add wave -noupdate -expand -group {ws2812 leds mngt} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/o_stat_conf_done
add wave -noupdate -expand -group {ws2812 leds mngt} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/o_dyn_ongoing
add wave -noupdate -expand -group {ws2812 leds mngt} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/o_rfrsh_dyn_done
add wave -noupdate -expand -group {ws2812 leds mngt} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_end_static
add wave -noupdate -expand -group {ws2812 leds mngt} /tu_ws2812_leds_mngt/ws2812_leds_mngt_inst/s_dyn_ongoing
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7402680000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 250
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
WaveRestoreZoom {0 ps} {8400 us}
