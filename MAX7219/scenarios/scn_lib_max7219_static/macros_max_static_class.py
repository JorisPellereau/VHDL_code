import sys


# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import scn_class

class macros_max_static_class:

    def __init__(self):
        self.scn = scn_class.scn_class()

    # Init STATIC_RAM to 0x0000
    def INIT_STATIC_RAM(self):
        self.scn.WTFS("CLK")
        self.scn.SET("ME", 1)
        self.scn.SET("WE", 1)
        self.scn.print_line("\n")

        for i in range(0, 256):
            self.scn.WTFS("CLK")
            self.scn.SET("ADDR", i)
            self.scn.SET("WDATA", 0)
            self.scn.print_line("\n")

        self.scn.WTFS("CLK")    
        self.scn.SET("ME", 0)
        self.scn.SET("WE", 0)
        self.scn.print_line("\n")




    # LOAD STATIC RAM with a specific pattern
    def LOAD_PATTERN_I_STATIC(self, pattern_i, start_addr):
        self.scn.WTFS("CLK")
        self.scn.SET("ME", 1)
        self.scn.SET("WE", 1)
        self.scn.print_line("\n")

        reg_addr     = 1 # Addr Digit 0
        matrix       = 0
        cnt_7        = 0
        load         = 0
        data_2_write = 0

        for i in range(0, 8*8):

            data_2_write = (load << 12) | (reg_addr << 8) | int(pattern_i[i], 16)
            self.scn.WTFS("CLK")
            self.scn.SET("ADDR", i + start_addr)
            self.scn.SET("WDATA", data_2_write)
            self.scn.print_line("\n")

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

            self.scn.WTFS("CLK") 
            self.scn.SET("ME", 0)
            self.scn.SET("WE", 0)
            self.scn.print_line("\n")
