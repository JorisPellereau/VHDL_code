# ========================================== #
#
# Makefile For CRC block 
#
# ========================================== #

# ========================================== #
# Author  : J.P
# Date    : 25/05/2022
# Version : 1.0
#         -
# ========================================== #

# == Makefile Configuration ==
SEL_STATION=LINUX
ROOT=$(PWD)/..
PROJECT_NAME=CRC
WORK_DIR=CRC_WORK
TRANSCRIPT_EN=OFF
# ============================

# == SOURCES DIRECTORY ==
SRC_CRC_DIR=~/Documents/GitHub/VHDL_code/CRC/sources
# =======================

# == DESIGN LIBRARIES ==
LIB_CRC_16=lib_crc_16
# ======================

# == TESTBENCH LIBRARIES ==
LIB_TB_CRC_16+=lib_tb_crc_16
# =========================

# ==  LIB LIST ==
LIB_LIST+=$(LIB_CRC_16)
LIB_LIST+=$(LIB_TB_CRC_16)
# ================



all: print_generic_rules
	@echo ""
	@echo "Makefile for CRC blocks tests"
	@echo ""
	@echo "== SOURCES COMPILATIONS =="
	@echo ""
	@echo "- Design Sources Compilation :"
	@echo "make compile_design"
	@echo ""	
	@echo "- Compile Testbench :"
	@echo "make compile_testbench"
	@echo ""
	@echo "- Compile Design & Testbench :"
	@echo "make compile_all"
	@echo ""
	@echo "=========================="
	@echo ""
	@echo "== RUN TESTS =="
	@echo "- Run Test of UART display controller"
	@echo "make run_tb_crc_16 TEST=[TEST_NB]"
	@echo "==============="
	@echo ""
	@echo "== SCENARII LIST =="
	@echo "$(SCN_LIST)"
	@echo "==================="

SCN_LIB_DIR=scn_lib_crc_16
LIB_TB_TOP=lib_tb_crc_16

# == DESIGN VHD FILE LIST ==
src_lib_crc_16+=$(SRC_DIR)/lib_crc_16/crc_16_ccit.vhd
# ==========================

# == TESTBENCH CRC V FILES LIST ==

# =================================

# == Specific Testbench File List ==
src_tb_lib_crc_16_v+=$(TB_SRC_DIR)/tb_lib_crc_16/testbench_setup.sv
src_tb_lib_crc_16_v+=$(TB_SRC_DIR)/tb_lib_crc_16/clk_gen.sv
src_tb_lib_crc_16_v+=$(TB_SRC_DIR)/tb_lib_crc_16/tb_top.sv
# ==================================



## == COMPILE DESIGN == ##
compile_crc_16_ccit:
	make compile_design_vhd_files SRC_VHD="$(src_lib_crc_16)" VHD_DESIGN_LIB=$(LIB_CRC_16)


# == Compile Design Library here ==
compile_design : compile_crc_16_ccit
# ================================


## == COMPILE TESTBENCH == ##
compile_generic_tb_v_files:
	make compile_tb_v_files SRC_TB_V="$(src_gen_tb_v)" TB_LIB_TOP=$(LIB_TB_CRC_16)

compile_testbench_sources:
	make compile_tb_v_files SRC_TB_V="$(src_tb_data_checker_v)" TB_LIB_TOP=$(LIB_TB_CRC_16)
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_crc_16_v)" TB_LIB_TOP=$(LIB_TB_CRC_16)

# == COMPILE ALL TESTBENCH files ==
compile_testbench :  compile_generic_tb_v_files compile_testbench_sources
# =======================

compile_all_crc : clean_all create_project_dir libs compile_design compile_testbench print_compile_logs_file

# == SCENARII LIST ==
SCN_LIST+=CRC_16_000.py
# =======================

# == LIB ARGS ==
LIB_ARGS=-L lib_crc_16
# ==============


# == RUN TEST ==
run_tb_crc_16:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON
# ==============


# == CODE COVERAGE ==

include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGeneric
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGHDL
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileSonarqube
