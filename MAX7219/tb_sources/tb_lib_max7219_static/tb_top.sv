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


`include "/home/linux-jp/Documents/GitHub/VHDL_code/MAX7219/tb_sources/tb_lib_max7219_static/testbench_setup.sv"
`include "/home/linux-jp/Documents/GitHub/Verilog/Testbench/sources/lib_tb_sequencer/tb_tasks.sv"
// `include "/home/jorisp/GitHub/Verilog/lib_testbench/wait_event_wrapper.sv"
// `include "/home/jorisp/GitHub/Verilog/lib_testbench/set_injector_wrapper.sv"
// `include "/home/jorisp/GitHub/Verilog/lib_testbench/wait_duration_wrapper.sv"
// `include "/home/jorisp/GitHub/Verilog/lib_testbench/check_level_wrapper.sv"
// `include "/home/jorisp/GitHub/Verilog/lib_testbench/tb_tasks.sv"


// TB TOP
module tb_top
  #(
    parameter SCN_FILE_PATH = "scenario.txt"
   )
   ();
   

   
   // == INTERNAL SIGNALS ==
   
   wire clk;
   wire rst_n;

   wire s_en;
   wire s_me;
   wire s_we;
   wire [7:0] s_addr;
   wire [15:0] s_wdata;
   wire [15:0] s_rdata;
   wire [7:0]  s_start_ptr;   
   wire [7:0]  s_last_ptr;
   
   wire      s_ptr_val;
   wire      s_loop;
   wire      s_ptr_equality;
   wire      s_discard;   
   
   wire      s_max7219_if_done;
   wire      s_max7219_if_start;
   wire      s_max7219_if_en_load;
   wire [15:0] s_max7219_if_data;
   
   wire        s_max7219_load;
   wire        s_max7219_data;
   wire        s_max7219_clk;
   

   wire [7:0]  s_display_reg_matrix_n;
   wire        s_sel;
   wire        s_display_screen_matrix_tb;
   wire        s_display_screen_matrix;

   // == SPI Checker Signals ==
   wire        s_frame_received;
   wire        s_load_received;
   wire [15:0] s_data_received;
   
   
  

   
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
   

    check_level_intf #( .CHECK_SIZE  (),
		        .CHECK_WIDTH  ()
    )
    s_check_level_if();
   
   data_collector_intf #(
			 .G_NB_COLLECTOR (`C_NB_DATA_COLLECTOR),
			 .G_DATA_WIDTH   (`C_DATA_COLLECTOR_DATA_WIDTH)
			 )
   s_data_collector_if();
   // =====================================================

   // == TESTBENCH MODULES ALIASES & SIGNALS AFFECTATION ==

   // SET WAIT EVENT SIGNALS
   assign s_wait_event_if.wait_signals[0] = rst_n;
   assign s_wait_event_if.wait_signals[1] = clk;
   assign s_wait_event_if.wait_signals[2] = s_ptr_equality;
   assign s_wait_event_if.wait_signals[3] = s_discard;
   assign s_wait_event_if.wait_signals[4] = s_frame_received;
   assign s_wait_event_if.wait_signals[5] = s_load_received;
   


   // SET SET_INJECTOR SIGNALS
   assign s_me        = s_set_injector_if.set_signals_synch[0];
   assign s_we        = s_set_injector_if.set_signals_synch[1];
   assign s_addr      = s_set_injector_if.set_signals_synch[2];
   assign s_wdata     = s_set_injector_if.set_signals_synch[3];
   assign s_start_ptr = s_set_injector_if.set_signals_synch[4];
   assign s_last_ptr  = s_set_injector_if.set_signals_synch[5];
   assign s_ptr_val   = s_set_injector_if.set_signals_synch[6];
   assign s_loop      = s_set_injector_if.set_signals_synch[7];
   assign s_en        = s_set_injector_if.set_signals_synch[8];
   
   assign s_display_reg_matrix_n     = s_set_injector_if.set_signals_synch[9];
   assign s_display_screen_matrix_tb = s_set_injector_if.set_signals_synch[10];
   assign s_sel                      = s_set_injector_if.set_signals_synch[11];
   
   
   // SET SET_INJECTOR INITIAL VALUES
   assign s_set_injector_if.set_signals_asynch_init_value[0]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[1]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[2]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[3]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[4]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[5]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[6]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[7]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[8]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[9]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[10] = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[11] = 0;
   
   // SET CHECK_SIGNALS
   assign s_check_level_if.check_signals[0] = s_data_received;

  
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


   // // == TESTBENCH SEQUENCER ==
   // tb_modules_custom_class tb_modules_custom_class_inst = new();
   
   
   // CREATE CLASS - Configure Parameters
   static tb_class #( 
		      .G_SET_SIZE     (`C_SET_SIZE),
                      .G_SET_WIDTH    (`C_SET_WIDTH),
                      .G_WAIT_SIZE    (`C_WAIT_ALIAS_NB),
                      .G_WAIT_WIDTH   (`C_WAIT_WIDTH), 
                      .G_CLK_PERIOD   (`C_TB_CLK_PERIOD),
                      .G_CHECK_SIZE   (`C_CHECK_SIZE),
                      .G_CHECK_WIDTH  (`C_CHECK_WIDTH),
		      
		      .G_NB_COLLECTOR          (`C_NB_DATA_COLLECTOR),
		      .G_DATA_COLLECTOR_WIDTH  (`C_DATA_COLLECTOR_DATA_WIDTH)
		      )
   tb_class_inst = new (s_wait_event_if, 
                        s_set_injector_if, 
                        s_wait_duration_if,
                        s_check_level_if
			);
   
   
   initial begin// : TB_SEQUENCER

      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "ME",                     0);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "WE",                     1);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "ADDR",                   2);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "WDATA",                  3);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "START_PTR",              4);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "LAST_PTR",               5);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "PTR_VAL",                6);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "LOOP",                   7);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "EN",                     8);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "DISPLAY_REG_MATRIX_N",   9);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "DISPLAY_SCREEN_MATRIX",  10);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "SEL",                    11);
      

      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "RST_N",              0);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "CLK",                1);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "PTR_EQUALITY",       2);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "O_DISCARD",          3);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "SPI_FRAME_RECEIVED", 4);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "SPI_LOAD_RECEIVED",  5);

      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "SPI_DATA",  0);
      // == INIT DATA COLLECTOR MODULE ==
      tb_class_inst.tb_modules_custom_inst.init_data_collector_custom_class(s_data_collector_if, "MAX7219_STATIC_INPUT_COLLECTOR_0");
      
      
      tb_class_inst.tb_sequencer(SCN_FILE_PATH);
      
   end// : TB_SEQUENCER
   
   // ========================


   

   // == MAX7219 IF INST ==
   max7219_if #(
		.G_MAX_HALF_PERIOD (4),
		.G_LOAD_DURATION   (4)
   )
   i_max7219_if_0 (
		   .clk    (clk),
		   .rst_n  (rst_n),

		   .i_start    (s_max7219_if_start),
		   .i_en_load  (s_max7219_if_en_load),
		   .i_data     (s_max7219_if_data),

		   .o_max7219_load  (s_max7219_load),
		   .o_max7219_data  (s_max7219_data),
		   .o_max7219_clk   (s_max7219_clk),
		   .o_done          (s_max7219_if_done)
   );
   
   // =======================

   // == MAX7219 MATRIX EMUL ==
   max7219_checker_wrapper #(
                         .G_NB_MATRIX  (8)
    )
    i_max7219_checker_wrapper_0
    (
                          .clk  (clk),
                          .rst_n  (rst_n),
     
                          .i_max7219_clk   (s_max7219_clk),
                          .i_max7219_din   (s_max7219_data),
                          .i_max7219_load  (s_max7219_load),
     
                          .i_display_reg_matrix_n   (s_display_reg_matrix_n),
                          .i_display_screen_matrix  (s_display_screen_matrix)
     
    );
   // =========================
   

   assign s_display_screen_matrix = (s_sel == 0) ? s_display_screen_matrix_tb : s_max7219_if_en_load; // Mux for selection
   

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
   max7219_cmd_decod #(
		       .G_RAM_ADDR_WIDTH     (8),
		       .G_RAM_DATA_WIDTH     (16),
		       .G_DECOD_MAX_CNT_32B  (100)
   )
   i_dut (
	  .clk   (clk),
	  .rst_n (rst_n),
	  .i_en  (s_en),

	  .i_me     (s_me),
	  .i_we     (s_we),
	  .i_addr   (s_addr),
	  .i_wdata  (s_wdata),
	  .o_rdata  (s_rdata),

	  .i_start_ptr     (s_start_ptr),
	  .i_last_ptr      (s_last_ptr),
	  .i_ptr_val       (s_ptr_val),
	  .i_loop          (s_loop),
	  .o_ptr_equality  (s_ptr_equality),
	  .o_discard       (s_discard),

	  .i_max7219_if_done    (s_max7219_if_done),
	  .o_max7219_if_start   (s_max7219_if_start),
	  .o_max7219_if_en_load (s_max7219_if_en_load),
	  .o_max7219_if_data    (s_max7219_if_data)
   );
   
   // ==============

   
endmodule // tb_top
