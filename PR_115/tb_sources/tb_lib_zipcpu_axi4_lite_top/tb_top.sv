

`timescale 1ps/1ps

// INCLUDES
`include "/home/linux-jp/Documents/GitHub/VHDL_code/PR_115/tb_sources/tb_lib_zipcpu_axi4_lite_top/testbench_setup.sv"
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


   // -- LCD EMUL SIGNALS
   wire [7:0] busy_flag_duration;
   wire [7:0] wdata_lcd_emul;
   wire       wdata_sel_emul;
   wire [7:0] rdata_lcd_emul;
   wire       rdata_val_emul;
   
   
   // -- DUT SIGNALS
   wire       key_1_a_dut;
   wire       key_2_a_dut;
   wire       key_3_a_dut;
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
   wire        max7219_clk_dut;
   wire        max7219_load_dut;
   wire        max7219_data_dut;
   wire        rx_uart_dut;
   wire        tx_uart_dut;
   wire        rts_n_a_dut;
   wire        cts_n_dut;
   wire        spi_master_clk_dut;
   wire        spi_master_cs_n_dut;
   wire [`C_SPI_SIZE-1:0] spi_master_do_dut;
   wire 		  spi_slave_clk_dut;
   wire 		  spi_slave_cs_n_dut;
   wire [`C_SPI_SIZE-1:0] spi_slave_di_dut;
   reg 		  spi_slave_clk_dut_delay;
   reg 		  spi_slave_cs_n_dut_delay;
   reg [`C_SPI_SIZE-1:0] spi_slave_di_dut_delay;
   
   // I2C EEPROM TB signals
   wire 		 sclk_eeprom_dut;
   wire 		 sda_eeprom_dut;
   reg [$clog2(256):0] 	 nb_data_i2c_slave; // Same size as the function inside the DUT

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
   assign i_wait_event_0.wait_event_if.wait_signals[2] = rdata_val_emul;
   assign i_wait_event_0.wait_event_if.wait_signals[3] = ledg_dut[0];
 
   assign wdata_lcd_emul                         = i_set_injector_0.set_injector_if.set_signals_synch[5];
   assign wdata_sel_emul                         = i_set_injector_0.set_injector_if.set_signals_synch[6];
   assign busy_flag_duration                     = i_set_injector_0.set_injector_if.set_signals_synch[7];
  
   // SET SET_INJECTOR INITIAL VALUES
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[0]  = 0;
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[1]  = 0;
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[2]  = 0;
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[3]  = 0;
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[4]  = 0;
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[5]  = 0;
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[6]  = 0;
   assign i_set_injector_0.set_injector_if.set_signals_asynch_init_value[7]  = 0;
  
   // Check Signals affectation
   assign i_check_level_0.check_level_if.check_signals[2] = rdata_lcd_emul;
   assign i_check_level_0.check_level_if.check_signals[3] = ledg_dut;   

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
                      .G_CHECK_WIDTH     (`C_CHECK_WIDTH),

		      .G_SLAVE_I2C_FIFO_DEPTH (`C_SLAVE_I2C_FIFO_DEPTH)
		      )
   
   tb_class_inst = new (i_wait_event_0.wait_event_if, 
			i_set_injector_0.set_injector_if, 
			i_wait_duration_0.wait_duration_if,
			i_check_level_0.check_level_if);


   initial begin
      // Add Alias of Generic TB Modules
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "START_MASTER",        0);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "ADDR_MASTER",         1);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "RNW_MASTER",          2);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "STROBE_MASTER",       3);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "WDATA_MASTER",        4);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "WDATA_LCD",           5);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "SEL_LCD",             6);
      tb_class_inst.ADD_ALIAS("SET_INJECTOR", "BUSY_FLAG_DURATION",  7);
        
      // ADD ALias of WAIT Module        
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "RST_N",            0);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "CLK",              1);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "LCD_VAL",          2);
      tb_class_inst.ADD_ALIAS("WAIT_EVENT", "LEDG_DUT_0",       3); 
     							       
      // Check Level Alias				       
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "RDATA_MASTER",    0);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "STATUS_MASTER",   1);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "LCD_RDATA",       2);
      tb_class_inst.ADD_ALIAS("CHECK_LEVEL", "LEDG",            3);

      // I2C Slave EEPROM Module configuration
      tb_class_inst.tb_modules_custom_inst.init_slave_i2c_custom_class(i_i2c_slave_eeprom_0.i2c_slave_if,
								       "I2C_SLAVE_EEPROM"
								       );
              
      // RUN Testbench Sequencer
      tb_class_inst.tb_sequencer(SCN_FILE_PATH);
   end


   // LCD CFAH Emulator
   LCD_CFAH_emul #(
		   .G_RECEIVED_CMD_BUFFER_SIZE (256)
		   )
   LCD_CFAH_emul_0 (
		    .clk   (clk),
		    .rst_n (rst_n),
		    
		    // Physical Interface
		    .i_rs    (lcd_rs_dut),
		    .i_rw    (lcd_rw_dut),
		    .i_en    (lcd_en_dut),
		    .io_data (lcd_data_dut),
		    
		    // Check Interface
		    .i_busy_flag_duration (busy_flag_duration), // Busy flag duration before set flag to '0'
		    .i_wdata              (wdata_lcd_emul), // Wdata for read operation
		    .i_wdata_sel          (wdata_sel_emul), // If 0 return autonomously busy flag after the busy flag duration, if 1 return i_wdata value
		    .o_rdata              (rdata_lcd_emul), // Data received
		    .o_rdata_val          (rdata_val_emul)
		    );
   
   // == DUT ==
   zipcpu_axi4_lite_top 
     i_dut (
	    .clk   (clk),
	    .rst_n (rst_n),

	    // Push-buttons
	    .key_1_a  (key_1_a_dut),
	    .key_2_a  (key_2_a_dut),    
	    .key_3_a  (key_3_a_dut),
	    
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
	    
	    // MAX7219 Interface
	    .o_max7219_clk  (max7219_clk_dut),
	    .o_max7219_load (max7219_load_dut),
	    .o_max7219_data (max7219_data_dut),
	    
	    // UART Interface
	    .i_rx_uart (rx_uart_dut),
	    .o_tx_uart (tx_uart_dut),
	    .i_rts_n_a (rts_n_a_dut),
	    .o_cts_n   (cts_n_dut),
	    
	    // SPI MASTER I/F
	    .spi_clk  (spi_master_clk_dut),
	    .spi_cs_n (spi_master_cs_n_dut),
	    .spi_do   (spi_master_do_dut),
	    
	    // SPI SLAVE I/F
	    .spi_slave_clk  (spi_slave_clk_dut_delay),
	    .spi_slave_cs_n (spi_slave_cs_n_dut_delay),
	    .spi_slave_di   (spi_slave_di_dut_delay),

	    // I2C MASTER EEPROM I/F
	    .sclk_io_eeprom (sclk_eeprom_dut),
	    .sda_io_eeprom  (sda_eeprom_dut),
	    
	    .ledr (ledr_dut),
	    
	    .ledg (ledg_dut)
	    );


   assign key_1_a_dut = 1;
   assign key_2_a_dut = 1;
   assign key_3_a_dut = 1;


   // Simulate the delay on the line
   always @(spi_slave_clk_dut) begin
      spi_slave_clk_dut_delay <= #100000 spi_slave_clk_dut;
   end

   always @(spi_slave_cs_n_dut) begin
      spi_slave_cs_n_dut_delay <= #100000 spi_slave_cs_n_dut;
   end

   always @(spi_slave_di_dut) begin
      spi_slave_di_dut_delay <= #100000 spi_slave_di_dut;
   end


   pullup(sclk_eeprom_dut);
   pullup(sda_eeprom_dut);
   
   // Instanciation of an I2C Slave : EEPROM simulation
   i2c_slave #(
	       .G_SLAVE_I2C_FIFO_DEPTH (`C_SLAVE_I2C_FIFO_DEPTH)
	       )
   i_i2c_slave_eeprom_0
     (
      .rst_n   (rst_n),
      .nb_data (nb_data_i2c_slave),
      .sclk    (sclk_eeprom_dut),
      .sda     (sda_eeprom_dut)
      );
     
   // DE0 NANO ?
   spi_mirror_top #(
		    .G_SPI_SIZE (4)
		    )
   i_de0_nano_0 (
		 .clk_spi      (spi_master_clk_dut),   
		 .rst_n        (rst_n),
		 .clk_spi_out  (spi_slave_clk_dut),
		 .spi_cs_n     (spi_master_cs_n_dut),
		 .spi_cs_n_out (spi_slave_cs_n_dut),
		 .spi_di       (spi_master_do_dut),
		 .spi_do       (spi_slave_di_dut)
		);
   
   // Latch nb_data for the I2C Slave on start_dut pulse inside the DUT
   always @(posedge i_dut.i_zipcpu_axi4_lite_core_0.i_axi4_lite_i2c_master_eeprom_0.start_i2c) begin
      nb_data_i2c_slave <= i_dut.i_zipcpu_axi4_lite_core_0.i_axi4_lite_i2c_master_eeprom_0.nb_data;
   end
   
endmodule // tb_top
