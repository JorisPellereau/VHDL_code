

`timescale 1ps/1ps

// INCLUDES
`include "/home/linux-jp/Documents/GitHub/VHDL_code/PR_115/tb_sources/tb_lib_jtag_7seg_top/testbench_setup.sv"
`include "/home/linux-jp/Documents/GitHub/RTL_Testbench/sources/lib_tb_sequencer/tb_tasks.sv"


// TB TOP
module tb_top
  #(
    parameter SCN_FILE_PATH = "scenario.txt"
   )
   ();

   // == INTERNAL SIGNALS ==   
   wire clk;
   wire rst_n;

   wire set_injector_0;  // To complete
   wire check_level_0;



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
   // ======================================================

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

   // == TESTBENCH SIGNALS AFFECTATION ==

   // SET WAIT EVENT SIGNALS
   assign s_wait_event_if.wait_signals[0] = rst_n;
   assign s_wait_event_if.wait_signals[1] = clk;
   
   // SET SET_INJECTOR SIGNALS
   assign set_injector_0            = s_set_injector_if.set_signals_synch[0];
  
   // SET SET_INJECTOR INITIAL VALUES
   assign s_set_injector_if.set_signals_asynch_init_value[0]  = 0;
  
   // SET CHECK_SIGNALS
   assign s_check_level_if.check_signals[0] = check_level_0;
 
   // =====================================================

   

   // CREATE Handle and object CLASS - Configure Parameters
   
   static tb_class #( .G_SET_SIZE        (`C_SET_SIZE),
                      .G_SET_WIDTH       (`C_SET_WIDTH),
                      .G_WAIT_SIZE       (`C_WAIT_ALIAS_NB),
                      .G_WAIT_WIDTH      (`C_WAIT_WIDTH), 
                      .G_CLK_PERIOD      (`C_TB_CLK_PERIOD),
                      .G_CHECK_SIZE      (`C_CHECK_SIZE),
                      .G_CHECK_WIDTH     (`C_CHECK_WIDTH)/*,
		      
                      // ADD HERE CUSTUM TB MODULES PARAMETERS
		      .G_NB_UART_CHECKER        (`C_NB_UART_CHECKER),
		      .G_UART_DATA_WIDTH        (`C_UART_DATA_WIDTH),
		      .G_UART_BUFFER_ADDR_WIDTH (`C_UART_DATA_WIDTH),

		      .G_NB_COLLECTOR          (`C_NB_DATA_COLLECTOR), 	     
		      .G_DATA_COLLECTOR_WIDTH  (`C_DATA_COLLECTOR_DATA_WIDTH)*/
		      )
   
   tb_class_inst = new (s_wait_event_if, 
			s_set_injector_if, 
			s_wait_duration_if,
			s_check_level_if);


   initial begin
      // Add Alias of Generic TB Modules
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "SET_INJECTOR_ALIAS_0",    0);
        
      // ADD ALias of WAIT Module        
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "RST_N",                 0);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "CLK",                   1);      
     
      // Check Level Alias
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "CHECK_LEVEL_ALIAS_0",            0);
     
      /*	
      ADD Custom TB odule Instanciation HERE
      tb_class_inst.tb_modules_custom_inst.init_uart_custom_class(uart_checker_if,   "UART_RPi");
      tb_class_inst.tb_modules_custom_inst.init_uart_custom_class(uart_checker_if_2, "UART_RPi_TEST");

     
      tb_class_inst.tb_modules_custom_inst.init_data_collector_custom_class(s_data_collector_if, "UART_DISPLAY_CTRL_INPUT_COLLECTOR_0");
      */
            
      // RUN Testbench Sequencer
      tb_class_inst.tb_sequencer(SCN_FILE_PATH);
   end


   // == DUT ==
   jtag_7seg_top i_dut_0 (
			  .clk   (clk),
			  .rst_n (rst_n),

			  .o_seg0 (),
			  .o_seg1 (),
			  .o_seg2 (),
			  .o_seg3 (),
			  .o_seg4 (),
			  .o_seg5 (),
			  .o_seg6 (),
			  .o_seg7 ()
    );
   
endmodule // tb_top
