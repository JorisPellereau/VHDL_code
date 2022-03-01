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

`include "/home/linux-jp/Documents/GitHub/VHDL_code/MAX7219/tb_sources/tb_lib_max7219_controller/testbench_setup.sv"
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
   wire        s_static_dyn;
   wire        s_new_display;

   wire        s_display_test;
   wire [7:0]  s_decod_mode;
   wire [7:0]  s_intensity;
   wire [7:0]  s_scan_limit;
   wire [7:0]  s_shutdown;
   wire        s_new_config_val;
   wire        s_config_done;   
   
   wire        s_me_static;
   wire        s_we_static;
   wire [7:0]  s_addr_static;
   wire [15:0] s_wdata_static;
   wire [15:0] s_rdata_static;

   wire        s_me_scroller;
   wire        s_we_scroller;
   wire [7:0]  s_addr_scroller;
   wire [7:0]  s_wdata_scroller;
   wire [7:0]  s_rdata_scroller;

   wire        s_en_static;   
   wire [7:0]  s_start_ptr_static;
   wire [7:0]  s_last_ptr_static;
   wire        s_ptr_val_static;
   wire        s_loop_static;
   wire        s_ptr_equality_static;
   wire        s_static_busy;
   
   wire [7:0]  s_ram_start_ptr_scroller;
   wire [7:0]  s_msg_length_scroller;
   wire        s_start_scroll;
   wire [31:0] s_max_tempo_cnt_scroller;
   wire        s_scroller_busy;   
      
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
   assign s_wait_event_if.wait_signals[2] = s_config_done;
   assign s_wait_event_if.wait_signals[3] = s_max7219_load;
   assign s_wait_event_if.wait_signals[4] = s_ptr_equality_static;
   assign s_wait_event_if.wait_signals[5] = s_static_busy;
   assign s_wait_event_if.wait_signals[6] = s_scroller_busy;
   assign s_wait_event_if.wait_signals[7] = i_dut.s_discard_static;
   assign s_wait_event_if.wait_signals[8] = s_frame_received;
   assign s_wait_event_if.wait_signals[9] = s_load_received;
   

   
   

   // MUX : Sel from SET inj or to LOAD output of MAX7219 checker
   

   // MUX : Sel SET inj or checker
   /*assign s_set_injector_if.set_alias[11]  = "LOAD_RAM_SEL";

   // RAM LOAD Injector Control signals
   assign s_set_injector_if.set_alias[12]  = "START_ADDR_LOAD_RAM";
   assign s_set_injector_if.set_alias[13]  = "STOP_ADDR_LOAD_RAM";
   assign s_set_injector_if.set_alias[14]  = "START_LOAD_RAM";
   assign s_set_injector_if.set_alias[15]  = "SEL_PATTERN_LOAD_RAM";*/
   
   
   // SET SET_INJECTOR SIGNALS
   assign s_static_dyn                    = s_set_injector_if.set_signals_synch[0];
   assign s_new_display                   = s_set_injector_if.set_signals_synch[1];
   assign s_new_config_val                = s_set_injector_if.set_signals_synch[2];
   assign s_static_en                     = s_set_injector_if.set_signals_synch[3];
   assign s_me_static                     = s_set_injector_if.set_signals_synch[4];
   assign s_we_static                     = s_set_injector_if.set_signals_synch[5];
   assign s_addr_static                   = s_set_injector_if.set_signals_synch[6];
   assign s_wdata_static                  = s_set_injector_if.set_signals_synch[7];   
   assign s_start_ptr_static              = s_set_injector_if.set_signals_synch[8];
   assign s_last_ptr_static               = s_set_injector_if.set_signals_synch[9];
   //assign s_ptr_val_static                = s_set_injector_if.set_signals_synch[10];
   assign s_loop_static                   = s_set_injector_if.set_signals_synch[11];
   assign s_ram_start_ptr_scroller        = s_set_injector_if.set_signals_synch[12];
   assign s_msg_length_scroller           = s_set_injector_if.set_signals_synch[13];
   //assign s_start_scroll                  = s_set_injector_if.set_signals_synch[14];
   assign s_max_tempo_cnt_scroller        = s_set_injector_if.set_signals_synch[15];
   assign s_me_scroller                   = s_set_injector_if.set_signals_synch[16];
   assign s_we_scroller                   = s_set_injector_if.set_signals_synch[17];
   assign s_addr_scroller                 = s_set_injector_if.set_signals_synch[18];
   assign s_wdata_scroller                = s_set_injector_if.set_signals_synch[19];
   assign s_display_test                  = s_set_injector_if.set_signals_synch[20];
   assign s_decod_mode                    = s_set_injector_if.set_signals_synch[21];
   assign s_intensity                     = s_set_injector_if.set_signals_synch[22];
   assign s_scan_limit                    = s_set_injector_if.set_signals_synch[23];
   assign s_shutdown                      = s_set_injector_if.set_signals_synch[24];   
   assign s_display_screen_sel            = s_set_injector_if.set_signals_synch[25];
   assign s_display_screen_matrix         = s_set_injector_if.set_signals_synch[26];
   assign s_display_reg_matrix_n          = s_set_injector_if.set_signals_synch[27];

   // MAX : Sel SET inj or checker
   /*assign s_load_ram_sel          = s_set_injector_if.set_signals_synch[11];

   // RAM LOAD Injector Control signals
   assign s_ram_start_addr_load_ram = s_set_injector_if.set_signals_synch[12];
   assign s_ram_stop_ptr_load_ram   = s_set_injector_if.set_signals_synch[13];
   assign s_start_load_ram          = s_set_injector_if.set_signals_synch[14];
   assign s_sel_load_ram            = s_set_injector_if.set_signals_synch[15];*/
   
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
   assign s_set_injector_if.set_signals_asynch_init_value[16]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[17]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[18]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[19]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[20]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[21]  = 8'hAA;
   assign s_set_injector_if.set_signals_asynch_init_value[22]  = 8'hBB;
   assign s_set_injector_if.set_signals_asynch_init_value[23]  = 8'hCC;
   assign s_set_injector_if.set_signals_asynch_init_value[24]  = 8'hDD;
   assign s_set_injector_if.set_signals_asynch_init_value[25]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[26]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[27]  = 0;
         

   // SET CHECK_SIGNALS
   assign s_check_level_if.check_signals[0] =  s_config_done;
   assign s_check_level_if.check_signals[1] =  s_rdata_static;
   assign s_check_level_if.check_signals[3] =  s_ptr_equality_static;
   assign s_check_level_if.check_signals[4] =  s_static_busy;
   assign s_check_level_if.check_signals[5] =  s_rdata_scroller;
   assign s_check_level_if.check_signals[6] =  s_max7219_load;
   assign s_check_level_if.check_signals[7] =  s_max7219_data;
   assign s_check_level_if.check_signals[8] =  s_max7219_clk;
   assign s_check_level_if.check_signals[9] =  s_data_received;   

   // == DATA Collector INST ==
   wire clk_data_collector   [`C_NB_DATA_COLLECTOR - 1:0];
   wire rst_n_data_collector [`C_NB_DATA_COLLECTOR - 1:0];
   
   assign clk_data_collector[0]   = clk;
   assign rst_n_data_collector[0] = rst_n;
   // 8 + 8 + 1 + 32 + 1 + 1 + 8 + 8 = 67
   assign s_data_collector[0] = {s_ram_start_ptr, s_msg_length, s_start_scroll, s_max_tempo_cnt,
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
		      .G_DATA_COLLECTOR_WIDTH  (`C_DATA_COLLECTOR_DATA_WIDTH))

   tb_class_inst = new (s_wait_event_if, 
                        s_set_injector_if, 
                        s_wait_duration_if,
                        s_check_level_if
			);
   
   
   initial begin// : TB_SEQUENCER

      // INIT WAIT EVENT ALIAS
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "RST_N",                 0);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "CLK",                   1);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "O_CONFIG_DONE",         2);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "O_MAX7219_LOAD",        3);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "O_PTR_EQUALITY_STATIC", 4);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "O_STATIC_BUSY",         5);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "O_SCROLLER_BUSY",       6);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "STATIC_DISCARD",        7);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "SPI_FRAME_RECEIVED",    8);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "SPI_LOAD_RECEIVED",     9);

      // INIT SET ALIAS
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_STATIC_DYN",       0);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_NEW_DISPLAY",      1);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_NEW_CONFIG_VAL",   2);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_EN_STATIC",        3);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_ME_STATIC",        4);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_WE_STATIC",        5);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_ADDR_STATIC",      6);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_WDATA_STATIC",     7);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_START_PTR_STATIC", 8);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_LAST_PTR_STATIC",  9);
      //assign s_set_injector_if.set_alias[10]  = "TOTO", );
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_LOOP_STATIC",            11);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_RAM_START_PTR_SCROLLER", 12);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_MSG_LENGTH_SCROLLER",    13);
      //tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_START_SCROLL", );   
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_MAX_TEMPO_CNT_SCROLLER", 15);   
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_ME_SCROLLER",            16);   
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_WE_SCROLLER",            17);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_ADDR_SCROLLER",          18);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_WDATA_SCROLLER",         19);
      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_DISPLAY_TEST", 20);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_DECOD_MODE",   21);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_INTENSITY",    22);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_SCAN_LIMIT",   23);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "I_SHUTDOWN",     24);
      
      // MUX : Sel from SET inj or to LOAD output of MAX7219 checker
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "DISPLAY_SCREEN_SEL",    25);      
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "DISPLAY_SCREEN_MATRIX", 26);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "DISPLAY_REG_MATRIX_N",  27);
  
      // INIT CHECK LEVEL ALIAS
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_CONFIG_DONE",         0);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_RDATA_STATIC",        1);   
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_PTR_EQUALITY_STATIC", 2);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_STATIC_BUSY",         3);      
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_SCROLLER_BUSY",       4);   
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_RDATA_SCROLLER",      5);      
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_MAX7219_LOAD",        6);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_MAX7219_DATA",        7);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_MAX7219_CLK",         8);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "SPI_DATA",              9);
      
      // == INIT DATA COLLECTOR MODULE ==
      tb_class_inst.tb_modules_custom_inst.init_data_collector_custom_class(s_data_collector_if, "MAX7219_CONTROLLER_INPUT_COLLECTOR_0");
		      
      tb_class_inst.tb_sequencer(SCN_FILE_PATH);
      
   end// : TB_SEQUENCER
   
   // ========================




   // == MAX7219 MATRIX EMUL ==
   max7219_checker_wrapper #(
                         .G_NB_MATRIX  (8)
    )
    i_max7219_checker_wrapper_0
    (
                          .clk    (clk),
                          .rst_n  (rst_n),
     
                          .i_max7219_clk   (s_max7219_clk),
                          .i_max7219_din   (s_max7219_data),
                          .i_max7219_load  (s_max7219_load),
     
                          .i_display_reg_matrix_n   (s_display_reg_matrix_n),
                          .i_display_screen_matrix  (s_display_screen_matrix_checker)
     
    );
   // =========================
   

   assign s_display_screen_matrix_checker = (s_display_screen_sel == 0) ? s_display_screen_matrix : s_max7219_load;


   // == DUT INST ==
   max7219_display_controller #(
    .G_MATRIX_NB (8), 
   
    .G_MAX_HALF_PERIOD (2*25),//4),
    .G_LOAD_DURATION   (4), //4),

    .G_RAM_ADDR_WIDTH_STATIC  (8),
    .G_RAM_DATA_WIDTH_STATIC  (16),
    .G_DECOD_MAX_CNT_32B      (32'h02FAF080),

    .G_RAM_ADDR_WIDTH_SCROLLER (8),
    .G_RAM_DATA_WIDTH_SCROLLER (8)
  )
 i_dut (
    .clk   (clk),
    .rst_n (rst_n),
   
    .i_static_dyn   (s_static_dyn),
    .i_new_display  (s_new_display),
   
    .i_display_test    (s_display_test),
    .i_decod_mode      (s_decod_mode),
    .i_intensity       (s_intensity),
    .i_scan_limit      (s_scan_limit),
    .i_shutdown        (s_shutdown),
    .i_new_config_val  (s_new_config_val),
    .o_config_done     (s_config_done),
 
    .i_en_static (s_static_en),

    .i_me_static     (s_me_static),
    .i_we_static     (s_we_static),
    .i_addr_static   (s_addr_static),
    .i_wdata_static  (s_wdata_static),
    .o_rdata_static  (s_rdata_static),
   
    .i_start_ptr_static      (s_start_ptr_static),
    .i_last_ptr_static       (s_last_ptr_static),
    //.i_ptr_val_static        (s_ptr_val_static),  // TO RM
    .i_loop_static           (s_loop_static),
    .o_ptr_equality_static   (s_ptr_equality_static),
    .o_static_busy           (s_static_busy),

    .i_ram_start_ptr_scroller  (s_ram_start_ptr_scroller),
    .i_msg_length_scroller     (s_msg_length_scroller),
    //.i_start_scroll            (s_start_scroll),
    .i_max_tempo_cnt_scroller  (s_max_tempo_cnt_scroller),
    .o_scroller_busy           (s_scroller_busy),

    .i_me_scroller    (s_me_scroller),
    .i_we_scroller    (s_we_scroller),
    .i_addr_scroller  (s_addr_scroller),
    .i_wdata_scroller (s_wdata_scroller),
    .o_rdata_scroller (s_rdata_scroller),
    
    .o_max7219_load (s_max7219_load),
    .o_max7219_data (s_max7219_data),
    .o_max7219_clk  (s_max7219_clk)

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
