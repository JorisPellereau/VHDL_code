

`timescale 1ps/1ps

// INCLUDES
`include "/home/linux-jp/Documents/GitHub/VHDL_code/SPI/tb_sources/tb_lib_spi_master/testbench_setup.sv"
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

   // -- DUT SIGNALS --
   wire wr_en_fifo_tx;
   wire [`C_FIFO_DATA_WIDTH - 1 : 0] wdata_fifo_tx;
   wire 			     rd_en_fifo_rx;
   wire [`C_FIFO_DATA_WIDTH - 1 : 0] rdata_fifo_rx;
   wire 			     rdata_val_fifo_rx;
   wire 			     start;
   wire [$clog2(`C_FIFO_DEPTH) - 1:0] nb_wr;
   wire [$clog2(`C_FIFO_DEPTH) - 1:0] nb_rd;
   wire 			      full_duplex;
   wire 			      cpha;
   wire 			      cpol;
   wire [7:0] 			      clk_div;
   wire 			      spi_cs;
   wire 			      spi_clk;
   wire [`C_SPI_SIZE-1:0] 	      spi_do;
   wire [`C_SPI_SIZE-1:0] 	      spi_di;
   wire 			      spi_busy;
   
   
   


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
   assign i_wait_event_0.wait_event_if.wait_signals[2] = spi_busy;
   
   // SET SET_INJECTOR SIGNALS
   assign wr_en_fifo_tx = i_set_injector_0.set_injector_if.set_signals_synch[0];
   assign wdata_fifo_tx = i_set_injector_0.set_injector_if.set_signals_synch[1];
   assign rd_en_fifo_rx = i_set_injector_0.set_injector_if.set_signals_synch[2];
   assign start         = i_set_injector_0.set_injector_if.set_signals_synch[3];
   assign nb_wr         = i_set_injector_0.set_injector_if.set_signals_synch[4];
   assign nb_rd         = i_set_injector_0.set_injector_if.set_signals_synch[5];
   assign full_duplex   = i_set_injector_0.set_injector_if.set_signals_synch[6];
   assign cpha          = i_set_injector_0.set_injector_if.set_signals_synch[7];
   assign cpol          = i_set_injector_0.set_injector_if.set_signals_synch[8];
   assign clk_div       = i_set_injector_0.set_injector_if.set_signals_synch[9];
   assign spi_di        = i_set_injector_0.set_injector_if.set_signals_synch[10];
   
   // SET SET_INJECTOR INITIAL VALUES
   genvar 			      i;
   generate
      for(i = 0 ; i < `C_SET_ALIAS_NB ; i++) begin
	 assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[i]  = 0;
      end
   endgenerate;
      
   // SET CHECK_SIGNALS
   assign i_check_level_0.check_level_if.check_signals[0] = check_level_0;

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
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "WR_EN_FIFO_TX",    0);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "WDATA_FIFO_TX",    1);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "RD_EN_FIFO_RX",    2);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "START",            3);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "NB_WR",            4);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "NB_RD",            5);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "FULL_DUPLEX",      6);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "CPHA",             7);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "CPOL",             8);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "CLK_DIV",          9);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "SPI_DI",           10);

        
      // ADD ALias of WAIT Module        
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "RST_N",                 0);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "CLK",                   1);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "SPI_BUSY",              2); 
     
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
   spi_master # (
		 .G_SPI_SIZE        (`C_SPI_SIZE),
		 .G_SPI_DATA_WIDTH  (`C_SPI_DATA_WIDTH),
		 .G_FIFO_DATA_WIDTH (`C_FIFO_DATA_WIDTH),
		 .G_FIFO_DEPTH      (`C_FIFO_DEPTH)
		 )
   i_dut (
	  .clk_sys           (clk),
	  .rst_n_sys         (rst_n),
	  .wr_en_fifo_tx     (wr_en_fifo_tx),
	  .wdata_fifo_tx     (wdata_fifo_tx),
	  .rd_en_fifo_rx     (rd_en_fifo_rx),
	  .rdata_fifo_rx     (rdata_fifo_rx),
	  .start             (start), 
	  .nb_wr             (nb_wr), 
	  .nb_rd             (nb_rd),
	  .full_duplex       (full_duplex),
	  .cpha              (cpha),
	  .cpol              (cpol),
	  .clk_div           (clk_div),
	  .spi_clk           (spi_clk),
	  .spi_cs_n          (spi_cs_n),
	  .spi_do            (spi_do),
	  .spi_di            (spi_di),
	  .spi_busy          (spi_busy)
    );
   

endmodule // tb_top
