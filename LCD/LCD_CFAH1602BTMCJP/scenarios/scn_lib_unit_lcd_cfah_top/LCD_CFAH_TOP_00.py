# UART_DISPLAY_CTRL_00.py
# Use for the generation of the scenario UART_DISPLAY_CTRL_00.txt
#

# Test of Initialization of STATIC and SCROLLER RAM - Robustness test overs theses commands

import sys
import os
import random
# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/scn_generator'
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

scn.WTRS("RST_N")
scn.WAIT(100, "ns")

scn.print_step("Set LCD ON after 1 us")
scn.WAIT(1, "us")
scn.SET("I_LCD_ON", 1)

scn.WAIT(60, "ms")

# macros_tb.lcd_wr_byte(rs    = 1,
#                       wdata = 0xAA)

# scn.SET("I_LCD_ON", 1)
# scn.WTFS("CLK")
# scn.WTFS("CLK")
# scn.SET("I_LCD_ON", 0)
# scn.WTFS("CLK")

# for i in range(42):
#     scn.WAIT(500, "us")

# scn.SET("I_LCD_ON", 1)
# scn.WTFS("CLK")
# scn.WTFS("CLK")
# scn.SET("I_LCD_ON", 0)
# scn.WTFS("CLK")

# for i in range(42):
#     scn.WAIT(500, "us")

# scn.SET("I_LCD_ON", 1)
# scn.WTFS("CLK")
# scn.WTFS("CLK")
# scn.SET("I_LCD_ON", 0)
# scn.WTFS("CLK")

# for i in range(42):
#     scn.WAIT(500, "us")

scn.END_TEST()
