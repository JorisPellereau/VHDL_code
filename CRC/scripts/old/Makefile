# Makefile for CRC C files compilation


crc_lib_path=/home/linux-jp/Documents/GitHub/VHDL_code/CRC/scripts
crc_lib_name=lib_c_crc

c_compile_path=/home/linux-jp/C_COMPILATION

c_file_list+=$(crc_lib_path)/$(crc_lib_name)/crc_functions.h
c_file_list+=$(crc_lib_path)/$(crc_lib_name)/crc_functions.c
c_file_list+=$(crc_lib_path)/$(crc_lib_name)/crc_computation.c
#c_file_list+=$(crc_lib_path)/$(crc_lib_name)/crc_serial2parallel.c

all:
	@echo "Makefile for CRC C files compilation"
	@echo ""
	@echo "make compile_c_files"


compile_c_files:
	gcc $(c_file_list) -o $(c_compile_path)/crc_computation.o -lm


%.o: 
