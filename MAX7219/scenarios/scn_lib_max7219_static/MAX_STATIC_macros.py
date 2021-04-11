import sys


# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import generic_tb_cmd_class
import scn_class

# Init STATIC_RAM to 0x0000
def INIT_STATIC_RAM(scn):
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("ME", 1)
    scn.generic_tb_cmd.SET("WE", 1)
    scn.print_line("\n")

    for i in range(0, 256):
        scn.generic_tb_cmd.WTFS("CLK")
        scn.generic_tb_cmd.SET("ADDR", i)
        scn.generic_tb_cmd.SET("WDATA", 0)
        scn.print_line("\n")

    scn.generic_tb_cmd.WTFS("CLK")    
    scn.generic_tb_cmd.SET("ME", 0)
    scn.generic_tb_cmd.SET("WE", 0)
    scn.print_line("\n")
    return scn



# LOAD STATIC RAM with a specific pattern
def LOAD_PATTERN_I_STATIC(scn, pattern_i, start_addr):
    scn.generic_tb_cmd.WTFS("CLK")
    scn.generic_tb_cmd.SET("ME", 1)
    scn.generic_tb_cmd.SET("WE", 1)
    scn.print_line("\n")

    reg_addr     = 1 # Addr Digit 0
    matrix       = 0
    cnt_7        = 0
    load         = 0
    data_2_write = 0

    for i in range(0, 8*8):

        data_2_write = (load << 12) | (reg_addr << 8) | int(pattern_i[i], 16)
        scn.generic_tb_cmd.WTFS("CLK")
        scn.generic_tb_cmd.SET("ADDR", i + start_addr)
        scn.generic_tb_cmd.SET("WDATA", data_2_write)
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
    scn.generic_tb_cmd.SET("ME", 0)
    scn.generic_tb_cmd.SET("WE", 0)
    scn.print_line("\n")
    return scn
