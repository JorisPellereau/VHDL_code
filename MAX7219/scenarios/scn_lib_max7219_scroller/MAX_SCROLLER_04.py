# MAX_SCROLLER_04.py
# Use for the generation of the scenario MAX_SCROLLER_04.txt
#
# Corner Tests
# 


import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import generic_tb_cmd_class
import scn_class


pattern_0_scroller = ['0xff', '0x7e', '0x3c', '0x18', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x18', '0x3c', '0x7e', '0xff']

pattern_3_scroller = ['0xff', '0x7e', '0x3c', '0x18', '0x99', '0xdb', '0xff', '0xff', '0xff', '0xdb', '0x99', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0xff', '0x99', '0x99', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x99', '0xdb', '0xff', '0xff', '0xdb', '0x99', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x18', '0x99', '0x99', '0xff', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x0', '0x99', '0xdb', '0xff', '0xff', '0xff', '0xdb', '0x99', '0x18', '0x3c', '0x7e', '0xff']

from MAX_SCROLLER_macros import INIT_SCROLLER_RAM, LOAD_PATTERN_I_SCROLLER, DISPLAY_MATRIX

# Create SCN Class
scn_max_scroller_04 = scn_class.scn_class("MAX_SCROLLER_04.txt")


# Start of SCN

scn_max_scroller_04.print_line("//-- STEP 0\n")
scn_max_scroller_04.print_line("\n")

scn_max_scroller_04.generic_tb_cmd.SET("DISPLAY_SCREEN_SEL", 1) # Screen Display on LOAD

scn_max_scroller_04.generic_tb_cmd.WTR("RST_N")
scn_max_scroller_04.generic_tb_cmd.WAIT(100, "ns")
scn_max_scroller_04.print_line("\n")



scn_max_scroller_04.print_line("//-- STEP 1\n")
scn_max_scroller_04.print_line("//-- Init SCROLLER RAM with 0\n")
scn_max_scroller_04.print_line("\n")


data_init = 0xAA
scn_max_scroller_04 = INIT_SCROLLER_RAM(scn_max_scroller_04, data_init)


scn_max_scroller_04.print_line("//-- STEP 2\n")
scn_max_scroller_04.print_line("//-- LOAD Scroller Patterns\n")
scn_max_scroller_04.print_line("\n")


start_addr = 0
scn_max_scroller_04 = LOAD_PATTERN_I_SCROLLER(scn_max_scroller_04, pattern_3_scroller, start_addr)

scn_max_scroller_04.print_line("//-- STEP 3\n")
scn_max_scroller_04.print_line("//-- Start SCROLLER with Start Ptr - Msg and TEMPO CNt at 0x00000\n")
scn_max_scroller_04.print_line("\n")

scn_max_scroller_04.generic_tb_cmd.WAIT(400, "ns")


for i in range(0, 10):
    scn_max_scroller_04.generic_tb_cmd.SET("RAM_START_PTR", 0)
    scn_max_scroller_04.generic_tb_cmd.SET("MSG_LENGTH", 0)
    scn_max_scroller_04.generic_tb_cmd.SET("MAX_TEMPO_CNT", 0)
    scn_max_scroller_04.print_line("\n")

    scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
    scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 1)
    scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
    scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 0)
    scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
    scn_max_scroller_04.print_line("\n")

    scn_max_scroller_04.generic_tb_cmd.WAIT(20, "ns")
    scn_max_scroller_04.print_line("\n")

    #scn_max_scroller_04.generic_tb_cmd.CHK("BUSY", 1, "OK")
    scn_max_scroller_04.print_line("\n")

    scn_max_scroller_04.generic_tb_cmd.WAIT(20, "ns")
    scn_max_scroller_04.print_line("\n")

    #scn_max_scroller_04.generic_tb_cmd.CHK("BUSY", 1, "ERROR")
    scn_max_scroller_04.print_line("\n")


scn_max_scroller_04.print_line("//-- STEP 4\n")
scn_max_scroller_04.print_line("//-- Start SCROLLER with Start Ptr = 0 - Msg = 4\n")
scn_max_scroller_04.print_line("\n")

scn_max_scroller_04.generic_tb_cmd.SET("RAM_START_PTR", 0)
scn_max_scroller_04.generic_tb_cmd.SET("MSG_LENGTH", 0x04)
scn_max_scroller_04.generic_tb_cmd.SET("MAX_TEMPO_CNT", 0)
scn_max_scroller_04.print_line("\n")

scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 1)
scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 0)
scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.print_line("\n")
    

scn_max_scroller_04.generic_tb_cmd.WTF("BUSY", 60, "ms")




scn_max_scroller_04.print_line("//-- STEP 5\n")
scn_max_scroller_04.print_line("//-- Start SCROLLER with Start Ptr - Msg and TEMPO CNt at 0x00000\n")
scn_max_scroller_04.print_line("\n")

scn_max_scroller_04.generic_tb_cmd.WAIT(400, "ns")


for i in range(0, 10):
    scn_max_scroller_04.generic_tb_cmd.SET("RAM_START_PTR", 0)
    scn_max_scroller_04.generic_tb_cmd.SET("MSG_LENGTH", 0)
    scn_max_scroller_04.generic_tb_cmd.SET("MAX_TEMPO_CNT", 0)
    scn_max_scroller_04.print_line("\n")

    scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
    scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 1)
    scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
    scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 0)
    scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
    scn_max_scroller_04.print_line("\n")

    scn_max_scroller_04.generic_tb_cmd.WAIT(20, "ns")
    scn_max_scroller_04.print_line("\n")

    #scn_max_scroller_04.generic_tb_cmd.CHK("BUSY", 1, "OK")
    scn_max_scroller_04.print_line("\n")

    scn_max_scroller_04.generic_tb_cmd.WAIT(20, "ns")
    scn_max_scroller_04.print_line("\n")

    #scn_max_scroller_04.generic_tb_cmd.CHK("BUSY", 1, "ERROR")
    scn_max_scroller_04.print_line("\n")


scn_max_scroller_04.generic_tb_cmd.WAIT(100, "us")


scn_max_scroller_04.print_line("//-- STEP 6\n")
scn_max_scroller_04.print_line("//-- Start SCROLLER with Start Ptr = 0- Msg length = MAX RAM\n")
scn_max_scroller_04.print_line("\n")



scn_max_scroller_04.generic_tb_cmd.SET("RAM_START_PTR", 0)
scn_max_scroller_04.generic_tb_cmd.SET("MSG_LENGTH", 0xFF)
scn_max_scroller_04.generic_tb_cmd.SET("MAX_TEMPO_CNT", 0)
scn_max_scroller_04.print_line("\n")

scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 1)
scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 0)
scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.print_line("\n")
    

scn_max_scroller_04.generic_tb_cmd.WTF("BUSY", 60, "ms")

scn_max_scroller_04.generic_tb_cmd.WAIT(100, "us")

scn_max_scroller_04.print_line("//-- STEP 7\n")
scn_max_scroller_04.print_line("//-- Start SCROLLER with Start Ptr = 0- Msg length = 0x100 RAM\n")
scn_max_scroller_04.print_line("\n")



scn_max_scroller_04.generic_tb_cmd.SET("RAM_START_PTR", 0)
scn_max_scroller_04.generic_tb_cmd.SET("MSG_LENGTH", 0x100)
scn_max_scroller_04.generic_tb_cmd.SET("MAX_TEMPO_CNT", 0)
scn_max_scroller_04.print_line("\n")

scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 1)
scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 0)
scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.print_line("\n")
    

scn_max_scroller_04.generic_tb_cmd.WTF("BUSY", 60, "ms")

scn_max_scroller_04.generic_tb_cmd.WAIT(100, "us")






scn_max_scroller_04.print_line("//-- STEP 8\n")
scn_max_scroller_04.print_line("//-- Start SCROLLER with Start Ptr = MAX- Msg length = 1\n")
scn_max_scroller_04.print_line("\n")


scn_max_scroller_04.generic_tb_cmd.SET("RAM_START_PTR", 0xFF)
scn_max_scroller_04.generic_tb_cmd.SET("MSG_LENGTH", 0x1)
scn_max_scroller_04.generic_tb_cmd.SET("MAX_TEMPO_CNT", 0)
scn_max_scroller_04.print_line("\n")

scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 1)
scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 0)
scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.print_line("\n")
    

scn_max_scroller_04.generic_tb_cmd.WTFS("BUSY", 60, "ms")

scn_max_scroller_04.generic_tb_cmd.WAIT(100, "us")



scn_max_scroller_04.print_line("//-- STEP 9\n")
scn_max_scroller_04.print_line("//-- Start SCROLLER with Start Ptr = MAX- Msg length = 15\n")
scn_max_scroller_04.print_line("\n")


scn_max_scroller_04.generic_tb_cmd.SET("RAM_START_PTR", 0xFF)
scn_max_scroller_04.generic_tb_cmd.SET("MSG_LENGTH", 15)
scn_max_scroller_04.generic_tb_cmd.SET("MAX_TEMPO_CNT", 0)
scn_max_scroller_04.print_line("\n")

scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 1)
scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 0)
scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.print_line("\n")
    

scn_max_scroller_04.generic_tb_cmd.WTFS("BUSY", 60, "ms")

scn_max_scroller_04.generic_tb_cmd.WAIT(100, "us")


scn_max_scroller_04.print_line("//-- STEP 10\n")
scn_max_scroller_04.print_line("//-- Start SCROLLER with Start Ptr = 128- Msg length = 0xFF\n")
scn_max_scroller_04.print_line("\n")


scn_max_scroller_04.generic_tb_cmd.SET("RAM_START_PTR", 0x80)
scn_max_scroller_04.generic_tb_cmd.SET("MSG_LENGTH", 255)
scn_max_scroller_04.generic_tb_cmd.SET("MAX_TEMPO_CNT", 0)
scn_max_scroller_04.print_line("\n")

scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 1)
scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.generic_tb_cmd.SET("START_SCROLL", 0)
scn_max_scroller_04.generic_tb_cmd.WTFS("CLK")
scn_max_scroller_04.print_line("\n")
    

scn_max_scroller_04.generic_tb_cmd.WTFS("BUSY", 60, "ms")

scn_max_scroller_04.generic_tb_cmd.WAIT(100, "us")

scn_max_scroller_04.END_TEST()
