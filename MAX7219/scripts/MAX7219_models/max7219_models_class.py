import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


sys.path.append("/home/linux-jp/Documents/GitHub/VHDL_code/MAX7219/scenarios/scn_lib_max7219_static")
import macros_max_static_class
import numpy as np

sys.path.append("/home/linux-jp/Documents/GitHub/Python/Tools/yattag_debug")
import html_blocs_class

# Import Class
import scn_class

class max7219_models_class:


    def __init__(self,
                 scn,
                 spi_frame_received_alias,
                 spi_load_received_alias,
                 spi_data_alias,
                 matrix_nb         = 8,
                 static_ram_addr   = 8,
                 scroller_ram_addr = 8):

        self.scn = scn

        self.macros_max_static_class = macros_max_static_class.macros_max_static_class(self.scn)
        
        # == ALIAS from TB ==
        self.spi_frame_received_alias = spi_frame_received_alias
        self.spi_load_received_alias  = spi_load_received_alias
        self.spi_data_alias           = spi_data_alias

        # == GENERICS ==
        self.matrix_nb         = matrix_nb
        self.static_ram_addr   = static_ram_addr
        self.scroller_ram_addr = scroller_ram_addr

        # Memory Model
        self.static_memory   = [0 for i in range(2**static_ram_addr)]
        self.scroller_memory = [0 for i in range(2**scroller_ram_addr)]

        # == MAX7219 INFOS ==
        self.decode_mode_reg_addr  = 0x9
        self.intensity_reg_addr    = 0xA
        self.scan_limit_reg_addr   = 0xB
        self.shutdown_reg_addr     = 0xC
        self.display_test_reg_addr = 0xF

        # List of config ADDR in order of apparition
        self.config_reg_addr_list = [
            self.decode_mode_reg_addr,
            self.intensity_reg_addr,
            self.scan_limit_reg_addr,
            self.shutdown_reg_addr,
            self.display_test_reg_addr
        ]

    # Check SPI Config - 5*MATRIX_NB frame send
    def check_spi_config(self,
                         decode_mode_data,
                         intensity_data,
                         scan_limit_data,
                         shutdown_data,
                         display_test_data):

      

        config_data_list = [decode_mode_data,
                            intensity_data,
                            scan_limit_data,
                            shutdown_data,
                            display_test_data]
            
        for config_reg_i in range(0, 5):

            for matrix_i in range(0, self.matrix_nb):

                self.scn.WTRS(self.spi_frame_received_alias, 10, "ms")
                self.scn.CHK(self.spi_data_alias, self.config_reg_addr_list[config_reg_i] << 8 | config_data_list[config_reg_i], "OK")
                if(matrix_i == self.matrix_nb - 1):
                    self.scn.WTRS(self.spi_load_received_alias, 10, "ms")


    # Write Data in Entire RAM - Start from 0 to last Addr
    def write_data_in_ram(self, ram_data_list, me_alias, we_alias, addr_alias, wdata_alias, clk_alias, ram_sel = "STATIC"):

        if(ram_sel == "STATIC"):
            self.static_memory = ram_data_list # Update RAM Model Static
        elif(ram_sel == "SCROLLER"):
            self.scroller_memory = ram_data_list
            
        self.scn.WTFS(clk_alias)
        self.scn.SET(me_alias, 1)
        self.scn.SET(we_alias, 1)

        for i in range(0, len(ram_data_list)):
            self.scn.SET(addr_alias, i)
            self.scn.SET(wdata_alias, ram_data_list[i])
            self.scn.WTFS(clk_alias)

        self.scn.SET(addr_alias,  0)
        self.scn.SET(wdata_alias, 0) 
        self.scn.SET(me_alias,    0)
        self.scn.SET(we_alias,    0)


    # Read data_in_ram
    def read_data_in_ram(self, ram_data_list, me_alias, we_alias, addr_alias, rdata_alias, clk_alias):

        self.scn.WTFS(clk_alias)
        self.scn.SET(me_alias, 1)
        self.scn.SET(we_alias, 0)

        for i in range(0, len(ram_data_list)):
            self.scn.SET(addr_alias, i)            
            self.scn.WTFS(clk_alias)
            self.scn.WTFS(clk_alias)
            self.scn.CHK(rdata_alias, ram_data_list[i], "OK")

        self.scn.SET(addr_alias,  0)
        self.scn.SET(me_alias,    0)
        self.scn.SET(we_alias,    0)





    # == STATIC MODELS ==

    # Check value through SPI
    # /!\ Only one Data send and One data checked
    def send_one_spi_request_and_check(self,
                                       ram_addr,
                                       ram_data,
                                       spi_check_expected,
                                       start_ptr_static_alias,
                                       last_ptr_static_alias,
                                       static_dyn_alias,
                                       new_display_alias,
                                       ptr_equality_alias,
                                       clk_alias):

        (cmd_type, load_en, spi_data) = self.get_cmd_type_load_data(self.static_memory[ram_addr])#ram_data)
     
        self.scn.print_line("//-- Set STATIC inputs - One Value to transmit\n")
        self.scn.SET(static_dyn_alias, 0)
        self.scn.SET(start_ptr_static_alias, ram_addr)
        if(ram_addr < 255):
            self.scn.SET(last_ptr_static_alias, ram_addr + 1)
        else:
            self.scn.SET(last_ptr_static_alias, ram_addr + 1 - 256)
            
        self.scn.WTFS(clk_alias)

        self.scn.print_line("//-- Send NEW STATIC Display\n")
        self.scn.WTFS(clk_alias)
        self.scn.SET(new_display_alias, 1)
        self.scn.WTFS(clk_alias)
        self.scn.SET(new_display_alias, 0)

        # SPI Frame only generated for normal_cmd
        if(cmd_type == "normal_cmd"):

            ram_data = self.static_memory[ram_addr]
            if(load_en == 1):
                ram_data = self.static_memory[ram_addr] & 0xEFFF # Force en_load to 0 (not expected in SPI received data)
            # Frame is received before PTR Equality is released
            self.scn.WTRS(self.spi_frame_received_alias, 10, "ms")
            self.scn.CHK(self.spi_data_alias, ram_data, spi_check_expected)

            # SPI LOAD RECEVIED always after FRAME received
            if(load_en == 1):
                self.scn.WTRS(self.spi_load_received_alias, 10, "ms")
                
            # Wait for PTR equality
            self.scn.WTRS(ptr_equality_alias, 10, "ms")            
            
        self.scn.print_line("//-- end")

    # Check value through SPI
    # /!\ MAX list element = 256
    def send_multiple_spi_request_and_check(self,
                                            ram_start_addr,
                                            ram_stop_addr,
                                            spi_check_expected, 
                                            start_ptr_static_alias,
                                            last_ptr_static_alias,
                                            static_dyn_alias,
                                            new_display_alias,
                                            ptr_equality_alias,
                                            clk_alias,
                                            spi_timeout = [10, "ms"],
                                            bypass_set_inputs = False):

        offset  = 0 # Offset for wrapping addr
        
        if((ram_stop_addr - ram_start_addr) >= 0):            
            data_nb = ram_stop_addr - ram_start_addr
        else:
            data_nb = ram_stop_addr - ram_start_addr + 256 # Wrap Management
        # Get RAM ADDR usr for the pattern
        ram_addr_list = []
        for i in range(0, data_nb):

            if((ram_start_addr + i) > 255):
                ram_addr_list.append(ram_start_addr + i - 256)
            else:
                ram_addr_list.append(ram_start_addr + i)

        if(bypass_set_inputs == False):
            self.scn.print_line("//-- Set STATIC inputs - One Value to transmit\n")
            self.scn.SET(static_dyn_alias, 0)
            self.scn.SET(start_ptr_static_alias, ram_start_addr)        
            self.scn.SET(last_ptr_static_alias, ram_stop_addr)

            
            self.scn.WTFS(clk_alias)
            
            self.scn.print_line("//-- Send NEW STATIC Display\n")
            self.scn.WTFS(clk_alias)
            self.scn.SET(new_display_alias, 1)
            self.scn.WTFS(clk_alias)
            self.scn.SET(new_display_alias, 0)
                
        

        for j in ram_addr_list:          
            (cmd_type, load_en, spi_data) = self.get_cmd_type_load_data(self.static_memory[j])
            
            # SPI Frame only generated for normal_cmd
            if(cmd_type == "normal_cmd"):
                self.scn.print_comment("normal_cmd :")
                ram_data = self.static_memory[j]
                if(load_en == 1):
                    ram_data = self.static_memory[j] & 0xEFFF # Force en_load to 0 (not expected in SPI received data)
                # Frame is received before PTR Equality is released
                self.scn.WTRS(self.spi_frame_received_alias, spi_timeout[0], spi_timeout[1])
                self.scn.CHK(self.spi_data_alias, ram_data, spi_check_expected)

                    # SPI LOAD RECEVIED always after FRAME received
                if(load_en == 1):
                    self.scn.WTRS(self.spi_load_received_alias, spi_timeout[0], spi_timeout[1])
            elif(cmd_type == "wait_cmd"):
                self.scn.print_comment("wait_cmd - Wait value : %d (load_en : %d - spi_data : %d)" %( ((load_en << 12) + spi_data), load_en, spi_data))

        if(bypass_set_inputs == False):
            # Wait for PTR equality after the end of transmission
            self.scn.WTRS(ptr_equality_alias, 10, "ms")            
            
        self.scn.print_line("//-- end")



   
    
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
    # ===================

    # Sort Mem List
    # The list must have the size of 8*G_MATRIX_NB
    def sort_mem_list_static(self, data_list):
        return self.macros_max_static_class.sort_mem_list(data_list)

    # == SCROLLER MODELS ==

    # Set scroller config, start pattern and check it
    def send_scroller_pattern_and_check(self,
                                        ram_start_addr,
                                        msg_length,
                                        static_dyn_alias,
                                        ram_start_ptr_alias,
                                        msg_length_alias,
                                        new_display_alias,
                                        scroller_busy_alias,
                                        clk_alias,
                                        timeout_value   = 10,
                                        timeout_unity   = "ms",
                                        html_debug_en   = False,
                                        html_debug_name = ""):

        # Get RAM ADDR Use for the pattern
        ram_addr_list = []

        for i in range(0, msg_length):
            if((ram_start_addr + i) > 255):
                ram_addr_list.append(ram_start_addr + i - 256)
            else:
                ram_addr_list.append(ram_start_addr + i)
                
        self.scn.WTFS(clk_alias)

        self.scn.print_line("//-- Set Configuration for Scroller Pattern\n")
        self.scn.SET(static_dyn_alias, 1)
        self.scn.SET(ram_start_ptr_alias, ram_start_addr)
        self.scn.SET(msg_length_alias, msg_length)

        self.scn.WTFS(clk_alias)

        self.scn.print_line("//-- Send NEW SCROLLER Display\n")
        self.scn.WTFS(clk_alias)
        self.scn.SET(new_display_alias, 1)
        self.scn.WTFS(clk_alias)
        self.scn.SET(new_display_alias, 0)

        self.scn.WTFS(clk_alias)

        self.check_scroller_spi_transaction(ram_start_addr,
                                            msg_length,
                                            html_debug_en,
                                            html_debug_name)

        self.scn.WTFS(scroller_busy_alias, timeout_value, timeout_unity)



    def check_scroller_spi_transaction(self,
                                       ram_start_addr,
                                       msg_length,
                                       html_debug_en = False,
                                       html_debug_name = ""):
            
        shift_nb                   = 8*self.matrix_nb + msg_length #ram_data_len # - 1 ?
        spi_trans_4_screen_refresh = 8*self.matrix_nb
        spi_transaction_nb         = spi_trans_4_screen_refresh*shift_nb
        offset                     = 0
        
        # data_to_check[0] == Di_M7        
        # data_to_check[1] == Di_M6
        # data_to_check[0] == Di_M7
        data_to_check = np.zeros([shift_nb, 8, self.matrix_nb], int)

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
                if((ram_start_addr + shift_i) >= 256):
                    print("shift_i : %d" %(shift_i))
                    offset = 256
                    
                data_to_check[shift_i, 7, 0] = data_to_check[shift_i, 7, 0] | self.scroller_memory[ram_start_addr + shift_i - offset]
               

            # Loop On 8 Digits
            for digit_i in range(0, 8):
                
                # Loop on self.matrix_nb
                for matrix_i in range(0, self.matrix_nb):
                                    
                    self.scn.WTRS(self.spi_frame_received_alias, 1, "ms")

                    self.scn.CHK(self.spi_data_alias, data_to_check[shift_i, digit_i, matrix_i], "OK")
                    # Every  self.matrix_nb a frame a LOAD is sended
                    if(matrix_i == self.matrix_nb - 1):
                        self.scn.WTRS(self.spi_load_received_alias)
            
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
                for matrix_i in range(1, self.matrix_nb):
                    data_to_check[shift_i + 1, 7, matrix_i] = (data_to_check[shift_i + 1, 7, matrix_i] & 0xF00) | (data_to_check[shift_i, 0, matrix_i - 1] & 0xFF)


        if(html_debug_en == True):
            buttons_name_list = ["SHIFT_" + str(i) for i in range(shift_nb)]
            div_content_list  = [self.html_blocs.np_array_2_tab(data_to_check[i]) for i in range(shift_nb)]
            html_page_str = self.html_blocs.create_page_with_multiple_button(page_name         = "SPI SCROLLER MATRIX SHIFT DEBUG",
                                                                             buttons_name_list = buttons_name_list,
                                                                             div_content_list  = div_content_list)
        
            f = open("/home/linux-jp/SIMULATION_VHDL/index_scroller_matrix_shift_debug_" + html_debug_name + ".html", "w")
            f.write(html_page_str)
            f.close()
   
                
    # =====================


    def max7219_scroller_model(self, ram_start_addr, msg_length):
        
        shift_nb                   = 8*self.matrix_nb + msg_length #ram_data_len # - 1 ?
        spi_trans_4_screen_refresh = 8*self.matrix_nb
        spi_transaction_nb         = spi_trans_4_screen_refresh*shift_nb
        offset                     = 0
        
        # data_to_check[0] == Di_M7        
        # data_to_check[1] == Di_M6
        # data_to_check[0] == Di_M7
        data_to_check = np.zeros([shift_nb, 8, self.matrix_nb], int)

        # Init Matrix with Addr of each digit on bits 11 to 8
        # Digit 0 First
        for i in range(0, 8):
            data_to_check[:, i, :] = (i + 1) << 8 #
                    
        # Init data_to_check with 
        # Loop on Number of shift
        for shift_i in range(0, shift_nb):

            if(shift_i < msg_length):#ram_data_len):

                # Manage wrapp addr
                if((ram_start_addr + shift_i) >= 256):
                    #print("shift_i : %d" %(shift_i))
                    offset = 256
                    
                data_to_check[shift_i, 7, 0] = data_to_check[shift_i, 7, 0] | self.scroller_memory[ram_start_addr + shift_i - offset]
               

            
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
                for matrix_i in range(1, self.matrix_nb):
                    data_to_check[shift_i + 1, 7, matrix_i] = (data_to_check[shift_i + 1, 7, matrix_i] & 0xF00) | (data_to_check[shift_i, 0, matrix_i - 1] & 0xFF)


        return data_to_check

