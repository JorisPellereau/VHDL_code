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
 *  Testbench TOP for test of MAX7219 SCROLLER Block
 * 
 */ 

`timescale 1ps/1ps

`include "/home/linux-jp/Documents/GitHub/VHDL_code/MAX7219/tb_sources/tb_lib_max7219_scroller/testbench_setup.sv"
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

   // Signals from SET Injector
   wire s_me;
   wire s_we;
   wire [7:0]  s_addr;
   wire [7:0]  s_wdata;
   wire [7:0]  s_rdata;

   // Signals to DUT
   wire s_me_dut;
   wire s_we_dut;
   wire [7:0]  s_addr_dut;
   wire [7:0]  s_wdata_dut;
   wire [7:0]  s_rdata_dut;

   // Signals from LOAD RAM Injector
   wire s_me_load_ram;
   wire s_we_load_ram;
   wire [7:0]  s_addr_load_ram;
   wire [7:0]  s_wdata_load_ram;
   wire [7:0]  s_rdata_load_ram;
   wire [7:0]  s_sel_load_ram;

   wire [7:0]  s_ram_start_addr_load_ram;
   wire [7:0]  s_ram_stop_ptr_load_ram;
   wire        s_start_load_ram;
   wire        s_done_load_ram;   
      
   
   wire [7:0]  s_ram_start_ptr;   
   wire [7:0]  s_msg_length;
   wire [31:0] s_max_tempo_cnt;
   
   
   wire      s_start_scroll;
   wire      s_max7219_if_done;
   wire      s_max7219_if_start;
   wire      s_max7219_if_en_load;
   wire [15:0] s_max7219_if_data;
   
   wire        s_max7219_load;
   wire        s_max7219_data;
   wire        s_max7219_clk;

   wire        s_busy;
   
   

   wire [7:0]  s_display_reg_matrix_n;
   wire        s_display_screen_matrix_checker;
   wire        s_display_screen_matrix;
   wire        s_display_screen_sel;  

   wire        s_load_ram_sel; // 0 : Load via SET injector - 1 : Load via LOAD RAM Injector
    
   // == DATA Collector Signals ==
   wire [`C_DATA_COLLECTOR_DATA_WIDTH - 1:0] s_data_collector [`C_NB_DATA_COLLECTOR - 1:0];

   wire 				     s_frame_received;   
   wire 				     s_load_received;      
   wire [15:0] 				     s_data_received;
   


   
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
  
   // =====================================================

   // == TESTBENCH MODULES ALIASES & SIGNALS AFFECTATION ==

   

   // SET WAIT EVENT SIGNALS
   assign s_wait_event_if.wait_signals[0] = rst_n;
   assign s_wait_event_if.wait_signals[1] = clk;
   assign s_wait_event_if.wait_signals[2] = s_busy;
   assign s_wait_event_if.wait_signals[3] = s_max7219_load;
   assign s_wait_event_if.wait_signals[4] = s_done_load_ram;
   assign s_wait_event_if.wait_signals[5] = s_frame_received;   
   assign s_wait_event_if.wait_signals[6] = s_load_received; 
   

   
   
   
   // SET SET_INJECTOR SIGNALS
   assign s_me                    = s_set_injector_if.set_signals_synch[0];
   assign s_we                    = s_set_injector_if.set_signals_synch[1];
   assign s_addr                  = s_set_injector_if.set_signals_synch[2];
   assign s_wdata                 = s_set_injector_if.set_signals_synch[3];
   assign s_ram_start_ptr         = s_set_injector_if.set_signals_synch[4];
   assign s_msg_length            = s_set_injector_if.set_signals_synch[5];
   assign s_start_scroll          = s_set_injector_if.set_signals_synch[6];
   assign s_max_tempo_cnt         = s_set_injector_if.set_signals_synch[7];   
   assign s_display_reg_matrix_n  = s_set_injector_if.set_signals_synch[8];
   assign s_display_screen_matrix = s_set_injector_if.set_signals_synch[9];
   assign s_display_screen_sel    = s_set_injector_if.set_signals_synch[10];

   // MAX : Sel SET inj or checker
   assign s_load_ram_sel          = s_set_injector_if.set_signals_synch[11];

   // RAM LOAD Injector Control signals
   assign s_ram_start_addr_load_ram = s_set_injector_if.set_signals_synch[12];
   assign s_ram_stop_ptr_load_ram   = s_set_injector_if.set_signals_synch[13];
   assign s_start_load_ram          = s_set_injector_if.set_signals_synch[14];
   assign s_sel_load_ram            = s_set_injector_if.set_signals_synch[15];
   
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
   assign s_set_injector_if.set_signals_asynch_init_value[10]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[11]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[12]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[13]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[14]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[15]  = 0;
   
   
   

   // SET CHECK_SIGNALS
   assign s_check_level_if.check_signals[0] = s_busy;
   assign s_check_level_if.check_signals[1] = s_rdata_dut;   
   assign s_check_level_if.check_signals[2] = s_max7219_if_start;   
   assign s_check_level_if.check_signals[3] = s_max7219_if_en_load;   
   assign s_check_level_if.check_signals[4] = s_max7219_if_data;
   assign s_check_level_if.check_signals[5] = s_data_received;
   
   

   // == DATA Collector INST ==
   wire clk_data_collector   [`C_NB_DATA_COLLECTOR - 1:0];
   wire rst_n_data_collector [`C_NB_DATA_COLLECTOR - 1:0];
   
   assign clk_data_collector[0]   = clk;
   assign rst_n_data_collector[0] = rst_n;
   // 8 + 8 + 1 + 32 + 1 + 1 + 1 + 8 + 8 = 68
   assign s_data_collector[0] = {s_ram_start_ptr, s_msg_length, s_start_scroll, s_max_tempo_cnt, s_max7219_if_done,
				 s_me_dut, s_we_dut, s_addr_dut, s_wdata_dut};
   
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


   // == TESTBENCH SEQUENCER ==
 
   // CREATE CLASS - Configure Parameters
   static tb_class #( 
		      .G_SET_SIZE              (`C_SET_SIZE),
                      .G_SET_WIDTH             (`C_SET_WIDTH),
                      .G_WAIT_SIZE             (`C_WAIT_ALIAS_NB),
                      .G_WAIT_WIDTH            (`C_WAIT_WIDTH), 
                      .G_CLK_PERIOD            (`C_TB_CLK_PERIOD),
                      .G_CHECK_SIZE            (`C_CHECK_SIZE),
                      .G_CHECK_WIDTH           (`C_CHECK_WIDTH),		      
		      .G_NB_COLLECTOR          (`C_NB_DATA_COLLECTOR),
		      .G_DATA_COLLECTOR_WIDTH  (`C_DATA_COLLECTOR_DATA_WIDTH)
		      )
   tb_class_inst = new (s_wait_event_if, 
                        s_set_injector_if, 
                        s_wait_duration_if,
                        s_check_level_if
			);
   
   
   initial begin// : TB_SEQUENCER


      // INIT WAIT EVENT ALIAS
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "RST_N",              0);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "CLK",                1);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "BUSY",               2);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "MAX7219_LOAD",       3);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "DONE_LOAD_RAM",      4);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "SPI_FRAME_RECEIVED", 5);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "LOAD_RECEIVED",      6);

      // INIT SET ALIAS
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "ME",                    0);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "WE",                    1);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "ADDR",                  2);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "WDATA",                 3);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "RAM_START_PTR",         4);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "MSG_LENGTH",            5);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "START_SCROLL",          6);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "MAX_TEMPO_CNT",         7);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "DISPLAY_REG_MATRIX_N",  8);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "DISPLAY_SCREEN_MATRIX", 9);
      
      // MUX : Sel from SET inj or to LOAD output of MAX7219 checker
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "DISPLAY_SCREEN_SEL", 10);
      
      // MUX : Sel SET inj or checker
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "LOAD_RAM_SEL", 11);
      
      // RAM LOAD Injector Control signals
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "START_ADDR_LOAD_RAM",  12);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "STOP_ADDR_LOAD_RAM",   13);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "START_LOAD_RAM",       14);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "SEL_PATTERN_LOAD_RAM", 15);
      
      // INIT CHECK LEVEL ALIAS
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "BUSY",                 0);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_RDATA",              1);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_MAX7219_IF_START",   2);   
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_MAX7219_IF_EN_LOAD", 3);   
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_MAX7219_IF_DATA",    4);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "SPI_DATA",             5);

   

      // == INIT DATA COLLECTOR MODULE ==
      tb_class_inst.tb_modules_custom_inst.init_data_collector_custom_class(s_data_collector_if, "MAX7219_SCROLLER_INPUT_COLLECTOR_0");
      
      
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
                          .i_display_screen_matrix  (s_display_screen_matrix_checker)
     
    );
   // =========================
   

   assign s_display_screen_matrix_checker = (s_display_screen_sel == 0) ? s_display_screen_matrix : s_max7219_load;


   // RAM Load Injector
   /*load_ram_injector #(
		       .G_RAM_ADDR_WIDTH  (8),
		       .G_RAM_DATA_WIDTH  (8),
		       .G_SEL_WIDTH       (8)
		       )
   i_load_ram_injector_0 (
			  .clk    (clk),
			  .rst_n  (rst_n),

			  .i_ram_start_addr  (s_ram_start_addr_load_ram),
			  .i_ram_stop_addr   (s_ram_stop_ptr_load_ram),
			  .i_sel             (s_sel_load_ram),
			  .i_start           (s_start_load_ram),

			  .o_me     (s_me_load_ram),
			  .o_we     (s_we_load_ram),
			  .o_addr   (s_addr_load_ram),
			  .o_wdata  (s_wdata_load_ram),
			  .i_rdata  (s_rdata_load_ram),

			  .o_done (s_done_load_ram)
   );*/
   
   


   assign s_me_dut    = (s_load_ram_sel == 0) ? s_me    : s_me_load_ram;
   assign s_we_dut    = (s_load_ram_sel == 0) ? s_we    : s_we_load_ram;
   assign s_addr_dut  = (s_load_ram_sel == 0) ? s_addr  : s_addr_load_ram;
   assign s_wdata_dut = (s_load_ram_sel == 0) ? s_wdata : s_wdata_load_ram;
   assign s_rdata     = s_rdata_dut;
   

   // == DUT INST ==
   max7219_scroller_ctrl #(
		           .G_MATRIX_NB       (8),
		           .G_RAM_ADDR_WIDTH  (8),
		           .G_RAM_DATA_WIDTH  (8)
   )
   i_dut (
	  .clk   (clk),
	  .rst_n (rst_n),

	  .i_me     (s_me_dut),
	  .i_we     (s_we_dut),
	  .i_addr   (s_addr_dut),
	  .i_wdata  (s_wdata_dut),
	  .o_rdata  (s_rdata_dut),

	  .i_ram_start_ptr     (s_ram_start_ptr),
	  .i_msg_length        (s_msg_length),
	  .i_start_scroll      (s_start_scroll),
	  .i_max_tempo_cnt     (s_max_tempo_cnt),

	  .i_max7219_if_done    (s_max7219_if_done),
	  .o_max7219_if_start   (s_max7219_if_start),
	  .o_max7219_if_en_load (s_max7219_if_en_load),
	  .o_max7219_if_data    (s_max7219_if_data),

	  .o_busy               (s_busy)
   );
   
   // ==============


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


   
endmodule // tb_top
