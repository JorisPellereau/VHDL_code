import sys


# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import generic_tb_cmd_class
import scn_class



# Dent de scie
#pattern_0 = ['0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff', '0x40', '0x20', '0x10', '0x8', '0x4', '0x2', '0xff']


#pattern_array = []
#pattern_array.append(pattern_0)

# Init STATIC_RAM to 0x0000
def INIT_STATIC_RAM(scn):
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("I_ME_STATIC", 1)
    scn.generic_tb_cmd.SET("I_WE_STATIC", 1)
    scn.print_line("\n")

    for i in range(0, 256):
        scn.generic_tb_cmd.WTFS("CLK")
        scn.generic_tb_cmd.SET("I_ADDR_STATIC", i)
        scn.generic_tb_cmd.SET("I_WDATA_STATIC", 0)
        scn.print_line("\n")

    scn.generic_tb_cmd.WTFS("CLK")    
    scn.generic_tb_cmd.SET("I_ME_STATIC", 0)
    scn.generic_tb_cmd.SET("I_WE_STATIC", 0)
    scn.print_line("\n")
    return scn


# Init SCROLLER_RAM to 0x00
def INIT_SCROLLER_RAM(scn):
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("I_ME_SCROLLER", 1)
    scn.generic_tb_cmd.SET("I_WE_SCROLLER", 1)
    scn.print_line("\n")
    
    for i in range(0, 256):
        scn.generic_tb_cmd.WTFS("CLK")
        scn.generic_tb_cmd.SET("I_ADDR_SCROLLER", i)
        scn.generic_tb_cmd.SET("I_WDATA_SCROLLER", 0)
        scn.print_line("\n")

    scn.generic_tb_cmd.WTFS("CLK")    
    scn.generic_tb_cmd.SET("I_ME_SCROLLER", 0)
    scn.generic_tb_cmd.SET("I_WE_SCROLLER", 0)
    scn.print_line("\n")
    return scn

# LOAD STATIC RAM with a specific pattern
def LOAD_PATTERN_I_STATIC(scn, pattern_i, start_addr):
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("I_ME_STATIC", 1)
    scn.generic_tb_cmd.SET("I_WE_STATIC", 1)
    scn.print_line("\n")

    reg_addr     = 1 # Addr Digit 0
    matrix       = 0
    cnt_7        = 0
    load         = 0
    data_2_write = 0

    for i in range(0, 8*8):

        data_2_write = (load << 12) | (reg_addr << 8) | int(pattern_i[i], 16)
        scn.generic_tb_cmd.WTFS("CLK")
        scn.generic_tb_cmd.SET("I_ADDR_STATIC", i + start_addr)
        scn.generic_tb_cmd.SET("I_WDATA_STATIC", data_2_write)
        scn.print_line("\n")

        if(cnt_7 < 7):
            cnt_7 +=1
        else:
            cnt_7 = 0
            if(reg_addr < 9):
                reg_addr += 1
            else:
                reg_addr = 1

        if(cnt_7 == 7):
            load = 1
        else:
            load = 0

    scn.generic_tb_cmd.WTFS("CLK") 
    scn.generic_tb_cmd.SET("I_ME_STATIC", 0)
    scn.generic_tb_cmd.SET("I_WE_STATIC", 0)
    scn.print_line("\n")
    return scn



# LOAD SCROLLER RAM with a specified pattern
def LOAD_PATTERN_I_SCROLLER(scn, pattern_i, start_addr):
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("I_ME_SCROLLER", 1)
    scn.generic_tb_cmd.SET("I_WE_SCROLLER", 1)
    scn.print_line("\n")

    for i in range(0, 8*8):
        scn.generic_tb_cmd.WTFS("CLK")
        scn.generic_tb_cmd.SET("I_ADDR_SCROLLER", i + start_addr)
        scn.generic_tb_cmd.SET("I_WDATA_SCROLLER", int(pattern_i[i], 16))
        scn.print_line("\n")

    scn.generic_tb_cmd.WTFS("CLK") 
    scn.generic_tb_cmd.SET("I_ME_SCROLLER", 0)
    scn.generic_tb_cmd.SET("I_WE_SCROLLER", 0)
    scn.print_line("\n")
    return scn


# Display Screen Matrix
def DISPLAY_MATRIX(scn):
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("DISPLAY_SCREEN_MATRIX", 1)
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("DISPLAY_SCREEN_MATRIX", 0)
    return scn
