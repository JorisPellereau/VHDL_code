// Testbench for AXI4 Lite Blocks

`timescale 1ps/1ps

// INCLUDES
`include "/home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/tb_sources/tb_lib_axi4_lite/testbench_setup.sv"
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

   wire set_injector_0;  // To complete
   wire check_level_0;

   wire awvalid;
   wire [`C_AXI4_LITE_ADDR_WIDTH-1:0] awaddr;
   wire [2:0] 			      awprot;
   wire 			      awready;
   wire 			      wvalid;
   wire [`C_AXI4_LITE_DATA_WIDTH-1:0] wdata;
   wire [(`C_AXI4_LITE_DATA_WIDTH/8)-1:0] wstrb;
   wire 				  wready;
   wire 				  bready;
   wire 				  bvalid;
   wire [1:0] 				  bresp;
   wire 				  arvalid;
   wire [`C_AXI4_LITE_ADDR_WIDTH-1:0] 	  araddr;
   wire [2:0] 				  arprot;
   wire 				  arready;
   wire 				  rready;
   wire 				  rvalid;
   wire [`C_AXI4_LITE_DATA_WIDTH-1:0] 	  rdata;
   wire [1:0] 				  rresp;

   wire 				  slv_reg_wren;
   wire [`C_AXI4_LITE_ADDR_WIDTH-1:0] 	  slv_reg_waddr;
   wire [`C_AXI4_LITE_DATA_WIDTH-1:0] 	  slv_reg_wdata;
   wire 				  slv_reg_awready;
   wire 				  slv_reg_wready;
   wire [1:0] 				  slv_reg_bresp;
   wire 				  slv_reg_bvalid;   
   wire 				  master_bready;
   wire 				  slv_reg_rden;
   wire [`C_AXI4_LITE_ADDR_WIDTH-1:0] 	  slv_reg_raddr;
   wire [`C_AXI4_LITE_DATA_WIDTH-1:0] 	  slv_reg_rdata;
   wire 				  slv_reg_arready;
   wire [1:0] 				  slv_reg_rresp;
   
 

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
   // -- WAIT EVENT Module
   wait_event #(.CLK_PERIOD (`C_TB_CLK_PERIOD),
		.WAIT_SIZE  (`C_WAIT_ALIAS_NB),
		.WAIT_WIDTH (`C_WAIT_WIDTH)
		)
   i_wait_event_0 (
		   .clk   (clk),
		   .rst_n (rst_n)  
		   );

   // -- SET INJECTOR Module
   set_injector #(.SET_SIZE  (`C_SET_ALIAS_NB),
		  .SET_WIDTH (`C_SET_WIDTH)
   )
   i_set_injector_0 (
		     .clk   (clk),
		     .rst_n (rst_n)
   );

   // -- CHECK LEVEL Module
   check_level #( .CHECK_SIZE   (`C_CHECK_ALIAS_NB),
		  .CHECK_WIDTH  (`C_CHECK_WIDTH)
		  )
   i_check_level_0 ();
   
   // -- WAIT DURATION Module
   wait_duration i_wait_duration_0 ();   
   
   // =====================================================

   // == TESTBENCH SIGNALS AFFECTATION ==

   // SET WAIT EVENT SIGNALS
   assign i_wait_event_0.wait_event_if.wait_signals[0] = rst_n;
   assign i_wait_event_0.wait_event_if.wait_signals[1] = clk;
   
   // SET SET_INJECTOR SIGNALS
   assign set_injector_0            = i_set_injector_0.set_injector_if.set_signals_synch[0];
  
   // SET SET_INJECTOR INITIAL VALUES
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[0]  = 0;
  
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


   // == OSVVM AXI4Lite Manager ==
   osvvm_axi4lite_manager_wrapper #(
				    .MODEL_ID_NAME ("MASTER_AXI4_Lite_0"),
				    .G_AXI4_LITE_ADDR_WIDTH (`C_AXI4_LITE_ADDR_WIDTH),
				    .G_AXI4_LITE_DATA_WIDTH (`C_AXI4_LITE_DATA_WIDTH),
				    .tperiod_Clk            (10000),
				    .DEFAULT_DELAY          (0),
				    .tpd_Clk_AWAddr         (0),
				    .tpd_Clk_AWProt         (0),
				    .tpd_Clk_AWValid        (0),
				    .tpd_Clk_WValid         (0),
				    .tpd_Clk_WData          (0),
				    .tpd_Clk_WStrb          (0),
				    .tpd_Clk_BReady         (0),
				    .tpd_Clk_ARValid        (0),
				    .tpd_Clk_ARProt         (0),
				    .tpd_Clk_ARAddr         (0),
				    .tpd_Clk_RReady         (0)

				    )
   
   i_osvvm_axi4lite_manager_wrapper (
				     .clk     (clk),
				     .rst_n   (rst_n),
				     .awvalid (awvalid),
				     .awaddr  (awaddr),
				     .awprot  (awprot),
				     .awready (awready),
				     .wvalid  (wvalid),
				     .wdata   (wdata),
				     .wstrb   (wstrb),
				     .wready  (wready),
				     .bready  (bready),
				     .bvalid  (bvalid),
				     .bresp   (bresp),
				     .arvalid (arvalid),
				     .araddr  (araddr),
				     .arprot  (arprot),
				     .arready (arready),
				     .rready  (rready),
				     .rvalid  (rvalid),
				     .rdata   (rdata),
				     .rresp   (rresp)
				     );
   // == DUT ==

   axi4_lite_slave_test #(
			  .G_AXI4_LITE_ADDR_WIDTH  (`C_AXI4_LITE_ADDR_WIDTH),
			  .G_AXI4_LITE_DATA_WIDTH  (`C_AXI4_LITE_DATA_WIDTH),
			  .G_REG_CONFIG            (),
			  .G_REG_IN_NB             (),
			  .G_REG_OUT_NB            ()			  
			  )   
   i_dut (	   
		   .clk   (clk),
		   .rst_n (rst_n),
		   
		   .awvalid (awvalid),
		   .awaddr  (awaddr),
		   .awprot  (awprot),
		   .awready (awready),
		   
		   .wvalid (wvalid), 
		   .wdata  (wdata), 
		   .wstrb  (wstrb), 
		   .wready (wready),
		   
		   .bready (bready), 
		   .bvalid (bvalid), 
		   .bresp  (bresp),
		   
		   .arvalid (arvalid),
		   .araddr  (araddr),
		   .arprot  (arprot),
		   .arready (arready),
		   
		   .rready (rready), 
		   .rvalid (rvalid), 
		   .rdata  (rdata), 
		   .rresp  (rresp), 
		   
		   .registers_in (0),
		   .registers_out ()
		   );
   

endmodule // tb_top
