# UART_DISPLAY_CTRL_03.py
# Use for the generation of the scenario UART_DISPLAY_CTRL.txt
#
# Test of generation of LOAD of SCROLLER pattern from UART

import sys
import os
import random

# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

scn_txt_path = "/home/linux-jp/SIMULATION_VHDL/UART/scenarios/"


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


scn.print_step("Check initial value of SCROLLER RAM")
memory_rtl_path = "/tb_top/i_dut/i_max7219_display_controller_0/max7219_scroller_ctrl_inst_0/tdpram_inst_0/v_ram"
memory_to_check = ["X"*2 for i in range(256)]
# Check that memory is filled with XX
scn.CHECK_MEMORY(memory_rtl_path = memory_rtl_path,
                 memory_to_check = memory_to_check,
                 digit_number    = 2)




scn.print_step("LOAD SCROLLER RAM with 0000")

scn_macros.send_uart_cmd_and_check_resp(uart_data = "LOAD_PATTERN_SCROLL",
                                        main_cmd  = False,
                                        not_rdy   = False,
                                        check_spi = False,
                                        wait_time = 1000)

start_ptr = 0
last_ptr  = 255
scroller_ram_data    = [0 for i in range(2 + (last_ptr - start_ptr + 1))]
scroller_ram_data[0] = start_ptr
scroller_ram_data[1] = last_ptr
scn_macros.send_uart_cmd_and_check_resp(uart_data = scroller_ram_data,
                                        main_cmd  = "LOAD_PATTERN_SCROLL",
                                        not_rdy   = False,
                                        check_spi = False,
                                        wait_time = 1000)


memory_to_check = [0 for i in range(256)]
# Check that memory is filled with data
scn.CHECK_MEMORY(memory_rtl_path = memory_rtl_path,
                 memory_to_check = memory_to_check,
                 digit_number    = 2)



scn.print_step("LOAD SCROLLER RAM - Write data two by two")

loop_nb = 5 # 256

for i in range(0, loop_nb):

    scn_macros.send_uart_cmd_and_check_resp(uart_data = "LOAD_PATTERN_SCROLL",
                                        main_cmd  = False,
                                        not_rdy   = False,
                                        check_spi = False,
                                        wait_time = 1000)

    random.seed(i)
    start_ptr = i
    last_ptr  = i + 1
    scroller_ram_data    = [random.randrange(0, 255) for i in range(2 + (last_ptr - start_ptr + 1))]
    scroller_ram_data[0] = start_ptr # Start ptr
    scroller_ram_data[1] = last_ptr
    scn_macros.send_uart_cmd_and_check_resp(uart_data = scroller_ram_data,
                                            main_cmd  = "LOAD_PATTERN_SCROLL",
                                            not_rdy   = False,
                                            check_spi = False,
                                            wait_time = 1000)


    memory_to_check[start_ptr:last_ptr + 1] = scroller_ram_data[2:2 + len(scroller_ram_data)-2]
    # Check that memory is filled with data
    scn.CHECK_MEMORY(memory_rtl_path = memory_rtl_path,
                     memory_to_check = memory_to_check,
                     digit_number    = 2)  






scn.print_step("LOAD SCROLLER RAM - Write data one by one")

for i in range(0, loop_nb):

    scn_macros.send_uart_cmd_and_check_resp(uart_data = "LOAD_PATTERN_SCROLL",
                                        main_cmd  = False,
                                        not_rdy   = False,
                                        check_spi = False,
                                        wait_time = 1000)

    random.seed(i+1)
    start_ptr = i
    last_ptr  = i
    scroller_ram_data    = [random.randrange(0, 255) for i in range(2 + (last_ptr - start_ptr + 1))]
    scroller_ram_data[0] = start_ptr # Start ptr
    scroller_ram_data[1] = last_ptr
    scn_macros.send_uart_cmd_and_check_resp(uart_data = scroller_ram_data,
                                            main_cmd  = "LOAD_PATTERN_SCROLL",
                                            not_rdy   = False,
                                            check_spi = False,
                                            wait_time = 1000)


    memory_to_check[start_ptr:last_ptr + 1] = scroller_ram_data[2:2 + len(scroller_ram_data)-2]
    # Check that memory is filled with data
    scn.CHECK_MEMORY(memory_rtl_path = memory_rtl_path,
                     memory_to_check = memory_to_check,
                     digit_number    = 2)  



scn.print_step("LOAD SCROLLER RAM - Write data in ram - Test wrapping RAM")


scn_macros.send_uart_cmd_and_check_resp(uart_data = "LOAD_PATTERN_SCROLL",
                                        main_cmd  = False,
                                        not_rdy   = False,
                                        check_spi = False,
                                        wait_time = 1000)

random.seed(3)
start_ptr = 255
last_ptr  = 0

scroller_ram_data    = [random.randrange(0, 255) for i in range(2 + 2)]
scroller_ram_data[0] = start_ptr # Start ptr
scroller_ram_data[1] = last_ptr
scn_macros.send_uart_cmd_and_check_resp(uart_data = scroller_ram_data,
                                        main_cmd  = "LOAD_PATTERN_SCROLL",
                                        not_rdy   = False,
                                        check_spi = False,
                                        wait_time = 1000)


# memory_to_check[start_ptr:last_ptr + 1] = scroller_ram_data[2:2 + len(scroller_ram_data)-2]
# # Check that memory is filled with data
# scn.CHECK_MEMORY(memory_rtl_path = memory_rtl_path,
#                  memory_to_check = memory_to_check,
#                  digit_number    = 2)  





scn.END_TEST()
