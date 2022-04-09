# UART_DISPLAY_CTRL_02.py
# Use for the generation of the scenario UART_DISPLAY_CTRL_02.txt
#
# Test of generation of LOAD of STATIC pattern from UART

import sys
import os

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class
import macros_uart_display_ctrl_class


# Create SCN Class
scn = scn_class.scn_class()

# Create SCN Macro
scn_macros = macros_uart_display_ctrl_class.macros_uart_display_ctrl_class(scn)

# == Collect Path ==
collect_path = "/home/linux-jp/SIMULATION_VHDL/UART_COLLECT/{0}_collect.txt".format(os.path.basename(__file__)[:-3])

memory_dump_path = "/home/linux-jp/SIMULATION_VHDL/MEMORY_DUMP/"

# Start of SCN

scn.DATA_COLLECTOR_INIT("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0, collect_path)
scn.DATA_COLLECTOR_START("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)


scn.print_step("Wait for Reset")

scn.WTR("RST_N")
scn.WAIT(100, "ns")


scn.print_step("Wait for the end of SPI Configuration")
scn_macros.check_init_config()


scn.print_step("LOAD STATIC RAM with 0000")


signal_path    = "/tb_top/i_dut/rst_n"
value_to_check = 1
scn.CHECK_SIGNAL_VALUE(signal_path    = signal_path,
                       value_to_check = value_to_check)



memory_rtl_path = "/tb_top/i_dut/i_max7219_display_controller_0/max7219_cmd_decod_inst_0/tdpram_inst_0/v_ram"
memory_to_check = ["X"*4 for i in range(256)]
# Check that memory is filled with XX
scn.CHECK_MEMORY(memory_rtl_path = memory_rtl_path,
                 memory_to_check = memory_to_check,
                 digit_number    = 4)

wr_ptr_list = [0, 64, 2*64, 3*64]
for j in range(0, 4):

    scn_macros.send_uart_cmd_and_check_resp(uart_data = "LOAD_PATTERN_STATIC",
                                        main_cmd  = False,
                                        not_rdy   = False,
                                        check_spi = False,
                                        wait_time = 1000)
    
    static_ram_data    = [0 for i in range(2*64+1)]
    static_ram_data[0] = wr_ptr_list[j] # Write Pointer

    scn_macros.send_uart_cmd_and_check_resp(uart_data = static_ram_data,
                                            main_cmd  = "LOAD_PATTERN_STATIC",
                                            not_rdy   = False,
                                            check_spi = False,
                                            wait_time = 1000)

    scn.SAVE_MEMORY(scn_macros.static_memory_rtl_path, memory_dump_path + os.path.basename(__file__)[:-3] + "_{0}.mem".format(j))
    memory_to_check[j*64 : (j+1)*64] = [0 for i in range(64)]
    # Check that memory is filled with data
    scn.CHECK_MEMORY(memory_rtl_path = memory_rtl_path,
                     memory_to_check = memory_to_check,
                     digit_number    = 4)

scn.DATA_COLLECTOR_STOP("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)
scn.DATA_COLLECTOR_CLOSE("UART_DISPLAY_CTRL_INPUT_COLLECTOR_0", 0)


scn.END_TEST()








# scn.print_line("//-- STEP 1\n")
# scn.print_line("//-- Injection of Correct command\n")
# scn.print_line("\n")


# scn.print_line("//-- Send : LOAD_MATRIX_CONFIG\n")
# data_to_send = str_cmd_2_hex_data_cmd("LOAD_MATRIX_CONFIG")
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("LOAD_MATRIX_RDY")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

# scn.generic_tb_cmd.WAIT(10, "us")


# scn.print_line("//-- Send : Data for config Matrix\n")
# # Display Test
# # Decod Mode
# # Intensity
# # Scan Limit
# # Shutdown
# data_to_send = [0x01, 0x02, 0x03, 0x04, 0x05]
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("LOAD_MATRIX_DONE")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

# scn.generic_tb_cmd.WAIT(10, "us")




# scn.print_line("//-- STEP 2\n")
# scn.print_line("//-- Injection of Correct command\n")
# scn.print_line("\n")


# scn.print_line("//-- Send : UPDATE_MATRIX_CONFIG\n")
# data_to_send = str_cmd_2_hex_data_cmd("UPDATE_MATRIX_CONFIG")
# scn.generic_tb_uart_cmd.TX_START("UART_RPi", data_to_send)


# data_to_read = str_cmd_2_hex_data_cmd("UPDATE_MATRIX_DONE")
# scn.generic_tb_uart_cmd.RX_WAIT_DATA("UART_RPi", data_to_read)

# scn.generic_tb_cmd.WAIT(10, "us")

