import sys

# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)


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
        
        # == ALIAS from TB ==
        self.spi_frame_received_alias = spi_frame_received_alias
        self.spi_load_received_alias  = spi_load_received_alias
        self.spi_data_alias           = spi_data_alias

        # == GENERICS ==
        self.matrix_nb         = matrix_nb
        self.static_ram_addr   = static_ram_addr
        self.scroller_ram_addr = scroller_ram_addr

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
    def write_data_in_ram(self, ram_data_list, me_alias, we_alias, addr_alias, wdata_alias, clk_alias):

        self.static_memory = ram_data_list # Update RAM Model Static
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
    def send_multiple_spi_request_and_check(self, ram_start_addr,
                                            ram_stop_addr,
                                            ram_data_list,
                                            spi_check_expected, 
                                            start_ptr_static_alias,
                                            last_ptr_static_alias,
                                            static_dyn_alias,
                                            new_display_alias,
                                            ptr_equality_alias,
                                            clk_alias,
                                            spi_timeout = [10, "ms"]):

        offset  = 0 # Offset for wrapping addr
        data_nb = 1
        
        if(len(ram_data_list) > 256):
            print("Error: len(ram_data_list) > 256 !")
        else:
            data_nb = len(ram_data_list)

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
                
        

        for j in range(0, data_nb):            
            (cmd_type, load_en, spi_data) = self.get_cmd_type_load_data(ram_data_list[j])
            
            # SPI Frame only generated for normal_cmd
            if(cmd_type == "normal_cmd"):
                self.scn.print_comment("normal_cmd :")
                if(load_en == 1):
                    ram_data_list[j] = ram_data_list[j] & 0xEFFF # Force en_load to 0 (not expected in SPI received data)
                # Frame is received before PTR Equality is released
                self.scn.WTRS(self.spi_frame_received_alias, spi_timeout[0], spi_timeout[1])
                self.scn.CHK(self.spi_data_alias, ram_data_list[j], spi_check_expected)

                    # SPI LOAD RECEVIED always after FRAME received
                if(load_en == 1):
                    self.scn.WTRS(self.spi_load_received_alias, spi_timeout[0], spi_timeout[1])
            elif(cmd_type == "wait_cmd"):
                self.scn.print_comment("wait_cmd - Wait value : %d (load_en : %d - spi_data : %d)" %( ((load_en << 12) + spi_data), load_en, spi_data))
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



    # == SCROLLER MODELS ==
    
    # =====================
