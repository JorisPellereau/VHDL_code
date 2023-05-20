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
SRC_UTILS_DIR=~/Documents/GitHub/VHDL_code/PKG/sources/lib_pkg_utils
SRC_AXI4_LITE_DIR=~/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite
OSVVM_PATH=/opt/OsvvmLibraries
SRC_OSVVM_WRAPPER_PATH=/home/linux-jp/Documents/GitHub/VHDL_code/Testbench/tb_lib_osvvm_axi4lite
SRC_TB_LIB_AXI4_PATH=/home/linux-jp/Documents/GitHub/Verilog/Testbench/sources/lib_tb_axi4
# =======================


# == DESIGN LIBRARIES ==
LIB_AXI4_LITE=lib_axi4_lite
LIB_PKG_UTILS=lib_pkg_utils
# ======================


# == TESTBENCH LIBRARIES ==
TB_LIB_AXI4_LITE=tb_lib_axi4_lite
TB_OSVVM_AXI4_LITE=tb_lib_osvvm_axi4lite
# =========================


# ==  LIB LIST ==
LIB_LIST+=$(LIB_PKG_UTILS)
LIB_LIST+=$(LIB_AXI4_LITE)
LIB_LIST+=$(TB_LIB_AXI4_LITE)
LIB_LIST+=$(TB_OSVVM_AXI4_LITE)
LIB_LIST+=osvvm
LIB_LIST+=osvvm_common
LIB_LIST+=work
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
util_src_vhd +=$(SRC_UTILS_DIR)/pkg_utils.vhd

axi4_lite_src_vhd +=$(SRC_AXI4_LITE_DIR)/pkg_axi4_lite_reg.vhd
axi4_lite_src_vhd +=$(SRC_AXI4_LITE_DIR)/axi4_lite_slave_reg.vhd
#axi4_lite_src_vhd +=$(SRC_AXI4_LITE_DIR)/pkg_axi4_lite.vhd
#axi4_lite_src_vhd +=$(SRC_AXI4_LITE_DIR)/pkg_axi4_lite_inst.vhd
#axi4_lite_src_vhd +=$(SRC_AXI4_LITE_DIR)/axi4_list_slave_rec_to_itf.vhd
axi4_lite_src_vhd +=$(SRC_AXI4_LITE_DIR)/axi4_lite_slave_itf.vhd
axi4_lite_src_vhd +=$(SRC_AXI4_LITE_DIR)/axi4_lite_slave_test.vhd
# ==========================

# == TESTBENCH VHDL Custom FILES LIST ==
src_osvvm_axi4_lite_vhd+=$(SRC_OSVVM_WRAPPER_PATH)/osvvm_axi4lite_manager_wrapper.vhd
# ======================================


# == TESTBENCH {0}  VERILOG Custom FILES LIST ==
src_lib_tb_axi4_v+=$(SRC_TB_LIB_AXI4_PATH)/master_axi4lite_intf.sv
src_lib_tb_axi4_v+=$(SRC_TB_LIB_AXI4_PATH)/master_axi4lite.sv
src_lib_tb_axi4_v+=$(SRC_TB_LIB_AXI4_PATH)/tb_master_axi4lite_class.sv
# =================================


# == Specific Testbench File List ==
# -- Complete Here the name of the library
src_tb_lib_axi4_lite_v+=$(TB_SRC_DIR)/tb_lib_axi4_lite/testbench_setup.sv
src_tb_lib_axi4_lite_v+=$(TB_SRC_DIR)/tb_lib_axi4_lite/clk_gen.sv
src_tb_lib_axi4_lite_v+=$(TB_SRC_DIR)/tb_lib_axi4_lite/tb_top.sv
# ==================================


## == COMPILE DESIGN == ##

# -- Add here targets for design compilation
# VCOM_ARGS=-2008
# Compile Lib axi4 Lite in vHDL 2008
compile_lib_axi4_lite:
	make compile_design_vhd_files SRC_VHD="$(util_src_vhd)" VHD_DESIGN_LIB=$(LIB_PKG_UTILS)
	make compile_design_vhd_files SRC_VHD="$(axi4_lite_src_vhd)" VHD_DESIGN_LIB=$(LIB_AXI4_LITE)


#compile_design: compile_lib_axi4_lite
# ====================== #


## == COMPILE TESTBENCH == ##

# -- Add Here targets for testbenchs compilation
OSVVM_AXI4_COMMON_LIB=$(TB_OSVVM_AXI4_LITE)
OSVVM_AXI4LITE_LIB=$(TB_OSVVM_AXI4_LITE)
compile_tb_lib_axi4_lite: compile_osvvm compile_osvvm_common compile_osvvm_axi4_common compile_osvvm_axi4lite
	make compile_tb_v_files SRC_TB_V="$(src_gen_tb_v)" TB_LIB_TOP=$(TB_LIB_AXI4_LITE) VCOM_ARGS=-2008
	make compile_tb_vhd_files SRC_TB_VHD="$(src_osvvm_axi4_lite_vhd)" TB_LIB_TOP=$(TB_LIB_AXI4_LITE) VCOM_ARGS=-2008
	make compile_tb_v_files SRC_TB_V="$(src_lib_tb_axi4_v)" TB_LIB_TOP=$(TB_LIB_AXI4_LITE)
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_axi4_lite_v)" TB_LIB_TOP=$(TB_LIB_AXI4_LITE)
# ========================= #

# == COMPILE ALL Targets ==
compile_all_lib_axi4_lite: clean_all create_project_dir libs compile_lib_axi4_lite compile_tb_lib_axi4_lite print_compile_logs_file

# =========================

# == SCENARII LIST ==

# -- Add here the list of scenarii
SCN_LIST +=AXI4_LITE_000.py

# ===================


# == LIB ARGS ==
# -- Complete here the library use for running a test with vsim
LIB_ARGS=-L lib_axi4_lite -L $(TB_OSVVM_AXI4_LITE)
# ==============


# == RUN TEST ==
# -- Add here targets for running tests
run_tb_lib_axi4_lite:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON SCN_LIB_DIR=scn_lib_axi4_lite LIB_TB_TOP=$(TB_LIB_AXI4_LITE) 
# ==============
# LIB_ARGS=$(LIB_ARGS)

# == MAKEFILE Includes ==
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGeneric
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileOSVVM
#include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGHDL
#include ~/Documents/GitHub/VHDL_code/Makefile/MakefileSonarqube
# =======================
