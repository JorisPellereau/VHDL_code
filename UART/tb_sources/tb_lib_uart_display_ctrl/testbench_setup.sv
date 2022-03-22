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


// SET ALIAS Configuration
`define C_SET_ALIAS_NB 3
`define C_SET_SIZE     3
`define C_SET_WIDTH    32

// WAIT EVENT Configuration
`define C_WAIT_ALIAS_NB 4
`define C_WAIT_WIDTH    1

// CHECK LEVEL Configuration
`define C_CHECK_ALIAS_NB 2
`define C_CHECK_SIZE     2
`define C_CHECK_WIDTH    32

// UART TESTBENCH Configuration
`define C_NB_UART_CHECKER        1
`define C_UART_DATA_WIDTH        8
`define C_UART_BUFFER_ADDR_WIDTH 8
`define C_STOP_BIT_NUMBER        1
`define C_POLARITY               4'd3      // '1' value
`define C_PARITY                 2         // No Parity
`define C_BAUDRATE               10         // Baudrate 9 : 155200 - 10 : 230400 - 11 : 460800
`define C_FIRST_BIT              0
`define C_CLOCK_FREQ             50000000  // 50 Mhz

// DATA COLLECTOR Configuration
`define C_NB_DATA_COLLECTOR         1
`define C_DATA_COLLECTOR_DATA_WIDTH 1 
