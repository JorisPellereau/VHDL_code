import sys
import numpy as np


# Path of Python SCN scripts generator
scn_generator_class = '/home/jorisp/GitHub/Verilog/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class

# Import Model
max7219_model_class = "/home/linux-jp/Documents/GitHub/VHDL_code/MAX7219/scripts/MAX7219_models"
sys.path.append(max7219_model_class)
import max7219_models_class

# Import HTML
sys.path.append("/home/linux-jp/Documents/GitHub/Python/Tools/yattag_debug")
import html_blocs_class

class macros_max_controller_class:        

    def __init__(self, scn):
        self.scn = scn

        # == TB ALIAS ==
        self.clk_alias = "CLK"
        
        self.spi_frame_received_alias = "SPI_FRAME_RECEIVED"
        self.spi_load_received_alias  = "SPI_LOAD_RECEIVED"
        self.spi_data_alias           = "SPI_DATA"
        self.config_done_alias        = "O_CONFIG_DONE"

        self.i_decode_mode_alias  = "I_DECOD_MODE"
        self.i_intensity_alias    = "I_INTENSITY"
        self.i_scan_limit_alias   = "I_SCAN_LIMIT"
        self.i_shutdown_alias     = "I_SHUTDOWN"
        self.i_display_test_alias = "I_DISPLAY_TEST"

        self.i_new_config_val_alias = "I_NEW_CONFIG_VAL"

        self.i_static_dyn_alias       = "I_STATIC_DYN"
        self.i_new_display_alias      = "I_NEW_DISPLAY"
        self.i_en_static_alias        = "I_EN_STATIC"
        self.i_me_static_alias        = "I_ME_STATIC"
        self.i_we_static_alias        = "I_WE_STATIC"
        self.i_addr_static_alias      = "I_ADDR_STATIC"
        self.i_wdata_static_alias     = "I_WDATA_STATIC"
        self.i_start_ptr_static_alias = "I_START_PTR_STATIC"
        self.i_last_ptr_static_alias  = "I_LAST_PTR_STATIC"
        self.i_loop_static_alias      = "I_LOOP_STATIC"
        self.o_rdata_static_alias     = "O_RDATA_STATIC"
        self.o_ptr_equality_static_alias = "O_PTR_EQUALITY_STATIC"

        self.sel_display_screen_matrix_alias = "DISPLAY_SCREEN_SEL"
        self.display_screen_matrix_alias     = "DISPLAY_SCREEN_MATRIX"
        self.i_me_scroller_alias            = "I_ME_SCROLLER"
        self.i_we_scroller_alias            = "I_WE_SCROLLER"
        self.i_addr_scroller_alias          = "I_ADDR_SCROLLER"
        self.i_wdata_scroller_alias         = "I_WDATA_SCROLLER"
        self.i_ram_start_ptr_scroller_alias = "I_RAM_START_PTR_SCROLLER"
        self.i_msg_length_scroller_alias    = "I_MSG_LENGTH_SCROLLER"
        self.i_max_tempo_cnt_scroller_alias = "I_MAX_TEMPO_CNT_SCROLLER"
        self.o_rdata_scroller_alias         = "O_RDATA_SCROLLER"
        self.o_scroller_busy_alias          = "O_SCROLLER_BUSY"

        # == Default Value from TB ==        
        self.decode_mode_init_data  = 0xAA        
        self.intensity_init_data    = 0xBB
        self.scan_limit_init_data   = 0xCC
        self.shutdown_init_data     = 0xDD
        self.display_test_init_data = 0

        # == Create MAX7219 MODELS CLASS ==
        self.max7219_models_class     = max7219_models_class.max7219_models_class(scn                      = self.scn,
                                                                                  spi_frame_received_alias = self.spi_frame_received_alias,
                                                                                  spi_load_received_alias  = self.spi_load_received_alias,
                                                                                  spi_data_alias           = self.spi_data_alias)


    # Check SPI INIT Config after Release of reset
    def check_init_config(self):

        self.scn.print_comment("Check Initial SPI Configuration and wait for Config Done")
        self.max7219_models_class.check_spi_config(self.decode_mode_init_data,
                                                   self.intensity_init_data,
                                                   self.scan_limit_init_data,
                                                   self.shutdown_init_data,
                                                   self.display_test_init_data)

        self.scn.WTRS(self.config_done_alias, 100, "us")


    # Check a SPI Config
    def check_config(self,
                     decode_mode_data,
                     intensity_data,
                     scan_limit_data,
                     shutdown_data,
                     display_test_data):

        self.scn.print_comment("Check a SPI Configuration and wait for Config Done")
        self.max7219_models_class.check_spi_config(decode_mode_data,
                                                   intensity_data,
                                                   scan_limit_data,
                                                   shutdown_data,
                                                   display_test_data)

        self.scn.WTRS(self.config_done_alias, 100, "us")
        self.scn.CHK(self.config_done_alias, 1, "OK")


    # Set a new Config and check it
    def set_new_config_and_check(self,
                                 decode_mode_data,
                                 intensity_data,
                                 scan_limit_data,
                                 shutdown_data,
                                 display_test_data,
                                 bypass_set_config = False):
        
        self.scn.print_comment("Set a New config and check it")

        # Check that A last config was already done
        self.scn.CHK(self.config_done_alias, 1, "OK")

        self.scn.WTFS(self.clk_alias)
        
        # Set config
        self.scn.SET(self.i_decode_mode_alias,  decode_mode_data)
        self.scn.SET(self.i_intensity_alias,    intensity_data)
        self.scn.SET(self.i_scan_limit_alias,   scan_limit_data)
        self.scn.SET(self.i_shutdown_alias,     shutdown_data)
        self.scn.SET(self.i_display_test_alias, display_test_data)

        self.scn.WTFS(self.clk_alias)

        if(bypass_set_config == False):
            self.scn.WTFS(self.clk_alias)
            self.scn.SET(self.i_new_config_val_alias, 1)
            self.scn.WTFS(self.clk_alias)
            self.scn.SET(self.i_new_config_val_alias, 0)

        # Wait for Falling edge of status
        self.scn.WTFS(self.config_done_alias, 100, "us")
        
        # Check Config
        self.check_config(decode_mode_data,
                          intensity_data,
                          scan_limit_data,
                          shutdown_data,
                          display_test_data)


    # Write Data in Static RAM
    def write_static_data_in_ram(self, ram_data_list):
        self.max7219_models_class.write_data_in_ram(ram_data_list,
                                                    self.i_me_static_alias,
                                                    self.i_we_static_alias,
                                                    self.i_addr_static_alias,
                                                    self.i_wdata_static_alias,
                                                    self.clk_alias)

    def read_static_data_in_ram(self, ram_data_list):
        self.max7219_models_class.read_data_in_ram(ram_data_list,
                                                   self.i_me_static_alias,
                                                   self.i_we_static_alias,
                                                   self.i_addr_static_alias,
                                                   self.o_rdata_static_alias,
                                                   self.clk_alias)


    # Send One SPI Request and check it - STATIC Mode
    def send_one_spi_request_and_check_static(self, ram_addr, ram_data):

        spi_check_expected = "OK"
        
        self.max7219_models_class.send_one_spi_request_and_check(ram_addr,
                                                                 ram_data,
                                                                 spi_check_expected,
                                                                 self.i_start_ptr_static_alias,
                                                                 self.i_last_ptr_static_alias,
                                                                 self.i_static_dyn_alias,
                                                                 self.i_new_display_alias,
                                                                 self.o_ptr_equality_static_alias,
                                                                 self.clk_alias)
    # Send Multiple SPI REQUEST and check it - Static Mode
    def send_multiple_spi_request_and_check_static(self,
                                                   ram_start_ptr,
                                                   ram_stop_ptr):
        spi_check_expected = "OK"
        self.max7219_models_class.send_multiple_spi_request_and_check(ram_start_ptr,
                                                                      ram_stop_ptr,
                                                                      spi_check_expected,
                                                                      self.i_start_ptr_static_alias,
                                                                      self.i_last_ptr_static_alias,
                                                                      self.i_static_dyn_alias,
                                                                      self.i_new_display_alias,
                                                                      self.o_ptr_equality_static_alias,
                                                                      self.clk_alias)



    # Write Data in Scroller RAM
    def write_scroller_data_in_ram(self, ram_data_list):
        self.max7219_models_class.write_data_in_ram(ram_data_list,
                                                    self.i_me_scroller_alias,
                                                    self.i_we_scroller_alias,
                                                    self.i_addr_scroller_alias,
                                                    self.i_wdata_scroller_alias,
                                                    self.clk_alias,
                                                    ram_sel = "SCROLLER")
    # Read Data in Scroller RAM
    def read_scroller_data_in_ram(self, ram_data_list):
        self.max7219_models_class.read_data_in_ram(ram_data_list,
                                                   self.i_me_scroller_alias,
                                                   self.i_we_scroller_alias,
                                                   self.i_addr_scroller_alias,
                                                   self.o_rdata_scroller_alias,
                                                   self.clk_alias)
        
    # Set Scroller Config and check spi transaction
    # RAM Scroller must be previously written
    def send_scroller_pattern_and_check(self,
                                        ram_start_ptr,
                                        msg_length,
                                        timeout_value   = 10,
                                        timeout_unity   = "ms",
                                        html_debug_en   = False,
                                        html_debug_name = ""):
        
        self.max7219_models_class.send_scroller_pattern_and_check(
            ram_start_addr      = ram_start_ptr,
            msg_length          = msg_length,
            static_dyn_alias    = self.i_static_dyn_alias,
            ram_start_ptr_alias = self.i_ram_start_ptr_scroller_alias,
            msg_length_alias    = self.i_msg_length_scroller_alias,
            new_display_alias   = self.i_new_display_alias,
            scroller_busy_alias = self.o_scroller_busy_alias,
            clk_alias           = self.clk_alias,
            timeout_value       = timeout_value,
            timeout_unity       = timeout_unity,
            html_debug_en       = html_debug_en,
            html_debug_name     = html_debug_name)


    # Send Commandes from a list and check
    # Commandes : "CONFIG" "STATIC" or "SCROLLER"
    def send_multile_pattern_and_check(self, commandes_list):

        # Write commands
        for cmd in range(0, len(commandes_list)):
            if(commandes_list[cmd] == "CONFIG"):
                self.scn.WTFS(self.clk_alias)
                self.scn.SET(self.i_new_config_val_alias, 1)
                self.scn.WTFS(self.clk_alias)
                self.scn.SET(self.i_new_config_val_alias, 0)

            elif(commandes_list[cmd] == "STATIC"):
                self.scn.WTFS(self.clk_alias)
                self.scn.SET(self.i_static_dyn_alias, 0)
                self.scn.SET(self.i_new_display_alias, 1)
                self.scn.WTFS(self.clk_alias)
                self.scn.SET(self.i_static_dyn_alias, 0)
                self.scn.SET(self.i_new_display_alias, 0)

            elif(commandes_list[cmd] == "SCROLLER"):
                self.scn.WTFS(self.clk_alias)
                self.scn.SET(self.i_static_dyn_alias, 1)
                self.scn.SET(self.i_new_display_alias, 1)
                self.scn.WTFS(self.clk_alias)
                self.scn.SET(self.i_static_dyn_alias, 0)
                self.scn.SET(self.i_new_display_alias, 0)

            else:
                print("Error: Commands not recognized")


        # Check Status for each commands (MAX 10)
        if(len(commandes_list) <= 10):
            max_cmd = len(commandes_list)
        else:
            max_cmd = 10
            
        for cmd in range(0, max_cmd):
            if(commandes_list[cmd] == "CONFIG"):
                self.scn.WTRS(self.config_done_alias, 10, "ms")
                
            elif(commandes_list[cmd] == "STATIC"):
                self.scn.WTRS(self.o_ptr_equality_static_alias, 10, "ms")
                
            elif(commandes_list[cmd] == "SCROLLER"):
                self.scn.WTFS(self.o_scroller_busy_alias, 10, "ms")
                    
