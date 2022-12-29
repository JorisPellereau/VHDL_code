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
import macros_tb_unit_lcd_cfah_top

# Create SCN Class
scn       = scn_class.scn_class()
macros_tb = macros_tb_unit_lcd_cfah_top.macros_tb_unit_lcd_cfah_top(scn)

# == Collect Path ==
#collect_path = "/home/linux-jp/SIMULATION_VHDL/UART_COLLECT/{0}_collect.txt".format(os.path.basename(__file__)[:-3])

# Start of SCN

#scn.DATA_COLLECTOR_INIT("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0, collect_path)
#scn.DATA_COLLECTOR_START("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)

# == VARIABLES CONFIGURATION ==
lines_data_list = [[None for i in range(16)] for j in range(2)]

lines_data_list[0][0] = 0xAA
wait_duration = 1

# Static configuration :
dl_n_f = 0b110 # 8bits - 2 Lines - 5*11 dots
# =============================


# == BEGINNING of SCENARIO ==
scn.print_step("Wait for Reset")

scn.WTR("RST_N")
scn.WAIT(100, "ns")

# ==============================================
scn.print_step("Set configuration of LCD Emulation Block")
# ==============================================
scn.SET("S_BUSY_FLAG_DURATION", wait_duration)

# ==============================================
scn.print_step("Set Static configuration")
# ==============================================
macros_tb.lcd_set_static_config(dl_n_f)
scn.WAIT(400, "ns")

# ==============================================
scn.print_step("Enable LCD power and wait for the end of command")
# ==============================================
macros_tb.lcd_start_cmd(lcd_on = 1)
scn.WTRS("O_CONTROL_DONE", 40, "ms")

# ==============================================
scn.print_step("Update ALL LCD")
# ==============================================
macros_tb.lcd_start_cmd(update_lcd = 1, lcd_all_char = 1)
scn.WTRS("O_CONTROL_DONE", 40, "ms")
scn.WAIT(1, "us")



scn.END_TEST()
