onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TX /test_robustesse/tx_inst/reset_n
add wave -noupdate -group TX /test_robustesse/tx_inst/clock
add wave -noupdate -group TX /test_robustesse/tx_inst/start_tx
add wave -noupdate -group TX /test_robustesse/tx_inst/tx_data
add wave -noupdate -group TX /test_robustesse/tx_inst/tx
add wave -noupdate -group TX /test_robustesse/tx_inst/tx_done
add wave -noupdate -group TX /test_robustesse/tx_inst/tx_fsm
add wave -noupdate -group TX /test_robustesse/tx_inst/start_tx_old
add wave -noupdate -group TX /test_robustesse/tx_inst/start_tx_re
add wave -noupdate -group TX /test_robustesse/tx_inst/tx_data_s
add wave -noupdate -group TX /test_robustesse/tx_inst/tx_s
add wave -noupdate -group TX /test_robustesse/tx_inst/cnt_bit_duration
add wave -noupdate -group TX /test_robustesse/tx_inst/tick_data
add wave -noupdate -group TX /test_robustesse/tx_inst/cnt_data
add wave -noupdate -group TX /test_robustesse/tx_inst/cnt_bit
add wave -noupdate -group TX /test_robustesse/tx_inst/cnt_stop_bit
add wave -noupdate -group TX /test_robustesse/tx_inst/tx_done_s
add wave -noupdate -group TX /test_robustesse/tx_inst/parity_value
add wave -noupdate -group RX /test_robustesse/rx_inst/reset_n
add wave -noupdate -group RX /test_robustesse/rx_inst/clock
add wave -noupdate -group RX /test_robustesse/rx_inst/rx
add wave -noupdate -group RX /test_robustesse/rx_inst/rx_data
add wave -noupdate -group RX /test_robustesse/rx_inst/rx_done
add wave -noupdate -group RX /test_robustesse/rx_inst/parity_rcvd
add wave -noupdate -group RX /test_robustesse/rx_inst/rx_fsm
add wave -noupdate -group RX /test_robustesse/rx_inst/rx_old
add wave -noupdate -group RX /test_robustesse/rx_inst/start_rx_fe
add wave -noupdate -group RX /test_robustesse/rx_inst/start_rx_re
add wave -noupdate -group RX /test_robustesse/rx_inst/start_cnt
add wave -noupdate -group RX /test_robustesse/rx_inst/tick_data
add wave -noupdate -group RX /test_robustesse/rx_inst/rx_data_s
add wave -noupdate -group RX /test_robustesse/rx_inst/parity_rcvd_s
add wave -noupdate -group RX /test_robustesse/rx_inst/rx_done_s
add wave -noupdate -group RX /test_robustesse/rx_inst/cnt_half_bit
add wave -noupdate -group RX /test_robustesse/rx_inst/cnt_bit
add wave -noupdate -group RX /test_robustesse/rx_inst/cnt_data
add wave -noupdate -group RX /test_robustesse/rx_inst/cnt_stop_bit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {110876260 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 198
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
configure wave -timeline 1
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {1050 us}
