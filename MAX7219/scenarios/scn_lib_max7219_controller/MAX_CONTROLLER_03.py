# MAX_CONTROLLER_03.py
# Use for the generation of the scenario MAX_CONTROLLER_03.txt
#
#
#


import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import generic_tb_cmd_class
import scn_class

# Import Macros
from MAX_CONTROLLER_macros import INIT_STATIC_RAM, INIT_SCROLLER_RAM, LOAD_PATTERN_I_SCROLLER, LOAD_PATTERN_I_STATIC, DISPLAY_MATRIX


#pattern_0 = ['0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xff', '0xAA'] 


pattern_0 = ['0x80', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0x1', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0']
# Dent de scie
#pattern_0 = ['0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff']

pattern_1 = ['0xfe', '0xfe', '0xfd', '0xfd', '0xfb', '0xfb', '0xf7', '0xf7', '0xef', '0xef', '0xdf', '0xdf', '0xbf', '0xbf', '0x0', '0x0', '0xfd', '0xfd', '0xfb', '0xfb', '0xf7', '0xf7', '0xef', '0xef', '0xdf', '0xdf', '0xbf', '0xbf', '0x0', '0x0', '0xfd', '0xfd', '0xfb', '0xfb', '0xf7', '0xf7', '0xef', '0xef', '0xdf', '0xdf', '0xbf', '0xbf', '0x0', '0x0', '0xfd', '0xfd', '0xfb', '0xfb', '0xf7', '0xf7', '0xef', '0xef', '0xdf', '0xdf', '0xbf', '0xbf', '0x0', '0x0', '0xfd', '0xfd', '0xfb', '0xf3', '0xf7', '0xef']


pattern_2 = ['0x1', '0x1', '0x2', '0x2', '0x4', '0x4', '0x8', '0x8', '0x10', '0x10', '0x20', '0x20', '0x40', '0x40', '0xff', '0xff', '0x2', '0x2', '0x4', '0x4', '0x8', '0x8', '0x10', '0x10', '0x20', '0x20', '0x40', '0x40', '0xff', '0xff', '0x2', '0x2', '0x4', '0x4', '0x8', '0x8', '0x10', '0x10', '0x20', '0x20', '0x40', '0x40', '0xff', '0xff', '0x2', '0x2', '0x4', '0x4', '0x8', '0x8', '0x10', '0x10', '0x20', '0x20', '0x40', '0x40', '0xff', '0xff', '0x2', '0x2', '0x4', '0xc', '0x8', '0x10']

pattern_3 = ['0x81', '0x81', '0x82', '0x82', '0x84', '0x84', '0x88', '0x88', '0x90', '0x90', '0xa0', '0xa0', '0xc0', '0xc0', '0xff', '0xff', '0x3', '0x3', '0x5', '0x5', '0x9', '0x9', '0x11', '0x11', '0x21', '0x21', '0x41', '0x41', '0xff', '0xff', '0x82', '0x82', '0x84', '0x84', '0x88', '0x88', '0x90', '0x90', '0xa0', '0xa0', '0xc0', '0xc0', '0xff', '0xff', '0x3', '0x3', '0x5', '0x5', '0x9', '0x9', '0x11', '0x11', '0x21', '0x21', '0x41', '0x41', '0xff', '0xff', '0x82', '0x82', '0x84', '0x8c', '0x88', '0x90']

# Create SCN Class
scn_max_controller_03 = scn_class.scn_class("MAX_CONTROLLER_03.txt")


# Start of SCN

scn_max_controller_03.print_line("-- STEP 0\n")
scn_max_controller_03.print_line("\n")

scn_max_controller_03.generic_tb_cmd.WTR("RST_N")
scn_max_controller_03.generic_tb_cmd.WAIT(100, "ns")
scn_max_controller_03.print_line("\n")


#// Display SCREEN Matrix on load
#SET DISPLAY_SCREEN_SEL 1
#scn_max_controller_03.generic_tb_cmd.SET("DISPLAY_SCREEN_SEL", 1)

scn_max_controller_03.print_line("-- STEP 1\n")
scn_max_controller_03.print_line("-- Init RAMs with 0\n")
scn_max_controller_03.print_line("\n")


scn_max_controller_03 = INIT_STATIC_RAM(scn_max_controller_03)
scn_max_controller_03 = INIT_SCROLLER_RAM(scn_max_controller_03)


scn_max_controller_03.print_line("-- STEP 2\n")
scn_max_controller_03.print_line("-- LOAD Scroller Patterns\n")
scn_max_controller_03.print_line("\n")


start_addr = 0
scn_max_controller_03 = LOAD_PATTERN_I_SCROLLER(scn_max_controller_03, pattern_0, start_addr)


start_addr = 64
scn_max_controller_03 = LOAD_PATTERN_I_SCROLLER(scn_max_controller_03, pattern_1, start_addr)


start_addr = 64 + 64
scn_max_controller_03 = LOAD_PATTERN_I_SCROLLER(scn_max_controller_03, pattern_2, start_addr)


start_addr = 64 + 64 + 64
scn_max_controller_03 = LOAD_PATTERN_I_SCROLLER(scn_max_controller_03, pattern_3, start_addr)


scn_max_controller_03.print_line("-- STEP 3\n")
scn_max_controller_03.print_line("-- LOAD Static Patterns\n")
scn_max_controller_03.print_line("\n")


start_addr = 0
scn_max_controller_03 = LOAD_PATTERN_I_STATIC(scn_max_controller_03, pattern_3, start_addr)

start_addr = 64
scn_max_controller_03 = LOAD_PATTERN_I_STATIC(scn_max_controller_03, pattern_2, start_addr)

start_addr = 2*64
scn_max_controller_03 = LOAD_PATTERN_I_STATIC(scn_max_controller_03, pattern_1, start_addr)

start_addr = 3*64
scn_max_controller_03 = LOAD_PATTERN_I_STATIC(scn_max_controller_03, pattern_0, start_addr)

scn_max_controller_03.generic_tb_cmd.WTR("O_CONFIG_DONE")
scn_max_controller_03.generic_tb_cmd.WAIT(100, "ns")
scn_max_controller_03.print_line("\n")



scn_max_controller_03.print_line("-- STEP 4\n")
scn_max_controller_03.print_line("-- Display Pattern STATIC\n")
scn_max_controller_03.print_line("\n")


scn_max_controller_03.generic_tb_cmd.SET("I_EN_STATIC", 1)


scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_START_PTR_STATIC", 0x000)
scn_max_controller_03.generic_tb_cmd.SET("I_LAST_PTR_STATIC", 64)
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
scn_max_controller_03.generic_tb_cmd.WTR("O_PTR_EQUALITY_STATIC")
scn_max_controller_03 = DISPLAY_MATRIX(scn_max_controller_03)



scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_START_PTR_STATIC", 64)
scn_max_controller_03.generic_tb_cmd.SET("I_LAST_PTR_STATIC", 2*64)
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
scn_max_controller_03.generic_tb_cmd.WTR("O_PTR_EQUALITY_STATIC")
scn_max_controller_03 = DISPLAY_MATRIX(scn_max_controller_03)

scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_START_PTR_STATIC", 2*64)
scn_max_controller_03.generic_tb_cmd.SET("I_LAST_PTR_STATIC", 3*64)
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
scn_max_controller_03.generic_tb_cmd.WTR("O_PTR_EQUALITY_STATIC")
scn_max_controller_03 = DISPLAY_MATRIX(scn_max_controller_03)

scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_START_PTR_STATIC", 3*64)
scn_max_controller_03.generic_tb_cmd.SET("I_LAST_PTR_STATIC", 4*64)
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 1)
scn_max_controller_03.generic_tb_cmd.WTFS("CLK")
scn_max_controller_03.generic_tb_cmd.SET("I_NEW_DISPLAY", 0)
scn_max_controller_03.generic_tb_cmd.WTR("O_PTR_EQUALITY_STATIC")
scn_max_controller_03 = DISPLAY_MATRIX(scn_max_controller_03)





scn_max_controller_03.generic_tb_cmd.WAIT(100, "us")   
scn_max_controller_03.END_TEST()


