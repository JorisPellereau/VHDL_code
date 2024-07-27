

`timescale 1ps/1ps

// INCLUDES
`include "/home/linux-jp/Documents/GitHub/VHDL_code/DE0_nano/tb_sources/tb_lib_top_watch/testbench_setup.sv"
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

              
      // RUN Testbench Sequencer
      tb_class_inst.tb_sequencer(SCN_FILE_PATH);
   end

   
   // == DUT ==

   top_watch 
     i_dut (
	    // Clock and Reset
	    .clk_50MHz (),
	    .rst_n     (),
	    
	    // UART I/F
	    .uart_rx (),
	    .uart_tx (),
	    
	    // MAX7219 I/F
	    .max7219_load (),
	    .max7219_data (),
	    .max7219_clk ()
	    );


   // TEST
   tb_module_class tb_module_class_inst;
   tb_0_module_class tb_0_module_class_inst;
   tb_1_module_class tb_1_module_class_inst;
   tb_2_module_class tb_2_module_class_inst;

   tb_0_module_class tb_0_module_class_inst2;
   
   
   tb_module_class tb_array [5];
   
   initial begin
      tb_module_class_inst   = new("BASE", "MAIN");
      tb_0_module_class_inst = new("CHILD_0", "T0", 50);
      tb_1_module_class_inst = new("CHILD_1", "T1", 30);
      tb_2_module_class_inst = new("CHILD_2", "T2", 31);

      
      $display("Before cast");
      
      $display("BASE Class name : %s - type : %s", tb_module_class_inst.TB_MODULE_NAME, tb_module_class_inst.TB_MODULE_TYPE);
      $display("Child_0 Class name : %s - type : %s - data : %d", tb_0_module_class_inst.TB_MODULE_NAME, tb_0_module_class_inst.TB_MODULE_TYPE, tb_0_module_class_inst.data_child);
      $display("Child_1 Class name : %s - type : %s - data : %d", tb_1_module_class_inst.TB_MODULE_NAME, tb_1_module_class_inst.TB_MODULE_TYPE, tb_1_module_class_inst.data_child);
      


      //$display("Assign tb_module_cass = tb_0_module_class - display name and type");
      tb_module_class_inst = tb_0_module_class_inst; // Assignment allowed
      //$display("BASE Class name : %s - type : %s", tb_module_class_inst.TB_MODULE_NAME, tb_module_class_inst.TB_MODULE_TYPE);
      
      $cast(tb_0_module_class_inst2, tb_module_class_inst);
      $display("Child_0_inst2 Class name : %s - type : %s - data : %d", tb_0_module_class_inst2.TB_MODULE_NAME, tb_0_module_class_inst2.TB_MODULE_TYPE, tb_0_module_class_inst2.data_child);
     
      tb_array[0] = tb_0_module_class_inst;
//tb_module_class_inst;

      $display("tb_array[0] Class name : %s", tb_array[0].TB_MODULE_NAME);
      
      tb_2_module_class_inst.add_child_class(tb_0_module_class_inst/*tb_0_module_class_inst2*/);
      tb_2_module_class_inst.add_child_class(tb_1_module_class_inst/*tb_0_module_class_inst2*/);
      
      $display("class name in index 0 : %s", tb_2_module_class_inst.tb_array[0].TB_MODULE_NAME);
      $display("class name in index 1 : %s", tb_2_module_class_inst.tb_array[1].TB_MODULE_NAME);
      
      
      //tb_module_class_inst = t2_class_inst;
      //$cast(sc2, tb_module_class_inst);
      

      //$display("After cast");
      
      //$display("BASE Class name : %s - type : %s", tb_module_class_inst.TB_MODULE_NAME, tb_module_class_inst.TB_MODULE_TYPE);
      //$display("Child Class name : %s - type : %s - data : %d", test_tb_module_class_inst.TB_MODULE_NAME, test_tb_module_class_inst.TB_MODULE_TYPE, test_tb_module_class_inst.data_child);
      //sc2.print_toto();
      //sc2.print_titi();
      
      
   end
endmodule // tb_top


class tb_module_class;

   string TB_MODULE_NAME; // TB Module Name
   string TB_MODULE_TYPE;

   function new(string new_tb_module_name, string new_tb_module_type);
      this.TB_MODULE_NAME = new_tb_module_name;
      this.TB_MODULE_TYPE = new_tb_module_type;
   endfunction // new
   
endclass // tb_module_class


class tb_0_module_class extends tb_module_class;

   int 	  data_child;
   

   function new (string new_tb_module_name, string new_tb_module_type, int new_data_child);
      super.new(new_tb_module_name, new_tb_module_type);
      this.data_child = new_data_child;
      
   endfunction // new

   function void print_toto();
      $display("TOTO");
      
   endfunction // print_toto
   
      
   
endclass // test_tb_module_class

   
   
class tb_1_module_class extends tb_module_class;

   int 	  data_child;
   

   function new (string new_tb_module_name, string new_tb_module_type, int new_data_child);
      super.new(new_tb_module_name, new_tb_module_type);
      this.data_child = new_data_child;
      
   endfunction // new

   function void print_titi();
      $display("TITI");
      
   endfunction // print_titi
   
      
   
endclass // test_tb_module_class


class tb_2_module_class extends tb_module_class;

   int 	  data_child;

   tb_module_class tb_array [*];
   int 	  array_ptr;
   

   function new (string new_tb_module_name, string new_tb_module_type, int new_data_child);
      super.new(new_tb_module_name, new_tb_module_type);
      this.data_child = new_data_child;

      this.array_ptr = 0;
      
   endfunction // new

   function void print_tito();
      $display("TITo");
      
   endfunction // print_titi


   function void add_child_class(tb_module_class new_tb_module_class);
      this.tb_array[this.array_ptr] = new_tb_module_class;
      this.array_ptr += 1;
      
	
   endfunction // add_child_class
   
      
   
endclass // test_tb_module_class
