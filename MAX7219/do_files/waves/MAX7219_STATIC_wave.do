onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/clk
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/rst_n
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_en
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_me
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_we
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_addr
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_wdata
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/o_rdata
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_start_ptr
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_last_ptr
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_ptr_val
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_loop
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/o_ptr_equality
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/o_discard
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/i_max7219_if_done
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/o_max7219_if_start
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/o_max7219_if_en_load
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/o_max7219_if_data
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/s_me_decod
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/s_we_decod
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/s_addr_decod
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/s_wdata_decod
add wave -noupdate -group {DUT TOP} /tb_top/i_dut/s_rdata_decod
add wave -noupdate -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/clk
add wave -noupdate -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_me_a
add wave -noupdate -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_we_a
add wave -noupdate -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_addr_a
add wave -noupdate -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_wdata_a
add wave -noupdate -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/o_rdata_a
add wave -noupdate -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_me_b
add wave -noupdate -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_we_b
add wave -noupdate -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_addr_b
add wave -noupdate -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/i_wdata_b
add wave -noupdate -group {RAM TOP} /tb_top/i_dut/tdpram_inst_0/o_rdata_b
add wave -noupdate /tb_top/i_dut/tdpram_inst_0/v_ram
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/clk
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/rst_n
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/i_en
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/o_me
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/o_we
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/o_addr
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/i_rdata
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/i_start_ptr
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/i_last_ptr
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/i_ptr_val
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/i_loop
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/o_ptr_equality
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/o_discard
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/o_start
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/o_en_load
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/o_data
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/i_done
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_decod_busy
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_start_ram_access
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_me
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_we
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_me_p1
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_me_p2
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_rdata_valid
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_en_load
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_decod_done
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_start
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_inc_done
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_max_cnt_valid
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_start_cnt
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_cnt_done
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_ptr_equality
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_update_ptr
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_ptr_val
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_ptr_val_r_edge
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_data
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_addr
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_rdata
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_cnt_32b
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_max_cnt_32b
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_start_ptr
add wave -noupdate -group {CMD DECOD} /tb_top/i_dut/max7219_ram_decod_inst_0/s_last_ptr
add wave -noupdate -divider <NULL>
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/clk
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/rst_n
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/i_start
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/i_en_load
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/i_data
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/o_max7219_load
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/o_max7219_data
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/o_max7219_clk
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/o_done
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_data
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_en_load
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_start
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_init_data
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_en_clk
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_max7219_data
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_max7219_clk
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_max7219_clk_p
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_max7219_clk_f_edge
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_max7219_clk_r_edge
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_max7219_load
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_start_r_edge
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_done
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_cnt_15
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_cnt_16
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_cnt_half_period
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_load_px
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_end_frame
add wave -noupdate -group MAX7219_IF /tb_top/i_max7219_if_0/s_ongoing
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/clk
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/rst_n
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/i_max7219_clk
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/i_max7219_din
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/i_max7219_load
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/o_frame_received
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/o_load_received
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/o_data_received
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/s_max7219_clk
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/s_max7219_load
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/s_frame_received
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/s_max7219_data
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/s_cnt_15
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/s_cnt_15_done
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/s_max7219_clk_r_edge
add wave -noupdate -group {MAX7219 SPI CHECKER} /tb_top/max7219_spi_checker_0/s_max7219_load_f_edge
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/clk
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/rst_n
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/i_max7219_clk
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/i_max7219_din
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/i_max7219_load
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/i_display_reg_matrix_n
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/i_display_screen_matrix
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/s_max7219_din
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/s_max7219_dout
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/s_frame_received
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/s_display_screen_matrix
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/s_display_screen_matrix_r_edge
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/line_char
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/line
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/k
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/l
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/m
add wave -noupdate -group {MAX7219 CHECKER} /tb_top/i_max7219_checker_wrapper_0/n
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[0]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[1]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[2]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[3]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[4]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[5]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[6]}
add wave -noupdate -radix ascii {/tb_top/i_max7219_checker_wrapper_0/s_line_row_i[7]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {299030000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 255
configure wave -valuecolwidth 501
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
WaveRestoreZoom {0 ps} {315094500 ps}
