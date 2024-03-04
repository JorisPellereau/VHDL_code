
`timescale 1ps/1ps

// Clock and Reset Configuration - Unit in [ps]
`define C_TB_CLK_HALF_PERIOD 10000
`define C_WAIT_RST           100000
`define C_TB_CLK_PERIOD      2*`C_TB_CLK_HALF_PERIOD

// SET ALIAS Configuration
`define C_SET_ALIAS_NB 7
`define C_SET_SIZE     7
`define C_SET_WIDTH    32

// WAIT EVENT Configuration
`define C_WAIT_ALIAS_NB 3
`define C_WAIT_WIDTH    3

// CHECK LEVEL Configuration
`define C_CHECK_ALIAS_NB 1
`define C_CHECK_SIZE     1
`define C_CHECK_WIDTH    8

// DUT Configuration
`define C_I2C_FREQ        400000
`define C_CLKSYS_FREQ     50000000
`define C_NB_DATA         256
`define C_FIFO_DATA_WIDTH 8
`define C_FIFO_DEPTH      1024
 
// I2C SLAVE Configuration
`define C_SLAVE_I2C_FIFO_DEPTH 256
