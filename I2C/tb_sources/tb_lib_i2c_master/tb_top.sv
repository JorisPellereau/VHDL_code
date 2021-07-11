//                              -*- Mode: Verilog -*-
// Filename        : tb_top.sv
// Description     : Testbench TOP
// Author          : JorisP
// Created On      : Mon Oct 12 21:51:03 2020
// Last Modified By: JorisP
// Last Modified On: Mon Oct 12 21:51:03 2020
// Update Count    : 0
// Status          : V1.0

/*
 *  Testbench TOP for test of I2C_MASTER block
 * 
 */ 

`timescale 1ps/1ps


`include "/home/jorisp/GitHub/VHDL_code/I2C/tb_sources/tb_lib_i2c_master/testbench_setup.sv"
`include "/home/jorisp/GitHub/Verilog/lib_testbench/wait_event_wrapper.sv"
`include "/home/jorisp/GitHub/Verilog/lib_testbench/set_injector_wrapper.sv"
`include "/home/jorisp/GitHub/Verilog/lib_testbench/wait_duration_wrapper.sv"
`include "/home/jorisp/GitHub/Verilog/lib_testbench/check_level_wrapper.sv"
`include "/home/jorisp/GitHub/Verilog/lib_tb_uart/uart_checker_wrapper.sv"
`include "/home/jorisp/GitHub/Verilog/lib_testbench/tb_tasks.sv"


// TB TOP
module tb_top
  #(
    parameter SCN_FILE_PATH = "scenario.txt"
   )
   ();
   

   
   // == INTERNAL SIGNALS ==
   
   wire clk;
   wire rst_n;

   wire s_rw;
   wire [6:0] s_chip_addr;
   wire [7:0] s_nb_data;
   wire [7:0] s_wdata;

   wire [7:0] s_rdata;
   wire       s_rdata_valid;
   wire       s_next_wdata_rdy;
   wire       s_sack_error;

   wire       s_scl;
   wire       s_sda;

   wire [6:0] s_chip_addr_slave_0;
   wire [7:0] s_wdata_slave_0;
   wire       s_wdata_valid_slave_0;

   wire [7:0] s_rdata_slave_0;
   wire       s_rdata_valid_slave_0;
   wire       s_chip_addr_ok_slave_0;
   
   

   
   // == CLK GEN INST ==
   clk_gen #(
	.G_CLK_HALF_PERIOD  (`C_TB_CLK_HALF_PERIOD),
	.G_WAIT_RST         (`C_WAIT_RST)
   )
   i_clk_gen (
	      .clk_tb (clk),
              .rst_n  (rst_n)	      
   );
   // ==================




   // == TESTBENCH GENERIC INTERFACE SIGNALS DECLARATIONS ==
    wait_event_intf #( .WAIT_SIZE   (`C_WAIT_ALIAS_NB),
                       .WAIT_WIDTH  (`C_WAIT_WIDTH)
    ) 
    s_wait_event_if();

    set_injector_intf #( .SET_SIZE   (`C_SET_ALIAS_NB),
			 .SET_WIDTH  (`C_SET_WIDTH)
    )
    s_set_injector_if();
 
    wait_duration_intf s_wait_duration_if();
   
    assign s_wait_duration_if.clk = clk;
   

    check_level_intf #( .CHECK_SIZE   (`C_CHECK_ALIAS_NB),
		        .CHECK_WIDTH  (`C_CHECK_WIDTH)
    )
    s_check_level_if();
   


    // == HDL GENERIC TESTBENCH MODULES ==

    // WAIT EVENT TB WRAPPER INST
    wait_event_wrapper #(.CLK_PERIOD (`C_TB_CLK_PERIOD)
    )
    i_wait_event_wrapper (
       .clk            (clk),
       .rst_n          (rst_n),
       .wait_event_if  (s_wait_event_if)			 
    );


    // SET INJECTOR TB WRAPPER INST
    set_injector_wrapper #()
    i_set_injector_wrapper (
       .clk              (clk),
       .rst_n            (rst_n),
       .set_injector_if  (s_set_injector_if)			   
    );   
   // =====================================================

   

   // == TESTBENCH MODULES ALIASES & SIGNALS AFFECTATION ==

   // INIT WAIT EVENT ALIAS
   assign s_wait_event_if.wait_alias[0] = "RST_N";
   assign s_wait_event_if.wait_alias[1] = "CLK";
   assign s_wait_event_if.wait_alias[2] = "S_RDATA_VALID";
   assign s_wait_event_if.wait_alias[3] = "S_NEXT_WDATA_RDY";
   assign s_wait_event_if.wait_alias[4] = "S_SACK_ERROR";
   assign s_wait_event_if.wait_alias[5] = "WDATA_VALID_SLAVE_0";
   assign s_wait_event_if.wait_alias[6] = "RDATA_VALID_SLAVE_0";
   
   // SET WAIT EVENT SIGNALS
   assign s_wait_event_if.wait_signals[0] = rst_n;
   assign s_wait_event_if.wait_signals[1] = clk;
   assign s_wait_event_if.wait_signals[2] = s_rdata_valid;
   assign s_wait_event_if.wait_signals[3] = s_next_wdata_rdy;
   assign s_wait_event_if.wait_signals[4] = s_sack_error;
   assign s_wait_event_if.wait_signals[5] = s_wdata_valid_slave_0;
   assign s_wait_event_if.wait_signals[6] = s_rdata_valid_slave_0;

   

   // INIT SET ALIAS
   assign s_set_injector_if.set_alias[0]   = "I_START";
   assign s_set_injector_if.set_alias[1]   = "I_RW";
   assign s_set_injector_if.set_alias[2]   = "I_CHIP_ADDR";
   assign s_set_injector_if.set_alias[3]   = "I_NB_DATA";
   assign s_set_injector_if.set_alias[4]   = "I_WDATA";
   assign s_set_injector_if.set_alias[5]   = "CHIP_ADDR_SLAVE_0";
   assign s_set_injector_if.set_alias[6]   = "WDATA_SLAVE_0";
   
   // SET SET_INJECTOR SIGNALS
   assign s_start             = s_set_injector_if.set_signals_synch[0];
   assign s_rw                = s_set_injector_if.set_signals_synch[1];
   assign s_chip_addr         = s_set_injector_if.set_signals_synch[2];
   assign s_nb_data           = s_set_injector_if.set_signals_synch[3];
   assign s_wdata             = s_set_injector_if.set_signals_synch[4];
   assign s_chip_addr_slave_0 = s_set_injector_if.set_signals_synch[5];
   assign s_wdata_slave_0     = s_set_injector_if.set_signals_synch[6];
 
   // SET SET_INJECTOR INITIAL VALUES
   assign s_set_injector_if.set_signals_asynch_init_value[0]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[1]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[2]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[3]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[4]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[5]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[6]  = 0;

   
   
   // INIT CHECK LEVEL ALIAS
   assign s_check_level_if.check_alias[0] = "SCL";
   assign s_check_level_if.check_alias[1] = "SDA";   
  
   // SET CHECK_SIGNALS
   assign s_check_level_if.check_signals[0] =  s_scl;
   assign s_check_level_if.check_signals[1] =  s_sda;

   
   // =====================================================


   // == HDL SPEFICIC TESTBENCH MODULES ==

 
   // =============================
   

   // == TESTBENCH Configuration ==

   // Declare  TB Modules Class 
   tb_modules_custom_class tb_modules_custom_class_inst = new();

   
   // CREATE CLASS - Configure Parameters
   static tb_class #( `C_SET_SIZE, 
                      `C_SET_WIDTH,
                      `C_WAIT_ALIAS_NB,
                      `C_WAIT_WIDTH, 
                      `C_TB_CLK_PERIOD,
                      `C_CHECK_SIZE,
                      `C_CHECK_WIDTH
		      )
   
   tb_class_inst= new (s_wait_event_if, 
                       s_set_injector_if, 
                       s_wait_duration_if,
                       s_check_level_if,
		       tb_modules_custom_class_inst);
   
   initial begin// : TB_SEQUENCER


      // RUN Testbench Sequencer
      tb_class_inst.tb_sequencer(SCN_FILE_PATH);
      
   end// : TB_SEQUENCER
   
   // ========================



   // I2C Pull Up
   pullup(s_scl);
   pullup(s_sda);
   

   

   // == DUT INST ==
   i2c_master #(
		.G_SCL_FREQ    (`SCL_FREQ),  // f400k selected
		.G_CLOCK_FREQ  (`CLOCK_FREQ)		      				       
		)
   
   i_dut (
	  .clk    (clk),
	  .rst_n  (rst_n),
	  	  
	  .i_start      (s_start),
	  .i_rw         (s_rw),
	  .i_chip_addr  (s_chip_addr),
	  .i_nb_data    (s_nb_data),
	  .i_wdata      (s_wdata),

	  .o_rdata           (s_rdata),
	  .o_rdata_valid     (s_rdata_valid),
	  .o_next_wdata_rdy  (s_next_wdata_rdy),
	  .o_sack_error      (s_sack_error),

	  .scl  (s_scl),
	  .sda  (s_sda)	  
	  );   
   // ===============


   // I2C SLAVE CHECKER
   i2c_slave_checker i_i2c_slave_checker_0 (
					    .clk    (clk),
					    .rst_n  (rst_n),

					    .i_chip_addr    (s_chip_addr_slave_0),
					    .i_wdata        (s_wdata_slave_0),
					    .o_wdata_valid  (s_wdata_valid_slave_0),

					    .o_rdata        (s_rdata_slave_0),
					    .o_rdata_valid  (s_rdata_valid_slave_0),

					    .o_chip_addr_ok  (s_chip_addr_ok_slave_0),

					    .scl  (s_scl),
					    .sda  (s_sda)
					    );
   

endmodule // tb_top
