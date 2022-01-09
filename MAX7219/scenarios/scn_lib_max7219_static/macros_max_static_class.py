import sys


# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


# Import Class
import scn_class

class macros_max_static_class:

    # == CONSTANTES ==
    

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

        (cmd_type, load_en, spi_data) = self.get_cmd_type_load_data(ram_data)
     
        self.scn.print_line("//-- MACRO send_one_spi_request : begin")
        self.scn.print_line("//-- ram_data : %d - cmd_type : %s - load_en : %d - spi_data : %X" %(ram_data, cmd_type, load_en, spi_data))
        self.scn.print_line("//-- LOAD DATA to Memory ADDR(%X) : %d\n" %(ram_addr, ram_data))

        self.write_data_to_ram(ram_addr, ram_data)

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


    # Write several data value in RAM and send it
    # Check value through SPI
    # /!\ MAX list element = 256
    def send_multiple_spi_request_and_check(self, ram_addr, ram_data_list, spi_check_expected):

        offset  = 0 # Offset for wrapping addr
        data_nb = 1
        if(len(ram_data_list) > 256):
            print("Error: len(ram_data_list) > 256 !")
        else:
            data_nb = len(ram_data_list)

        # Write DAta to RAM
        self.write_data_to_ram(ram_addr, ram_data_list)

        self.scn.print_line("//-- Set inputs - %d Value to transmit\n" %(data_nb))
        self.scn.SET("START_PTR", ram_addr)
        if(ram_addr + data_nb > 256):
            offset = -256
        self.scn.SET("LAST_PTR", ram_addr + data_nb + offset)
        self.scn.WTFS("CLK")

        self.scn.print_line("//-- Start Val and wait for received value through SPI\n")
        self.scn.WTFS("CLK")
        self.scn.SET("PTR_VAL", 1)
        self.scn.WTFS("CLK")
        self.scn.SET("PTR_VAL", 0)

        for j in range(0, data_nb):            
            (cmd_type, load_en, spi_data) = self.get_cmd_type_load_data(ram_data_list[j])
            
            # SPI Frame only generated for normal_cmd
            if(cmd_type == "normal_cmd"):

                if(load_en == 1):
                    ram_data_list[j] = ram_data_list[j] & 0xEFFF # Force en_load to 0 (not expected in SPI received data)
                # Frame is received before PTR Equality is released
                self.scn.WTRS("SPI_FRAME_RECEIVED", 10, "ms")
                self.scn.CHK("SPI_DATA", ram_data_list[j], spi_check_expected)

                    # SPI LOAD RECEVIED always after FRAME received
                if(load_en == 1):
                    self.scn.WTRS("SPI_LOAD_RECEIVED", 10, "ms")
                
        # Wait for PTR equality after the end of transmission
        self.scn.WTRS("PTR_EQUALITY", 10, "ms")            
            
        self.scn.print_line("//-- end")
        
    # Write DAta to RAM
    # ram_data can be a single data or a list
    def write_data_to_ram(self, ram_addr, ram_data):
        offset  = 0 # Manage wrappe address
        data_nb = 1
        if(type(ram_data) == int):
            data_nb = 1
        elif(type(ram_data) == list):
            data_nb = len(ram_data)
            if(data_nb > 256):
                print("Error: data_nb = %d > 256 !" %(data_nb))
        else:
            print("Error: type(ram_data) != integer or list !")

        self.scn.print_line("//-- Write value to RAM")
        self.scn.WTFS("CLK")
        self.scn.SET("ME", 1)
        self.scn.SET("WE", 1)
        for i in range(0, data_nb):

            if(ram_addr + i > 256):
                offset = -256
                
            self.scn.WTFS("CLK")
            self.scn.SET("ADDR", ram_addr + i + offset)

            # Manage Type (list or int)
            if(type(ram_data) == list):
                self.scn.SET("WDATA", ram_data[i])
            else:
                self.scn.SET("WDATA", ram_data)
                
            self.scn.WTFS("CLK")
        self.scn.SET("ME", 0)
        self.scn.SET("WE", 0)
        self.scn.WTFS("CLK")


    # == LOCAL FUNCTIONS ==

    # Return Command type, load value and spi_data
    def get_cmd_type_load_data(self, ram_data):
        cmd_type = None
        load_en  = None
        spi_data = None
        
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

        # Extract SPI DATA
        spi_data = ram_data & 0xFFF
        return cmd_type, load_en, spi_data
