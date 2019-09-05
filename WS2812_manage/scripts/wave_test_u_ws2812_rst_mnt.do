onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {WS RST Manage} /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/clock_i
add wave -noupdate -expand -group {WS RST Manage} /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/reset_n
add wave -noupdate -expand -group {WS RST Manage} /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/en_start_i
add wave -noupdate -expand -group {WS RST Manage} /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/reset_gen_i
add wave -noupdate -expand -group {WS RST Manage} /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/config_done_i
add wave -noupdate -expand -group {WS RST Manage} /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/start_leds_o
add wave -noupdate -expand -group {WS RST Manage} /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/config_done_s
add wave -noupdate -expand -group {WS RST Manage} /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/config_done_r_edge
add wave -noupdate -expand -group {WS RST Manage} -radix hexadecimal /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/cnt_rst_s
add wave -noupdate -expand -group {WS RST Manage} /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/start_cnt_s
add wave -noupdate -expand -group {WS RST Manage} /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/rst_done_s
add wave -noupdate -expand -group {WS RST Manage} /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/en_start_i_s
add wave -noupdate -expand -group {WS RST Manage} /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/en_start_i_ss
add wave -noupdate -expand -group {WS RST Manage} /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/reset_gen_i_s
add wave -noupdate -expand -group {WS RST Manage} /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/reset_gen_i_ss
add wave -noupdate -expand -group {WS RST Manage} /test_u_ws2812_rst_mng/ws2812_rst_mng_inst/start_leds_o_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1014641 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 205
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
WaveRestoreZoom {421069 ps} {1276575 ps}
