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
dl_n_f = 0b110 # 8bits - 2 Lines - 5*8 dots
# =============================


# == BEGINNING of SCENARIO ==
scn.print_step("Wait for Reset")

scn.WTR("RST_N")
scn.WAIT(100, "ns")

# ==============================================
scn.print_step("Set configuration of LCD Emulation Block")
# ==============================================
scn.SET("S_BUSY_FLAG_DURATION", wait_duration)


# == FIRST Config For font == 0

# ==============================================
scn.print_step("Set Static configuration")
# ==============================================
macros_tb.lcd_set_static_config(dl_n_f)
scn.WAIT(400, "ns")

# ==============================================
scn.print_step("SET CGRAM Buffer")
# ==============================================
cgram_data_list = [i+1 for i in range(8)] + [i+2 for i in range(8)] + [i+3 for i in range(8)] + [i+4 for i in range(8)] + \
    [i+5 for i in range(8)] + [i+6 for i in range(8)] + [i+7 for i in range(8)] + [i+8 for i in range(8)]

macros_tb.lcd_load_cgram_buffer(cgram_data_list)
scn.WAIT(1, "us")

# ==============================================
scn.print_step("SET LCD INIT")
# ==============================================
macros_tb.lcd_start_cmd(lcd_init = 1)
scn.WTRS("O_CONTROL_DONE", 40, "ms")
scn.WAIT(1, "us")

# ==============================================
scn.print_step("Update CGRAM - Update pattern one by one")
# ==============================================

for pattern_i in range(0, 8):
    macros_tb.lcd_start_cmd(update_cgram = 1, cgram_all_char = 0, cgram_char_position = pattern_i)
    scn.WTRS("O_CONTROL_DONE", 40, "ms")
    scn.WAIT(1, "us")






# == FIRST Config For font == 1
dl_n_f = 0b111 # 8bits - 2 Lines - 5*11 dots
# ==============================================
scn.print_step("Set Static configuration")
# ==============================================
macros_tb.lcd_set_static_config(dl_n_f)
scn.WAIT(400, "ns")

# ==============================================
scn.print_step("SET CGRAM Buffer")
# ==============================================
cgram_data_list = [0]*64
cgram_data_list[0:11]  = [1]*11
cgram_data_list[16:27] = [2]*11
cgram_data_list[32:43] = [3]*11
cgram_data_list[48:59] = [4]*11

macros_tb.lcd_load_cgram_buffer(cgram_data_list)
scn.WAIT(1, "us")

# ==============================================
scn.print_step("SET LCD INIT")
# ==============================================
macros_tb.lcd_start_cmd(lcd_init = 1)
scn.WTRS("O_CONTROL_DONE", 40, "ms")
scn.WAIT(1, "us")


# ==============================================
scn.print_step("Update CGRAM - Update pattern one by one")
# ==============================================

for pattern_i in range(0, 8):
    macros_tb.lcd_start_cmd(update_cgram = 1, cgram_all_char = 0, cgram_char_position = pattern_i)
    scn.WTRS("O_CONTROL_DONE", 40, "ms")
    scn.WAIT(1, "us")


scn.WAIT(50, "us")


# == FONT Config 0 and update all CGRAM ==
dl_n_f = 0b110 # 8bits - 2 Lines - 5*8 dots
# ==============================================
scn.print_step("Set Static configuration")
# ==============================================
macros_tb.lcd_set_static_config(dl_n_f)
scn.WAIT(400, "ns")

# ==============================================
scn.print_step("SET CGRAM Buffer")
# ==============================================
cgram_data_list = [0xA]*64


macros_tb.lcd_load_cgram_buffer(cgram_data_list)
scn.WAIT(1, "us")

# ==============================================
scn.print_step("SET LCD INIT")
# ==============================================
macros_tb.lcd_start_cmd(lcd_init = 1)
scn.WTRS("O_CONTROL_DONE", 40, "ms")
scn.WAIT(1, "us")


macros_tb.lcd_start_cmd(update_cgram = 1, cgram_all_char = 1)
scn.WTRS("O_CONTROL_DONE", 40, "ms")
scn.WAIT(1, "us")



# == FONT Config 0 and update all CGRAM ==
dl_n_f = 0b111 # 8bits - 2 Lines - 5*11 dots
# ==============================================
scn.print_step("Set Static configuration")
# ==============================================
macros_tb.lcd_set_static_config(dl_n_f)
scn.WAIT(400, "ns")

# ==============================================
scn.print_step("SET CGRAM Buffer")
# ==============================================
cgram_data_list = [0xC]*64


macros_tb.lcd_load_cgram_buffer(cgram_data_list)
scn.WAIT(1, "us")

# ==============================================
scn.print_step("SET LCD INIT")
# ==============================================
macros_tb.lcd_start_cmd(lcd_init = 1)
scn.WTRS("O_CONTROL_DONE", 40, "ms")
scn.WAIT(1, "us")


macros_tb.lcd_start_cmd(update_cgram = 1, cgram_all_char = 1)
scn.WTRS("O_CONTROL_DONE", 40, "ms")
scn.WAIT(1, "us")


scn.END_TEST()
