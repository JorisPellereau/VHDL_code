import sys


# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import scn_class

class macros_max_static_class:

    def __init__(self, scn):
        self.scn = scn
        
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


    # Write a single value in RAM and send it
    # Check value through SPI
    # /!\ Only one Data send and One data checked
    def send_one_spi_request_and_check(self, ram_addr, ram_data, spi_check_expected):

        cmd_type = None
        load_en  = None
        
        # Get Command type from Ram DATA
        if((ram_data & 0xE000) == 0x0000):
            cmd_type = "normal_cmd"
        elif((ram_data & 0xE000) == 0x2000):
            cmd_type = "wait_cmd"
        elif((ram_data & 0xE000) == 0x4000):
            cmd_type = "wait_G_MAX_CNT_32B_cmd"
        
        # Detect of LOAD is enable or not
        # Load on bit 12
        if(ram_data & 0x1000 == 0x1000):
            load_en = 1
        else:
            load_en = 0
        

    
        self.scn.print_line("//-- MACRO send_one_spi_request : begin")
        self.scn.print_line("//-- ram_data : %d - cmd_type : %s - load_en : %d" %(ram_data, cmd_type, load_en))
        self.scn.print_line("//-- LOAD DATA to Memory ADDR(%X) : %d\n" %(ram_addr, ram_data))
        self.scn.WTFS("CLK")
        self.scn.SET("ME", 1)
        self.scn.SET("WE", 1)
        self.scn.WTFS("CLK")
        self.scn.SET("ADDR", ram_addr)
        self.scn.SET("WDATA", ram_data)
        self.scn.WTFS("CLK")    
        self.scn.SET("ME", 0)
        self.scn.SET("WE", 0)
        self.scn.WTFS("CLK")

        self.scn.print_line("//-- Set inputs - One Value to transmit\n")
        self.scn.SET("START_PTR", ram_addr)
        self.scn.SET("LAST_PTR", ram_addr + 1)
        self.scn.WTFS("CLK")

        self.scn.print_line("//-- Start Val and wait for received value through SPI\n")
        self.scn.WTFS("CLK")
        self.scn.SET("PTR_VAL", 1)
        self.scn.WTFS("CLK")
        self.scn.SET("PTR_VAL", 0)

        # SPI Frame only generated for normal_cmd
        if(cmd_type == "normal_cmd"):

            if(load_en == 1):
                ram_data = ram_data & 0xEFFF # Force en_load to 0 (not expected in SPI received data)
            # Frame is received before PTR Equality is released
            self.scn.WTRS("SPI_FRAME_RECEIVED", 10, "ms")
            self.scn.CHK("SPI_DATA", ram_data, spi_check_expected)

            # SPI LOAD RECEVIED always after FRAME received
            if(load_en == 1):
                self.scn.WTRS("SPI_LOAD_RECEIVED", 10, "ms")
                
            # Wait for PTR equality
            self.scn.WTRS("PTR_EQUALITY", 10, "ms")            
            
        self.scn.print_line("//-- end")
