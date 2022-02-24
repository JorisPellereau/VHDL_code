import sys
import numpy as np


# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

sys.path.append("/home/linux-jp/Documents/GitHub/VHDL_code/MAX7219/scenarios/scn_lib_max7219_static")
# Import class
import macros_max_static_class

sys.path.append("/home/linux-jp/Documents/GitHub/Python/Tools/yattag_debug")
import html_blocs_class

class macros_max_scroller_class:        

    def __init__(self, scn):

        self.patterns_matrix = []
        
        self.scn = scn
        self.macros_max_static_class = macros_max_static_class.macros_max_static_class(scn)
        self.html_blocs = html_blocs_class.html_blocs_class()

        # == CONSTANTES ==
    

        # == Define Matrix from mem_gen.py ==
        self.patterns_matrix.append([240, 240, 15, 15, 240, 240, 0, 0, 0, 4, 14, 31, 31, 14, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, \
                                     126, 255, 255, 255, 239, 199, 66, 0, 0, 0, 0, 0, 0, 0, 1, 3, 215, 3, 1, 0, 0, 0, 0, 0, 0, 0, \
                                     0, 254, 129, 66, 34, 17, 58, 34, 33, 34, 20, 8])

        self.patterns_matrix.append([15, 15, 240, 240, 15, 15, 255, 255, 255, 251, 241, 224, 224, 241, 251, 255, 255, 255, 255,  \
                                     255, 255, 255, 255, 255, 255, 195, 129, 0, 0, 0, 16, 56, 189, 255, 255, 255, 255, 255, 255, \
                                     255, 254, 252, 40, 252, 254, 255, 255, 255, 255, 255, 255, 255, 255, 1, 126, 189, 221, 238, \
                                     197, 221, 222, 221, 235, 247])
    
    def write_data_in_ram(self, ram_addr, ram_data):
        self.macros_max_static_class.write_data_to_ram(ram_addr, ram_data)


    # Check SPI Transaction from ram_data
    # Digit 0 Updated first
    def check_spi_transaction(self, ram_addr, ram_data, msg_length, matrix_nb = 8):                
        
        if(type(ram_data) != list):
            print("Error: type(ram_data) != list")
            
        shift_nb                   = 8*matrix_nb + msg_length#ram_data_len # - 1 ?
        spi_trans_4_screen_refresh = 8*matrix_nb
        spi_transaction_nb         = spi_trans_4_screen_refresh*shift_nb
        offset                     = 0
        
        # data_to_check[0] == Di_M7        
        # data_to_check[1] == Di_M6
        # data_to_check[0] == Di_M7
        data_to_check = np.zeros([shift_nb, 8, matrix_nb], int)

        # Init Matrix with Addr of each digit on bits 11 to 8
        # Digit 0 First
        for i in range(0, 8):
            data_to_check[:, i, :] = (i + 1) << 8 #
            
        self.scn.print_comment("Number of SPI Transaction expected : %d" %(spi_transaction_nb))

        # Init data_to_check with 
        # Loop on Number of shift
        for shift_i in range(0, shift_nb):

            if(shift_i < msg_length):#ram_data_len):

                # Manage wrapp addr
                if((ram_addr + shift_i) > 256):
                    offset = 256
                data_to_check[shift_i, 7, 0] = data_to_check[shift_i, 7, 0] | ram_data[ram_addr + shift_i - offset]
               

            # Loop On 8 Digits
            for digit_i in range(0, 8):
                
                # Loop on matrix_nb
                for matrix_i in range(0, matrix_nb):
                                    
                    self.scn.WTRS("SPI_FRAME_RECEIVED", 1, "ms")

                    self.scn.CHK("SPI_DATA", data_to_check[shift_i, digit_i, matrix_i], "OK")
                    # Every  matrix_nb a frame a LOAD is sended
                    if(matrix_i == matrix_nb - 1):
                        self.scn.WTRS("LOAD_RECEIVED")
            
            # Save current matrix
            data_to_check_tmp = data_to_check
            # Update data_to_check by shift it
            if(shift_i < shift_nb - 1):
                
                data_to_check[shift_i + 1, 6, :] = (data_to_check[shift_i + 1, 6, :] & 0xF00) | (data_to_check_tmp[shift_i, 7, :] & 0xFF)# D7 => D6
                data_to_check[shift_i + 1, 5, :] = (data_to_check[shift_i + 1, 5, :] & 0xF00) | (data_to_check_tmp[shift_i, 6, :] & 0xFF)# D6 => D5
                data_to_check[shift_i + 1, 4, :] = (data_to_check[shift_i + 1, 4, :] & 0xF00) | (data_to_check_tmp[shift_i, 5, :] & 0xFF)# D5 => D4
                data_to_check[shift_i + 1, 3, :] = (data_to_check[shift_i + 1, 3, :] & 0xF00) | (data_to_check_tmp[shift_i, 4, :] & 0xFF) # D4 => D3
                data_to_check[shift_i + 1, 2, :] = (data_to_check[shift_i + 1, 2, :] & 0xF00) | (data_to_check_tmp[shift_i, 3, :] & 0xFF) # D3 => D2
                data_to_check[shift_i + 1, 1, :] = (data_to_check[shift_i + 1, 1, :] & 0xF00) | (data_to_check_tmp[shift_i, 2, :] & 0xFF) # D2 => D1
                data_to_check[shift_i + 1, 0, :] = (data_to_check[shift_i + 1, 0, :] & 0xF00) | (data_to_check_tmp[shift_i, 1, :] & 0xFF)# D1 => D0

                # D0 Mi to D7 Mi-1
                for matrix_i in range(1, matrix_nb):
                    data_to_check[shift_i + 1, 7, matrix_i] = (data_to_check[shift_i + 1, 7, matrix_i] & 0xF00) | (data_to_check[shift_i, 0, matrix_i - 1] & 0xFF)



        buttons_name_list = ["SHIFT_" + str(i) for i in range(shift_nb)]
        div_content_list  = [self.html_blocs.np_array_2_tab(data_to_check[i]) for i in range(shift_nb)]
        html_page_str = self.html_blocs.create_page_with_multiple_button(page_name         = "SPI SCROLLER MATRIX SHIFT DEBUG",
                                                                         buttons_name_list = buttons_name_list,
                                                                         div_content_list  = div_content_list)
        
        f = open("/home/linux-jp/SIMULATION_VHDL/index_scroller_matrix_shift_debug.html", "w")
        f.write(html_page_str)
        f.close()



    # Write Patterns in entire RAM and Check All SPI Transactions
    def send_patterns_and_check(self, start_addr, ram_data, msg_length, check_disable = False):

        self.scn.print_step("INIT RAM")
        self.write_data_in_ram(start_addr, ram_data)

        self.scn.print_step("START SPI TRANSACTIONS")
        self.scn.WTFS("CLK")
        self.scn.SET("START_SCROLL", 0x1)
        self.scn.WTFS("CLK")
        self.scn.SET("START_SCROLL", 0x0)

        if(check_disable == False):
            self.scn.print_step("CHECK SPI TRANSACTIONS")
        self.scn.WTRS("BUSY", 10, "ms")

        if(check_disable == False):
            self.check_spi_transaction(start_addr, ram_data, msg_length)
        self.scn.WTFS("BUSY", 10, "ms")
