

`timescale 1ps/1ps

// INCLUDES
`include "/home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/tb_sources/tb_lib_axi4_lite_7seg/testbench_setup.sv"
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

   wire check_level_0;

   // == DUT SIGNALS ==
   wire start;
   wire [`C_AXI_ADDR_WIDTH-1:0] addr;
   wire rnw;
   wire [(`C_AXI_DATA_WIDTH/8) - 1 : 0] strobe;
   wire [`C_AXI_DATA_WIDTH - 1 :0] master_wdata;
   wire 			  done;
   wire [`C_AXI_DATA_WIDTH - 1 :0] master_rdata;
   wire [1:0] 			  access_status;
   
   wire 			  awvalid;
   wire [`C_AXI_ADDR_WIDTH - 1 : 0] awaddr;
   wire [2:0] 			   awprot;
   wire 			   awready;

   wire 			   wvalid;
   wire [`C_AXI_DATA_WIDTH-1:0] 	   wdata;
   wire [(`C_AXI_DATA_WIDTH/8) - 1 : 0] wstrb;
   wire 			       wready;

   wire 			       bready;
   wire 			       bvalid;
   wire [1:0] 			       bresp;

   wire 			       arvalid;
   wire [`C_AXI_ADDR_WIDTH - 1 : 0]     araddr;
   wire [2:0] 			       arprot;
   wire 			       arready;

   wire 			       rready;
   wire 			       rvalid;
   wire [`C_AXI_DATA_WIDTH-1:0]        rdata;
   wire [1:0] 			       rresp;
   
   wire [6:0] 			       seg0;
   wire [6:0] 			       seg1;
   wire [6:0] 			       seg2;
   wire [6:0] 			       seg3;
   wire [6:0] 			       seg4;
   wire [6:0] 			       seg5;
   wire [6:0] 			       seg6;
   wire [6:0] 			       seg7;
   

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
   assign start          = s_set_injector_if.set_signals_synch[0];
   assign addr           = s_set_injector_if.set_signals_synch[1];
   assign rnw            = s_set_injector_if.set_signals_synch[2];
   assign strobe         = s_set_injector_if.set_signals_synch[3];
   assign master_wdata   = s_set_injector_if.set_signals_synch[4];
      
   // SET SET_INJECTOR INITIAL VALUES
   assign s_set_injector_if.set_signals_asynch_init_value[0]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[1]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[2]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[3]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[4]  = 0;
  
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
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "START",           0);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "ADDR",            1);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "RNW",             2);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "STROBE",          3);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "MASTER_WDATA",    4);
        
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
   // AXI4_LITE_MASTER <-> AXI4LITE_7 SEG
   axi4_lite_master #(
		      .G_DATA_WIDTH (`C_AXI_DATA_WIDTH),
		      .G_ADDR_WIDTH (`C_AXI_ADDR_WIDTH)
		      )
   i_axi4_lite_master_0 (
			 
			 .clk  (clk),
			 .rst_n (rst_n),
			 
			 .start         (start),
			 .addr          (addr),
			 .rnw           (rnw),
			 .strobe        (strobe),
			 .master_wdata  (master_wdata),
			 .done          (done),
			 .master_rdata  (master_rdata),
			 .access_status (access_status),

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
			 .rresp  (rresp)
			 );

   axi4_lite_7segs #(
		     .G_AXI4_LITE_ADDR_WIDTH (`C_AXI_ADDR_WIDTH),
		     .G_AXI4_LITE_DATA_WIDTH (`C_AXI_DATA_WIDTH)
		     )
   i_axi4_lite_7segs_0 (
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
			
			.o_seg0 (seg0),  // SEG 0
			.o_seg1 (seg1),  // SEG 1
			.o_seg2 (seg2),  // SEG 2
			.o_seg3 (seg3),  // SEG 3
			.o_seg4 (seg4),  // SEG 4
			.o_seg5 (seg5),  // SEG 5
			.o_seg6 (seg6),  // SEG 6
			.o_seg7 (seg7)  // SEG 7
			);
   

endmodule // tb_top
