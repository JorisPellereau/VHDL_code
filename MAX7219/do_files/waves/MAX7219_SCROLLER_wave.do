onerror {resume}
quietly virtual signal -install /tb_top/i_data_collector_0 { /tb_top/i_data_collector_0/i_data[0][7:0]} wdata
quietly virtual signal -install /tb_top/i_data_collector_0 { /tb_top/i_data_collector_0/i_data[0][15:8]} addr
quietly virtual signal -install /tb_top/i_data_collector_0 {/tb_top/i_data_collector_0/i_data[0][16]  } WE
quietly virtual signal -install /tb_top/i_data_collector_0 {/tb_top/i_data_collector_0/i_data[0][17]  } ME
quietly virtual signal -install /tb_top/i_data_collector_0 { /tb_top/i_data_collector_0/i_data[0][49:18]} tempo_max
quietly virtual signal -install /tb_top/i_data_collector_0 {/tb_top/i_data_collector_0/i_data[0][50]  } start_scroll
quietly virtual signal -install /tb_top/i_data_collector_0 { /tb_top/i_data_collector_0/i_data[0][58:51]} msg_length
quietly virtual signal -install /tb_top/i_data_collector_0 { /tb_top/i_data_collector_0/i_data[0][66:59]} ram_addr_start
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group DUT /tb_top/i_dut/clk
add wave -noupdate -expand -group DUT /tb_top/i_dut/rst_n
add wave -noupdate -expand -group DUT -group {RAM I/F} /tb_top/i_dut/i_me
add wave -noupdate -expand -group DUT -group {RAM I/F} /tb_top/i_dut/i_we
add wave -noupdate -expand -group DUT -group {RAM I/F} /tb_top/i_dut/i_addr
add wave -noupdate -expand -group DUT -group {RAM I/F} /tb_top/i_dut/i_wdata
add wave -noupdate -expand -group DUT -group {RAM I/F} /tb_top/i_dut/o_rdata
add wave -noupdate -expand -group DUT -group I_CONTROLS /tb_top/i_dut/i_ram_start_ptr
add wave -noupdate -expand -group DUT -group I_CONTROLS /tb_top/i_dut/i_msg_length
add wave -noupdate -expand -group DUT -group I_CONTROLS /tb_top/i_dut/i_start_scroll
add wave -noupdate -expand -group DUT -group I_CONTROLS /tb_top/i_dut/i_max_tempo_cnt
add wave -noupdate -expand -group DUT -group {MAX7219 I/F} /tb_top/i_dut/o_max7219_if_start
add wave -noupdate -expand -group DUT -group {MAX7219 I/F} /tb_top/i_dut/o_max7219_if_en_load
add wave -noupdate -expand -group DUT -group {MAX7219 I/F} /tb_top/i_dut/o_max7219_if_data
add wave -noupdate -expand -group DUT -group {MAX7219 I/F} /tb_top/i_dut/i_max7219_if_done
add wave -noupdate -expand -group DUT /tb_top/i_dut/o_busy
add wave -noupdate -expand -group DUT -group {Internal Signals} /tb_top/i_dut/s_me_b
add wave -noupdate -expand -group DUT -group {Internal Signals} /tb_top/i_dut/s_we_b
add wave -noupdate -expand -group DUT -group {Internal Signals} /tb_top/i_dut/s_addr_b
add wave -noupdate -expand -group DUT -group {Internal Signals} /tb_top/i_dut/s_wdata_b
add wave -noupdate -expand -group DUT -group {Internal Signals} /tb_top/i_dut/s_rdata_b
add wave -noupdate -expand -group DUT -group {Internal Signals} /tb_top/i_dut/s_seg_data
add wave -noupdate -expand -group DUT -group {Internal Signals} /tb_top/i_dut/s_seg_data_valid
add wave -noupdate -expand -group DUT -group {Internal Signals} /tb_top/i_dut/s_scroller_if_busy
add wave -noupdate -expand -group DUT -group {Internal Signals} /tb_top/i_dut/s_done
add wave -noupdate -expand -group DUT -group {Internal Signals} /tb_top/i_dut/s_start
add wave -noupdate -expand -group DUT -group {Internal Signals} /tb_top/i_dut/s_en_load
add wave -noupdate -expand -group DUT -group {Internal Signals} /tb_top/i_dut/s_data
add wave -noupdate -divider <NULL>
add wave -noupdate -group RAM_2_SCROLLER_IF /tb_top/i_dut/max7219_ram2scroller_if_inst_0/clk
add wave -noupdate -group RAM_2_SCROLLER_IF /tb_top/i_dut/max7219_ram2scroller_if_inst_0/rst_n
add wave -noupdate -group RAM_2_SCROLLER_IF /tb_top/i_dut/max7219_ram2scroller_if_inst_0/i_start
add wave -noupdate -group RAM_2_SCROLLER_IF /tb_top/i_dut/max7219_ram2scroller_if_inst_0/i_msg_length
add wave -noupdate -group RAM_2_SCROLLER_IF /tb_top/i_dut/max7219_ram2scroller_if_inst_0/i_ram_start_ptr
add wave -noupdate -group RAM_2_SCROLLER_IF /tb_top/i_dut/max7219_ram2scroller_if_inst_0/i_rdata
add wave -noupdate -group RAM_2_SCROLLER_IF /tb_top/i_dut/max7219_ram2scroller_if_inst_0/o_me
add wave -noupdate -group RAM_2_SCROLLER_IF /tb_top/i_dut/max7219_ram2scroller_if_inst_0/o_we
add wave -noupdate -group RAM_2_SCROLLER_IF /tb_top/i_dut/max7219_ram2scroller_if_inst_0/o_addr
add wave -noupdate -group RAM_2_SCROLLER_IF /tb_top/i_dut/max7219_ram2scroller_if_inst_0/o_seg_data
add wave -noupdate -group RAM_2_SCROLLER_IF /tb_top/i_dut/max7219_ram2scroller_if_inst_0/o_seg_data_valid
add wave -noupdate -group RAM_2_SCROLLER_IF /tb_top/i_dut/max7219_ram2scroller_if_inst_0/i_scroller_if_busy
add wave -noupdate -group RAM_2_SCROLLER_IF /tb_top/i_dut/max7219_ram2scroller_if_inst_0/o_busy
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_busy
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_start
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_start_r_edge
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_scroller_if_busy
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_scroller_if_busy_f_edge
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_scroller_if_busy_f_edge_p
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_scroller_if_busy_f_edge_p2
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_inputs_val
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_we
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_me
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_me_p
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_rdata_valid
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_access_cnt_done
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_ram_sel
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_seg_data_valid
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_msg_length
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_ram_addr
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_rdata
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals -radix decimal /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_access_cnt
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals -radix unsigned /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_max_access
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_seg_data
add wave -noupdate -group RAM_2_SCROLLER_IF -group Internal_signals /tb_top/i_dut/max7219_ram2scroller_if_inst_0/s_reject_scroll
add wave -noupdate -divider <NULL>
add wave -noupdate -group SCROLLER_IF /tb_top/i_dut/max7219_scroller_if_inst_0/clk
add wave -noupdate -group SCROLLER_IF /tb_top/i_dut/max7219_scroller_if_inst_0/rst_n
add wave -noupdate -group SCROLLER_IF /tb_top/i_dut/max7219_scroller_if_inst_0/i_seg_data
add wave -noupdate -group SCROLLER_IF /tb_top/i_dut/max7219_scroller_if_inst_0/i_seg_data_valid
add wave -noupdate -group SCROLLER_IF /tb_top/i_dut/max7219_scroller_if_inst_0/i_max_tempo_cnt
add wave -noupdate -group SCROLLER_IF /tb_top/i_dut/max7219_scroller_if_inst_0/o_busy
add wave -noupdate -group SCROLLER_IF /tb_top/i_dut/max7219_scroller_if_inst_0/i_max7219_if_done
add wave -noupdate -group SCROLLER_IF /tb_top/i_dut/max7219_scroller_if_inst_0/o_max7219_if_start
add wave -noupdate -group SCROLLER_IF /tb_top/i_dut/max7219_scroller_if_inst_0/o_max7219_if_en_load
add wave -noupdate -group SCROLLER_IF /tb_top/i_dut/max7219_scroller_if_inst_0/o_max7219_if_data
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_matrix_array
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_shift_matrix
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_busy
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_segment_cnt
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_matrix_cnt
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_tempo_cnt
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_segment_addr
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_new_data_flag
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_max7219_start
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_max7219_en_load
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_max7219_data
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_max7219_if_done
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_max7219_if_done_r_edge
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_max7219_if_done_f_edge
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_matrix_updated_flag
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_start_tempo
add wave -noupdate -group SCROLLER_IF -group Internal /tb_top/i_dut/max7219_scroller_if_inst_0/s_tempo_done
add wave -noupdate -divider <NULL>
add wave -noupdate -group TDPRAM /tb_top/i_dut/tdpram_inst_0/clk
add wave -noupdate -group TDPRAM /tb_top/i_dut/tdpram_inst_0/i_me_a
add wave -noupdate -group TDPRAM /tb_top/i_dut/tdpram_inst_0/i_we_a
add wave -noupdate -group TDPRAM /tb_top/i_dut/tdpram_inst_0/i_addr_a
add wave -noupdate -group TDPRAM /tb_top/i_dut/tdpram_inst_0/i_wdata_a
add wave -noupdate -group TDPRAM /tb_top/i_dut/tdpram_inst_0/o_rdata_a
add wave -noupdate -group TDPRAM /tb_top/i_dut/tdpram_inst_0/i_me_b
add wave -noupdate -group TDPRAM /tb_top/i_dut/tdpram_inst_0/i_we_b
add wave -noupdate -group TDPRAM /tb_top/i_dut/tdpram_inst_0/i_addr_b
add wave -noupdate -group TDPRAM /tb_top/i_dut/tdpram_inst_0/i_wdata_b
add wave -noupdate -group TDPRAM /tb_top/i_dut/tdpram_inst_0/o_rdata_b
add wave -noupdate -group TDPRAM /tb_top/i_dut/tdpram_inst_0/v_ram
add wave -noupdate -divider <NULL>
add wave -noupdate -expand -group MAX7219_IF /tb_top/i_max7219_if_0/clk
add wave -noupdate -expand -group MAX7219_IF /tb_top/i_max7219_if_0/rst_n
add wave -noupdate -expand -group MAX7219_IF /tb_top/i_max7219_if_0/i_start
add wave -noupdate -expand -group MAX7219_IF /tb_top/i_max7219_if_0/i_en_load
add wave -noupdate -expand -group MAX7219_IF /tb_top/i_max7219_if_0/i_data
add wave -noupdate -expand -group MAX7219_IF /tb_top/i_max7219_if_0/o_max7219_load
add wave -noupdate -expand -group MAX7219_IF /tb_top/i_max7219_if_0/o_max7219_data
add wave -noupdate -expand -group MAX7219_IF /tb_top/i_max7219_if_0/o_max7219_clk
add wave -noupdate -expand -group MAX7219_IF /tb_top/i_max7219_if_0/o_done
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_data
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_en_load
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_start
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_init_data
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_en_clk
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_max7219_data
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_max7219_clk
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_max7219_clk_p
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_max7219_clk_f_edge
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_max7219_clk_r_edge
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_max7219_load
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_start_r_edge
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_done
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_cnt_15
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_cnt_16
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_cnt_half_period
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_load_px
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_end_frame
add wave -noupdate -expand -group MAX7219_IF -group intertnal /tb_top/i_max7219_if_0/s_ongoing
add wave -noupdate -divider <NULL>
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/clk
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/rst_n
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/i_max7219_clk
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/i_max7219_din
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/i_max7219_load
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/o_frame_received
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/o_load_received
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/o_data_received
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/s_max7219_clk
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/s_max7219_load
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/s_frame_received
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/s_max7219_data
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/s_cnt_15
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/s_cnt_15_done
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/s_max7219_clk_r_edge
add wave -noupdate -group {SPI CHECKER} /tb_top/max7219_spi_checker_0/s_max7219_load_f_edge
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[0]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[1]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[2]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[3]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[4]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[5]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[6]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[7]}
add wave -noupdate -expand -group Collect_Signals /tb_top/i_data_collector_0/wdata
add wave -noupdate -expand -group Collect_Signals /tb_top/i_data_collector_0/addr
add wave -noupdate -expand -group Collect_Signals /tb_top/i_data_collector_0/WE
add wave -noupdate -expand -group Collect_Signals /tb_top/i_data_collector_0/ME
add wave -noupdate -expand -group Collect_Signals /tb_top/i_data_collector_0/tempo_max
add wave -noupdate -expand -group Collect_Signals /tb_top/i_data_collector_0/start_scroll
add wave -noupdate -expand -group Collect_Signals /tb_top/i_data_collector_0/msg_length
add wave -noupdate -expand -group Collect_Signals /tb_top/i_data_collector_0/ram_addr_start
add wave -noupdate -expand -group Collect_Signals -subitemconfig {{/tb_top/i_data_collector_0/i_data[0]} -expand} /tb_top/i_data_collector_0/i_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11117850000 ps} 1} {{Cursor 2} {0 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 288
configure wave -valuecolwidth 130
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
WaveRestoreZoom {0 ps} {6294193500 ps}
