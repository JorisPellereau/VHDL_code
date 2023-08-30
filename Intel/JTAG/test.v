module test (clock, rst_n, leds);
   input clock;
   input rst_n;
   
   output [7:0] leds;
   
   
   // Signals and registers declared for VJI instance
   wire 	tck, tdi;
   wire 	tdo;
   wire 	cdr, e1dr, e2dr, pdr, sdr, udr, uir, cir;
   wire  	ir_in;
   // Instantiation of VJI
   my_vji VJI_INST(
		   .tdo (tdo),
		   .tck (tck),
		   .tdi (tdi),
		   .tms(),
		   .ir_in(ir_in),
		   .ir_out(),
		   .virtual_state_cdr (cdr),
		   .virtual_state_e1dr(e1dr),
		   .virtual_state_e2dr(e2dr),
		   .virtual_state_pdr (pdr),
		   .virtual_state_sdr (sdr),
		   .virtual_state_udr (udr),
		   .virtual_state_uir (uir),
		   .virtual_state_cir (cir)
		   );

   

   vJTAG_interface i_vftag_interface_0 (
					.tck   (tck),
					.tdi   (tdi),
					.aclr  (!rst_n),
					.ir_in (ir_in),
					.v_sdr (sdr),
					.udr   (udr),
					.LEDs  (leds[6:0]),
					.tdo   (tdo)
   );

   assign leds[7] = 1;
   

endmodule
