import sys

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


class macros_uart_display_ctrl_class:

    def __init__(self, scn):
        self.scn = scn # Init scn

        # == TB ALIAS ==
        self.clk_alias = "CLK"
        
        self.spi_frame_received_alias = "SPI_FRAME_RECEIVED"
        self.spi_load_received_alias  = "SPI_LOAD_RECEIVED"
        self.spi_data_alias           = "O_SPI_DATA_RECEIVED"

        self.uart_rpi_alias           = "UART_RPi"

        # == UART Commands  ==
        self.uart_cmd_init_ram_static      = "INIT_RAM_STATIC"
        self.uart_cmd_init_ram_scroller    = "INIT_RAM_SCROLLER"    
        self.uart_cmd_update_matrix_config = "UPDATE_MATRIX_CONFIG"
        self.uart_cmd_load_matrix_config   = "LOAD_MATRIX_CONFIG"
        self.uart_cmd_load_pattern_static  = "LOAD_PATTERN_STATIC"
        self.uart_cmd_load_pattern_scroll  = "LOAD_PATTERN_SCROLL"
        self.uart_cmd_run_pattern_static   = "RUN_PATTERN_STATIC"
        self.uart_cmd_run_pattern_scroller = "RUN_PATTERN_SCROLLER"
        self.uart_cmd_run_scroller_tempo   = "LOAD_SCROLLER_TEMPO"

        self.uart_cmd_list = [
            self.uart_cmd_init_ram_static,
            self.uart_cmd_init_ram_scroller,
            self.uart_cmd_update_matrix_config,
            self.uart_cmd_load_matrix_config,
            self.uart_cmd_load_pattern_static,
            self.uart_cmd_load_pattern_scroll,
            self.uart_cmd_run_pattern_static,
            self.uart_cmd_run_pattern_scroller,
            self.uart_cmd_run_scroller_tempo,
        ]

        # == UART Responses ==       
        self.resp_ram_static_done    = "RAM_STATIC_DONE"        
        self.resp_ram_scroller_done  = "RAM_SCROLLER_DONE"
        self.resp_update_matrix_done = "UPDATE_MATRIX_DONE"
        
        self.resp_load_matrix_rdy  = "LOAD_MATRIX_RDY"
        self.resp_load_matrix_done = "LOAD_MATRIX_DONE"
        
        self.resp_load_static_rdy     = "LOAD_STATIC_RDY",
        self.resp_load_static_done    = "LOAD_STATIC_DONE"
        self.resp_load_static_not_rdy = "LOAD_STATIC_NOT_RDY"
        
        self.resp_load_scroller_rdy   = "LOAD_SCROLL_RDY"
        self.resp_load_scroll_done    = "LOAD_SCROLL_DONE"
        self.resp_load_scroll_not_rdy = "LOAD_SCROLL_NOT_RDY"
        
        self.resp_static_ptrn_rdy     = "STATIC_PTRN_RDY"
        self.resp_static_ptrn_done    = "STATIC_PTRN_DONE",
        self.resp_static_ptrn_not_rdy = "STATIC_PTRN_NOT_RDY"
        
        self.resp_scroll_ptrn_rdy   = "SCROLL_PTRN_RDY"
        self.resp_scroll_ptrn_done  = "SCROLL_PTRN_DONE"
        self.resp_scroll_ptrn_not_rdy = "SCROLL_PTRN_NOT_RDY"
        
        self.resp_load_tempo_rdy     = "LOAD_TEMPO_RDY"
        self.resp_load_tempo_done    = "LOAD_TEMPO_DONE"
        self.resp_load_tempo_not_rdy = "LOAD_TEMPO_NOT_RDY"
        
        self.resp_cmd_discard = "CMD_DISCARD"

        
        # Init Value of Configuration
        self.decode_mode_init_data  = 0x00        
        self.intensity_init_data    = 0x00
        self.scan_limit_init_data   = 0x07
        self.shutdown_init_data     = 0x01
        self.display_test_init_data = 0


        # == Create MAX7219 MODELS CLASS ==
        self.max7219_models_class     = max7219_models_class.max7219_models_class(scn                      = self.scn,
                                                                                  spi_frame_received_alias = self.spi_frame_received_alias,
                                                                                  spi_load_received_alias  = self.spi_load_received_alias,
                                                                                  spi_data_alias           = self.spi_data_alias)


    # Convert a str to data commend - return a list
    def str_cmd_2_hex_data_cmd(self, cmd, verbose = False):

        data_list = []
        for i in range(0, len(cmd)):
            data_list.append(self.ascii_str_2_hex(cmd[i]))

        # Fill Command with 0x00 if command < 20 bytes  
        if(len(data_list) < 20):
            for i in range(20-len(data_list)):
                data_list.append(0x00)

        if(verbose == True):    
            print(data_list)

        return data_list

    # Convert an ASCII String to HEX int
    def ascii_str_2_hex(self, ascii_str):

        if(ascii_str == "A"):
            data_hex = 0x41
        elif(ascii_str == "C"):
            data_hex = 0x43
        elif(ascii_str == "D"):
            data_hex = 0x44    
        elif(ascii_str == "E"):
            data_hex = 0x45
        elif(ascii_str == "F"):
            data_hex = 0x46
        elif(ascii_str == "G"):
            data_hex = 0x47    
        elif(ascii_str == "I"):
            data_hex = 0x49
        elif(ascii_str == "L"):
            data_hex = 0x4C
        elif(ascii_str == "M"):
            data_hex = 0x4D
        elif(ascii_str == "N"):
            data_hex = 0x4E
        elif(ascii_str == "O"):
            data_hex = 0x4F
        elif(ascii_str == "P"):
            data_hex = 0x50
        elif(ascii_str == "R"):
            data_hex = 0x52
        elif(ascii_str == "S"):
            data_hex = 0x53
        elif(ascii_str == "T"):
            data_hex = 0x54
        elif(ascii_str == "U"):
            data_hex = 0x55
        elif(ascii_str == "X"):
            data_hex = 0x58
        elif(ascii_str == "Y"):
            data_hex = 0x59
            
        # Special Char
        elif(ascii_str == "_"):
            data_hex = 0x5F
        else:
            data_hex = 0xFF
            print("data_hex error")
        
        return data_hex

    def check_init_config(self):
        self.scn.print_comment("Check Initial SPI Configuration and wait for Config Done")
        self.max7219_models_class.check_spi_config(self.decode_mode_init_data,
                                                   self.intensity_init_data,
                                                   self.scan_limit_init_data,
                                                   self.shutdown_init_data,
                                                   self.display_test_init_data)

    # Send UART Command from a str type
    def uart_tx_start_cmd(self, cmd_str):
        data_to_send = self.str_cmd_2_hex_data_cmd(cmd_str)
        self.scn.TX_START(self.uart_rpi_alias, data_to_send)

    # Send UART Check from a str type
    def uart_rx_wait_data_resp_cmd(self, cmd_str):        
        data_to_read = self.str_cmd_2_hex_data_cmd(cmd_str)            
        self.scn.RX_WAIT_DATA(self.uart_rpi_alias, data_to_read)


    # Send UART from a data_list
    def uart_tx_start_data(self, data_list):
        self.scn.TX_START(self.uart_rpi_alias, data_list)

    
    # Send UART_CMD and check resp by UART
    def send_uart_cmd_and_check_resp(self, uart_data, main_cmd = False):

        # Send a Command
        if(type(uart_data) == str):
            self.uart_tx_start_cmd(uart_data)

            # Case wrong Command : A discard resp in expected
            if uart_data not in self.uart_cmd_list:            
                self.uart_rx_wait_data_resp_cmd(self.resp_cmd_discard)       
            # Send Command in list
            else:
                if(uart_data == self.uart_cmd_init_ram_static):
                    self.uart_rx_wait_data_resp_cmd(self.resp_ram_static_done)

                elif(uart_data == self.uart_cmd_init_ram_scroller):
                    self.uart_rx_wait_data_resp_cmd(self.resp_ram_scroller_done)

                elif(uart_data == self.uart_cmd_update_matrix_config):
                    self.uart_rx_wait_data_resp_cmd(self.resp_update_matrix_done)

                elif(uart_data == self.uart_cmd_load_matrix_config):
                    self.uart_rx_wait_data_resp_cmd(self.resp_load_matrix_rdy)

                elif(uart_data == self.uart_cmd_load_pattern_static):
                    self.uart_rx_wait_data_resp_cmd(self.resp_load_static_rdy)

                elif(uart_data == self.uart_cmd_load_pattern_scroll):
                    self.uart_rx_wait_data_resp_cmd(self.resp_load_scroll_rdy)

                elif(uart_data == self.uart_cmd_run_pattern_static):
                    self.uart_rx_wait_data_resp_cmd(self.resp_static_ptrn_rdy)

                elif(uart_data == self.uart_cmd_run_pattern_scroller):
                    self.uart_rx_wait_data_resp_cmd(self.resp_scroll_ptrn_rdy)

                elif(uart_data == self.uart_cmd_run_scroller_tempo):
                    self.uart_rx_wait_data_resp_cmd(self.resp_load_tempo_rdy)
                    
        # Send Data
        elif(type(uart_data) == list):
            self.uart_tx_start_data(uart_data)



        
            
