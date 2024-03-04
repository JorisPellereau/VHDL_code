

`timescale 1ps/1ps

// INCLUDES
`include "/home/linux-jp/Documents/GitHub/VHDL_code/I2C/tb_sources/tb_lib_i2c/testbench_setup.sv"
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

   // == DUT SIGNALS ==
   wire start_dut;
   wire rw_dut;
   wire [6:0] chip_addr_dut;
   wire [$clog2(`C_NB_DATA):0] nb_data_dut;
   wire 		       wr_en_fito_tx_dut;
   wire [7:0] 		       wdata_fifo_tx_dut;
   wire 		       fifo_empty_fifo_tx_dut;
   wire 		       fifo_full_fifo_tx_dut;
   wire 		       rd_en_fifo_rx_dut;
   wire [7:0] 		       rdata_fifo_rx_dut;
   wire 		       fifo_empty_fifo_rx_dut;
   wire 		       fifo_full_fifo_rx_dut;
   wire 		       sack_error_dut;
   wire 		       busy_dut;
   wire 		       sclk_dut;
   wire 		       sclk_en_dut;
   wire 		       sda_in_dut;
   wire 		       sda_out_dut;
   wire 		       sda_en_dut;
   
   // Common signals between DUT and I2C Slave
   wire 		       sclk;
   wire 		       sda;
   
   reg 	[$clog2(`C_NB_DATA):0]      nb_data_i2c_slave;
   

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
   assign i_wait_event_0.wait_event_if.wait_signals[2] = busy_dut;
   
   // SET SET_INJECTOR SIGNALS
   assign start_dut           = i_set_injector_0.set_injector_if.set_signals_synch[0];
   assign rw_dut              = i_set_injector_0.set_injector_if.set_signals_synch[1];
   assign chip_addr_dut       = i_set_injector_0.set_injector_if.set_signals_synch[2];
   assign nb_data_dut         = i_set_injector_0.set_injector_if.set_signals_synch[3];
   assign wr_en_fifo_tx_dut   = i_set_injector_0.set_injector_if.set_signals_synch[4];
   assign wdata_fifo_tx_dut   = i_set_injector_0.set_injector_if.set_signals_synch[5];
   assign rd_en_fifo_rx_dut   = i_set_injector_0.set_injector_if.set_signals_synch[6];
  
   // SET SET_INJECTOR INITIAL VALUES
   genvar 			 i;
   for(i = 0; i < 7 ; i++) begin
      assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[i]  = 0;
   end
  
   // SET CHECK_SIGNALS
   assign i_check_level_0.check_level_if.check_signals[0] = rdata_fifo_rx_dut;

   // WAIT DURATION Connection
   assign i_wait_duration_0.wait_duration_if.clk = clk; // Assign Clock
   // =====================================================

   

   // CREATE Handle and object CLASS - Configure Parameters
   
   static tb_class #( .G_SET_SIZE             (`C_SET_SIZE),
                      .G_SET_WIDTH            (`C_SET_WIDTH),
                      .G_WAIT_SIZE            (`C_WAIT_ALIAS_NB),
                      .G_WAIT_WIDTH           (`C_WAIT_WIDTH), 
                      .G_CLK_PERIOD           (`C_TB_CLK_PERIOD),
                      .G_CHECK_SIZE           (`C_CHECK_SIZE),
                      .G_CHECK_WIDTH          (`C_CHECK_WIDTH),
		      .G_SLAVE_I2C_FIFO_DEPTH (`C_SLAVE_I2C_FIFO_DEPTH)
		      )
   
   tb_class_inst = new (i_wait_event_0.wait_event_if, 
			i_set_injector_0.set_injector_if, 
			i_wait_duration_0.wait_duration_if,
			i_check_level_0.check_level_if);


   initial begin
      // Add Alias of Generic TB Modules
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "START",         0);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "RW",            1);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "CHIP_ADDR",     2);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "NB_DATA",       3);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "WR_EN_FIFO_TX", 4);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "WDATA_FIFO_TX", 5);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "RD_EN_FIFO_RX", 6);
        
      // ADD ALias of WAIT Module        
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "RST_N",            0);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "CLK",              1);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "BUSY",             2);
     
      // Check Level Alias
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "RDATA_FIFO_RX",   0);

      // I2C Slave EEPROM Module configuration
      tb_class_inst.tb_modules_custom_inst.init_slave_i2c_custom_class(i_i2c_slave_0.i2c_slave_if, "I2C_SLAVE");
      
      // RUN Testbench Sequencer
      tb_class_inst.tb_sequencer(SCN_FILE_PATH);
   end


   // == DUT ==
   i2c_master #(
		.G_I2C_FREQ        (`C_I2C_FREQ), 
		.G_CLKSYS_FREQ     (`C_CLKSYS_FREQ), 
		.G_NB_DATA         (`C_NB_DATA), 
		.G_FIFO_DATA_WIDTH (`C_FIFO_DATA_WIDTH),
		.G_FIFO_DEPTH      (`C_FIFO_DEPTH)
		) 
   i_dut (
	  .clk_sys   (clk),
	  .rst_n_sys (rst_n),
	  
	  // Control Signals
	  .start     (start_dut),
	  .rw        (rw_dut),
	  .chip_addr (chip_addr_dut),
	  .nb_data   (nb_data_dut),
	  
	  // FIFO TX Control and Status
	  .wr_en_fifo_tx      (wr_en_fifo_tx_dut),
	  .wdata_fifo_tx      (wdata_fifo_tx_dut),
	  .fifo_empty_fifo_tx (fifo_empty_fifo_tx_dut),
	  .fifo_full_fifo_tx  (fifo_full_fifo_tx_dut),
	  
	  // FIFO RX Control and Status
	  .rd_en_fifo_rx      (rd_en_fifo_rx_dut),
	  .rdata_fifo_rx      (rdata_fifo_rx_dut),
	  .fifo_empty_fifo_rx (fifo_empty_fifo_rx_dut),
	  .fifo_full_fifo_rx  (fifo_full_fifo_rx_dut),
	  
	  // Status and data
	  .sack_error (sack_error_dut),
	  .busy       (busy_dut),
	  
	  // I2C Interface    
	  .sclk    (sclk_dut),
	  .sclk_en (sclk_en_dut),
	  .sda_in  (sda_in_dut),
	  .sda_out (sda_out_dut),
	  .sda_en  (sda_en_dut)
	  );

   assign sclk = sclk_en_dut ? sclk_dut    : 1'bZ;
   assign sda  = sda_en_dut  ? sda_out_dut : 1'bZ;
   
   assign sda_in_dut = sda;   

   pullup(sclk);
   pullup(sda);
   
   // I2C Slave Checker

   // Instanciation of an I2C Slave
   i2c_slave #(
	       .G_SLAVE_I2C_FIFO_DEPTH (`C_SLAVE_I2C_FIFO_DEPTH)
	       )
   i_i2c_slave_0
     (
      .rst_n   (rst_n),
      .nb_data (nb_data_i2c_slave),
      .sclk    (sclk),
      .sda     (sda)
      );

   // Latch nb_data for the I2C Slave on start_dut pulse
   always @(posedge start_dut) begin
      nb_data_i2c_slave <= nb_data_dut;    
   end
   
endmodule // tb_top
