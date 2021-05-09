onerror {resume}
quietly virtual signal -install /tb_top/i_dut/i_rx_uart_0 { (context /tb_top/i_dut/i_rx_uart_0 )(reset_n & clock & rx &rx_data & rx_done & parity_rcvd & rx_fsm & rx_old & start_rx_fe & start_rx_re & start_cnt & tick_data &rx_data_s & parity_rcvd_s & rx_done_s & cnt_half_bit & cnt_bit & cnt_data & cnt_stop_bit )} RX_UART
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {TOP DUT} -radix hexadecimal /tb_top/i_dut/clk
add wave -noupdate -expand -group {TOP DUT} -radix hexadecimal /tb_top/i_dut/rst_n
add wave -noupdate -expand -group {TOP DUT} -radix hexadecimal /tb_top/i_dut/i_rx
add wave -noupdate -expand -group {TOP DUT} -radix hexadecimal /tb_top/i_dut/o_tx
add wave -noupdate -expand -group {TOP DUT} -group {config. and Status} -radix hexadecimal /tb_top/i_dut/o_static_dyn
add wave -noupdate -expand -group {TOP DUT} -group {config. and Status} -radix hexadecimal /tb_top/i_dut/o_new_display
add wave -noupdate -expand -group {TOP DUT} -group {config. and Status} -radix hexadecimal /tb_top/i_dut/o_new_config_val
add wave -noupdate -expand -group {TOP DUT} -group {config. and Status} -radix hexadecimal /tb_top/i_dut/o_en_static
add wave -noupdate -expand -group {TOP DUT} -group {config. and Status} -radix hexadecimal /tb_top/i_dut/o_start_ptr_static
add wave -noupdate -expand -group {TOP DUT} -group {config. and Status} -radix hexadecimal /tb_top/i_dut/o_last_ptr_static
add wave -noupdate -expand -group {TOP DUT} -group {config. and Status} -radix hexadecimal /tb_top/i_dut/i_ptr_equality_static
add wave -noupdate -expand -group {TOP DUT} -group {config. and Status} -radix hexadecimal /tb_top/i_dut/i_static_busy
add wave -noupdate -expand -group {TOP DUT} -group {config. and Status} -radix hexadecimal /tb_top/i_dut/i_scroller_busy
add wave -noupdate -expand -group {TOP DUT} -group {config. and Status} -radix hexadecimal /tb_top/i_dut/o_ram_start_ptr_scroller
add wave -noupdate -expand -group {TOP DUT} -group {config. and Status} -radix hexadecimal /tb_top/i_dut/o_msg_length_scroller
add wave -noupdate -expand -group {TOP DUT} -group {config. and Status} -radix hexadecimal /tb_top/i_dut/o_max_tempo_cnt_scroller
add wave -noupdate -expand -group {TOP DUT} -radix hexadecimal /tb_top/i_dut/i_config_done
add wave -noupdate -expand -group {TOP DUT} -group {CONFIG MATRIX} -radix hexadecimal /tb_top/i_dut/o_display_test
add wave -noupdate -expand -group {TOP DUT} -group {CONFIG MATRIX} -radix hexadecimal /tb_top/i_dut/o_decod_mode
add wave -noupdate -expand -group {TOP DUT} -group {CONFIG MATRIX} -radix hexadecimal /tb_top/i_dut/o_intensity
add wave -noupdate -expand -group {TOP DUT} -group {CONFIG MATRIX} -radix hexadecimal /tb_top/i_dut/o_scan_limit
add wave -noupdate -expand -group {TOP DUT} -group {CONFIG MATRIX} -radix hexadecimal /tb_top/i_dut/o_shutdown
add wave -noupdate -expand -group {TOP DUT} -expand -group {RAM STATIC I/F} -radix hexadecimal /tb_top/i_dut/i_rdata_static
add wave -noupdate -expand -group {TOP DUT} -expand -group {RAM STATIC I/F} -radix hexadecimal /tb_top/i_dut/o_me_static
add wave -noupdate -expand -group {TOP DUT} -expand -group {RAM STATIC I/F} -radix hexadecimal /tb_top/i_dut/o_we_static
add wave -noupdate -expand -group {TOP DUT} -expand -group {RAM STATIC I/F} -radix hexadecimal -childformat {{/tb_top/i_dut/o_addr_static(7) -radix hexadecimal} {/tb_top/i_dut/o_addr_static(6) -radix hexadecimal} {/tb_top/i_dut/o_addr_static(5) -radix hexadecimal} {/tb_top/i_dut/o_addr_static(4) -radix hexadecimal} {/tb_top/i_dut/o_addr_static(3) -radix hexadecimal} {/tb_top/i_dut/o_addr_static(2) -radix hexadecimal} {/tb_top/i_dut/o_addr_static(1) -radix hexadecimal} {/tb_top/i_dut/o_addr_static(0) -radix hexadecimal}} -subitemconfig {/tb_top/i_dut/o_addr_static(7) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_addr_static(6) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_addr_static(5) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_addr_static(4) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_addr_static(3) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_addr_static(2) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_addr_static(1) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_addr_static(0) {-height 16 -radix hexadecimal}} /tb_top/i_dut/o_addr_static
add wave -noupdate -expand -group {TOP DUT} -expand -group {RAM STATIC I/F} -radix hexadecimal -childformat {{/tb_top/i_dut/o_wdata_static(15) -radix hexadecimal} {/tb_top/i_dut/o_wdata_static(14) -radix hexadecimal} {/tb_top/i_dut/o_wdata_static(13) -radix hexadecimal} {/tb_top/i_dut/o_wdata_static(12) -radix hexadecimal} {/tb_top/i_dut/o_wdata_static(11) -radix hexadecimal} {/tb_top/i_dut/o_wdata_static(10) -radix hexadecimal} {/tb_top/i_dut/o_wdata_static(9) -radix hexadecimal} {/tb_top/i_dut/o_wdata_static(8) -radix hexadecimal} {/tb_top/i_dut/o_wdata_static(7) -radix hexadecimal} {/tb_top/i_dut/o_wdata_static(6) -radix hexadecimal} {/tb_top/i_dut/o_wdata_static(5) -radix hexadecimal} {/tb_top/i_dut/o_wdata_static(4) -radix hexadecimal} {/tb_top/i_dut/o_wdata_static(3) -radix hexadecimal} {/tb_top/i_dut/o_wdata_static(2) -radix hexadecimal} {/tb_top/i_dut/o_wdata_static(1) -radix hexadecimal} {/tb_top/i_dut/o_wdata_static(0) -radix hexadecimal}} -subitemconfig {/tb_top/i_dut/o_wdata_static(15) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_wdata_static(14) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_wdata_static(13) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_wdata_static(12) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_wdata_static(11) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_wdata_static(10) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_wdata_static(9) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_wdata_static(8) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_wdata_static(7) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_wdata_static(6) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_wdata_static(5) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_wdata_static(4) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_wdata_static(3) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_wdata_static(2) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_wdata_static(1) {-height 16 -radix hexadecimal} /tb_top/i_dut/o_wdata_static(0) {-height 16 -radix hexadecimal}} /tb_top/i_dut/o_wdata_static
add wave -noupdate -expand -group {TOP DUT} -group {RAM SCROLLER I/F} -radix hexadecimal /tb_top/i_dut/i_rdata_scroller
add wave -noupdate -expand -group {TOP DUT} -group {RAM SCROLLER I/F} -radix hexadecimal /tb_top/i_dut/o_me_scroller
add wave -noupdate -expand -group {TOP DUT} -group {RAM SCROLLER I/F} -radix hexadecimal /tb_top/i_dut/o_we_scroller
add wave -noupdate -expand -group {TOP DUT} -group {RAM SCROLLER I/F} -radix hexadecimal /tb_top/i_dut/o_addr_scroller
add wave -noupdate -expand -group {TOP DUT} -group {RAM SCROLLER I/F} -radix hexadecimal /tb_top/i_dut/o_wdata_scroller
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} -radix hexadecimal /tb_top/i_dut/s_rx
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} -radix hexadecimal /tb_top/i_dut/s_rx_data
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} -radix hexadecimal /tb_top/i_dut/s_rx_done
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} -radix hexadecimal /tb_top/i_dut/s_parity_rcvd
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} -radix hexadecimal /tb_top/i_dut/s_start_tx
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} -radix hexadecimal /tb_top/i_dut/s_tx_data
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} -radix hexadecimal /tb_top/i_dut/s_tx
add wave -noupdate -expand -group {TOP DUT} -group {Internal Signals} -radix hexadecimal /tb_top/i_dut/s_tx_done
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/reset_n
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/clock
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/rx
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/rx_data
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/rx_done
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/cnt_stop_bit
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/cnt_data
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/cnt_bit
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/cnt_half_bit
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/rx_done_s
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/parity_rcvd_s
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/rx_data_s
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/tick_data
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/start_cnt
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/start_rx_re
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/start_rx_fe
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/rx_old
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/rx_fsm
add wave -noupdate -expand -group {TOP DUT} -group RX_UART -radix hexadecimal /tb_top/i_dut/i_rx_uart_0/parity_rcvd
add wave -noupdate -expand -group {TOP DUT} -expand -group {UART CMD DECOD} -radix hexadecimal /tb_top/i_dut/i_uart_cmd_decod_0/clk
add wave -noupdate -expand -group {TOP DUT} -expand -group {UART CMD DECOD} -radix hexadecimal /tb_top/i_dut/i_uart_cmd_decod_0/rst_n
add wave -noupdate -expand -group {TOP DUT} -expand -group {UART CMD DECOD} -radix hexadecimal /tb_top/i_dut/i_uart_cmd_decod_0/i_data
add wave -noupdate -expand -group {TOP DUT} -expand -group {UART CMD DECOD} -radix hexadecimal /tb_top/i_dut/i_uart_cmd_decod_0/i_data_valid
add wave -noupdate -expand -group {TOP DUT} -expand -group {UART CMD DECOD} -radix hexadecimal -childformat {{/tb_top/i_dut/i_uart_cmd_decod_0/o_commands(7) -radix hexadecimal} {/tb_top/i_dut/i_uart_cmd_decod_0/o_commands(6) -radix hexadecimal} {/tb_top/i_dut/i_uart_cmd_decod_0/o_commands(5) -radix hexadecimal} {/tb_top/i_dut/i_uart_cmd_decod_0/o_commands(4) -radix hexadecimal} {/tb_top/i_dut/i_uart_cmd_decod_0/o_commands(3) -radix hexadecimal} {/tb_top/i_dut/i_uart_cmd_decod_0/o_commands(2) -radix hexadecimal} {/tb_top/i_dut/i_uart_cmd_decod_0/o_commands(1) -radix hexadecimal} {/tb_top/i_dut/i_uart_cmd_decod_0/o_commands(0) -radix hexadecimal}} -expand -subitemconfig {/tb_top/i_dut/i_uart_cmd_decod_0/o_commands(7) {-height 16 -radix hexadecimal} /tb_top/i_dut/i_uart_cmd_decod_0/o_commands(6) {-height 16 -radix hexadecimal} /tb_top/i_dut/i_uart_cmd_decod_0/o_commands(5) {-height 16 -radix hexadecimal} /tb_top/i_dut/i_uart_cmd_decod_0/o_commands(4) {-height 16 -radix hexadecimal} /tb_top/i_dut/i_uart_cmd_decod_0/o_commands(3) {-height 16 -radix hexadecimal} /tb_top/i_dut/i_uart_cmd_decod_0/o_commands(2) {-height 16 -radix hexadecimal} /tb_top/i_dut/i_uart_cmd_decod_0/o_commands(1) {-height 16 -radix hexadecimal} /tb_top/i_dut/i_uart_cmd_decod_0/o_commands(0) {-height 16 -radix hexadecimal}} /tb_top/i_dut/i_uart_cmd_decod_0/o_commands
add wave -noupdate -expand -group {TOP DUT} -expand -group {UART CMD DECOD} -color Pink -radix hexadecimal /tb_top/i_dut/i_uart_cmd_decod_0/o_discard
add wave -noupdate -expand -group {TOP DUT} -expand -group {UART CMD DECOD} -radix hexadecimal -childformat {{/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(0) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(1) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(2) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(3) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(4) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(5) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(6) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(7) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(8) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(9) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(10) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(11) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(12) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(13) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(14) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(15) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(16) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(17) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(18) -radix ascii} {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(19) -radix ascii}} -subitemconfig {/tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(0) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(1) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(2) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(3) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(4) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(5) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(6) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(7) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(8) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(9) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(10) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(11) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(12) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(13) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(14) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(15) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(16) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(17) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(18) {-color Cyan -height 16 -radix ascii -radixshowbase 0} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store(19) {-color Cyan -height 16 -radix ascii -radixshowbase 0}} /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_2_store
add wave -noupdate -expand -group {TOP DUT} -expand -group {UART CMD DECOD} -radix hexadecimal /tb_top/i_dut/i_uart_cmd_decod_0/s_cnt_data
add wave -noupdate -expand -group {TOP DUT} -expand -group {UART CMD DECOD} -radix hexadecimal /tb_top/i_dut/i_uart_cmd_decod_0/s_cnt_data_done
add wave -noupdate -expand -group {TOP DUT} -expand -group {UART CMD DECOD} -radix hexadecimal /tb_top/i_dut/i_uart_cmd_decod_0/s_commands
add wave -noupdate -expand -group {TOP DUT} -expand -group {UART CMD DECOD} -radix hexadecimal /tb_top/i_dut/i_uart_cmd_decod_0/s_discard
add wave -noupdate -expand -group {TOP DUT} -expand -group {UART CMD DECOD} -radix hexadecimal /tb_top/i_dut/i_uart_cmd_decod_0/s_cmd_check
add wave -noupdate -expand -group {TOP DUT} -expand -group {UART CMD DECOD} -radix hexadecimal /tb_top/i_dut/i_uart_cmd_decod_0/s_raz_cnt
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/clk
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/rst_n
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/i_cmd_pulses
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/o_rx_data_sel
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/i_init_static_ram_done
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/i_init_scroller_ram_done
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/o_init_static_ram
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/o_init_scroller_ram
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/i_tx_done
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/o_load_pattern_static
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/i_load_pattern_static_done
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/o_tx_uart_start
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/o_tx_data
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/s_init_static_ram
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/s_init_scroller_ram
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/s_tx_uart_start
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/s_tx_data
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/s_cnt_tx_data
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/s_resp_done
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/s_rx_data_sel
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/i_cmd_discard
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/s_resp_ongoing
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/s_tx_done
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/s_tx_done_r_edge
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/s_first_access
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/s_index_resp
add wave -noupdate -expand -group {TOP DUT} -expand -group SEQUENCER -radix hexadecimal /tb_top/i_dut/i_sequencer_uart_cmd_0/s_load_pattern_static
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/clk
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/rst_n
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/i_rdata_static
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/o_me_static
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/o_we_static
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/o_addr_static
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/o_wdata_static
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/i_init_static_ram
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/o_init_static_ram_done
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/i_load_static_ram
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/o_load_static_ram_done
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/i_rx_data
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/i_rx_done
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/s_load_static_ram_ongoing
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/s_load_static_ram_done
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/s_wr_ptr
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/s_init_ram_ongoing
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/s_init_static_ram_done
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/s_me_static
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/s_we_static
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/s_wdata_static
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/s_cnt_rx_data
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/s_cnt_2
add wave -noupdate -expand -group {TOP DUT} -expand -group {Static Ram MNGT} -radix hexadecimal /tb_top/i_dut/i_static_ram_mngr/s_data_rdy
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/reset_n
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/clock
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/start_tx
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/tx_data
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/tx
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/tx_done
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/tx_fsm
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/latch_done_s
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/start_tx_s
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/start_tx_r_edge
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/tx_data_s
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/tx_s
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/cnt_bit_duration
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/tick_data
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/cnt_data
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/cnt_bit
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/cnt_stop_bit
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/tx_done_s
add wave -noupdate -expand -group {TOP DUT} -group {TX UART} -radix hexadecimal /tb_top/i_dut/i_tx_uart_0/parity_value
add wave -noupdate -divider <NULL>
add wave -noupdate -group {UART Checker} /tb_top/i_uart_checker_wrapper/s_rx_done_r_edge
add wave -noupdate -group {UART Checker} /tb_top/i_uart_checker_wrapper/o_tx
add wave -noupdate -group {UART Checker} /tb_top/i_uart_checker_wrapper/i_rx
add wave -noupdate -group {UART Checker} /tb_top/i_uart_checker_wrapper/rst_n
add wave -noupdate -group {UART Checker} /tb_top/i_uart_checker_wrapper/clk
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_new_config_val
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_mux_sel
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_done
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_clk
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_data
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_load
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_data
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_en_load
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_start
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_data_scroller
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_en_load_scroller
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_start_scroller
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_done_scroller
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_busy_scroller
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_status_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_discard_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_ptr_equality_static_p1
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_ptr_equality_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_data_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_en_load_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_start_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_done_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_config_done
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_data_config
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_en_load_config
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_start_config
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_max7219_if_done_config
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_start_scroll
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_msg_length_scroller
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_ram_start_ptr_scroller
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_loop_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_ptr_val_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_last_ptr_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/s_start_ptr_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/o_max7219_clk
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/o_max7219_data
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/o_max7219_load
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/o_rdata_scroller
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_wdata_scroller
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_addr_scroller
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_we_scroller
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_me_scroller
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/o_scroller_busy
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_max_tempo_cnt_scroller
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_msg_length_scroller
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_ram_start_ptr_scroller
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/o_static_busy
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/o_ptr_equality_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_loop_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_last_ptr_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_start_ptr_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/o_rdata_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_wdata_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_addr_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_we_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_me_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_en_static
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/o_config_done
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_new_config_val
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_shutdown
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_scan_limit
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_intensity
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_decod_mode
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_display_test
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_new_display
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/i_static_dyn
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/rst_n
add wave -noupdate -group {MAX7219 DISPLAY CTRL TOP} -radix hexadecimal /tb_top/i_max7219_display_controller/clk
add wave -noupdate -label {STATIC RAM} /tb_top/i_max7219_display_controller/max7219_cmd_decod_inst_0/tdpram_inst_0/v_ram
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3251258626 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 296
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
WaveRestoreZoom {0 ps} {5470500 ps}
