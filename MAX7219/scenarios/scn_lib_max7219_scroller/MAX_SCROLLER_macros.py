import sys


# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import generic_tb_cmd_class
import scn_class


# Init SCROLLER_RAM to 0x00
def INIT_SCROLLER_RAM(scn, data_init):
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("ME", 1)
    scn.generic_tb_cmd.SET("WE", 1)
    scn.print_line("\n")
    
    for i in range(0, 256):
        scn.generic_tb_cmd.WTFS("CLK")
        scn.generic_tb_cmd.SET("ADDR", i)
        scn.generic_tb_cmd.SET("WDATA", data_init)
        scn.print_line("\n")

    scn.generic_tb_cmd.WTFS("CLK")    
    scn.generic_tb_cmd.SET("ME", 0)
    scn.generic_tb_cmd.SET("WE", 0)
    scn.print_line("\n")
    return scn


# LOAD SCROLLER RAM with a specified pattern
def LOAD_PATTERN_I_SCROLLER(scn, pattern_i, start_addr):
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("ME", 1)
    scn.generic_tb_cmd.SET("WE", 1)
    scn.print_line("\n")

    for i in range(0, 8*8):
        scn.generic_tb_cmd.WTFS("CLK")
        scn.generic_tb_cmd.SET("ADDR", i + start_addr)
        scn.generic_tb_cmd.SET("WDATA", int(pattern_i[i], 16))
        scn.print_line("\n")

    scn.generic_tb_cmd.WTFS("CLK") 
    scn.generic_tb_cmd.SET("ME", 0)
    scn.generic_tb_cmd.SET("WE", 0)
    scn.print_line("\n")
    return scn


# Display Screen Matrix
def DISPLAY_MATRIX(scn):
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("DISPLAY_SCREEN_MATRIX", 1)
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("DISPLAY_SCREEN_MATRIX", 0)
    return scn
