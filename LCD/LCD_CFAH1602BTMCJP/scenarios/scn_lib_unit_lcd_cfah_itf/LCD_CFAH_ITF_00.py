# UART_DISPLAY_CTRL_00.py
# Use for the generation of the scenario UART_DISPLAY_CTRL_00.txt
#

# Test of Initialization of STATIC and SCROLLER RAM - Robustness test overs theses commands

import sys
import os
import random
# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class


sys.path.append("/home/linux-jp/Documents/GitHub/VHDL_code/LCD/LCD_CFAH1602BTMCJP/scripts/python_scripts/")
import macros_tb_unit_lcd_cfah_itf

# Create SCN Class
scn       = scn_class.scn_class()
macros_tb = macros_tb_unit_lcd_cfah_itf.macros_tb_unit_lcd_cfah_itf(scn)

# == Collect Path ==
#collect_path = "/home/linux-jp/SIMULATION_VHDL/UART_COLLECT/{0}_collect.txt".format(os.path.basename(__file__)[:-3])

# Start of SCN

#scn.DATA_COLLECTOR_INIT("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0, collect_path)
#scn.DATA_COLLECTOR_START("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)


scn.print_step("Wait for Reset")

scn.WTR("RST_N")
scn.WAIT(100, "ns")

macros_tb.lcd_wr_byte(rs    = 0,
                      wdata = 0xAA)

macros_tb.lcd_rd_byte(rs    = 0,
                      rdata = 0xBB)



nb_wr = 10
for i in range(0, nb_wr):
    macros_tb.lcd_wr_byte(rs    = 0,
                          wdata = random.randrange(0, 256))

    

    
#scn.DATA_COLLECTOR_STOP("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)
#scn.DATA_COLLECTOR_CLOSE("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)


scn.END_TEST()
