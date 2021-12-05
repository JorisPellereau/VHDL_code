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
 *  Testbench TOP for test of MAX7219 STATIC Block
 * 
 */ 

`timescale 1ps/1ps

`include "/home/linux-jp/Documents/GitHub/VHDL_code/MAX7219/tb_sources/tb_lib_max7219_if/testbench_setup.sv"
`include "/home/linux-jp/Documents/GitHub/Verilog/Testbench/sources/lib_tb_sequencer/tb_tasks.sv"

// Data Collector Modules and Class

// TB TOP
module tb_top
  #(
    parameter SCN_FILE_PATH = "scenario.txt"
   )
   ();
   

   
   // == INTERNAL SIGNALS ==   
   wire clk;
   wire rst_n;

   // == DUT Signals ==
   wire        s_start;
   wire        s_en_load;
   wire [15:0] s_data;   
   wire        s_max7219_load;   
   wire        s_max7219_data;
   wire        s_max7219_clk;
   wire        s_done;

   // == SPI Checker Signals ==
   wire        s_frame_received;
   wire        s_load_received;
   wire [15:0] s_data_received;

   // == DATA Collector Signals ==
   wire [`C_DATA_COLLECTOR_DATA_WIDTH - 1:0] s_data_collector [`C_NB_DATA_COLLECTOR - 1:0];
   
   
   
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
   

    check_level_intf #( .CHECK_SIZE  (`C_CHECK_ALIAS_NB),
		        .CHECK_WIDTH (`C_CHECK_WIDTH)
    )
    s_check_level_if();

   data_collector_intf #(
			 .G_NB_COLLECTOR (`C_NB_DATA_COLLECTOR),
			 .G_DATA_WIDTH   (`C_DATA_COLLECTOR_DATA_WIDTH)
			 )
   s_data_collector_if();
   
   

   // =====================================================

   // == TESTBENCH SIGNALS AFFECTATION ==

   // SET WAIT EVENT SIGNALS
   assign s_wait_event_if.wait_signals[0] = rst_n;
   assign s_wait_event_if.wait_signals[1] = clk;
   assign s_wait_event_if.wait_signals[2] = s_max7219_load;
   assign s_wait_event_if.wait_signals[3] = s_max7219_clk;
   assign s_wait_event_if.wait_signals[4] = s_done;
   assign s_wait_event_if.wait_signals[5] = s_frame_received;  
   assign s_wait_event_if.wait_signals[6] = s_load_received;   


   // SET SET_INJECTOR SIGNALS
   assign s_start   = s_set_injector_if.set_signals_synch[0];
   assign s_en_load = s_set_injector_if.set_signals_synch[1];
   assign s_data    = s_set_injector_if.set_signals_synch[2];
      
   // SET SET_INJECTOR INITIAL VALUES
   assign s_set_injector_if.set_signals_asynch_init_value[0]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[1]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[2]  = 0;

   // SET CHECK_SIGNALS
   assign s_check_level_if.check_signals[0] =  s_max7219_load;   
   assign s_check_level_if.check_signals[1] =  s_max7219_data;   
   assign s_check_level_if.check_signals[2] =  s_max7219_clk;
   assign s_check_level_if.check_signals[3] =  s_done;
   assign s_check_level_if.check_signals[4] =  s_data_received;
   // =====================================================


   
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
   
   
   // ===========================

   // == DATA Collector INST ==
   wire clk_data_collector   [`C_NB_DATA_COLLECTOR - 1:0];
   wire rst_n_data_collector [`C_NB_DATA_COLLECTOR - 1:0];
   
   data_collector #(
		    .G_NB_COLLECTOR (`C_NB_DATA_COLLECTOR),
		    .G_DATA_WIDTH   (`C_DATA_COLLECTOR_DATA_WIDTH)
		    )
   i_data_collector_0 (
		       .clk                  (clk_data_collector),
		       .rst_n                (rst_n_data_collector),
		       .i_data               (s_data_collector),
		       .data_collector_if    (s_data_collector_if)
		       );

   
   assign clk_data_collector[0]   = clk;
   assign rst_n_data_collector[0] = rst_n;   
   assign s_data_collector[0]     = {s_start, s_en_load, s_data}; // Collect input Data Without Clock and Reset
   // =========================   



   // == TESTBENCH SEQUENCER ==
   
   // CREATE CLASS - Configure Parameters
   static tb_class #( 
		      .G_SET_SIZE        (`C_SET_SIZE),
                      .G_SET_WIDTH       (`C_SET_WIDTH),
                      .G_WAIT_SIZE       (`C_WAIT_ALIAS_NB),
                      .G_WAIT_WIDTH      (`C_WAIT_WIDTH), 
                      .G_CLK_PERIOD      (`C_TB_CLK_PERIOD),
                      .G_CHECK_SIZE      (`C_CHECK_SIZE),
                      .G_CHECK_WIDTH     (`C_CHECK_WIDTH),
		      
		      .G_NB_COLLECTOR          (`C_NB_DATA_COLLECTOR),
		      .G_DATA_COLLECTOR_WIDTH  (`C_DATA_COLLECTOR_DATA_WIDTH)
		      )
   tb_class_inst = new (s_wait_event_if, 
                        s_set_injector_if, 
                        s_wait_duration_if,
                        s_check_level_if/*,
			tb_modules_custom_class_inst*/
			);
   
   
   initial begin// : TB_SEQUENCER

      // == INIT Testbench ALIASES ==
      tb_class_inst.tb_modules_custom_inst.tb_set_injector_inst.ADD_SET_INJECTOR_ALIAS("I_START",   0);
      tb_class_inst.tb_modules_custom_inst.tb_set_injector_inst.ADD_SET_INJECTOR_ALIAS("I_EN_LOAD", 1);
      tb_class_inst.tb_modules_custom_inst.tb_set_injector_inst.ADD_SET_INJECTOR_ALIAS("I_DATA",    2);

      tb_class_inst.tb_modules_custom_inst.tb_wait_event_inst.ADD_WAIT_EVENT_ALIAS("RST_N",            0);
      tb_class_inst.tb_modules_custom_inst.tb_wait_event_inst.ADD_WAIT_EVENT_ALIAS("CLK",              1);
      tb_class_inst.tb_modules_custom_inst.tb_wait_event_inst.ADD_WAIT_EVENT_ALIAS("O_MAX7219_LOAD",   2);
      tb_class_inst.tb_modules_custom_inst.tb_wait_event_inst.ADD_WAIT_EVENT_ALIAS("O_MAX7219_CLK",    3);
      tb_class_inst.tb_modules_custom_inst.tb_wait_event_inst.ADD_WAIT_EVENT_ALIAS("O_DONE",           4);
      tb_class_inst.tb_modules_custom_inst.tb_wait_event_inst.ADD_WAIT_EVENT_ALIAS("S_FRAME_RECEIVED", 5);
      tb_class_inst.tb_modules_custom_inst.tb_wait_event_inst.ADD_WAIT_EVENT_ALIAS("S_LOAD_RECEIVED",  6);
      
      tb_class_inst.tb_modules_custom_inst.tb_check_level_inst.ADD_CHECK_LEVEL_ALIAS("O_MAX7219_LOAD",  0);
      tb_class_inst.tb_modules_custom_inst.tb_check_level_inst.ADD_CHECK_LEVEL_ALIAS("O_MAX7219_DATA",  1);
      tb_class_inst.tb_modules_custom_inst.tb_check_level_inst.ADD_CHECK_LEVEL_ALIAS("O_MAX7219_CLK",   2);
      tb_class_inst.tb_modules_custom_inst.tb_check_level_inst.ADD_CHECK_LEVEL_ALIAS("O_DONE",          3);
      tb_class_inst.tb_modules_custom_inst.tb_check_level_inst.ADD_CHECK_LEVEL_ALIAS("S_DATA_RECEIVED", 4);

      // == INIT DATA COLLECTOR MODULE ==
      tb_class_inst.tb_modules_custom_inst.init_data_collector_custom_class(s_data_collector_if, "MAX7219_IF_INPUT_COLLECTOR_0");
      
      
      tb_class_inst.tb_sequencer(SCN_FILE_PATH);
      
   end// : TB_SEQUENCER
   
   // ========================


   // == MAX7219 SPI Checker ==
   max7219_spi_checker max7219_spi_checker_0 (
					      .clk    (clk),
					      .rst_n  (rst_n),

					      .i_max7219_clk   (s_max7219_clk),
					      .i_max7219_din   (s_max7219_data),
					      .i_max7219_load  (s_max7219_load),

					      .o_frame_received  (s_frame_received),
					      .o_load_received   (s_load_received),
					      .o_data_received   (s_data_received)
					      );
 


   // == DUT INST ==
   max7219_if #(
		.G_MAX_HALF_PERIOD (`C_MAX_HALF_PERIOD),
		.G_LOAD_DURATION   (`C_LOAD_DURATION)
   )
   i_dut (
	  .clk    (clk),
	  .rst_n  (rst_n),
	  
	  .i_start    (s_start),
	  .i_en_load  (s_en_load),
	  .i_data     (s_data),

	  .o_max7219_load  (s_max7219_load),
	  .o_max7219_data  (s_max7219_data),
	  .o_max7219_clk   (s_max7219_clk),
	  
	  .o_done (s_done)
   );   
   // ==============
      
endmodule // tb_top
