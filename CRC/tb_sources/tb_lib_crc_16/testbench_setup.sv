//                              -*- Mode: Verilog -*-
// Filename        : testbench_setup.sv
// Description     : Testbench Constant Setup
// Author          : JorisP
// Created On      : Wed Oct 21 19:51:54 2020
// Last Modified By: JorisP
// Last Modified On: Wed Oct 21 19:51:54 2020
// Update Count    : 0
// Status          : V1.0

/*
 *  Testbench Setup for test of CRC 16 Block
 * 
 */
`timescale 1ps/1ps

// Clock and Reset Configuration
`define C_TB_CLK_HALF_PERIOD 10000   // 10000 ps = 10 ns
`define C_WAIT_RST           100000  // 100000 ps = 100 ns before release Reset
`define C_TB_CLK_PERIOD      20000   // 200000 ps = 20 ns


// SET ALIAS Configuration
`define C_SET_ALIAS_NB 3
`define C_SET_SIZE     3
`define C_SET_WIDTH    32

// WAIT EVENT Configuration
`define C_WAIT_ALIAS_NB 4
`define C_WAIT_WIDTH    1

// CHECK LEVEL Configuration
`define C_CHECK_ALIAS_NB 3
`define C_CHECK_SIZE     3
`define C_CHECK_WIDTH    32

// DATA CHECKER Configuration
`define C_NB_CHECKER         1
`define C_CHECKER_DATA_WIDTH 16

