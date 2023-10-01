# ZIPCPU_AXI4_LITE_TOP_01
#
# Set data on 7 segments from ZIPCPU
# 
#
import sys
import os
# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class



# Create SCN Class
scn = scn_class.scn_class()

# Initialized the ROM with NOOP instruction
#scn.MODELSIM_CMD("mem load -skip 0 -filltype value -filldata 77C00000 -fillradix hexadecimal /tb_top/i_dut/i_zipcpu_axi4_lite_core_0/i_axi4_lite_memory_0/i_sp_rom_0/rom")

# Set specific data into the ROM
#mem load -filltype value -filldata 5 -fillradix hexadecimal /tb_top/i_dut/i_zipcpu_axi4_lite_core_0/i_axi4_lite_memory_0/i_sp_rom_0/rom(22)

# MOV 0x00000038, R2
# 0x1343c00d
#scn.MODELSIM_CMD("mem load -filltype value -filldata 1343C00D -fillradix hexadecimal /tb_top/i_dut/i_zipcpu_axi4_lite_core_0/i_axi4_lite_memory_0/i_sp_rom_0/rom(16)")

#scn.WAIT(100, "ns")
#scn.MODELSIM_CMD("mem load -skip 0 -filltype value -filldata 1343C00D -fillradix hexadecimal -startaddress 10 -endaddress 10 /tb_top/i_dut/i_zipcpu_axi4_lite_core_0/i_axi4_lite_memory_0/i_sp_rom_0/rom")
#scn.MODELSIM_CMD("mem load -filltype value -filldata {0} -fillradix hexadecimal /tb_top/i_dut/i_zipcpu_axi4_lite_core_0/i_axi4_lite_memory_0/i_sp_rom_0/rom({1})".format("1343c00d", 10))


data_list = ["1343C00D", "1a000000", "1a400150",
             "25848000", "2443ffff", "78880018",
             "2c84c00c", "2c400001", "78abfff4", "24c4c00c", "10800001", "7883ffdc",
             "7f800100", "70c00010",
             "48656c6c", "6f2c2057", "6f726c64", "210d0a00"
]

#for i, data in enumerate(data_list):
#    scn.MODELSIM_CMD("mem load -filltype value -filldata {0} -fillradix hexadecimal /tb_top/i_dut/i_zipcpu_axi4_lite_core_0/i_axi4_lite_memory_0/i_sp_rom_0/rom({1})".format(data, i))
# Disassembly of section .start:

# 00000000 <_start>:
#    0:	13 43 c0 0d 	MOV        0x00000038,R2  // 38 <string>
#    4:	1a 00 00 00 	LDI        0x00000150,R3  // 150 <uart>
#    8:	1a 40 01 50 

# 0000000c <next_char>:
#    c:	25 84 80 00 	LB         (R2),R4
#   10:	24 43 ff ff 	TST        $-1,R4
#   14:	78 88 00 18 	BZ         @0x00000030    // 30 <all_done>

# 00000018 <keep_waiting>:
#   18:	2c 84 c0 0c 	LW         12(R3),R5
#   1c:	2c 40 00 01 	TST        $1,R5
#   20:	78 ab ff f4 	BNZ        @0x00000018    // 18 <keep_waiting>
#   24:	24 c4 c0 0c 	SW         R4,$12(R3)
#   28:	10 80 00 01 	ADD        $1,R2
#   2c:	78 83 ff dc 	BRA        @0x0000000c    // c <next_char>

# 00000030 <all_done>:
#   30:	7f 80 01 00 	SEXIT
#   34:	70 c0 00 10 	HALT

# 00000038 <string>:
#   38:	48 65 6c 6c 	AND.V      $-5012+R5,R9
#   3c:	6f 2c 20 57 	ILL 6f2c2057
#   40:	6f 72 6c 64 	ILL 6f726c64
#   44:	21 0d 0a 00 	XOR.Z      $2560+R4,R4

  
scn.print_step("Wait for Reset")

scn.WTRS("RST_N")

scn.WAIT(20, "us")



scn.END_TEST()
