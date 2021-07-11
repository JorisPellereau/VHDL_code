# SCENARIO For I2C Master block
#
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


scn = scn_class.scn_class("I2C_MASTER_00.txt")


# Start of SCN
scn.print_line("//-- STEP 0 - INIT Inputs\n")
scn.print_line("\n")

CHIP_ADDR = 0x41

scn.generic_tb_cmd.SET("I_START", 0)
scn.generic_tb_cmd.SET("I_RW", 0)
scn.generic_tb_cmd.SET("I_CHIP_ADDR", CHIP_ADDR)
scn.generic_tb_cmd.SET("I_NB_DATA", 1)
scn.generic_tb_cmd.SET("I_WDATA", 0xBB)
scn.generic_tb_cmd.SET("CHIP_ADDR_SLAVE_0", CHIP_ADDR)

scn.generic_tb_cmd.WTRS("RST_N")
scn.generic_tb_cmd.WTFS("CLK")




scn.print_line("//-- STEP 1 - Start WR Transaction for 1 Data\n")
scn.print_line("\n")

scn.generic_tb_cmd.WTFS("CLK")
scn.generic_tb_cmd.SET("I_START", 1)
scn.generic_tb_cmd.WTFS("CLK")
scn.generic_tb_cmd.SET("I_START", 0)


scn.generic_tb_cmd.WAIT("100", "us")



scn.END_TEST()
