import sys
import os
# Path of Python SCN scripts generator
# scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
# sys.path.append(scn_generator_class)

# # Import Class
# import scn_class


class macros_tb_unit_lcd_cfah_itf:

    
        def __init__(self, scn):
            self.scn = scn


            
        def lcd_wr_byte(self, rs, wdata):

            self.scn.print_comment("LCD_WR_Byte - rs : %d - wdata : %X" %(rs, wdata))
            # Single Write
            self.scn.SET("I_WDATA", wdata)
            self.scn.SET("I_RS", rs)
            self.scn.SET("I_RW", 0)
            self.scn.WTFS("CLK")
            self.scn.SET("I_START", 1)
            self.scn.WTFS("CLK")
            self.scn.SET("I_START", 0)
            
            self.scn.WTRS("O_DONE", 1, "us")


        def lcd_rd_byte(self, rs, rdata):

            self.scn.print_comment("LCD_RD_Byte - rs : %d - rdata : %X" %(rs,rdata))
            # Single Read
            self.scn.SET("WDATA_EMUL",rdata)
            self.scn.SET("I_RS", rs)
            self.scn.SET("I_RW", 1)
            self.scn.WTFS("CLK")
            self.scn.SET("I_START", 1)
            self.scn.WTFS("CLK")
            self.scn.SET("I_START", 0)
            
            self.scn.WTRS("O_DONE", 1, "us")
            #self.scn.WTRS("O_RDATA_VAL_EMUL", 1, "us")
            self.scn.CHK("O_LCD_RDATA", rdata, "OK")
