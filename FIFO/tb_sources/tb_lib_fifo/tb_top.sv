

`timescale 1ps/1ps

// INCLUDES
`include "/home/linux-jp/Documents/GitHub/VHDL_code/FIFO/tb_sources/tb_lib_fifo/testbench_setup.sv"
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

   // -- FIFO SP Signals --
   wire wr_en_fifo_sp_ram;
   wire rd_en_fifo_sp_ram;
   wire [7:0] wdata_fifo_sp_ram;
   wire [7:0] rdata_fifo_sp_ram;
   wire       rdata_val_fifo_sp_ram;
   wire [7:0] wdata_out_fifo_sp_ram;
   wire       we_fifo_sp_ram;
   wire [9:0] wr_addr_fifo_sp_ram;
   wire [9:0] rd_addr_fifo_sp_ram;
   wire [7:0] rdata_in_fifo_sp_ram;
   wire       fifo_empty_fifo_sp_ram;
   wire       fifo_full_fifo_sp_ram;
   
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


   // == HDL GENERIC TESTBENCH MODULES ==

   // -- WAIT EVENT TB INST
   wait_event #(.CLK_PERIOD (`C_TB_CLK_PERIOD),
		.WAIT_SIZE  (`C_WAIT_ALIAS_NB),
		.WAIT_WIDTH (`C_WAIT_WIDTH)
		)
   i_wait_event_0 (
		   .clk   (clk),
		   .rst_n (rst_n)  
		   );

   // -- SET INJECTOR TB INST
   set_injector #(.SET_SIZE  (`C_SET_ALIAS_NB),
		  .SET_WIDTH (`C_SET_WIDTH)
   )
   i_set_injector_0 (
		     .clk   (clk),
		     .rst_n (rst_n)
   );

   // -- WAIT DURATION Module
   wait_duration i_wait_duration_0 ();

   // -- CHECK LEVEL Module
   check_level #( .CHECK_SIZE   (`C_CHECK_ALIAS_NB),
		  .CHECK_WIDTH  (`C_CHECK_WIDTH)
		  )
   i_check_level_0 ();

   // =====================================================

   // == TESTBENCH SIGNALS AFFECTATION ==

   // SET WAIT EVENT SIGNALS
   assign i_wait_event_0.wait_event_if.wait_signals[0] = rst_n;
   assign i_wait_event_0.wait_event_if.wait_signals[1] = clk;
   assign i_wait_event_0.wait_event_if.wait_signals[2] = rdata_val_fifo_sp_ram;
   
   // SET SET_INJECTOR SIGNALS
   assign wr_en_fifo_sp_ram            = i_set_injector_0.set_injector_if.set_signals_synch[0];
   assign rd_en_fifo_sp_ram            = i_set_injector_0.set_injector_if.set_signals_synch[1];
   assign wdata_fifo_sp_ram            = i_set_injector_0.set_injector_if.set_signals_synch[2];
  
   // SET SET_INJECTOR INITIAL VALUES
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[0]  = 0;
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[1]  = 0;
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[2]  = 0;
  
   // SET CHECK_SIGNALS
   assign i_check_level_0.check_level_if.check_signals[0] = fifo_empty_fifo_sp_ram;
   assign i_check_level_0.check_level_if.check_signals[1] = fifo_full_fifo_sp_ram;
   assign i_check_level_0.check_level_if.check_signals[2] = rdata_fifo_sp_ram;
   
   

   // WAIT DURATION Connection
   assign i_wait_duration_0.wait_duration_if.clk = clk; // Assign Clock
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
   
   tb_class_inst = new (i_wait_event_0.wait_event_if, 
			i_set_injector_0.set_injector_if, 
			i_wait_duration_0.wait_duration_if,
			i_check_level_0.check_level_if);


   initial begin
      // Add Alias of Generic TB Modules
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "WR_EN",    0);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "RD_EN",    1);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "WDATA",    2);
        
      // ADD ALias of WAIT Module        
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "RST_N",                 0);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "CLK",                   1);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "RDATA_VAL",             2);  
     
      // Check Level Alias
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "FIFO_EMPTY",           0);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "FIFO_FULL",            1);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "RDATA",                2);
     
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

   fifo_sp_ram # (
    .G_DATA_WIDTH(8), 
    .G_ADDR_WIDTH(10)
    )
  i_dut_fifo_sp_ram (
		     
		     .clk   (clk),
		     .rst_n (rst_n),
		     
		     .wr_en     (wr_en_fifo_sp_ram),
		     .rd_en     (rd_en_fifo_sp_ram),
		     .wdata     (wdata_fifo_sp_ram),
		     .rdata     (rdata_fifo_sp_ram),
		     .rdata_val (rdata_val_fifo_sp_ram),
		     
		     .wdata_out (wdata_out_fifo_sp_ram),
		     .we        (we_fifo_sp_ram),
		     .wr_addr   (wr_addr_fifo_sp_ram),
		     .rd_addr   (rd_addr_fifo_sp_ram),
		     .rdata_in  (rdata_in_fifo_sp_ram),
		     
		     .fifo_empty (fifo_empty_fifo_sp_ram),
		     .fifo_full  (fifo_full_fifo_sp_ram)
		     );

   sp_ram #(
	    .G_ADDR_WIDTH (10),
	    .G_DATA_WIDTH (8)
	    )
   i_sp_ram_0 (
	       .clk      (clk),
	       .data_in  (wdata_out_fifo_sp_ram),
	       .wr_addr  (wr_addr_fifo_sp_ram),
	       .rd_addr  (rd_addr_fifo_sp_ram),
	       .we       (we_fifo_sp_ram),
	       .data_out (rdata_in_fifo_sp_ram)
	      );
   

endmodule // tb_top
