onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/i_clk
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/i_reset
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/o_wb_cyc
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/o_wb_stb
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/o_wb_we
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/o_wb_addr
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/o_wb_data
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/o_wb_sel
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/i_wb_stall
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/i_wb_ack
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/i_wb_data
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/i_wb_err
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/i_ext_int
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/o_ext_int
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/i_dbg_cyc
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/i_dbg_stb
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/i_dbg_we
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/i_dbg_addr
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/i_dbg_data
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/i_dbg_sel
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/o_dbg_stall
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/o_dbg_ack
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/o_dbg_data
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/o_cpu_debug
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/o_prof_stb
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/o_prof_addr
add wave -noupdate -group ZIPSYSTEM /tb_top/i_dut/i_zip_system_0/o_prof_ticks
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/main_int_vector
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/alt_int_vector
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ctri_int
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/tma_int
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/tmb_int
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/tmc_int
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/jif_int
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dmac_int
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mtc_int
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/moc_int
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mpc_int
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mic_int
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/utc_int
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/uoc_int
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/upc_int
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/uic_int
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/actr_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/actr_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/actr_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_clken
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sys_cyc
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sys_stb
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sys_we
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sys_addr
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_addr
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sys_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sys_idata
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sys_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sys_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sel_counter
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sel_timer
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sel_pic
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sel_apic
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sel_watchdog
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sel_bus_watchdog
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sel_dmac
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/sel_mmus
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_cyc
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_stb
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_we
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_addr
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_idata
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_odata
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_sel
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/no_dbg_err
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_break
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_cmd_write
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_cpu_write
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_cpu_read
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_cmd_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_cmd_strb
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/reset_hold
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/halt_on_fault
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_catch
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/reset_request
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/release_request
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/halt_request
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/step_request
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/clear_cache_request
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cmd_reset
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cmd_halt
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cmd_step
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cmd_clear_cache
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cmd_write
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cmd_read
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cmd_waddr
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cmd_wdata
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_dbg_cc
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_reset
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_halt
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_has_halted
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_dbg_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/pic_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_status
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_gie
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/wdt_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/wdt_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/wdt_reset
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/wdt_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/wdbus_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/r_wdbus_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/wdbus_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/reset_wdbus_timer
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/wdbus_int
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_op_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_pf_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_i_count
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dmac_stb
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dc_err
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dmac_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dmac_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dmac_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dc_cyc
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dc_stb
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dc_we
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dc_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dc_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dc_addr
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dc_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dc_sel
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_gbl_cyc
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dmac_int_vec
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ctri_sel
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ctri_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ctri_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ctri_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/tma_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/tma_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/tmb_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/tmb_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/tmc_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/tmc_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/jif_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/jif_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/tma_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/tmb_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/tmc_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/jif_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/pic_interrupt
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/pic_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/pic_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_gbl_stb
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_lcl_cyc
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_lcl_stb
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_we
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_idata
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_sel
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmu_sel
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_err
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_dbg_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ext_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ext_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmu_cyc
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmu_stb
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmu_we
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmu_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmu_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmu_err
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmus_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmus_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmu_addr
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmu_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmu_idata
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmus_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cpu_miss
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmu_cpu_stall
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmu_cpu_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/mmu_cpu_idata
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/pf_return_stb
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/pf_return_we
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/pf_return_cachable
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/pf_return_v
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/pf_return_p
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ext_cyc
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ext_stb
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ext_we
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ext_err
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ext_addr
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ext_odata
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ext_sel
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ext_idata
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/tmr_data
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/w_ack_idx
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/ack_idx
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/last_sys_stb
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/cmd_read_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/r_mmus_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_pre_ack
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_pre_addr
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/dbg_cpu_status
add wave -noupdate -group ZIPSYSTEM -group internal /tb_top/i_dut/i_zip_system_0/unused
add wave -noupdate -divider DUT
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/clk
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/rst
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_wb_cyc
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_wb_stb
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_wb_stall
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_wb_ack
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_wb_we
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/uart_rx
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/uart_tx
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/cts_n
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_uart_rx_int
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_uart_tx_int
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_wb_addr
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_wb_data
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_wb_sel
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_i_wb_data
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_i_ext_int
add wave -noupdate -expand -group i_dut -group Internal /tb_top/i_dut/s_prof_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_a_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_a_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_a_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_a_adr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_a_dat
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_a_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_b_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_b_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_b_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_b_adr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_b_dat
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_b_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Inputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/i_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Outputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/o_a_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Outputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/o_a_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Outputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/o_a_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Outputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/o_b_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Outputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/o_b_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Outputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/o_b_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Outputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/o_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Outputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/o_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Outputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/o_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Outputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/o_adr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Outputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/o_dat
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Outputs /tb_top/i_dut/i_zip_system_0/dmacvcpu/o_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group dmacvcpu -group Internal /tb_top/i_dut/i_zip_system_0/dmacvcpu/r_a_owner
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mmstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mmstall_ctr/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mmstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mmstall_ctr/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mmstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mmstall_ctr/i_event
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mmstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mmstall_ctr/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mmstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mmstall_ctr/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mmstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mmstall_ctr/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mmstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mmstall_ctr/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mmstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mmstall_ctr/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mmstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mmstall_ctr/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mmstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mmstall_ctr/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mmstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mmstall_ctr/o_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mmstall_ctr -group Internal /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mmstall_ctr/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mpstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mpstall_ctr/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mpstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mpstall_ctr/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mpstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mpstall_ctr/i_event
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mpstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mpstall_ctr/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mpstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mpstall_ctr/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mpstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mpstall_ctr/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mpstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mpstall_ctr/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mpstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mpstall_ctr/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mpstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mpstall_ctr/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mpstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mpstall_ctr/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mpstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mpstall_ctr/o_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mpstall_ctr -group Internal /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mpstall_ctr/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group uins_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/uins_ctr/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group uins_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/uins_ctr/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group uins_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/uins_ctr/i_event
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group uins_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/uins_ctr/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group uins_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/uins_ctr/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group uins_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/uins_ctr/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group uins_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/uins_ctr/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group uins_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/uins_ctr/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group uins_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/uins_ctr/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group uins_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/uins_ctr/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group uins_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/uins_ctr/o_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group uins_ctr -group Internal /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/uins_ctr/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mtask_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mtask_ctr/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mtask_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mtask_ctr/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mtask_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mtask_ctr/i_event
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mtask_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mtask_ctr/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mtask_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mtask_ctr/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mtask_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mtask_ctr/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mtask_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mtask_ctr/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mtask_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mtask_ctr/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mtask_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mtask_ctr/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mtask_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mtask_ctr/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mtask_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mtask_ctr/o_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mtask_ctr -group Internal /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mtask_ctr/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group umstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/umstall_ctr/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group umstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/umstall_ctr/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group umstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/umstall_ctr/i_event
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group umstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/umstall_ctr/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group umstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/umstall_ctr/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group umstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/umstall_ctr/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group umstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/umstall_ctr/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group umstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/umstall_ctr/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group umstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/umstall_ctr/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group umstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/umstall_ctr/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group umstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/umstall_ctr/o_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group umstall_ctr -group Internal /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/umstall_ctr/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group upstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/upstall_ctr/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group upstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/upstall_ctr/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group upstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/upstall_ctr/i_event
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group upstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/upstall_ctr/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group upstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/upstall_ctr/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group upstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/upstall_ctr/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group upstall_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/upstall_ctr/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group upstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/upstall_ctr/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group upstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/upstall_ctr/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group upstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/upstall_ctr/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group upstall_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/upstall_ctr/o_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group upstall_ctr -group Internal /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/upstall_ctr/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mins_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mins_ctr/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mins_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mins_ctr/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mins_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mins_ctr/i_event
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mins_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mins_ctr/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mins_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mins_ctr/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mins_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mins_ctr/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mins_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mins_ctr/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mins_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mins_ctr/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mins_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mins_ctr/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mins_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mins_ctr/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mins_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mins_ctr/o_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group mins_ctr -group Internal /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/mins_ctr/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group utask_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/utask_ctr/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group utask_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/utask_ctr/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group utask_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/utask_ctr/i_event
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group utask_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/utask_ctr/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group utask_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/utask_ctr/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group utask_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/utask_ctr/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group utask_ctr -group Inputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/utask_ctr/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group utask_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/utask_ctr/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group utask_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/utask_ctr/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group utask_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/utask_ctr/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group utask_ctr -group Outputs /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/utask_ctr/o_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group ACCOUNTING_COUNTERS -group utask_ctr -group Internal /tb_top/i_dut/i_zip_system_0/ACCOUNTING_COUNTERS/utask_ctr/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Inputs /tb_top/i_dut/i_zip_system_0/u_watchdog/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Inputs /tb_top/i_dut/i_zip_system_0/u_watchdog/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Inputs /tb_top/i_dut/i_zip_system_0/u_watchdog/i_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Inputs /tb_top/i_dut/i_zip_system_0/u_watchdog/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Inputs /tb_top/i_dut/i_zip_system_0/u_watchdog/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Inputs /tb_top/i_dut/i_zip_system_0/u_watchdog/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Inputs /tb_top/i_dut/i_zip_system_0/u_watchdog/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Inputs /tb_top/i_dut/i_zip_system_0/u_watchdog/i_wb_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Outputs /tb_top/i_dut/i_zip_system_0/u_watchdog/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Outputs /tb_top/i_dut/i_zip_system_0/u_watchdog/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Outputs /tb_top/i_dut/i_zip_system_0/u_watchdog/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Outputs /tb_top/i_dut/i_zip_system_0/u_watchdog/o_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Internal /tb_top/i_dut/i_zip_system_0/u_watchdog/r_running
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Internal /tb_top/i_dut/i_zip_system_0/u_watchdog/r_zero
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Internal /tb_top/i_dut/i_zip_system_0/u_watchdog/r_value
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Internal /tb_top/i_dut/i_zip_system_0/u_watchdog/wb_write
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Internal /tb_top/i_dut/i_zip_system_0/u_watchdog/auto_reload
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Internal /tb_top/i_dut/i_zip_system_0/u_watchdog/interval_count
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchdog -group Internal /tb_top/i_dut/i_zip_system_0/u_watchdog/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_a/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_a/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_a/i_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_a/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_a/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_a/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_a/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_a/i_wb_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Outputs /tb_top/i_dut/i_zip_system_0/u_timer_a/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Outputs /tb_top/i_dut/i_zip_system_0/u_timer_a/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Outputs /tb_top/i_dut/i_zip_system_0/u_timer_a/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Outputs /tb_top/i_dut/i_zip_system_0/u_timer_a/o_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_a/r_running
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_a/r_zero
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_a/r_value
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_a/wb_write
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_a/auto_reload
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_a/interval_count
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_a -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_a/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/i_soft_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/i_dma_request
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/i_src_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/i_dst_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/i_length
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/i_transferlen
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/i_trigger
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/i_mm2s_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/i_mm2s_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/i_mm2s_inc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/i_s2mm_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/i_s2mm_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/i_s2mm_inc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/o_dma_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/o_dma_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/o_remaining_len
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/o_mm2s_request
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/o_mm2s_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/o_mm2s_transferlen
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/o_s2mm_request
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/o_s2mm_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/o_s2mm_transferlen
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/r_length
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/r_transferlen
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_dma_fsm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_dma_fsm/fsm_state
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/i_request
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/i_inc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/i_size
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/i_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/S_VALID
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/S_DATA
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/S_BYTES
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/S_LAST
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/i_wr_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/i_wr_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/i_wr_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/i_wr_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/o_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/o_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/S_READY
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/o_wr_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/o_wr_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/o_wr_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/o_wr_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/o_wr_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/o_wr_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/ik
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/r_inc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/r_size
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/next_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/subaddr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/next_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/r_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/next_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/pre_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/r_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/r_last
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/wb_outstanding
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/wb_pipeline_full
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/addr_overflow
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_s2mm -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_s2mm/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/i_request
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/i_inc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/i_size
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/i_transferlen
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/i_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/i_rd_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/i_rd_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/i_rd_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/i_rd_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/M_READY
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/o_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/o_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/o_rd_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/o_rd_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/o_rd_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/o_rd_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/o_rd_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/o_rd_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/M_VALID
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/M_DATA
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/M_BYTES
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/M_LAST
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/nxtstb_size
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/rdstb_size
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/rdack_size
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/first_size
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/next_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/last_request_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/subaddr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/rdack_subaddr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/nxtstb_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/first_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/base_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/ibase_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/wb_outstanding
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/fill
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/next_fill
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/m_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/m_last
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/sreg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/m_bytes
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/rdstb_len
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/rdack_len
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/pre_shift
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/pre_shifted_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/r_inc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/r_size
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_mm2s -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_mm2s/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/i_swb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/i_swb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/i_swb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/i_swb_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/i_swb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/i_swb_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/i_mwb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/i_mwb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/i_mwb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/i_mwb_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/i_dev_ints
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/o_swb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/o_swb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/o_swb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/o_mwb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/o_mwb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/o_mwb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/o_mwb_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/o_mwb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/o_mwb_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/o_interrupt
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/dma_request
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/dma_abort
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/dma_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/dma_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/dma_src
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/dma_dst
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/read_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/write_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/dma_length
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/remaining_len
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/dma_transferlen
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/dma_trigger
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_request
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_request
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_inc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_inc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_size
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_size
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_transferlen
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_transferlen
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_rd_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_rd_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_rd_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_rd_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_rd_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_rd_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_rd_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_rd_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_rd_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_ready
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_last
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/mm2s_bytes
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/rx_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/rx_ready
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/rx_last
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/rx_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/rx_bytes
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/tx_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/tx_ready
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/tx_last
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/tx_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/tx_bytes
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/sfifo_full
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/sfifo_empty
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/ign_sfifo_fill
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_ready
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_last
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_bytes
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_wr_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_wr_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_wr_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_wr_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_wr_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_wr_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_wr_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_wr_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/s2mm_wr_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/wb_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/wb_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/wb_idata
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/wb_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_a_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_a_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_a_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_a_adr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_a_dat
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_a_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_b_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_b_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_b_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_b_adr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_b_dat
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_b_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/i_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/o_a_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/o_a_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/o_a_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/o_b_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/o_b_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/o_b_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/o_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/o_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/o_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/o_adr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/o_dat
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/o_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/r_a_owner
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_arbiter -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_arbiter/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/i_soft_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/S_VALID
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/S_DATA
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/S_BYTES
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/S_LAST
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/M_READY
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/S_READY
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/M_VALID
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/M_DATA
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/M_BYTES
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/M_LAST
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/sreg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/next_fill
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/fill
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/m_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/m_last
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/next_last
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/r_last
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/r_full
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/m_bytes
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/shift
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/s_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_rxgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_rxgears/ik
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/i_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/i_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/i_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/i_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/i_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/i_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/i_dma_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/i_dma_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/i_current_src
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/i_current_dst
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/i_remaining_len
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/i_dma_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/o_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/o_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/o_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/o_dma_request
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/o_dma_abort
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/o_src_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/o_dst_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/o_length
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/o_transferlen
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/o_mm2s_inc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/o_s2mm_inc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/o_mm2s_size
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/o_s2mm_size
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/o_trigger
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/o_interrupt
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/int_trigger
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/r_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/r_zero_len
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/r_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/int_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/next_src
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/next_dst
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/next_len
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/next_tlen
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/w_control_reg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_controller -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_controller/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/i_soft_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/i_size
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/S_VALID
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/S_DATA
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/S_BYTES
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/S_LAST
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/M_READY
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/S_READY
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/M_VALID
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/M_DATA
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/M_BYTES
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/M_LAST
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/m_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/m_last
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/r_last
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/r_next
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/sreg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/m_bytes
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_txgears -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_txgears/fill
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/i_wr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/i_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Inputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/i_rd
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/o_full
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/o_fill
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/o_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Outputs /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/o_empty
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/r_full
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/r_empty
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/wr_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/rd_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/rd_next
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/w_wr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/w_rd
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DMA -group dma_controller -group u_sfifo -group Internal /tb_top/i_dut/i_zip_system_0/DMA/dma_controller/u_sfifo/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_c/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_c/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_c/i_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_c/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_c/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_c/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_c/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_c/i_wb_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Outputs /tb_top/i_dut/i_zip_system_0/u_timer_c/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Outputs /tb_top/i_dut/i_zip_system_0/u_timer_c/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Outputs /tb_top/i_dut/i_zip_system_0/u_timer_c/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Outputs /tb_top/i_dut/i_zip_system_0/u_timer_c/o_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_c/r_running
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_c/r_zero
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_c/r_value
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_c/wb_write
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_c/auto_reload
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_c/interval_count
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_c -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_c/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/i_wr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/i_signed
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/i_numerator
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/i_denominator
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/o_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/o_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/o_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/o_quotient
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/o_flags
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/r_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/r_divisor
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/r_dividend
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/diff
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/r_sign
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/pre_sign
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/r_z
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/r_c
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/last_bit
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/r_bit
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/zero_divisor
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group DIVIDE -group thedivide -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/DIVIDE/thedivide/w_n
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group thempy -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/thempy/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group thempy -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/thempy/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group thempy -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/thempy/i_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group thempy -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/thempy/i_op
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group thempy -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/thempy/i_a
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group thempy -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/thempy/i_b
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group thempy -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/thempy/o_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group thempy -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/thempy/o_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group thempy -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/thempy/o_result
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group thempy -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/thempy/o_hi
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/i_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/i_op
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/i_a
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/i_b
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/o_c
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/o_f
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/o_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/o_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/w_brev_result
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/z
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/n
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/v
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/vx
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/c
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/pre_sign
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/set_ovfl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/keep_sgn_on_ovfl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/w_lsr_result
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/w_asr_result
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/w_lsl_result
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/mpy_result
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/mpyhi
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/mpybusy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/mpydone
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/this_is_a_multiply_op
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group doalu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/doalu/r_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/i_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/i_stalled
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/i_instruction
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/i_gie
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/i_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/i_pf_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/i_illegal
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_phase
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_illegal
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_dcdR
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_dcdA
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_dcdB
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_preA
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_preB
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_I
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_zI
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_cond
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_wF
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_op
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_ALU
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_M
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_DV
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_FP
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_break
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_lock
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_wR
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_rA
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_rB
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_early_branch
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_early_branch_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_branch_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_ljmp
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_pipe
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_sim
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/o_sim_immv
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_op
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_ldi
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_mov
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_cmptst
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_ldilo
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_ALU
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_brev
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_noop
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_lock
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_sim
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_break
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_special
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_add
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_mpy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_dcdR
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_dcdB
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_dcdA
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_dcdR_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_dcdR_cc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_dcdA_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_dcdA_cc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_dcdB_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_dcdB_cc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_cond
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_wF
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_mem
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_sto
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_div
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_fpu
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_wR
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_rA
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_rB
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_wR_n
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_ljmp
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_ljmp_dly
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_cis_ljmp
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/iword
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/pf_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/r_nxt_half
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_cis_op
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/r_I
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_fullI
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_I
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_Iz
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/w_immsrc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/r_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/insn_is_pipeable
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/illegal_shift
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group instruction_decoder -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/instruction_decoder/possibly_unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_interrupt
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_halt
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_clear_cache
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_dbg_wreg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_dbg_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_dbg_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_dbg_rreg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_pf_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_pf_illegal
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_pf_instruction
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_pf_instruction_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_mem_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_mem_rdbusy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_mem_pipe_stalled
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_mem_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_bus_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_mem_wreg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/core/i_mem_result
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_clken
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_dbg_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_dbg_reg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_dbg_cc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_break
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_pf_new_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_clear_icache
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_pf_ready
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_pf_request_address
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_clear_dcache
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_mem_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_bus_lock
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_mem_op
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_mem_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_mem_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_mem_lock_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_mem_reg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_op_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_pf_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_i_count
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_debug
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_prof_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_prof_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/core/o_prof_ticks
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/flags
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/iflags
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/w_uflags
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/w_iflags
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/break_en
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/user_step
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/sleep
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/r_halted
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/break_pending
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/trap
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/gie
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/ubreak
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/pending_interrupt
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/stepped
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/step
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/ill_err_u
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/ill_err_i
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/ibus_err_flag
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/ubus_err_flag
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/idiv_err_flag
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/udiv_err_flag
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/ifpu_err_flag
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/ufpu_err_flag
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/ihalt_phase
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/uhalt_phase
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/master_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/master_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/pf_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/new_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/clear_pipeline
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_stalled
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/pf_gie
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_opn
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_phase
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_A
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_B
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_R
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_preA
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_preB
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_Acc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_Bcc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_Apc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_Bpc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_Rcc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_Rpc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_F
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_wR
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_rA
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_rB
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_ALU
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_M
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_DIV
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_FP
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_wF
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_gie
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_break
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_lock
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_pipe
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_ljmp
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_I
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_zI
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_A_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_B_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_F_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_illegal
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_early_branch
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_early_branch_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_branch_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_sim
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_sim_immv
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/prelock_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/last_lock_insn
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/cc_invalid_for_dcd
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/pending_sreg_write
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_valid_mem
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_valid_alu
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_valid_div
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_valid_fpu
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_opn
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_R
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_Rcc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_Aid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_Bid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_rA
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_rB
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/r_op_Av
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/r_op_Bv
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/w_op_Av
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/w_op_Bv
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_Av
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_Bv
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/w_pcB_v
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/w_pcA_v
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/w_op_BnI
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_wR
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_wF
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_gie
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_Fl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/r_op_F
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_F
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_phase
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_pipe
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/r_op_break
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/w_op_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_lowpower_clear
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/w_cpu_info
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_illegal
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_break
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_lock
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_sim
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/op_sim_immv
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_sim
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_sim_immv
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_reg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/r_alu_pc_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/mem_pc_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_pc_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_phase
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_result
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_flags
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/set_cond
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_wR
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_wF
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_gie
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/alu_illegal
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/mem_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/mem_stalled
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/div_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/div_error
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/div_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/div_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/div_result
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/div_flags
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/fpu_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/fpu_error
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/fpu_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/fpu_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/fpu_result
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/fpu_flags
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/adf_ce_unconditional
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dbgv
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dbg_clear_pipe
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dbg_val
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/debug_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/r_dbg_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/wr_write_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/wr_write_cc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/wr_write_scc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/wr_write_ucc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/wr_reg_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/wr_flags_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/wr_flags
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/wr_index
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/wr_reg_id
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/wr_gpreg_vl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/wr_spreg_vl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/w_switch_to_interrupt
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/w_release_from_interrupt
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/ipc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/upc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/last_write_to_cc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/cc_write_hold
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/r_clear_icache
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/pfpcset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/pfpcsrc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/w_clken
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_full_R
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_full_A
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/dcd_full_B
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/avsrc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/bvsrc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/bisrc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/cpu_sim
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group core -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/core/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/i_new_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/i_clear_cache
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/i_ready
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/i_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/i_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/i_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/i_wb_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/o_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/o_illegal
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/o_insn
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/o_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/o_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/o_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/o_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/o_wb_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/r_v
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/cache_word
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/valid_mask
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/r_v_from_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/r_v_from_last
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/rvsrc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/w_v_from_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/w_v_from_last
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/lastpc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/wraddr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/pc_tag_lookup
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/last_tag_lookup
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/tag_lookup
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/pc_tag
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/lasttag
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/illegal_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/illegal_cache
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/r_pc_cache
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/r_last_cache
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/r_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/isrc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/delay
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/svmask
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/last_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/needload
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/last_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/bus_abort
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/saddr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/w_advance
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/w_invalidate_result
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/pc_line
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PFCACHE -group pf -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PFCACHE/pf/last_line
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_a_cyc_a
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_a_cyc_b
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_a_stb_a
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_a_stb_b
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_a_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_a_adr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_a_dat
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_a_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_b_cyc_a
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_b_cyc_b
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_b_stb_a
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_b_stb_b
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_b_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_b_adr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_b_dat
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_b_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/i_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/o_a_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/o_a_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/o_a_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/o_b_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/o_b_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/o_b_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/o_cyc_a
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/o_cyc_b
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/o_stb_a
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/o_stb_b
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/o_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/o_adr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/o_dat
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/o_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group PRIORITY_DATA -group pformem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/PRIORITY_DATA/pformem/r_a_owner
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/i_clear
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/i_pipe_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/i_lock
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/i_op
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/i_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/i_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/i_oreg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/i_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/i_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/i_wb_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/o_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/o_rdbusy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/o_pipe_stalled
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/o_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/o_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/o_wreg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/o_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/o_wb_cyc_gbl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/o_wb_cyc_lcl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/o_wb_stb_gbl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/o_wb_stb_lcl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/o_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/o_wb_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/o_wb_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/ik
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/last_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/end_of_line
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/last_line_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/r_wb_cyc_gbl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/r_wb_cyc_lcl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/npending
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/c_v
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/set_vflag
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/state
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/wr_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/cached_iword
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/cached_rword
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/lock_gbl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/lock_lcl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/c_wr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/c_wdata
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/c_wsel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/c_waddr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/last_tag
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/last_tag_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/i_cline
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/i_caddr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/cache_miss_inow
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/w_cachable
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/raw_cachable_address
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/r_cachable
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/r_svalid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/r_dvalid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/r_rd
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/r_cache_miss
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/r_rd_pending
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/r_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/r_cline
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/r_caddr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/r_ctag
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/wr_cstb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/r_iv
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/in_cache
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/r_itag
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/req_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/gie
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/pre_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/pre_shifted
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group chkaddress -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/chkaddress/i_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group DATA_CACHE -group mem -group chkaddress -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/DATA_CACHE/mem/chkaddress/o_cachable
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/i_interrupt
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/i_cpu_clken
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/i_halt
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/i_clear_cache
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/i_dbg_wreg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/i_dbg_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/i_dbg_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/i_dbg_rreg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/i_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/i_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Inputs /tb_top/i_dut/i_zip_system_0/thecpu/i_wb_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_dbg_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_halted
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_dbg_reg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_dbg_cc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_break
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_wb_gbl_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_wb_gbl_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_wb_lcl_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_wb_lcl_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_wb_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_wb_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_op_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_pf_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_i_count
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_debug
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_prof_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_prof_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Outputs /tb_top/i_dut/i_zip_system_0/thecpu/o_prof_ticks
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/cpu_clken
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/cpu_clock
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/clk_gate
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/cpu_debug
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/pf_new_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/clear_icache
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/pf_ready
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/pf_request_address
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/pf_instruction
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/pf_instruction_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/pf_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/pf_illegal
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/pf_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/pf_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/pf_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/pf_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/pf_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/pf_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/pf_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/pf_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/clear_dcache
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/bus_lock
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_op
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_cpu_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_lock_pc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_wdata
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_reg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_busy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_rdbusy
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_pipe_stalled
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_valid
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_bus_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_wreg
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_result
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_stb_lcl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_stb_gbl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_cyc_lcl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_cyc_gbl
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_bus_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/mem_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/w_dbg_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group thecpu -group Internal /tb_top/i_dut/i_zip_system_0/thecpu/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Inputs /tb_top/i_dut/i_zip_system_0/u_jiffies/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Inputs /tb_top/i_dut/i_zip_system_0/u_jiffies/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Inputs /tb_top/i_dut/i_zip_system_0/u_jiffies/i_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Inputs /tb_top/i_dut/i_zip_system_0/u_jiffies/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Inputs /tb_top/i_dut/i_zip_system_0/u_jiffies/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Inputs /tb_top/i_dut/i_zip_system_0/u_jiffies/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Inputs /tb_top/i_dut/i_zip_system_0/u_jiffies/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Inputs /tb_top/i_dut/i_zip_system_0/u_jiffies/i_wb_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Outputs /tb_top/i_dut/i_zip_system_0/u_jiffies/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Outputs /tb_top/i_dut/i_zip_system_0/u_jiffies/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Outputs /tb_top/i_dut/i_zip_system_0/u_jiffies/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Outputs /tb_top/i_dut/i_zip_system_0/u_jiffies/o_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Internal /tb_top/i_dut/i_zip_system_0/u_jiffies/r_counter
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Internal /tb_top/i_dut/i_zip_system_0/u_jiffies/int_set
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Internal /tb_top/i_dut/i_zip_system_0/u_jiffies/new_set
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Internal /tb_top/i_dut/i_zip_system_0/u_jiffies/int_now
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Internal /tb_top/i_dut/i_zip_system_0/u_jiffies/int_when
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Internal /tb_top/i_dut/i_zip_system_0/u_jiffies/new_when
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Internal /tb_top/i_dut/i_zip_system_0/u_jiffies/till_wb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Internal /tb_top/i_dut/i_zip_system_0/u_jiffies/till_when
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_jiffies -group Internal /tb_top/i_dut/i_zip_system_0/u_jiffies/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Inputs /tb_top/i_dut/i_zip_system_0/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Inputs /tb_top/i_dut/i_zip_system_0/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Inputs /tb_top/i_dut/i_zip_system_0/i_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Inputs /tb_top/i_dut/i_zip_system_0/i_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Inputs /tb_top/i_dut/i_zip_system_0/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Inputs /tb_top/i_dut/i_zip_system_0/i_wb_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Inputs /tb_top/i_dut/i_zip_system_0/i_ext_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Inputs /tb_top/i_dut/i_zip_system_0/i_dbg_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Inputs /tb_top/i_dut/i_zip_system_0/i_dbg_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Inputs /tb_top/i_dut/i_zip_system_0/i_dbg_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Inputs /tb_top/i_dut/i_zip_system_0/i_dbg_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Inputs /tb_top/i_dut/i_zip_system_0/i_dbg_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Inputs /tb_top/i_dut/i_zip_system_0/i_dbg_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Outputs /tb_top/i_dut/i_zip_system_0/o_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Outputs /tb_top/i_dut/i_zip_system_0/o_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Outputs /tb_top/i_dut/i_zip_system_0/o_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Outputs /tb_top/i_dut/i_zip_system_0/o_wb_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Outputs /tb_top/i_dut/i_zip_system_0/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Outputs /tb_top/i_dut/i_zip_system_0/o_wb_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Outputs /tb_top/i_dut/i_zip_system_0/o_ext_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Outputs /tb_top/i_dut/i_zip_system_0/o_dbg_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Outputs /tb_top/i_dut/i_zip_system_0/o_dbg_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Outputs /tb_top/i_dut/i_zip_system_0/o_dbg_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Outputs /tb_top/i_dut/i_zip_system_0/o_cpu_debug
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Outputs /tb_top/i_dut/i_zip_system_0/o_prof_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Outputs /tb_top/i_dut/i_zip_system_0/o_prof_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -expand -group Outputs /tb_top/i_dut/i_zip_system_0/o_prof_ticks
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/main_int_vector
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/alt_int_vector
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ctri_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/tma_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/tmb_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/tmc_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/jif_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dmac_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mtc_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/moc_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mpc_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mic_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/utc_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/uoc_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/upc_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/uic_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/actr_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/actr_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/actr_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_clken
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sys_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sys_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sys_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sys_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sys_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sys_idata
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sys_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sys_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sel_counter
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sel_timer
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sel_pic
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sel_apic
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sel_watchdog
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sel_bus_watchdog
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sel_dmac
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/sel_mmus
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_idata
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_odata
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/no_dbg_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_break
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_cmd_write
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_cpu_write
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_cpu_read
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_cmd_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_cmd_strb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/reset_hold
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/halt_on_fault
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_catch
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/reset_request
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/release_request
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/halt_request
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/step_request
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/clear_cache_request
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cmd_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cmd_halt
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cmd_step
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cmd_clear_cache
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cmd_write
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cmd_read
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cmd_waddr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cmd_wdata
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_dbg_cc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_halt
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_has_halted
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_dbg_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/pic_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_status
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_gie
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/wdt_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/wdt_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/wdt_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/wdt_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/wdbus_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/r_wdbus_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/wdbus_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/reset_wdbus_timer
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/wdbus_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_op_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_pf_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_i_count
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dmac_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dc_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dmac_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dmac_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dmac_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dc_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dc_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dc_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dc_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dc_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dc_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dc_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dc_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_gbl_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dmac_int_vec
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ctri_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ctri_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ctri_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ctri_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/tma_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/tma_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/tmb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/tmb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/tmc_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/tmc_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/jif_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/jif_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/tma_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/tmb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/tmc_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/jif_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/pic_interrupt
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/pic_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/pic_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_gbl_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_lcl_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_lcl_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_idata
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmu_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_dbg_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ext_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ext_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmu_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmu_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmu_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmu_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmu_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmu_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmus_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmus_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmu_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmu_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmu_idata
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmus_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cpu_miss
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmu_cpu_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmu_cpu_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/mmu_cpu_idata
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/pf_return_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/pf_return_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/pf_return_cachable
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/pf_return_v
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/pf_return_p
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ext_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ext_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ext_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ext_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ext_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ext_odata
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ext_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ext_idata
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/tmr_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/w_ack_idx
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/ack_idx
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/last_sys_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/cmd_read_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/r_mmus_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_pre_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_pre_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/dbg_cpu_status
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group Internal /tb_top/i_dut/i_zip_system_0/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_b/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_b/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_b/i_ce
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_b/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_b/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_b/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_b/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Inputs /tb_top/i_dut/i_zip_system_0/u_timer_b/i_wb_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Outputs /tb_top/i_dut/i_zip_system_0/u_timer_b/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Outputs /tb_top/i_dut/i_zip_system_0/u_timer_b/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Outputs /tb_top/i_dut/i_zip_system_0/u_timer_b/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Outputs /tb_top/i_dut/i_zip_system_0/u_timer_b/o_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_b/r_running
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_b/r_zero
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_b/r_value
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_b/wb_write
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_b/auto_reload
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_b/interval_count
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_timer_b -group Internal /tb_top/i_dut/i_zip_system_0/u_timer_b/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Inputs /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Inputs /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Inputs /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Inputs /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Inputs /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Inputs /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Inputs /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/i_wb_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Inputs /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/i_brd_ints
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Outputs /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Outputs /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Outputs /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Outputs /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/o_interrupt
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Internal /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/r_int_state
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Internal /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/r_int_enable
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Internal /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/r_mie
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Internal /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/w_any
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Internal /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/wb_write
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Internal /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/enable_ints
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Internal /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/disable_ints
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group MAIN_PIC -group pic -group Internal /tb_top/i_dut/i_zip_system_0/MAIN_PIC/pic/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Inputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Inputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Inputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Inputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Inputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Inputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/i_wb_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Inputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Inputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/i_wb_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Inputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/i_dly_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Inputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/i_dly_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Inputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/i_dly_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Inputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/i_dly_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Outputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Outputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Outputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Outputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/o_wb_err
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Outputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/o_dly_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Outputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/o_dly_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Outputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/o_dly_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Outputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/o_dly_addr
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Outputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/o_dly_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group DELAY_THE_DEBUG_BUS -group wbdelay -group Outputs /tb_top/i_dut/i_zip_system_0/DELAY_THE_DEBUG_BUS/wbdelay/o_dly_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Inputs /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Inputs /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Inputs /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/i_wb_cyc
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Inputs /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/i_wb_stb
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Inputs /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/i_wb_we
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Inputs /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/i_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Inputs /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/i_wb_sel
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Inputs /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/i_brd_ints
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Outputs /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/o_wb_stall
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Outputs /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/o_wb_ack
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Outputs /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/o_wb_data
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Outputs /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/o_interrupt
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Internal /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/r_int_state
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Internal /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/r_int_enable
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Internal /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/r_mie
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Internal /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/w_any
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Internal /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/wb_write
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Internal /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/enable_ints
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Internal /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/disable_ints
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group PIC_WITH_ACCOUNTING -group ALT_PIC -group ctri -group Internal /tb_top/i_dut/i_zip_system_0/PIC_WITH_ACCOUNTING/ALT_PIC/ctri/unused
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchbus -group Inputs /tb_top/i_dut/i_zip_system_0/u_watchbus/i_clk
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchbus -group Inputs /tb_top/i_dut/i_zip_system_0/u_watchbus/i_reset
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchbus -group Inputs /tb_top/i_dut/i_zip_system_0/u_watchbus/i_timeout
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchbus -group Outputs /tb_top/i_dut/i_zip_system_0/u_watchbus/o_int
add wave -noupdate -expand -group i_dut -group i_zip_system_0 -group u_watchbus -group Internal /tb_top/i_dut/i_zip_system_0/u_watchbus/r_value
add wave -noupdate -expand -group i_dut -expand -group i_wb_slv_memory_0 -expand -group Inputs /tb_top/i_dut/i_wb_slv_memory_0/clk_sys
add wave -noupdate -expand -group i_dut -expand -group i_wb_slv_memory_0 -expand -group Inputs /tb_top/i_dut/i_wb_slv_memory_0/rst_n_clk_sys
add wave -noupdate -expand -group i_dut -expand -group i_wb_slv_memory_0 -expand -group Inputs /tb_top/i_dut/i_wb_slv_memory_0/i_wb_cyc
add wave -noupdate -expand -group i_dut -expand -group i_wb_slv_memory_0 -expand -group Inputs /tb_top/i_dut/i_wb_slv_memory_0/i_wb_stb
add wave -noupdate -expand -group i_dut -expand -group i_wb_slv_memory_0 -expand -group Inputs /tb_top/i_dut/i_wb_slv_memory_0/i_wb_we
add wave -noupdate -expand -group i_dut -expand -group i_wb_slv_memory_0 -expand -group Inputs /tb_top/i_dut/i_wb_slv_memory_0/i_wb_addr
add wave -noupdate -expand -group i_dut -expand -group i_wb_slv_memory_0 -expand -group Inputs /tb_top/i_dut/i_wb_slv_memory_0/i_wb_data
add wave -noupdate -expand -group i_dut -expand -group i_wb_slv_memory_0 -expand -group Inputs /tb_top/i_dut/i_wb_slv_memory_0/i_wb_sel
add wave -noupdate -expand -group i_dut -expand -group i_wb_slv_memory_0 -expand -group Outputs /tb_top/i_dut/i_wb_slv_memory_0/o_wb_stall
add wave -noupdate -expand -group i_dut -expand -group i_wb_slv_memory_0 -expand -group Outputs /tb_top/i_dut/i_wb_slv_memory_0/o_wb_ack
add wave -noupdate -expand -group i_dut -expand -group i_wb_slv_memory_0 -expand -group Outputs /tb_top/i_dut/i_wb_slv_memory_0/o_wb_data
add wave -noupdate -expand -group i_dut -expand -group i_wb_slv_memory_0 -expand -group Internal /tb_top/i_dut/i_wb_slv_memory_0/s_wb_stall
add wave -noupdate -expand -group i_dut -expand -group i_wb_slv_memory_0 -expand -group Internal /tb_top/i_dut/i_wb_slv_memory_0/ram_array
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {360707 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 257
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
WaveRestoreZoom {0 ps} {3835952 ps}
