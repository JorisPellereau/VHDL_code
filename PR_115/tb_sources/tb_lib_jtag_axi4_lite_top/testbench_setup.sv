
`timescale 1ps/1ps

// Clock and Reset Configuration - Unit in [ps]
`define C_TB_CLK_HALF_PERIOD 10000
`define C_WAIT_RST           100000
`define C_TB_CLK_PERIOD      2*`C_TB_CLK_HALF_PERIOD

// SET ALIAS Configuration
`define C_SET_ALIAS_NB 5
`define C_SET_SIZE     5
`define C_SET_WIDTH    32

// WAIT EVENT Configuration
`define C_WAIT_ALIAS_NB 3
`define C_WAIT_WIDTH    3

// CHECK LEVEL Configuration
`define C_CHECK_ALIAS_NB 2
`define C_CHECK_SIZE     2
`define C_CHECK_WIDTH    32


// DUT GENERIC Configuration
`define C_SIMULATION 1

// AXI4 Lite Master PATH
`define C_AXI4_LITE_MASTER_PATH i_dut.i_jtag_axi4_lite_core_0.i_axi4_lite_master_0
