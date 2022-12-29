//                              -*- Mode: Verilog -*-
// Filename        : tb_top.sv
// Description     : Unit Testbench of LCD CFAH Interface
// Author          : Linux-JP
// Created On      : Sat Nov 19 21:50:55 2022
// Last Modified By: Linux-JP
// Last Modified On: Sat Nov 19 21:50:55 2022
// Update Count    : 0
// Status          : Unknown, Use with caution!

/*
 *  Testbench TOP for test of LCD ITF unit block
 * 
 */ 

`timescale 1ps/1ps


`include "/home/linux-jp/Documents/GitHub/VHDL_code/LCD/LCD_CFAH1602BTMCJP/tb_sources/tb_lib_unit_lcd_cfah_top/testbench_setup.sv"
`include "/home/linux-jp/Documents/GitHub/Verilog/Testbench/sources/lib_tb_sequencer/tb_tasks.sv"


// TB TOP
module tb_top
  #(
    parameter SCN_FILE_PATH = "scenario.txt"
   )
   ();
   
   
   // == INTERNAL SIGNALS ==   
   wire clk;
   wire rst_n;
    
   // Signals to DUT
   logic [7:0] s_lcd_data;
   logic       s_rs;
   logic       s_rw;
   logic       s_start;

   wire [7:0]  s_lcd_wdata;
   wire [7:0]  s_lcd_rdata;
   wire        s_lcd_rw;
   wire        s_lcd_en;
   wire        s_lcd_rs;
   wire        s_bidir_sel;
   wire        s_done;
   
   wire [7:0]   io_data;

   logic [7:0]  s_wdata_emul;
   logic [7:0] 	s_rdata_emul;
   logic 	s_rdata_val_emul;
   logic [7:0] 	s_busy_flag_duration;
   logic 	s_wdata_sel;
   
   
   logic [2:0] 	s_dl_n_f;
   logic [2:0] 	s_dcb;
   
   logic 	s_lcd_on_off;
   
   wire [7:0] 	s_char_wdata;
   wire 	s_char_wdata_val;
   wire [3:0]	s_char_position;
   wire 	s_line_sel;

   wire [2:0] 	s_cgram_addr;
   wire [7:0]	s_cgram_data;
   wire 	s_cgram_val;

   wire 	s_start_init;
   wire 	s_display_ctrl_cmd;
   wire 	s_clear_display;

   wire 	s_update_lcd;
   wire 	s_lcd_all_char;
   wire 	s_lcd_line_sel;
   wire [3:0] 	s_lcd_char_position;

   wire 	s_control_done;   
   
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
   

   check_level_intf #( .CHECK_SIZE   (`C_CHECK_ALIAS_NB),
		       .CHECK_WIDTH  (`C_CHECK_WIDTH)
		       )
   s_check_level_if();
   
   data_collector_intf #(
			 .G_NB_COLLECTOR (`C_NB_DATA_COLLECTOR),
			 .G_DATA_WIDTH   (`C_DATA_COLLECTOR_DATA_WIDTH)
			 )
   s_data_collector_if();
   


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
   assign s_wait_event_if.wait_signals[2] = s_control_done;
   assign s_wait_event_if.wait_signals[3] = s_rdata_val_emul;   
   
   // SET SET_INJECTOR SIGNALS
   assign s_lcd_on_off         = s_set_injector_if.set_signals_synch[0];
   assign s_dl_n_f             = s_set_injector_if.set_signals_synch[1];
   assign s_dcb                = s_set_injector_if.set_signals_synch[2];
   assign s_start_init         = s_set_injector_if.set_signals_synch[3];
   assign s_display_ctrl_cmd   = s_set_injector_if.set_signals_synch[4];
   assign s_clear_display      = s_set_injector_if.set_signals_synch[5];
   assign s_update_lcd         = s_set_injector_if.set_signals_synch[6];
   assign s_lcd_all_char       = s_set_injector_if.set_signals_synch[7];
   assign s_lcd_line_sel       = s_set_injector_if.set_signals_synch[8];
   assign s_lcd_char_position  = s_set_injector_if.set_signals_synch[9];
   assign s_char_wdata         = s_set_injector_if.set_signals_synch[10];
   assign s_char_wdata_val     = s_set_injector_if.set_signals_synch[11];
   assign s_char_position      = s_set_injector_if.set_signals_synch[12];
   assign s_line_sel           = s_set_injector_if.set_signals_synch[13];
   assign s_cgram_addr         = s_set_injector_if.set_signals_synch[14];
   assign s_cgram_data         = s_set_injector_if.set_signals_synch[15];
   assign s_cgram_val          = s_set_injector_if.set_signals_synch[16];
   assign s_busy_flag_duration = s_set_injector_if.set_signals_synch[17];
   assign s_wdata_sel          = s_set_injector_if.set_signals_synch[18];
   
   // SET SET_INJECTOR INITIAL VALUES
   genvar i;
   generate
      for(i = 0 ; i < `C_SET_ALIAS_NB ; i++) begin
	 assign s_set_injector_if.set_signals_asynch_init_value[i]  = 0;
      end
   endgenerate
   
      
   
   
   // SET CHECK_SIGNALS
   assign s_check_level_if.check_signals[0] = s_lcd_wdata;
   assign s_check_level_if.check_signals[1] = s_lcd_rdata;   
   assign s_check_level_if.check_signals[2] = s_lcd_rw;
   assign s_check_level_if.check_signals[3] = s_lcd_en;
   assign s_check_level_if.check_signals[4] = s_lcd_rs;
   assign s_check_level_if.check_signals[5] = s_bidir_sel;   
   assign s_check_level_if.check_signals[6] = s_control_done;
  
   // =====================================================

   wire clk_data_collector   [`C_NB_DATA_COLLECTOR - 1:0];
   wire rst_n_data_collector [`C_NB_DATA_COLLECTOR - 1:0];
   
   assign clk_data_collector[0]   = clk;
   assign rst_n_data_collector[0] = rst_n;
   
   

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

   // == HDL SPEFICIC TESTBENCH MODULES ==

  
   // =============================
   


   // CREATE Handle and object CLASS - Configure Parameters
   static tb_class #( .G_SET_SIZE        (`C_SET_SIZE),
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
			s_check_level_if);
   

   initial begin// : TB_SEQUENCER
    
      // Add Alias of Generic TB Modules
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_LCD_ON",            0);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_DL_N_F",            1);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_DCB",               2);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_START_INIT",        3);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_DISPLAY_CTRL_CMD",  4);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_CLEAR_DISPLAY",     5);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_UPDATE_LCD",        6);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_LCD_ALL_CHAR",      7);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_LCD_LINE_SEL",      8);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_LCD_CHAR_POSITION", 9);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_CHAR_WDATA",        10);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_CHAR_WDATA_VAL",    11);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_CHAR_POSITION",     12);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_LINE_SEL",          13);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_CGRAM_ADDR",        14);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_CGRAM_DATA",        15);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_CGRAM_VAL",         16);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "S_BUSY_FLAG_DURATION",17);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "S_WDATA_SEL",         18);
      
      // WAIT Event Alias
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "RST_N",            0);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "CLK",              1);      
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "O_CONTROL_DONE",   2);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "O_RDATA_VAL_EMUL", 3);

      // Check Level Alias
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_LCD_WDATA",    0);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_LCD_RDATA",    1);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_LCD_RW",       2);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_LCD_EN",       3);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_LCD_RS",       4);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_BIDIR_SEL",    5);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_CONTROL_DONE", 6);
	
      // INIT DATA COLLECTOR MODULE
      tb_class_inst.tb_modules_custom_inst.init_data_collector_custom_class(s_data_collector_if, "LCD_CFAH_ITF_INPUT_COLLECTOR_0");
                  
      // RUN Testbench Sequencer
      tb_class_inst.tb_sequencer(SCN_FILE_PATH);
      
   end// : TB_SEQUENCER
   
   // ========================

   // == DUT ==
   lcd_cfah_top # (
		   .G_CLK_PERIOD_NS      (20),    
		   .G_BIDIR_SEL_POLARITY (4'd2)
		   )
   i_dut (
	  .clk   (clk),
	  .rst_n (rst_n),
	      
	  .i_char_wdata      (s_char_wdata),  
	  .i_char_wdata_val  (s_char_wdata_val),
	  .i_char_position   (s_char_position),
	  .i_line_sel        (s_line_sel),

	  /*.i_cgram_addr  (s_cgram_addr),
	  .i_cgram_data  (s_cgram_data),
	  .i_cgram_val   (s_cgram_val),*/
	  
	  .i_start_init         (s_start_init),    
	  .i_display_ctrl_cmd   (s_display_ctrl_cmd),
	  .i_clear_display_cmd  (s_clear_display),
	  
	  .i_update_lcd         (s_update_lcd),
	  .i_lcd_all_char       (s_lcd_all_char),
	  .i_lcd_line_sel       (s_lcd_line_sel),
	  .i_lcd_char_position  (s_lcd_char_position),

	  .o_control_done (s_control_done),
	  	  
	  .i_lcd_on (s_lcd_on_off),
	  .i_dl_n_f (s_dl_n_f),
	  .i_dcb    (s_dcb),

	  .i_lcd_data  (s_lcd_data),
	  .o_lcd_wdata (s_lcd_wdata),
	  .o_lcd_rw    (s_lcd_rw),
	  .o_lcd_en    (s_lcd_en),
	  .o_lcd_rs    (s_lcd_rs),
	  .o_lcd_on    (s_lcd_on),
	  .o_bidir_sel (s_bidir_sel)	  
	  );
   // ===============

   // IO dir assignment
   assign io_data    = s_bidir_sel ? s_lcd_wdata : 8'bz;
   assign s_lcd_data = io_data;

//   assign s_dl_n_f = 3'b111;
   

   // LCD EMULATOR-CHECKER
   LCD_CFAH_emul #(
		   .G_RECEIVED_CMD_BUFFER_SIZE (`C_LCD_BUFFER_SIZE)
		   )
   i_LCD_CFAH_emul (
		    .clk   (clk),
		    .rst_n (rst_n),
		    
		    // Physical Interface
		    .i_rs    (s_lcd_rs),
		    .i_rw    (s_lcd_rw),
		    .i_en    (s_lcd_en),
		    .io_data (io_data),
		    
		    // Check Interface
		    .i_busy_flag_duration  (s_busy_flag_duration),
		    .i_wdata               (s_wdata_emul), // Wdata for read operation
		    .i_wdata_sel           (s_wdata_sel),
		    .o_rdata               (s_rdata_emul), // Data received
		    .o_rdata_val           (s_rdata_val_emul)
		    );
   
   assign s_wdata_emul = 0;
   
   //assign s_busy_flag_duration = 4;
   
endmodule // tb_top
