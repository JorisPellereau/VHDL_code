# ========================================== #
#
# Makefile for AXI4_Lite Project
#
# Author  : J.P
# Version : 1.0 
# 
# ========================================== #


# == Makefile Configuration ==
SEL_STATION=LINUX
ROOT=$(PWD)/..
PROJECT_NAME=AXI4_Lite
WORK_DIR=AXI4_LITE_WORK
TRANSCRIPT_EN=OFF
# ============================


# == SOURCES DIRECTORY ==
SRC_AXI4_LITE_DIR=~/Documents/GitHub/VHDL_code/TBD_a_completer
# =======================


# == DESIGN LIBRARIES ==
# -- ADD Here your design libraries
# ======================


# == TESTBENCH LIBRARIES ==
# -- ADD Here your testbench library
# =========================


# ==  LIB LIST ==
LIB_LIST+=
# ================


all: print_generic_rules
	@echo ""
	@echo "Makefile for AXI4_LITE blocks tests"
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
	@echo "- Run Test of XXXXX"
	@echo "make run_tb_XXXXX TEST=[TEST_NB]"
	@echo "==============="
	@echo ""
	@echo "== SCENARII LIST =="
	@echo "$(SCN_LIST)"
	@echo "==================="


# == DESIGN VHD FILE LIST ==
# -- Add Here your design list
# ==========================


# == TESTBENCH {0}  VERILOG Custom FILES LIST ==
# -- Add Here your Specific verilog custom testbench file
# =================================


# == Specific Testbench File List ==
# -- Complete Here the name of the library
src_tb_lib_XXXXX_v+=$(TB_SRC_DIR)/tb_lib_XXXXX/testbench_setup.sv
src_tb_lib_XXXXX_v+=$(TB_SRC_DIR)/tb_lib_XXXXX/clk_gen.sv
src_tb_lib_XXXXX_v+=$(TB_SRC_DIR)/tb_lib_XXXXX/tb_top.sv
# ==================================


## == COMPILE DESIGN == ##

# -- Add here targets for design compilation

# Compile Lib XXXXX
compile_XXXXX:
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_XXXXX)" VHD_DESIGN_LIB=$(LIB_XXXXX)

# ====================== #


## == COMPILE TESTBENCH == ##

# -- Add Here targets for testbenchs compilation
compile_testbench_sources:
	make compile_tb_v_files SRC_TB_V="$(src_tb_v)" TB_LIB_TOP=$(LIB_TB_XXXXX)
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_XXXXX_v)" TB_LIB_TOP=$(LIB_TB_XXXXX)
# ========================= #


# == SCENARII LIST ==

# -- Add here the list of scenarii
SCN_LIST +=

# ===================


# == LIB ARGS ==
# -- Complete here the library use for running a test with vsim
LIB_ARGS=-L lib_XXXX -L lib_YYYY
# ==============


# == RUN TEST ==
# -- Add here targets for running tests
run_tb_XXXXX:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON
# ==============


# == MAKEFILE Includes ==
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGeneric
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGHDL
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileSonarqube
# =======================
