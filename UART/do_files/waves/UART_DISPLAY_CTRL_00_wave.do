onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/clk
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/rst_n
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_static_dyn
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_new_display
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_display_test
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_decod_mode
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_intensity
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_scan_limit
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_shutdown
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_new_config_val
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/o_config_done
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_en_static
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_me_static
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_we_static
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_addr_static
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_wdata_static
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/o_rdata_static
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_start_ptr_static
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_last_ptr_static
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_loop_static
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/o_ptr_equality_static
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/o_static_busy
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_ram_start_ptr_scroller
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_msg_length_scroller
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_max_tempo_cnt_scroller
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/o_scroller_busy
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_me_scroller
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_we_scroller
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_addr_scroller
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/i_wdata_scroller
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/o_rdata_scroller
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/o_max7219_load
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/o_max7219_data
add wave -noupdate -expand -group {MAX7219_DISPLAY_CTRL Top} -radix hexadecimal /tb_top/i_max7219_display_controller/o_max7219_clk
add wave -noupdate -expand -group {UART CHECKER Wrapper} -radix hexadecimal /tb_top/i_uart_checker_wrapper/clk
add wave -noupdate -expand -group {UART CHECKER Wrapper} -radix hexadecimal /tb_top/i_uart_checker_wrapper/rst_n
add wave -noupdate -expand -group {UART CHECKER Wrapper} -radix hexadecimal /tb_top/i_uart_checker_wrapper/i_rx
add wave -noupdate -expand -group {UART CHECKER Wrapper} -radix hexadecimal /tb_top/i_uart_checker_wrapper/o_tx
add wave -noupdate -expand -group {UART CHECKER Wrapper} -radix hexadecimal /tb_top/i_uart_checker_wrapper/s_rx_done_r_edge
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/reset_n}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/clock}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/start_tx}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/tx_data}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/tx}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/tx_done}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/tx_fsm}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/latch_done_s}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/start_tx_s}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/start_tx_r_edge}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/tx_data_s}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/tx_s}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/cnt_bit_duration}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/tick_data}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/cnt_data}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/cnt_bit}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/cnt_stop_bit}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/tx_done_s}
add wave -noupdate -expand -group {TB TX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/parity_value}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/reset_n}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/clock}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/rx}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/rx_data}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/rx_done}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/parity_rcvd}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/rx_fsm}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/rx_old}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/start_rx_fe}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/start_rx_re}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/start_cnt}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/tick_data}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/rx_data_s}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/parity_rcvd_s}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/rx_done_s}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/cnt_half_bit}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/cnt_bit}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/cnt_data}
add wave -noupdate -expand -group {TB RX UART} -radix hexadecimal {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/cnt_stop_bit}
add wave -noupdate {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/baudrate}
add wave -noupdate {/tb_top/i_uart_checker_wrapper/i_rx_uart_checker[0]/baudrate}
add wave -noupdate {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/polarity}
add wave -noupdate {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/parity}
add wave -noupdate {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/first_bit}
add wave -noupdate {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/data_size}
add wave -noupdate {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/clock_frequency}
add wave -noupdate {/tb_top/i_uart_checker_wrapper/i_tx_uart_checker[0]/baudrate}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {430000 ps} 1} {{Cursor 2} {2717578 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 365
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
WaveRestoreZoom {0 ps} {40582500 ps}
