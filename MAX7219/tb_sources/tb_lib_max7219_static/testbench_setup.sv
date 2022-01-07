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
 *  Testbench Setup for test of MAX7219 STATIC Block
 * 
 */
`timescale 1ps/1ps

// Clock and Reset Configuration
`define C_TB_CLK_HALF_PERIOD 10000   // 10000 ps = 10 ns
`define C_WAIT_RST           100000  // 100000 ps = 100 ns before release Reset
`define C_TB_CLK_PERIOD      20000   // 200000 ps = 20 ns

// TESTBENCH SEQUENCER Configuration
`define C_CMD_ARGS_NB 5

// SET ALIAS Configuration
`define C_SET_ALIAS_NB 12
`define C_SET_SIZE     12
`define C_SET_WIDTH    32

// WAIT EVENT Configuration
`define C_WAIT_ALIAS_NB 5
`define C_WAIT_WIDTH    1

// CHECK LEVEL Configuration
`define C_CHECK_ALIAS_NB 5
`define C_CHECK_SIZE     5
`define C_CHECK_WIDTH    32

// DATA COLLECTOR Configuration
`define C_NB_DATA_COLLECTOR         1
`define C_DATA_COLLECTOR_DATA_WIDTH 18
