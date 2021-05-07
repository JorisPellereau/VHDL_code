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
 *  Testbench TOP for test of UART DISPLAY CTRL block - interfaced with MAX_7219_CONTROLLER
 * 
 */ 

`timescale 1ps/1ps


`include "/home/jorisp/GitHub/VHDL_code/UART/tb_sources/tb_lib_uart_display_ctrl/testbench_setup.sv"
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


   // Create UART checker Interface
   uart_checker_intf #(
		       .G_NB_UART_CHECKER    (`C_NB_UART_CHECKER),
		       .G_DATA_WIDTH         (`C_UART_DATA_WIDTH),
		       .G_BUFFER_ADDR_WIDTH  (`C_UART_BUFFER_ADDR_WIDTH)
		       ) 
   uart_checker_if();
   

   // == TESTBENCH MODULES ALIASES & SIGNALS AFFECTATION ==

   // INIT WAIT EVENT ALIAS
   assign s_wait_event_if.wait_alias[0] = "RST_N";
   assign s_wait_event_if.wait_alias[1] = "CLK";
   assign s_wait_event_if.wait_alias[2] = "O_CONFIG_DONE";
   assign s_wait_event_if.wait_alias[3] = "O_MAX7219_LOAD";
   assign s_wait_event_if.wait_alias[4] = "O_PTR_EQUALITY_STATIC";
   assign s_wait_event_if.wait_alias[5] = "O_STATIC_BUSY";
   assign s_wait_event_if.wait_alias[6] = "O_SCROLLER_BUSY";
   assign s_wait_event_if.wait_alias[7] = "STATIC_DISCARD"; // Internal signal
   

   // SET WAIT EVENT SIGNALS
   assign s_wait_event_if.wait_signals[0] = rst_n;
   assign s_wait_event_if.wait_signals[1] = clk;
   assign s_wait_event_if.wait_signals[2] = s_config_done;
   assign s_wait_event_if.wait_signals[3] = s_max7219_load;
   assign s_wait_event_if.wait_signals[4] = s_ptr_equality_static;
   assign s_wait_event_if.wait_signals[5] = s_static_busy;
   assign s_wait_event_if.wait_signals[6] = s_scroller_busy;
   assign s_wait_event_if.wait_signals[7] = i_max7219_display_controller.s_discard_static;
   

   // INIT SET ALIAS
   assign s_set_injector_if.set_alias[0]   = "I_STATIC_DYN";
   assign s_set_injector_if.set_alias[1]   = "I_NEW_DISPLAY";
   
   assign s_set_injector_if.set_alias[2]   = "I_NEW_CONFIG_VAL";
   
   assign s_set_injector_if.set_alias[3]   = "I_EN_STATIC";
   
   assign s_set_injector_if.set_alias[4]   = "I_ME_STATIC";
   assign s_set_injector_if.set_alias[5]   = "I_WE_STATIC";
   assign s_set_injector_if.set_alias[6]   = "I_ADDR_STATIC";
   assign s_set_injector_if.set_alias[7]   = "I_WDATA_STATIC";
   assign s_set_injector_if.set_alias[8]   = "I_START_PTR_STATIC";
   assign s_set_injector_if.set_alias[9]   = "I_LAST_PTR_STATIC";
   //assign s_set_injector_if.set_alias[10]  = "TOTO";
   assign s_set_injector_if.set_alias[11]  = "I_LOOP_STATIC";
   
   assign s_set_injector_if.set_alias[12]  = "I_RAM_START_PTR_SCROLLER";
   assign s_set_injector_if.set_alias[13]  = "I_MSG_LENGTH_SCROLLER";
   //assign s_set_injector_if.set_alias[14]  = "I_START_SCROLL";   
   assign s_set_injector_if.set_alias[15]  = "I_MAX_TEMPO_CNT_SCROLLER";   
   assign s_set_injector_if.set_alias[16]  = "I_ME_SCROLLER";   
   assign s_set_injector_if.set_alias[17]  = "I_WE_SCROLLER";
   assign s_set_injector_if.set_alias[18]  = "I_ADDR_SCROLLER";
   assign s_set_injector_if.set_alias[19]  = "I_WDATA_SCROLLER";

   assign s_set_injector_if.set_alias[20]  = "I_DISPLAY_TEST";
   assign s_set_injector_if.set_alias[21]  = "I_DECOD_MODE";
   assign s_set_injector_if.set_alias[22]  = "I_INTENSITY";
   assign s_set_injector_if.set_alias[23]  = "I_SCAN_LIMIT";
   assign s_set_injector_if.set_alias[24]  = "I_SHUTDOWN";

   // MUX : Sel from SET inj or to LOAD output of MAX7219 checker
   assign s_set_injector_if.set_alias[25]  = "DISPLAY_SCREEN_SEL";
   
   assign s_set_injector_if.set_alias[26]  = "DISPLAY_SCREEN_MATRIX";
   assign s_set_injector_if.set_alias[27]  = "DISPLAY_REG_MATRIX_N";
  
   
   

   // MUX : Sel from SET inj or to LOAD output of MAX7219 checker
   


   
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
   
   
   // INIT CHECK LEVEL ALIAS

   assign s_check_level_if.check_alias[0] = "O_CONFIG_DONE";
   assign s_check_level_if.check_alias[1] = "O_RDATA_STATIC";   
   assign s_check_level_if.check_alias[2] = "O_PTR_EQUALITY_STATIC";
   assign s_check_level_if.check_alias[3] = "O_STATIC_BUSY";      
   assign s_check_level_if.check_alias[4] = "O_SCROLLER_BUSY";   
   assign s_check_level_if.check_alias[5] = "O_RDATA_SCROLLER";      
   assign s_check_level_if.check_alias[6] = "O_MAX7219_LOAD";
   assign s_check_level_if.check_alias[7] = "O_MAX7219_DATA";
   assign s_check_level_if.check_alias[8] = "O_MAX7219_CLK";

   // SET CHECK_SIGNALS
   assign s_check_level_if.check_signals[0] =  s_config_done;
   assign s_check_level_if.check_signals[1] =  s_rdata_static;
   assign s_check_level_if.check_signals[3] =  s_ptr_equality_static;
   assign s_check_level_if.check_signals[4] =  s_static_busy;
   assign s_check_level_if.check_signals[5] =  s_rdata_scroller;
   assign s_check_level_if.check_signals[6] =  s_max7219_load;
   assign s_check_level_if.check_signals[7] =  s_max7219_data;
   assign s_check_level_if.check_signals[8] =  s_max7219_clk;
   
   // =====================================================


   // == HDL SPEFICIC TESTBENCH MODULES ==

   wire [`C_NB_UART_CHECKER - 1 : 0] s_rx_uart;
   wire [`C_NB_UART_CHECKER - 1 : 0] s_tx_uart;
   
				     
   uart_checker_wrapper #(

			      .G_NB_UART_CHECKER    (`C_NB_UART_CHECKER),
			      .G_STOP_BIT_NUMBER    (`C_STOP_BIT_NUMBER),
			      .G_POLARITY           (`C_POLARITY),
			      .G_PARITY             (`C_PARITY),
			      .G_BAUDRATE           (`C_BAUDRATE),
			      .G_DATA_WIDTH         (`C_UART_DATA_WIDTH),
			      .G_FIRST_BIT          (`C_FIRST_BIT),
			      .G_CLOCK_FREQ         (`C_CLOCK_FREQ),
			      .G_BUFFER_ADDR_WIDTH  (`C_UART_BUFFER_ADDR_WIDTH)
   )
   i_uart_checker_wrapper (
			   .clk    (clk),
			   .rst_n  (rst_n),			  

			   .i_rx  (s_rx_uart),
			   .o_tx  (s_tx_uart),

			   .uart_checker_if (uart_checker_if)
    
    );

   // =============================
   

   // == TESTBENCH Configuration ==

   // Declare UART TB Modules Class 
   tb_modules_custom_uart #(
			    .G_NB_UART_CHECKER     (`C_NB_UART_CHECKER),
			    .G_DATA_WIDTH          (`C_UART_DATA_WIDTH),
			    .G_BUFFER_ADDR_WIDTH   (`C_UART_BUFFER_ADDR_WIDTH)
			    ) tb_modules_custom_class_inst = new(uart_checker_if);

   
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


      // Add Alias of Custom TB Modules
      tb_modules_custom_class_inst.ADD_TB_CUSTOM_MODULES_ALIAS("UART_RPi", 0);
      
      // RUN Testbench Sequencer
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



   uart_max7219_display_ctrl #(
			       .G_MATRIX_NB                (8),
			       .G_RAM_ADDR_WIDTH_STATIC    (8), 
			       .G_RAM_DATA_WIDTH_STATIC    (16),
			       .G_RAM_ADDR_WIDTH_SCROLLER  (8),
			       .G_RAM_DATA_WIDTH_SCROLLER  (8)
			       )
   
   i_dut (
	  .clk    (clk),
	  .rst_n  (rst_n),

    
	  .i_rx(),
	  .o_tx(),

   
	  .o_static_dyn  (),
	  .o_new_display  (),
	  
	  
	  .i_config_done    (),
	  .o_display_test   (),
	  .o_decod_mode     (),
	  .o_intensity      (),
	  .o_scan_limit     (),
	  .o_shutdown       (),
	  .o_new_config_val (),

    
	  .o_en_static (),
  
	  .i_rdata_static (),
	  .o_me_static    (),
	  .o_we_static    (),
	  .o_addr_static  (),
	  .o_wdata_static (),
   
	  .o_start_ptr_static (),
	  .o_last_ptr_static  (),
	  
	  .i_ptr_equality_static (),
	  .i_static_busy         (),
	  
	  
	  .i_scroller_busy          (),
	  .o_ram_start_ptr_scroller (),
	  .o_msg_length_scroller    (),
	  .o_max_tempo_cnt_scroller (),
	      
	  .i_rdata_scroller (),
	  .o_me_scroller    (),
	  .o_we_scroller    (),
	  .o_addr_scroller  (),
	  .o_wdata_scroller ()

    );


   
   // ==============


   
    max7219_display_controller #(
    .G_MATRIX_NB (8), 
   
    .G_MAX_HALF_PERIOD (4),
    .G_LOAD_DURATION   (4),

    .G_RAM_ADDR_WIDTH_STATIC  (8),
    .G_RAM_DATA_WIDTH_STATIC  (16),
    .G_DECOD_MAX_CNT_32B      (32'h02FAF080),

    .G_RAM_ADDR_WIDTH_SCROLLER (8),
    .G_RAM_DATA_WIDTH_SCROLLER (8)
  )
 i_max7219_display_controller (
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
    .i_loop_static           (s_loop_static),
    .o_ptr_equality_static   (s_ptr_equality_static),
    .o_static_busy           (s_static_busy),

    .i_ram_start_ptr_scroller  (s_ram_start_ptr_scroller),
    .i_msg_length_scroller     (s_msg_length_scroller),
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

   
endmodule // tb_top
