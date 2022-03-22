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


`include "/home/linux-jp/Documents/GitHub/VHDL_code/UART/tb_sources/tb_lib_uart_display_ctrl/testbench_setup.sv"
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
   wire        s_max7219_load;
   wire        s_max7219_data;
   wire        s_max7219_clk;
  
   wire [7:0]  s_display_reg_matrix_n;
   wire        s_display_screen_matrix_checker;
   wire        s_display_screen_matrix;
   wire        s_display_screen_sel;  

   wire        s_load_ram_sel; // 0 : Load via SET injector - 1 : Load via LOAD RAM Injector

   // == MAX7219 SPI CHECKER ==
   wire        s_spi_frame_received;
   wire        s_spi_load_received;
   wire [15:0] s_spi_data_received;

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


   // Create UART checker Interface
   uart_checker_intf #(
		       .G_NB_UART_CHECKER    (`C_NB_UART_CHECKER),
		       .G_DATA_WIDTH         (`C_UART_DATA_WIDTH),
		       .G_BUFFER_ADDR_WIDTH  (`C_UART_BUFFER_ADDR_WIDTH)
		       ) 
   uart_checker_if();

   // Create UART checker Interface
   uart_checker_intf #(
		       .G_NB_UART_CHECKER    (`C_NB_UART_CHECKER),
		       .G_DATA_WIDTH         (`C_UART_DATA_WIDTH),
		       .G_BUFFER_ADDR_WIDTH  (`C_UART_BUFFER_ADDR_WIDTH)
		       ) 
   uart_checker_if_2();
   

   // == TESTBENCH MODULES ALIASES & SIGNALS AFFECTATION ==

   // SET WAIT EVENT SIGNALS
   assign s_wait_event_if.wait_signals[0] = rst_n;
   assign s_wait_event_if.wait_signals[1] = clk;
   assign s_wait_event_if.wait_signals[2] = s_spi_frame_received;   
   assign s_wait_event_if.wait_signals[3] = s_spi_load_received;      
  
   // SET SET_INJECTOR SIGNALS
   assign s_display_screen_sel            = s_set_injector_if.set_signals_synch[0];
   assign s_display_screen_matrix         = s_set_injector_if.set_signals_synch[1];
   assign s_display_reg_matrix_n          = s_set_injector_if.set_signals_synch[2];
 
   // SET SET_INJECTOR INITIAL VALUES
   assign s_set_injector_if.set_signals_asynch_init_value[0]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[1]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[2]  = 0;
   
   // SET CHECK_SIGNALS
   assign s_check_level_if.check_signals[0] = s_max7219_data;
   assign s_check_level_if.check_signals[1] = s_spi_data_received;
   
   // =====================================================

   wire clk_data_collector   [`C_NB_DATA_COLLECTOR - 1:0];
   wire rst_n_data_collector [`C_NB_DATA_COLLECTOR - 1:0];
   
   assign clk_data_collector[0]   = clk;
   assign rst_n_data_collector[0] = rst_n;

   assign s_data_collector[0] = 0

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
   


   // CREATE Handle and object CLASS - Configure Parameters
   static tb_class #( .G_SET_SIZE        (`C_SET_SIZE),
                      .G_SET_WIDTH       (`C_SET_WIDTH),
                      .G_WAIT_SIZE       (`C_WAIT_ALIAS_NB),
                      .G_WAIT_WIDTH      (`C_WAIT_WIDTH), 
                      .G_CLK_PERIOD      (`C_TB_CLK_PERIOD),
                      .G_CHECK_SIZE      (`C_CHECK_SIZE),
                      .G_CHECK_WIDTH     (`C_CHECK_WIDTH),
		      
		      .G_NB_UART_CHECKER        (`C_NB_UART_CHECKER),
		      .G_UART_DATA_WIDTH        (`C_UART_DATA_WIDTH),
		      .G_UART_BUFFER_ADDR_WIDTH (`C_UART_DATA_WIDTH)
		      )
   
   tb_class_inst = new (s_wait_event_if, 
			s_set_injector_if, 
			s_wait_duration_if,
			s_check_level_if);
   

   initial begin// : TB_SEQUENCER
    
      // Add Alias of Generic TB Modules
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "DISPLAY_SCREEN_SEL",    0);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "DISPLAY_SCREEN_MATRIX", 1);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "DISPLAY_REG_MATRIX_N",  2);      
      
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "RST_N",                 0);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "CLK",                   1);      
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "SPI_FRAME_RECEIVED",    2);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "SPI_LOAD_RECEIVED",     3);

      // Check Level Alias
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_SPI_DATA_RECEIVED",  0);
	
      // init_uart_custom_class
      tb_class_inst.tb_modules_custom_inst.init_uart_custom_class(uart_checker_if,   "UART_RPi");
      tb_class_inst.tb_modules_custom_inst.init_uart_custom_class(uart_checker_if_2, "UART_RPi_TEST");
                  
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


   // == DUT ==
   uart_max7219_display_ctrl_wrapper #(				      
				       .G_STOP_BIT_NUMBER (`C_STOP_BIT_NUMBER),
				       .G_PARITY          (`C_PARITY),
				       .G_BAUDRATE        (`C_BAUDRATE),
				       .G_UART_DATA_SIZE  (`C_UART_DATA_WIDTH),
				       .G_POLARITY        (`C_POLARITY),
				       .G_FIRST_BIT       (`C_FIRST_BIT ),
				       .G_CLOCK_FREQUENCY (`C_CLOCK_FREQ),
				       
				       .G_MATRIX_NB                (8),
				       .G_RAM_ADDR_WIDTH_STATIC    (8), 
				       .G_RAM_DATA_WIDTH_STATIC    (16),
				       .G_RAM_ADDR_WIDTH_SCROLLER  (8),
				       .G_RAM_DATA_WIDTH_SCROLLER  (8),

				       .G_MAX_HALF_PERIOD  (4), // old : 4
				       .G_LOAD_DURATION    (4),    // old : 4

				       .G_DECOD_MAX_CNT_32B  (32'h02FAF080)
				       )
   
   i_dut (
	  .clk    (clk),
	  .rst_n  (rst_n),
	  	  
	  .i_rx  (s_tx_uart),
	  .o_tx  (s_rx_uart),
	  
	  .o_max7219_load (s_max7219_load),
	  .o_max7219_data (s_max7219_data),
	  .o_max7219_clk  (s_max7219_clk)
	  );
   
   // ===============



   // == MAX7219_SPI_CHECKER

   max7219_spi_checker i_max7219_spi_checker_0 (
						.clk    (clk),
						.rst_n  (rst_n),

						.i_max7219_clk   (s_max7219_clk),
						.i_max7219_din   (s_max7219_data),
						.i_max7219_load  (s_max7219_load),

						.o_frame_received  (s_spi_frame_received),
						.o_load_received   (s_spi_load_received),
						.o_data_received   (s_spi_data_received)
						
						);
   
endmodule // tb_top
