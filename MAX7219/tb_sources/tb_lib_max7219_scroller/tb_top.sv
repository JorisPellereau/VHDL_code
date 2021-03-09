//                              -*- Mode: Verilog -*-
// Filename        : tb_top.sv
// Description     : Testbench TOP
// Author          : JorisP
// Created On      : Mon Oct 12 21:51:03 2020
// Last Modified By: JorisP
// Last Modified On: Mon Oct 12 21:51:03 2020
// Update Count    : 0
// Status          : V1.0

/*
 *  Testbench TOP for test of MAX7219 SCROLLER Block
 * 
 */ 

`timescale 1ps/1ps


`include "/home/jorisp/GitHub/VHDL_code/MAX7219/tb_sources/tb_lib_max7219_scroller/testbench_setup.sv"
`include "/home/jorisp/GitHub/Verilog/lib_testbench/wait_event_wrapper.sv"
`include "/home/jorisp/GitHub/Verilog/lib_testbench/set_injector_wrapper.sv"
`include "/home/jorisp/GitHub/Verilog/lib_testbench/wait_duration_wrapper.sv"
`include "/home/jorisp/GitHub/Verilog/lib_testbench/check_level_wrapper.sv"
`include "/home/jorisp/GitHub/Verilog/lib_testbench/tb_tasks.sv"


// TB TOP
module tb_top
  #(
    parameter SCN_FILE_PATH = "scenario.txt"
   )
   ();
   

   
   // == INTERNAL SIGNALS ==
   
   wire clk;
   wire rst_n;

   // Signals from SET Injector
   wire s_me;
   wire s_we;
   wire [7:0]  s_addr;
   wire [7:0]  s_wdata;
   wire [7:0]  s_rdata;

   // Signals to DUT
   wire s_me_dut;
   wire s_we_dut;
   wire [7:0]  s_addr_dut;
   wire [7:0]  s_wdata_dut;
   wire [7:0]  s_rdata_dut;

   // Signals from LOAD RAM Injector
   wire s_me_load_ram;
   wire s_we_load_ram;
   wire [7:0]  s_addr_load_ram;
   wire [7:0]  s_wdata_load_ram;
   wire [7:0]  s_rdata_load_ram;
   wire [7:0]  s_sel_load_ram;

   wire [7:0]  s_ram_start_addr_load_ram;
   wire [7:0]  s_ram_stop_ptr_load_ram;
   wire        s_start_load_ram;
   wire        s_done_load_ram;   
      
   
   wire [7:0]  s_ram_start_ptr;   
   wire [7:0]  s_msg_length;
   wire [31:0] s_max_tempo_cnt;
   
   
   wire      s_start_scroll;
   wire      s_max7219_if_done;
   wire      s_max7219_if_start;
   wire      s_max7219_if_en_load;
   wire [15:0] s_max7219_if_data;
   
   wire        s_max7219_load;
   wire        s_max7219_data;
   wire        s_max7219_clk;

   wire        s_busy;
   
   

   wire [7:0]  s_display_reg_matrix_n;
   wire        s_display_screen_matrix_checker;
   wire        s_display_screen_matrix;
   wire        s_display_screen_sel;  

   wire        s_load_ram_sel; // 0 : Load via SET injector - 1 : Load via LOAD RAM Injector
    
   

   // SET INJECTOR signals
   wire [31:0] i0;
   wire [31:0] i1;
   wire [31:0] i2;
   wire [31:0] i3;
   wire [31:0] i4;

   
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
   

   // =====================================================

   // == TESTBENCH MODULES ALIASES & SIGNALS AFFECTATION ==

   // INIT WAIT EVENT ALIAS
   assign s_wait_event_if.wait_alias[0] = "RST_N";
   assign s_wait_event_if.wait_alias[1] = "CLK";
   assign s_wait_event_if.wait_alias[2] = "BUSY";
   assign s_wait_event_if.wait_alias[3] = "MAX7219_LOAD";
   assign s_wait_event_if.wait_alias[4] = "DONE_LOAD_RAM";

   // SET WAIT EVENT SIGNALS
   assign s_wait_event_if.wait_signals[0] = rst_n;
   assign s_wait_event_if.wait_signals[1] = clk;
   assign s_wait_event_if.wait_signals[2] = s_busy;
   assign s_wait_event_if.wait_signals[3] = s_max7219_load;
   assign s_wait_event_if.wait_signals[4] = s_done_load_ram;

   // INIT SET ALIAS
   assign s_set_injector_if.set_alias[0]  = "ME";
   assign s_set_injector_if.set_alias[1]  = "WE";
   assign s_set_injector_if.set_alias[2]  = "ADDR";
   assign s_set_injector_if.set_alias[3]  = "WDATA";
   assign s_set_injector_if.set_alias[4]  = "RAM_START_PTR";
   assign s_set_injector_if.set_alias[5]  = "MSG_LENGTH";
   assign s_set_injector_if.set_alias[6]  = "START_SCROLL";
   assign s_set_injector_if.set_alias[7]  = "MAX_TEMPO_CNT";
   assign s_set_injector_if.set_alias[8]  = "DISPLAY_REG_MATRIX_N";
   assign s_set_injector_if.set_alias[9]  = "DISPLAY_SCREEN_MATRIX";

   // MUX : Sel from SET inj or to LOAD output of MAX7219 checker
   assign s_set_injector_if.set_alias[10]  = "DISPLAY_SCREEN_SEL";

   // MUX : Sel SET inj or checker
   assign s_set_injector_if.set_alias[11]  = "LOAD_RAM_SEL";

   // RAM LOAD Injector Control signals
   assign s_set_injector_if.set_alias[12]  = "START_ADDR_LOAD_RAM";
   assign s_set_injector_if.set_alias[13]  = "STOP_ADDR_LOAD_RAM";
   assign s_set_injector_if.set_alias[14]  = "START_LOAD_RAM";
   assign s_set_injector_if.set_alias[15]  = "SEL_PATTERN_LOAD_RAM";
   
   
   // SET SET_INJECTOR SIGNALS
   assign s_me                    = s_set_injector_if.set_signals_synch[0];
   assign s_we                    = s_set_injector_if.set_signals_synch[1];
   assign s_addr                  = s_set_injector_if.set_signals_synch[2];
   assign s_wdata                 = s_set_injector_if.set_signals_synch[3];
   assign s_ram_start_ptr         = s_set_injector_if.set_signals_synch[4];
   assign s_msg_length            = s_set_injector_if.set_signals_synch[5];
   assign s_start_scroll          = s_set_injector_if.set_signals_synch[6];
   assign s_max_tempo_cnt         = s_set_injector_if.set_signals_synch[7];   
   assign s_display_reg_matrix_n  = s_set_injector_if.set_signals_synch[8];
   assign s_display_screen_matrix = s_set_injector_if.set_signals_synch[9];
   assign s_display_screen_sel    = s_set_injector_if.set_signals_synch[10];

   // MAX : Sel SET inj or checker
   assign s_load_ram_sel          = s_set_injector_if.set_signals_synch[11];

   // RAM LOAD Injector Control signals
   assign s_ram_start_addr_load_ram = s_set_injector_if.set_signals_synch[12];
   assign s_ram_stop_ptr_load_ram   = s_set_injector_if.set_signals_synch[13];
   assign s_start_load_ram          = s_set_injector_if.set_signals_synch[14];
   assign s_sel_load_ram            = s_set_injector_if.set_signals_synch[15];
   
   // SET SET_INJECTOR INITIAL VALUES
   assign s_set_injector_if.set_signals_asynch_init_value[0]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[1]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[2]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[3]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[4]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[5]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[6]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[7]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[8]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[9]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[10]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[11]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[12]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[13]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[14]  = 0;
   assign s_set_injector_if.set_signals_asynch_init_value[15]  = 0;
   
   // INIT CHECK LEVEL ALIAS
   assign s_check_level_if.check_alias[0] = "BUSY";
   assign s_check_level_if.check_alias[1] = "TOTO1";
   assign s_check_level_if.check_alias[2] = "TOTO2";
   assign s_check_level_if.check_alias[3] = "TOTO3";
   assign s_check_level_if.check_alias[4] = "TOTO4";

   // SET CHECK_SIGNALS
   assign s_check_level_if.check_signals[0] =  s_busy;
   assign s_check_level_if.check_signals[1] =  32'hCAFEDEC0;
   assign s_check_level_if.check_signals[2] =  32'hCAFEDEC1;
   assign s_check_level_if.check_signals[3] =  32'hCAFEDEC2;
   assign s_check_level_if.check_signals[4] =  32'hCAFEDEC3;
  
   // =====================================================


   
   // == HDL GENERIC TESTBENCH MODULES ==

   // WAIT EVENT TB WRAPPER INST
   wait_event_wrapper #(
			.ARGS_NB    (`C_CMD_ARGS_NB),
			.CLK_PERIOD (`C_TB_CLK_PERIOD)
   )
   i_wait_event_wrapper (
       .clk            (clk),
       .rst_n          (rst_n),
       .wait_event_if  (s_wait_event_if)			 
   );


   // SET INJECTOR TB WRAPPER INST
   set_injector_wrapper #(
			  .ARGS_NB(`C_CMD_ARGS_NB) 
   )
   i_set_injector_wrapper (
       .clk              (clk),
       .rst_n            (rst_n),
       .set_injector_if  (s_set_injector_if)			   
   );
   
   
   // ===========================


   // == TESTBENCH SEQUENCER ==
   
   // CREATE CLASS - Configure Parameters
   static tb_class #( `C_CMD_ARGS_NB, 
                      `C_SET_SIZE, 
                      `C_SET_WIDTH,
                      `C_WAIT_ALIAS_NB,
                      `C_WAIT_WIDTH, 
                      `C_TB_CLK_PERIOD,
                      `C_CHECK_SIZE,
                      `C_CHECK_WIDTH) 
   tb_class_inst = new (s_wait_event_if, 
                        s_set_injector_if, 
                        s_wait_duration_if,
                        s_check_level_if);
   
   
   initial begin// : TB_SEQUENCER
      tb_class_inst.tb_sequencer(SCN_FILE_PATH);
      
   end// : TB_SEQUENCER
   
   // ========================


   

   // == MAX7219 IF INST ==
   max7219_if #(
		.G_MAX_HALF_PERIOD (4),
		.G_LOAD_DURATION   (4)
   )
   i_max7219_if_0 (
		   .clk    (clk),
		   .rst_n  (rst_n),

		   .i_start    (s_max7219_if_start),
		   .i_en_load  (s_max7219_if_en_load),
		   .i_data     (s_max7219_if_data),

		   .o_max7219_load  (s_max7219_load),
		   .o_max7219_data  (s_max7219_data),
		   .o_max7219_clk   (s_max7219_clk),
		   .o_done          (s_max7219_if_done)
   );
   
   // =======================

   // == MAX7219 MATRIX EMUL ==
   max7219_checker_wrapper #(
                         .G_NB_MATRIX  (8)
    )
    i_max7219_checker_wrapper_0
    (
                          .clk  (clk),
                          .rst_n  (rst_n),
     
                          .i_max7219_clk   (s_max7219_clk),
                          .i_max7219_din   (s_max7219_data),
                          .i_max7219_load  (s_max7219_load),
     
                          .i_display_reg_matrix_n   (s_display_reg_matrix_n),
                          .i_display_screen_matrix  (s_display_screen_matrix_checker)
     
    );
   // =========================
   

   assign s_display_screen_matrix_checker = (s_display_screen_sel == 0) ? s_display_screen_matrix : s_max7219_load;


   // RAM Load Injector
   load_ram_injector #(
		       .G_RAM_ADDR_WIDTH  (8),
		       .G_RAM_DATA_WIDTH  (8),
		       .G_SEL_WIDTH       (8)
		       )
   i_load_ram_injector_0 (
			  .clk    (clk),
			  .rst_n  (rst_n),

			  .i_ram_start_addr  (s_ram_start_addr_load_ram),
			  .i_ram_stop_addr   (s_ram_stop_ptr_load_ram),
			  .i_sel             (s_sel_load_ram),
			  .i_start           (s_start_load_ram),

			  .o_me     (s_me_load_ram),
			  .o_we     (s_we_load_ram),
			  .o_addr   (s_addr_load_ram),
			  .o_wdata  (s_wdata_load_ram),
			  .i_rdata  (s_rdata_load_ram),

			  .o_done (s_done_load_ram)
   );
   
   


   assign s_me_dut    = (s_load_ram_sel == 0) ? s_me    : s_me_load_ram;
   assign s_we_dut    = (s_load_ram_sel == 0) ? s_we    : s_we_load_ram;
   assign s_addr_dut  = (s_load_ram_sel == 0) ? s_addr  : s_addr_load_ram;
   assign s_wdata_dut = (s_load_ram_sel == 0) ? s_wdata : s_wdata_load_ram;
   assign s_rdata     = s_rdata_dut;
   

   // == DUT INST ==
   max7219_scroller_ctrl #(
		           .G_MATRIX_NB       (8),
		           .G_RAM_ADDR_WIDTH  (8),
		           .G_RAM_DATA_WIDTH  (8)
   )
   i_dut (
	  .clk   (clk),
	  .rst_n (rst_n),

	  .i_me     (s_me_dut),
	  .i_we     (s_we_dut),
	  .i_addr   (s_addr_dut),
	  .i_wdata  (s_wdata_dut),
	  .o_rdata  (s_rdata_dut),

	  .i_ram_start_ptr     (s_ram_start_ptr),
	  .i_msg_length        (s_msg_length),
	  .i_start_scroll      (s_start_scroll),
	  .i_max_tempo_cnt     (s_max_tempo_cnt),

	  .i_max7219_if_done    (s_max7219_if_done),
	  .o_max7219_if_start   (s_max7219_if_start),
	  .o_max7219_if_en_load (s_max7219_if_en_load),
	  .o_max7219_if_data    (s_max7219_if_data),

	  .o_busy               (s_busy)
   );
   
   // ==============

   
endmodule // tb_top
