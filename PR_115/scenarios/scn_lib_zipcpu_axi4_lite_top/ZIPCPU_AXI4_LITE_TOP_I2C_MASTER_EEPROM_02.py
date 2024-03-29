# ZIPCPU_AXI4_LITE_TOP_I2C_MASTER_EEPROM_02
#
# Use asm script : Test of single read access on I2C Interface
#
import sys
import os
# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class


# Create mk File with the content of the ROM
asm_to_memory_path = '/home/linux-jp/Documents/GitHub/Python/FPGA_environment/zipcpu'
sys.path.append(asm_to_memory_path)
import asm_to_memory
import ZIPCPU_AXI4_LITE_TOP_constants

phy_mem_list = asm_to_memory.main_asm_to_memory(asm_file_path  = ZIPCPU_AXI4_LITE_TOP_constants.scn_path,                                  
                                                asm_file       = os.path.splitext(os.path.basename(__file__))[0] + ".s",
                                                zip_tools_path = ZIPCPU_AXI4_LITE_TOP_constants.zip_tools_path,
                                                o_file_path    = ZIPCPU_AXI4_LITE_TOP_constants.o_file_path)

# Create SCN Class
scn = scn_class.scn_class()
# Create MODELSIM ROM Memory
mem_file = ZIPCPU_AXI4_LITE_TOP_constants.o_file_path + "/" +  os.path.splitext(os.path.basename(__file__))[0] + ".mem"
rtl_mem_path = "/tb_top/i_dut/i_zipcpu_axi4_lite_core_0/i_axi4_lite_memory_0/i_sp_rom_0/rom"

scn.CREATE_MODELSIM_MEMORY(mem_file        = mem_file,
                            data_list      = phy_mem_list,
                            rtl_mem_path   = rtl_mem_path,
                            mem_data_width = 32,
                            mem_depth      = 256,
                            default_data   = 0x77C00000)



scn.LOAD_MEMORY(memory_rtl_path = rtl_mem_path,
                mem_file        = mem_file)
  
scn.print_step("Wait for Reset")

scn.WTRS("RST_N")

# Initialized I2C SLAVE EEPROM
scn.I2C_SLAVE_SET_ADDR("I2C_SLAVE_EEPROM", 0x0A)
scn.I2C_SLAVE_LOAD_TX_DATA("I2C_SLAVE_EEPROM", [i for i in range(256)])

scn.WAIT(200, "ns")

scn.print_step("Wait until the ledg[0] rise")
scn.WTRS("LEDG_DUT_0", 20, "ms")
scn.CHK("LEDG", 255, "OK")

scn.END_TEST()


