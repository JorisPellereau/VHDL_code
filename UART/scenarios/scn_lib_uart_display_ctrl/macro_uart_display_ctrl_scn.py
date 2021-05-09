

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
