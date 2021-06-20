
import generic_tb_cmd_class
import tb_uart_cmd_class
import scn_class

import numpy as np




uart_cmd_list = dict()
uart_cmd_list[0] = "INIT_RAM_STATIC"
uart_cmd_list[1] = "INIT_RAM_SCROLLER"
uart_cmd_list[2] = "UPDATE_MATRIX_CONFIG"
uart_cmd_list[3] = "LOAD_MATRIX_CONFIG"
uart_cmd_list[4] = "LOAD_PATTERN_STATIC"
uart_cmd_list[5] = "LOAD_PATTERN_SCROLL"
uart_cmd_list[6] = "RUN_PATTERN_STATIC"
uart_cmd_list[7] = "RUN_PATTERN_SCROLLER"


def str_cmd_2_hex_data_cmd(cmd):

    data_list = []
    for i in range(0, len(cmd)):
        data_list.append(ascii_str_2_hex(cmd[i]))

    # Fill Command with 0x00 if command < 20 bytes  
    if(len(data_list) < 20):
        for i in range(20-len(data_list)):
            data_list.append(0x00)

            
    print data_list    

    return data_list

# Convert an ASCII String to HEX int
def ascii_str_2_hex(ascii_str):

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



# Check SPI Generation After Reset
def check_spi_config_after_reset(scn, decode_mode, intensity, scan_limit, shutdown, display_test):

    data_list = [(0x09 << 8) |decode_mode, (0x0A << 8) | intensity, (0x0B << 8) | scan_limit, (0x0C << 8) | shutdown, (0x0F << 8) | display_test]

    for nb_config in range(0, 5):
        for nb_matrix in range(0, 8):
            scn.generic_tb_cmd.WTR("SPI_FRAME_RECEIVED", 1, "ms")
            scn.generic_tb_cmd.CHK("O_SPI_DATA_RECEIVED",data_list[nb_config], 'OK')





# Check SPI transaction during a Scroller Pattern
# SPI transaction number :
# 8*8*(64 + pattern_length)
# Digit 0 updated 1st
# Digit 7 updated in last position
def check_spi_scroller(scn, data_to_check):

    data_matrix = np.zeros([8, 8], int)

    loop_nb = 64 + len(data_to_check)

    data = [0] * 64 # Init data
    data[0] = data_to_check[0]

    for loop_nb_i in range(0, loop_nb):
        for digit_i in range(0, 8):
            for matrix_i in range(0, 8):
              scn.generic_tb_cmd.WTR("SPI_FRAME_RECEIVED", 1, "ms")
              scn.generic_tb_cmd.CHK("O_SPI_DATA_RECEIVED",( (digit_i + 1) << 8) | data[matrix_i + digit_i*8], 'OK')


        # Shift data
        for i in range(0, 64):
            if(i < loop_nb_i):
                data[i] = data_to_check[loop_nb_i]
    
    
