# ========================================== #
#
# Makefile for MULTIPLIER Project
#
# Author  : J.P
# Version : 1.0 
# 
# ========================================== #


# == Makefile Configuration ==
SEL_STATION=LINUX
ROOT=$(PWD)/..
PROJECT_NAME=MULTIPLIER
WORK_DIR=MULTIPLIER_WORK
TRANSCRIPT_EN=OFF
# ============================


# == SOURCES DIRECTORY ==
SRC_MULTIPLIER_DIR=~/Documents/GitHub/VHDL_code/MULTIPLIER/sources
# =======================


# == DESIGN LIBRARIES ==
LIB_MULTIPLIER=lib_multiplier
# ======================


# == TESTBENCH LIBRARIES ==
TB_LIB_MULTIPLIER=tb_lib_multiplier
# =========================


# ==  LIB LIST ==
LIB_LIST+=$(LIB_MULTIPLIER)
LIB_LIST+=$(TB_LIB_MULTIPLIER)
# ================


all: print_generic_rules
	@echo ""
	@echo "Makefile for MULTIPLIER blocks tests"
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
src_multiplier_vhd+=$(SRC_MULTIPLIER_DIR)/$(LIB_MULTIPLIER)/multiplier.vhd
# ==========================


# == TESTBENCH {0}  VERILOG Custom FILES LIST ==
# -- Add Here your Specific verilog custom testbench file
# =================================


# == Specific Testbench File List ==
# -- Complete Here the name of the library
src_tb_lib_multiplier_v+=$(TB_SRC_DIR)/tb_lib_multiplier/testbench_setup.sv
src_tb_lib_multiplier_v+=$(TB_SRC_DIR)/tb_lib_multiplier/clk_gen.sv
src_tb_lib_multiplier_v+=$(TB_SRC_DIR)/tb_lib_multiplier/tb_top.sv
# ==================================


## == COMPILE DESIGN == ##

# -- Add here targets for design compilation

# Compile Lib multiplier
compile_multiplier:
	make compile_design_vhd_files SRC_VHD="$(src_multiplier_vhd)" VHD_DESIGN_LIB=$(LIB_MULTIPLIER)
# ====================== #


## == COMPILE TESTBENCH == ##

# -- Add Here targets for testbenchs compilation
compile_tb_multiplier:
	make compile_tb_v_files SRC_TB_V="$(src_tb_v)" TB_LIB_TOP=$(TB_LIB_MULTIPLIER)
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_multiplier_v)" TB_LIB_TOP=$(TB_LIB_MULTIPLIER)
# ========================= #


# == SCENARII LIST ==

# -- Add here the list of scenarii
SCN_LIST +=
# ===================


# == LIB ARGS ==
# -- Complete here the library use for running a test with vsim
LIB_ARGS=-L $(LIB_MULTIPLIER)
# ==============


# == RUN TEST ==
# -- Add here targets for running tests
run_tb_multiplier:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON
# ==============


# == MAKEFILE Includes ==
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGeneric
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGHDL
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileSonarqube
# =======================
