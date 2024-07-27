# ========================================== #
#
# Makefile for TOP WATCH
#
# ========================================== #

# ========================================== #
# Author  : J.P
# Date    : 22/05/2024
# Version : 1.0
#         - Initial commit
# ========================================== #

# Reminder :
# do ../../../Documents/GitHub/VHDL_code/Makefile/do_files_generic/add_dut_waves.do tb_top i_dut

# -- INCLUDES --
include TOP_WATCH_FILE_LIST.mk
# --------------

# -- PROJECT Configuration --
ROOT=$(PWD)/..
PROJECT_NAME=TOP_WATCH
# ---------------------------

# -- SCENARII Configuration --
SCN_LIB_DIR=scn_lib_top_watch
# ----------------------------



# -- SIMULATION Configuration --
RTL_Testbench_path=/home/linux-jp/Documents/GitHub
RTL_PATH=/home/linux-jp/Documents/GitHub/VHDL_code
HDL_SIMU_PATH=/home/linux-jp/SIMULATION_VHDL
WORK_DIR=TOP_WATCH_WORK
LIB_TB_TOP=tb_lib_top_watch
NO_WLF=OFF
GUI=ON
TRANSCRIPT_EN=ON
DO_FILES_EN=ON
# ------------------------------

# == SOURCES DIRECTORY ==
SRC_TOP_WATCH_VHD_DIR=~/Documents/GitHub/VHDL_code/DE0_nano/sources/lib_top_watch

# =======================


# == TESTBENCH LIBRARIES ==
LIB_LIST+=tb_lib_top_watch
# =========================

# ==  LIB LIST ==
LIB_LIST+=lib_max7219_interface
LIB_LIST+=lib_top_watch
# ================




# == Specific Testbench File List ==
src_tb_lib_top_watch_v+=testbench_setup.sv
src_tb_lib_top_watch_v+=clk_gen.sv
src_tb_lib_top_watch_v+=tb_top.sv
# ==================================


## == COMPILE DESIGN ==
compile_max7219_interface:
	make compile_design_vhd_files SRC_VHD="$(MAX7219_INTERFACE_VHD_SRC_LIST)" VHD_FILE_PATH=$(RTL_PATH)/MAX7219/sources/lib_max7219_interface/ VHD_DESIGN_LIB=lib_max7219_interface

compile_top_watch:
	make compile_design_vhd_files SRC_VHD="$(TOP_WATCH_VHD_SRC_LIST)" VHD_FILE_PATH=$(RTL_PATH)/DE0_nano/sources/lib_top_watch/ VHD_DESIGN_LIB=lib_top_watch

compile_all_design_top_watch:
	make compile_max7219_interface ; \
	make compile_top_watch

## == COMPILE TESTBENCH == ##

# Include files

compile_generic_tb_v_files:
	make compile_tb_v_files SRC_TB_V="$(GEN_MODULE_LIST)" TB_LIB_TOP=tb_lib_top_watch V_FILE_PATH=$(RTL_Testbench_path) INC_DIR_TB_EN=ON


compile_tb_top_watch:
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_top_watch_v)" LIB_TB_TOP=tb_lib_top_watch V_FILE_PATH=$(TB_SRC_DIR)/tb_lib_top_watch/


# == COMPILE ALL ==
compile_all_top_watch :
	make clean_all ; \
	make create_simulation_dir ; \
	make libs ; \
	make compile_all_design_top_watch ; \
	make compile_generic_tb_v_files ; \
	make print_compile_logs_file
	make compile_tb_top_watch ; \
	make print_compile_logs_file

# == SCENARII LIST ==
SCN_LIST+=

# =================

# == LIB ARGS ==
LIB_ARGS=$(foreach list,$(LIB_LIST),-L $(list) )
# ==============


# == RUN TEST ==
run_tb_top_watch:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON SCN_LIB_DIR=scn_lib_top_watch LIB_TB_TOP=tb_lib_top_watch
# ==============
