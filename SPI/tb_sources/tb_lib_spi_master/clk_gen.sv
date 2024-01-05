
`timescale 1ps/1ps

    module clk_gen
       #(
         parameter int G_CLK_HALF_PERIOD = 10000,
         parameter int G_WAIT_RST        = 100000
       )
       (
        output reg clk_tb,
        output reg rst_n
       );

       // Clock generation
       initial begin
         clk_tb <= 1'b0;
         forever begin
           #G_CLK_HALF_PERIOD;	
           clk_tb <= ~ clk_tb;
         end      
       end

       // Reset generation
       initial begin
         rst_n <= 1'b0;
         #G_WAIT_RST;
         rst_n <= 1'b0;
         #G_WAIT_RST;
         rst_n <= 1'b1;
       end     
   
endmodule // clk_gen