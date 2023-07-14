/*
 *  Testbench TOP for test of ZIPCPU block
 * 
 */ 

`timescale 1ps/1ps


`include "/home/linux-jp/Documents/GitHub/VHDL_code/PR_115/tb_sources/tb_lib_zipcpu/testbench_setup.sv"
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


   wire [`C_NB_UART_CHECKER - 1 : 0] s_rx_uart;
   wire [`C_NB_UART_CHECKER - 1 : 0] s_tx_uart;

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
   assign s_check_level_if.check_signals[2] = 0;   
   
   // =====================================================

   // == HDL SPEFICIC TESTBENCH MODULES ==

   
   


   // CREATE Handle and object CLASS - Configure Parameters
   static tb_class #( .G_SET_SIZE        (`C_SET_SIZE),
                      .G_SET_WIDTH       (`C_SET_WIDTH),
                      .G_WAIT_SIZE       (`C_WAIT_ALIAS_NB),
                      .G_WAIT_WIDTH      (`C_WAIT_WIDTH), 
                      .G_CLK_PERIOD      (`C_TB_CLK_PERIOD),
                      .G_CHECK_SIZE      (`C_CHECK_SIZE),
                      .G_CHECK_WIDTH     (`C_CHECK_WIDTH)
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
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "S_MAX7219_DATA",            0);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "O_SPI_DATA_RECEIVED",       1);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "S_MAX_TEMPO_CNT_SCROLLER",  2);

      // RUN Testbench Sequencer
      tb_class_inst.tb_sequencer(SCN_FILE_PATH);
      
   end// : TB_SEQUENCER
   
   // ========================


   


   // == DUT ==
   zip_cpu_wrapper i_dut();

   assign i_dut.clk = clk;
   assign i_dut.rst = ! rst_n;
   
   // ===============



   
endmodule // tb_top
