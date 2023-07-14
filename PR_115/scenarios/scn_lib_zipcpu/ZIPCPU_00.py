#
import sys
import os
# Path of Python SCN scripts generator
scn_generator_class = '/home/linux-jp/Documents/GitHub/Verilog/Testbench/scripts/scn_generator'
sys.path.append(scn_generator_class)

# Import Class
import scn_class


# Create SCN Class
scn = scn_class.scn_class()

scn.print_step("Wait for Reset")

f_path = "/home/linux-jp/SIMULATION_VHDL"
f_instruction = f_path + "/instructions.mem"


scn.WTRS("RST_N")

# LOAD MEMORY With Istruction
# NOOP Instruction : 01110111110000000000000000000000 = 0x77C00000
# !! bug a cause du (0) de ram_array


# MOV Instruction
#RSVD  DR   0xD    CND A BR   B 13-bit signed
#0     0000 01101  000 0 0000 0 1111111111111 = 0x03401FFF => MOV 0X1FFF to DR 0

# LDI Instruction
# RSVD DR   OPCODE 23 Bit Signed
# 0    0000 1100    000 AAAAA => 060AAAAA

#scn.MODELSIM_CMD(modelsim_cmd ="force -freeze sim:/tb_top/i_dut/i_wb_slv_memory_0/i_wb_we 1 0")
data_list = ["7fc00000" for i in range(256)]
# data_list[0] = "77C00000"
# data_list[1] = "060AAAAA"
# data_list[2] = "0E0AAAAA"
# data_list[3] = "1E0AAAAA"
# data_list[4] = "03401FFF"
# data_list[10] = "03401FFF"

# -- HELLO SIM Instruction
# data_list[0] = "7f800448"   
# data_list[1] = "7f800465"
# data_list[2] = "7f80046c"
# data_list[3] = "7f80046c"
# data_list[4] = "7f80046f"
# data_list[5] = "7f800420"
# data_list[6] = "7f800457"
# data_list[7] = "7f80046f"
# data_list[8] = "7f800472"
# data_list[9] = "7f80046c"
# data_list[10] = "7f800464"
# data_list[11] = "7f800421"
# data_list[12] = "7f80040d"
# data_list[13] = "7f80040a"
# data_list[14] = "7f800100"	 
# data_list[15] = "70c00010"

#data_list[0] = "1343c00d" #	MOV        0x00000038,R2  // 38 <string>
#data_list[1] = "1a000000"# 	LDI        0x00000150,R3  // 150 <uart>
#data_list[2] = "1a400150"
  
f = open(f_instruction, "w")
f.writelines("\n".join(data_list))
f.close()
scn.MODELSIM_CMD("mem load -i {0} -format hex /tb_top/i_dut/i_wb_slv_memory_0/ram_array".format(f_instruction))
#"mem load -filltype value -filldata {07F00000 } -fillradix hexadecimal /tb_top/i_dut/i_wb_slv_memory_0/ram_array(0)")

scn.WAIT(1, "us")



scn.END_TEST()
