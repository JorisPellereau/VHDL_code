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
 *  Testbench TOP for test of CRC 16 block
 * 
 */ 

`timescale 1ps/1ps


`include "/home/linux-jp/Documents/GitHub/VHDL_code/CRC/tb_sources/tb_lib_crc_16/testbench_setup.sv"
`include "/home/linux-jp/Documents/GitHub/Verilog/Testbench/sources/lib_tb_data_checker/data_checker.sv"
`include "/home/linux-jp/Documents/GitHub/Verilog/Testbench/sources/lib_tb_sequencer/tb_tasks.sv"
//`include "/home/linux-jp/Documents/GitHub/Verilog/Testbench/sources/lib_tb_utils/tb_utils_class.sv"

// TB TOP
module tb_top
  #(
    parameter SCN_FILE_PATH = "scenario.txt"
   )
   ();
   
   
   // == INTERNAL SIGNALS ==   
   wire clk;
   wire rst_n;

   // DATA Checker signals
   wire rst_n_checker [`C_NB_CHECKER - 1:0];
   wire clk_checker [`C_NB_CHECKER - 1:0];
   wire [`C_CHECKER_DATA_WIDTH - 1:0] s_checker_data [`C_NB_CHECKER - 1:0];
   wire s_checker_valid [`C_NB_CHECKER - 1:0];
   
    
   // Signals to DUT
   wire s_rst_crc;   
   wire s_val;   
   wire [7:0] s_data;
   wire [15:0] s_crc;
   
   
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

   // SET WAIT EVENT SIGNALS
   assign s_wait_event_if.wait_signals[0] = rst_n;
   assign s_wait_event_if.wait_signals[1] = clk;
         
   // SET SET_INJECTOR SIGNALS
   assign s_data    = s_set_injector_if.set_signals_synch[0];
   assign s_val     = s_set_injector_if.set_signals_synch[1];
   assign s_rst_crc = s_set_injector_if.set_signals_synch[2];
 
   // SET SET_INJECTOR INITIAL VALUES
   assign s_set_injector_if.set_signals_asynch_init_value[0]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[1]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[2]  = 0;
   
   // SET CHECK_SIGNALS
   assign s_check_level_if.check_signals[0] = s_crc;
   
   // =====================================================


   // == HDL SPEFICIC TESTBENCH MODULES ==
   data_checker #(
		  .G_NB_CHECKER         (`C_NB_CHECKER),
		  .G_CHECKER_DATA_WIDTH (`C_CHECKER_DATA_WIDTH)
		  )
   data_checker_crc_0 (
		       .clk          (clk_checker),
		       .rst_n        (rst_n_checker),

		       .i_data       (s_checker_data),
		       .i_data_valid (s_checker_valid)
		       
    );

   assign clk_checker[0]     = clk;
   assign rst_n_checker[0]   = rst_n;
   assign s_checker_data[0]  = s_crc;
   assign s_checker_valid[0] = 0;
   // =============================

   //tb_utils_class utils = new();
   
   


   // CREATE Handle and object CLASS - Configure Parameters
   static tb_class #( .G_SET_SIZE        (`C_SET_SIZE),
                      .G_SET_WIDTH       (`C_SET_WIDTH),
                      .G_WAIT_SIZE       (`C_WAIT_ALIAS_NB),
                      .G_WAIT_WIDTH      (`C_WAIT_WIDTH), 
                      .G_CLK_PERIOD      (`C_TB_CLK_PERIOD),
                      .G_CHECK_SIZE      (`C_CHECK_SIZE),
                      .G_CHECK_WIDTH     (`C_CHECK_WIDTH),
		      .G_NB_CHECKER         (`C_NB_CHECKER),
		      .G_DATA_CHECKER_WIDTH (`C_CHECKER_DATA_WIDTH
)		      
		      )
   
   tb_class_inst = new (s_wait_event_if, 
			s_set_injector_if, 
			s_wait_duration_if,
			s_check_level_if);
   
   args_t args;
   initial begin// : TB_SEQUENCER
    
      // Add Alias of Generic TB Modules
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_DATA",    0);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_VAL",     1);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_RST_CRC", 2);
             
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "RST_N",       0);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "CLK",         1);      
     
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_CRC",      0);

//      $system("date");
      
      tb_class_inst.tb_modules_custom_inst.init_data_checker_custom_class(data_checker_crc_0.data_checker_if, "CRC_CHECKER");
      
      // args = utils.str_2_args("TOTO0 TOTO1 1 2 3 888");
      // $display("args : %p", args);
      // $finish();
      
      // RUN Testbench Sequencer
      tb_class_inst.tb_sequencer(SCN_FILE_PATH);
      
   end// : TB_SEQUENCER
   
   // ========================


   // == DUT ==   
   crc_16_ccit # (
		  .G_CRC_INIT (16'hFFFF)
		  )
   i_dut (
	  .clk    (clk),
	  .rst_n  (rst_n),

	  .i_rst_crc (s_rst_crc),
	  .i_val     (s_val),
	  .i_data    (s_data),
	  .o_crc     (s_crc)
	  );   
   // ===============



   
endmodule // tb_top
