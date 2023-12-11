

`timescale 1ps/1ps

// INCLUDES
`include "/home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/tb_sources/tb_lib_axi4_lite_max7219/testbench_setup.sv"
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

   wire o_max7219_load;   
   wire o_max7219_data;   
   wire o_max7219_clk;

   wire frame_received;       // SPI Frame received
   wire load_received;        // Load Received
   wire [15:0] data_received; // Data received
   
   
   


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
   assign i_wait_event_0.wait_event_if.wait_signals[2] = frame_received;
   assign i_wait_event_0.wait_event_if.wait_signals[3] = load_received;
   
   // SET SET_INJECTOR SIGNALS
   assign set_injector_0            = i_set_injector_0.set_injector_if.set_signals_synch[0];
  
   // SET SET_INJECTOR INITIAL VALUES
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[0]  = 0;
  
   // SET CHECK_SIGNALS
   assign i_check_level_0.check_level_if.check_signals[0] = data_received;

   // WAIT DURATION Connection
   assign i_wait_duration_0.wait_duration_if.clk = clk; // Assign Clock
   // =====================================================


   // AXI4 Lite Master Instanciation
   master_axi4lite #(
		     .G_AXI4_LITE_ADDR_WIDTH (`C_MASTER_AXI4LITE_ADDR_WIDTH),
		     .G_AXI4_LITE_DATA_WIDTH (`C_MASTER_AXI4LITE_DATA_WIDTH)			 
		     )
   i_master_axi4lite_0  (
			 .clk   (clk),
			 .rst_n (rst_n)
			 );
   
   // CREATE Handle and object CLASS - Configure Parameters  
   static tb_class #( .G_SET_SIZE        (`C_SET_SIZE),
                      .G_SET_WIDTH       (`C_SET_WIDTH),
                      .G_WAIT_SIZE       (`C_WAIT_ALIAS_NB),
                      .G_WAIT_WIDTH      (`C_WAIT_WIDTH), 
                      .G_CLK_PERIOD      (`C_TB_CLK_PERIOD),
                      .G_CHECK_SIZE      (`C_CHECK_SIZE),
                      .G_CHECK_WIDTH     (`C_CHECK_WIDTH),/*,
		      
                      // ADD HERE CUSTUM TB MODULES PARAMETERS
		      .G_NB_UART_CHECKER        (`C_NB_UART_CHECKER),
		      .G_UART_DATA_WIDTH        (`C_UART_DATA_WIDTH),
		      .G_UART_BUFFER_ADDR_WIDTH (`C_UART_DATA_WIDTH),

		      .G_NB_COLLECTOR          (`C_NB_DATA_COLLECTOR), 	     
		      .G_DATA_COLLECTOR_WIDTH  (`C_DATA_COLLECTOR_DATA_WIDTH)*/
		      .G_NB_MASTER_AXI4LITE  (`C_NB_MASTER_AXI4LITE),
		      .G_AXI4LITE_ADDR_WIDTH (`C_MASTER_AXI4LITE_ADDR_WIDTH),
		      .G_AXI4LITE_DATA_WIDTH (`C_MASTER_AXI4LITE_DATA_WIDTH)
		      )
   
   tb_class_inst = new (i_wait_event_0.wait_event_if, 
			i_set_injector_0.set_injector_if, 
			i_wait_duration_0.wait_duration_if,
			i_check_level_0.check_level_if);


   initial begin
      // Add Alias of Generic TB Modules
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "SET_INJECTOR_ALIAS_0",    0);
        
      // ADD ALias of WAIT Module        
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "RST_N",            0);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "CLK",              1);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "FRAME_RECEIVED",   2);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "LOAD_RECEIVED",    3);
     
      // Check Level Alias
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "DATA_RECEIVED", 0);
           	
      // Custom AXI4Lite Master
      tb_class_inst.tb_modules_custom_inst.init_master_axi4lite_custom_class(i_master_axi4lite_0.master_axi4lite_if, "MASTER_AXI4LITE_0");
              
      // RUN Testbench Sequencer
      tb_class_inst.tb_sequencer(SCN_FILE_PATH);
   end


   // == DUT ==
   axi4_lite_max7219 #(
		       .G_AXI4_LITE_ADDR_WIDTH (`C_MASTER_AXI4LITE_ADDR_WIDTH),
		       .G_AXI4_LITE_DATA_WIDTH (`C_MASTER_AXI4LITE_DATA_WIDTH),
		       .G_MATRIX_NB            (`NB_MATRIX)
		       )
   i_dut (
	  .clk_sys   (clk),
	  .rst_n_sys (rst_n),
	  
	  // Write Address Channel signals
	  .awvalid (i_master_axi4lite_0.awvalid),
	  .awaddr  (i_master_axi4lite_0.awaddr),
	  .awprot  (i_master_axi4lite_0.awprot),
	  .awready (i_master_axi4lite_0.awready),
	  
	  // Write Data Channel
	  .wvalid (i_master_axi4lite_0.wvalid),
	  .wdata  (i_master_axi4lite_0.wdata),
	  .wstrb  (i_master_axi4lite_0.wstrb),
	  .wready (i_master_axi4lite_0.wready),
	  
	  // Write Response Channel
	  .bready (i_master_axi4lite_0.bready),
	  .bvalid (i_master_axi4lite_0.bvalid),
	  .bresp  (i_master_axi4lite_0.bresp),
	  
	  // Read Address Channel
	  .arvalid (i_master_axi4lite_0.arvalid),
	  .araddr  (i_master_axi4lite_0.araddr),
	  .arprot  (i_master_axi4lite_0.arprot),
	  .arready (i_master_axi4lite_0.arready),
	  
	  // Read Data Channel
	  .rready (i_master_axi4lite_0.rready),
	  .rvalid (i_master_axi4lite_0.rvalid),
	  .rdata  (i_master_axi4lite_0.rdata),
	  .rresp  (i_master_axi4lite_0.rresp),
	  
	  // MAX7219 I/F
	  .o_max7219_load (o_max7219_load),
	  .o_max7219_data (o_max7219_data),
	  .o_max7219_clk  (o_max7219_clk)	 
	  );
   
   
   // MAX7219 SPI CHECKER Instanciation
   max7219_spi_checker i_max7219_spi_checker_0 (
						.clk   (clk),
						.rst_n (rst_n),     
						
						.i_max7219_clk  (o_max7219_clk),
						.i_max7219_din  (o_max7219_data),
						.i_max7219_load (o_max7219_load),
						
						.o_frame_received (frame_received),
						.o_load_received  (load_received),
						.o_data_received  (data_received)
						);
   
endmodule // tb_top
