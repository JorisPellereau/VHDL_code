onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/clk
add wave -noupdate /tb_top/rst_n
add wave -noupdate -group {WAIT EVENT TB} /tb_top/i_wait_event_wrapper/i_wait_event_tb/clk
add wave -noupdate -group {WAIT EVENT TB} /tb_top/i_wait_event_wrapper/i_wait_event_tb/rst_n
add wave -noupdate -group {WAIT EVENT TB} /tb_top/i_wait_event_wrapper/i_wait_event_tb/i_wait_en
add wave -noupdate -group {WAIT EVENT TB} /tb_top/i_wait_event_wrapper/i_wait_event_tb/i_sel_wtr_wtf
add wave -noupdate -group {WAIT EVENT TB} -radix hexadecimal /tb_top/i_wait_event_wrapper/i_wait_event_tb/i_max_timeout
add wave -noupdate -group {WAIT EVENT TB} -expand /tb_top/i_wait_event_wrapper/i_wait_event_tb/i_wait
add wave -noupdate -group {WAIT EVENT TB} /tb_top/i_wait_event_wrapper/i_wait_event_tb/o_wait_done
add wave -noupdate -group {WAIT EVENT TB} -radix hexadecimal /tb_top/i_wait_event_wrapper/i_wait_event_tb/s_timeout_cnt
add wave -noupdate -group {WAIT EVENT TB} /tb_top/i_wait_event_wrapper/i_wait_event_tb/s_timeout_done
add wave -noupdate -group {SET INJECTOR TB} /tb_top/i_set_injector_wrapper/i_set_injector_tb/clk
add wave -noupdate -group {SET INJECTOR TB} /tb_top/i_set_injector_wrapper/i_set_injector_tb/rst_n
add wave -noupdate -group {SET INJECTOR TB} -radix hexadecimal -childformat {{{/tb_top/i_set_injector_wrapper/i_set_injector_tb/i_set_signals_asynch[0]} -radix hexadecimal} {{/tb_top/i_set_injector_wrapper/i_set_injector_tb/i_set_signals_asynch[1]} -radix hexadecimal} {{/tb_top/i_set_injector_wrapper/i_set_injector_tb/i_set_signals_asynch[2]} -radix hexadecimal} {{/tb_top/i_set_injector_wrapper/i_set_injector_tb/i_set_signals_asynch[3]} -radix hexadecimal} {{/tb_top/i_set_injector_wrapper/i_set_injector_tb/i_set_signals_asynch[4]} -radix hexadecimal}} -expand -subitemconfig {{/tb_top/i_set_injector_wrapper/i_set_injector_tb/i_set_signals_asynch[0]} {-height 16 -radix hexadecimal} {/tb_top/i_set_injector_wrapper/i_set_injector_tb/i_set_signals_asynch[1]} {-height 16 -radix hexadecimal} {/tb_top/i_set_injector_wrapper/i_set_injector_tb/i_set_signals_asynch[2]} {-height 16 -radix hexadecimal} {/tb_top/i_set_injector_wrapper/i_set_injector_tb/i_set_signals_asynch[3]} {-height 16 -radix hexadecimal} {/tb_top/i_set_injector_wrapper/i_set_injector_tb/i_set_signals_asynch[4]} {-height 16 -radix hexadecimal}} /tb_top/i_set_injector_wrapper/i_set_injector_tb/i_set_signals_asynch
add wave -noupdate -radix hexadecimal /tb_top/i0
add wave -noupdate -radix hexadecimal /tb_top/i1
add wave -noupdate -radix hexadecimal /tb_top/i2
add wave -noupdate -radix hexadecimal /tb_top/i3
add wave -noupdate -radix hexadecimal /tb_top/i4
add wave -noupdate /tb_top/s_check_level_if/check_alias
add wave -noupdate -radix hexadecimal -childformat {{{/tb_top/s_check_level_if/check_signals[0]} -radix hexadecimal} {{/tb_top/s_check_level_if/check_signals[1]} -radix hexadecimal} {{/tb_top/s_check_level_if/check_signals[2]} -radix hexadecimal} {{/tb_top/s_check_level_if/check_signals[3]} -radix hexadecimal} {{/tb_top/s_check_level_if/check_signals[4]} -radix hexadecimal}} -subitemconfig {{/tb_top/s_check_level_if/check_signals[0]} {-height 16 -radix hexadecimal} {/tb_top/s_check_level_if/check_signals[1]} {-height 16 -radix hexadecimal} {/tb_top/s_check_level_if/check_signals[2]} {-height 16 -radix hexadecimal} {/tb_top/s_check_level_if/check_signals[3]} {-height 16 -radix hexadecimal} {/tb_top/s_check_level_if/check_signals[4]} {-height 16 -radix hexadecimal}} /tb_top/s_check_level_if/check_signals
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 6} {3144151000 ps} 1} {{Cursor 2} {65381403 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 213
configure wave -valuecolwidth 135
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
WaveRestoreZoom {0 ps} {1110723600 ps}
