
`timescale 1ps/1ps

// Clock and Reset Configuration - Unit in [ps]
`define C_TB_CLK_HALF_PERIOD 10000
`define C_WAIT_RST           100000
`define C_TB_CLK_PERIOD      2*`C_TB_CLK_HALF_PERIOD

// SET ALIAS Configuration
`define C_SET_ALIAS_NB 8
`define C_SET_SIZE     8
`define C_SET_WIDTH    32

// WAIT EVENT Configuration
`define C_WAIT_ALIAS_NB 4
`define C_WAIT_WIDTH    4

// CHECK LEVEL Configuration
`define C_CHECK_ALIAS_NB 4
`define C_CHECK_SIZE     4
`define C_CHECK_WIDTH    32

// I2C SLAVE EEPROM Configuration
`define C_SLAVE_I2C_FIFO_DEPTH 256

// DUT GENERIC Configuration
`define C_SIMULATION 1
`define C_SPI_SIZE 4 // Size of the SPI BUS - QUAD
// AXI4 Lite Master PATH
//`define C_AXI4_LITE_MASTER_PATH i_dut.i_jtag_axi4_lite_core_0.i_axi4_lite_master_0

// Internal duration counter path
//`define C_DURATION_DONE_PATH i_dut.i_jtag_axi4_lite_core_0.i_axi4_lite_lcd_0.i_lcd_cfah_top_0.i_lcd_cfah_init_0.s_duration_done
