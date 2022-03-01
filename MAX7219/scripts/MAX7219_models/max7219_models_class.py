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
                 matrix_nb = 8):

        self.scn = scn
        
        # == ALIAS from TB ==
        self.spi_frame_received_alias = spi_frame_received_alias
        self.spi_load_received_alias  = spi_load_received_alias
        self.spi_data_alias           = spi_data_alias

        # == GENERICS ==
        self.matrix_nb = matrix_nb

        # == Default Value from TB ==        
        self.decode_mode_data  = 0xAA        
        self.intensity_data    = 0xBB
        self.scan_limit_data   = 0xCC
        self.shutdown_data     = 0xDD
        self.display_test_data = 0

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

    # Check SPI Config
    def check_spi_config(self,
                         decode_mode  = None,
                         intensity    = None,
                         scan_limit   = None,
                         shutdown     = None,
                         display_test = None):

        if(decode_mode == None):
            decode_mode_data = self.decode_mode_data
        else:
            decode_mode_data = decode_mode

        if(intensity == None):
            intensity_data = self.intensity_data
        else:
            intensity_data = intensity

        if(scan_limit == None):
            scan_limit_data = self.scan_limit_data
        else:
            scan_limit_data = scan_limit


        if(shutdown == None):
            shutdown_data = self.shutdown_data
        else:
            shutdown_data = shutdown

        if(display_test == None):
            display_test_data = self.display_test_data
        else:
            display_test_data = display_test


        config_data_list = [decode_mode_data,
                            intensity_data,
                            scan_limit_data,
                            shutdown_data,
                            display_test_data]
            
        for config_reg_i in range(0, 5):

            for matrix_i in range(0, self.matrix_nb):

                self.scn.WTRS(self.spi_frame_received_alias, 10, "ms")
                self.scn.CHK(self.spi_data_alias, self.config_reg_addr_list[config_reg_i] << 8 | config_data_list[config_reg_i])
                if(matrix_i == self.matrix_nb - 1):
                    self.scn.WTRS(self.spi_load_received_alias, 10, "ms")
                
