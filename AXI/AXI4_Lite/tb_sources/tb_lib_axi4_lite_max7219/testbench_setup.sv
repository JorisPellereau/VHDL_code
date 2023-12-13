
`timescale 1ps/1ps

// Clock and Reset Configuration - Unit in [ps]
`define C_TB_CLK_HALF_PERIOD 10000
`define C_WAIT_RST           100000
`define C_TB_CLK_PERIOD      2*`C_TB_CLK_HALF_PERIOD

// SET ALIAS Configuration
`define C_SET_ALIAS_NB 1
`define C_SET_SIZE     1
`define C_SET_WIDTH    32

// WAIT EVENT Configuration
`define C_WAIT_ALIAS_NB 4
`define C_WAIT_WIDTH    4

// CHECK LEVEL Configuration
`define C_CHECK_ALIAS_NB 1
`define C_CHECK_SIZE     1
`define C_CHECK_WIDTH    1

// AXI4Lite Master Configuration
`define C_NB_MASTER_AXI4LITE             1
`define C_MASTER_AXI4LITE_ADDR_WIDTH     32
`define C_MASTER_AXI4LITE_DATA_WIDTH     32

// DUT  Configuration
`define NB_MATRIX 4
