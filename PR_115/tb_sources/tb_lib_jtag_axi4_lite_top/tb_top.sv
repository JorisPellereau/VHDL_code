

`timescale 1ps/1ps

// INCLUDES
`include "/home/linux-jp/Documents/GitHub/VHDL_code/PR_115/tb_sources/tb_lib_jtag_axi4_lite_top/testbench_setup.sv"
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


   // -- DUT SIGNALS
   wire [6:0] seg0_dut;
   wire [6:0] seg1_dut;
   wire [6:0] seg2_dut;
   wire [6:0] seg3_dut;
   wire [6:0] seg4_dut;
   wire [6:0] seg5_dut;
   wire [6:0] seg6_dut;
   wire [6:0] seg7_dut;
   wire [7:0] lcd_data_dut;
   wire       lcd_rw_dut;
   wire       lcd_en_dut;
   wire       lcd_rs_dut;
   wire       lcd_on_dut;   
   wire [17:0] ledr_dut;
   wire [8:0]  ledg_dut;
   

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
   assign i_wait_event_0.wait_event_if.wait_signals[2] = `C_AXI4_LITE_MASTER_PATH.done;
   
   // SET SET_INJECTOR SIGNALS
   assign `C_AXI4_LITE_MASTER_PATH.start         = i_set_injector_0.set_injector_if.set_signals_synch[0];
   assign `C_AXI4_LITE_MASTER_PATH.addr          = i_set_injector_0.set_injector_if.set_signals_synch[1];
   assign `C_AXI4_LITE_MASTER_PATH.rnw           = i_set_injector_0.set_injector_if.set_signals_synch[2];
   assign `C_AXI4_LITE_MASTER_PATH.strobe        = i_set_injector_0.set_injector_if.set_signals_synch[3];
   assign `C_AXI4_LITE_MASTER_PATH.master_wdata  = i_set_injector_0.set_injector_if.set_signals_synch[4];
  
   // SET SET_INJECTOR INITIAL VALUES
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[0]  = 0;
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[1]  = 0;
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[2]  = 0;
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[3]  = 0;
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[4]  = 0;
  
   // SET CHECK_SIGNALS
   assign i_check_level_0.check_level_if.check_signals[0] = `C_AXI4_LITE_MASTER_PATH.master_rdata;
   assign i_check_level_0.check_level_if.check_signals[1] = `C_AXI4_LITE_MASTER_PATH.access_status;

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
                      .G_CHECK_WIDTH     (`C_CHECK_WIDTH)
		      )
   
   tb_class_inst = new (i_wait_event_0.wait_event_if, 
			i_set_injector_0.set_injector_if, 
			i_wait_duration_0.wait_duration_if,
			i_check_level_0.check_level_if);


   initial begin
      // Add Alias of Generic TB Modules
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "START_MASTER",   0);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "ADDR_MASTER",    1);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "RNW_MASTER",     2);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "STROBE_MASTER",  3);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "WDATA_MASTER",   4);
        
      // ADD ALias of WAIT Module        
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "RST_N",            0);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "CLK",              1);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "DONE_MASTER",      2);      
     							       
      // Check Level Alias				       
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "RDATA_MASTER",    0);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "STATUS_MASTER",   1);
     
     
            
      // RUN Testbench Sequencer
      tb_class_inst.tb_sequencer(SCN_FILE_PATH);
   end


   // == DUT ==
   jtag_axi4_lite_top # (
			 .SEL_ALTERA_VJTAG (0),
			 .G_SIMULATION     (`C_SIMULATION)
			 )
   i_dut (
	  .clk   (clk),
	  .rst_n (rst_n),
	  	  
	  .o_seg0 (seg0_dut),
	  .o_seg1 (seg1_dut),
	  .o_seg2 (seg2_dut),
	  .o_seg3 (seg3_dut),
	  .o_seg4 (seg4_dut),
	  .o_seg5 (seg5_dut),
	  .o_seg6 (seg6_dut),
	  .o_seg7 (seg7_dut),
  
	  .io_lcd_data (lcd_data_dut),   
	  .o_lcd_rw    (lcd_rw_dut),
	  .o_lcd_en    (lcd_en_dut),
	  .o_lcd_rs    (lcd_rs_dut),
	  .o_lcd_on    (lcd_on_dut),	  
    
	  .ledr (ledr_dut),
	 	  
	  .ledg (ledg_dut)
	  );

   
endmodule // tb_top
