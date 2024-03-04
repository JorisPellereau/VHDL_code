# ========================================== #
#
# Makefile for I2C Master blocks tests
#
# ========================================== #

# ========================================== #
# Author  : J.P
# Date    : 22/02/2024
# Version : 1.0
#         - Initialization
# ========================================== #

# Reminder :
# do ../../../Documents/GitHub/VHDL_code/Makefile/do_files_generic/add_dut_waves.do tb_top i_dut

# -- INCLUDES --

# --------------

# -- PROJECT Configuration --
ROOT=$(PWD)/..
PROJECT_NAME=I2C
# ---------------------------

# -- SCENARII Configuration --
SCN_LIB_DIR=scn_lib_i2c
# ----------------------------



# -- SIMULATION Configuration --
RTL_Testbench_path=/home/linux-jp/Documents/GitHub
HDL_SIMU_PATH=/home/linux-jp/SIMULATION_VHDL
WORK_DIR=I2C_WORK
LIB_TB_TOP=tb_lib_i2c
NO_WLF=OFF
GUI=ON
TRANSCRIPT_EN=ON
DO_FILES_EN=ON
# ------------------------------

# == TESTBENCH LIBRARIES ==
LIB_LIST+=tb_lib_i2c
# =========================

# ==  LIB LIST ==
LIB_LIST+=lib_pkg_utils
LIB_LIST+=lib_ram_intel
LIB_LIST+=lib_fifo
LIB_LIST+=lib_fifo_wrapper
LIB_LIST+=lib_i2c
# ================


# ZIPCPU Macro
# - Zipsystem Macros :
# -> VERILATOR
# -> VBENCH_TB
# -> OPT_MMU
# -> FORMAL

# == TESTBENCH VHD MODULES FILES LIST ==

# ======================================

# == TESTBENCH MODULES V FILES LIST ==
SRC_SLAVE_I2C_DIR=$(RTL_Testbench_path)
# ====================================



# == Specific Testbench File List ==
src_tb_lib_i2c_v+=testbench_setup.sv
src_tb_lib_i2c_v+=clk_gen.sv
src_tb_lib_i2c_v+=tb_top.sv
# ==================================

# == COMPILE DESIGN ==
SRC_UTILS_DIR                = /home/linux-jp/Documents/GitHub/VHDL_code/PKG/sources/lib_pkg_utils/
SRC_LIB_RAM_INTEL_DIR        = /home/linux-jp/Documents/GitHub/VHDL_code/RAM/sources/lib_ram_intel/
SRC_LIB_FIFO_DIR             = /home/linux-jp/Documents/GitHub/VHDL_code/FIFO/sources/lib_fifo/
SRC_LIB_FIFO_WRAPPER_DIR     = /home/linux-jp/Documents/GitHub/VHDL_code/FIFO/sources/lib_fifo_wrapper/

# I2C Master
SRC_LIB_I2C_DIR              = /home/linux-jp/Documents/GitHub/VHDL_code/I2C/sources/lib_i2c/

# Design Sources List
util_src_vhd += pkg_utils.vhd

src_lib_ram_intel_vhd+=sp_ram.vhd

src_lib_fifo_vhd+=fifo_sp_ram_fast.vhd

src_lib_fifo_wrapper_vhd+=fifo_sp_ram_fast_wrapper.vhd

# I2C MASTER
src_lib_i2c_vhd+=i2c_master_itf.vhd
src_lib_i2c_vhd+=i2c_master.vhd

compile_design_i2c_master:
	make compile_design_vhd_files SRC_VHD="$(util_src_vhd)"                     VHD_DESIGN_LIB=lib_pkg_utils              VHD_FILE_PATH=$(SRC_UTILS_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_lib_ram_intel_vhd)"            VHD_DESIGN_LIB=lib_ram_intel              VHD_FILE_PATH=$(SRC_LIB_RAM_INTEL_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_lib_fifo_vhd)"                 VHD_DESIGN_LIB=lib_fifo                   VHD_FILE_PATH=$(SRC_LIB_FIFO_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_lib_fifo_wrapper_vhd)"         VHD_DESIGN_LIB=lib_fifo_wrapper           VHD_FILE_PATH=$(SRC_LIB_FIFO_WRAPPER_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_lib_i2c_vhd)"                  VHD_DESIGN_LIB=lib_i2c                    VHD_FILE_PATH=$(SRC_LIB_I2C_DIR)
# ====================

## == COMPILE TESTBENCH == ##
compile_generic_tb_modules:
	make compile_tb_v_files SRC_TB_V="$(GEN_MODULE_LIST)" LIB_TB_TOP=tb_lib_i2c V_FILE_PATH=/home/linux-jp/Documents/GitHub INC_DIR_TB_EN=ON


compile_generic_tb_v_files:
	make compile_tb_v_files SRC_TB_V="$(src_gen_tb_v)" TB_LIB_TOP=tb_lib_i2c


compile_tb_i2c: compile_generic_tb_modules compile_generic_tb_v_files
	make compile_tb_v_files SRC_TB_V="$(I2C_SLAVE_FILE_LIST)" LIB_TB_TOP=tb_lib_i2c V_FILE_PATH=$(SRC_SLAVE_I2C_DIR)
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_i2c_v)"    LIB_TB_TOP=tb_lib_i2c V_FILE_PATH=$(TB_SRC_DIR)/tb_lib_i2c/


# == COMPILE ALL I2C MASTER ==
compile_all_i2c_master :
	make clean_all ; \
	make create_simulation_dir ; \
	make libs ; \
	make compile_design_i2c_master ; \
	make compile_tb_i2c ; \
	make print_compile_logs_file

# == SCENARII LIST ======
SCN_LIST+=
# =======================

# == LIB ARGS ==
LIB_ARGS=$(foreach list,$(LIB_LIST),-L $(list) )
# ==============

# == RUN TEST ==
run_tb_i2c:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON SCN_LIB_DIR=scn_lib_i2c LIB_TB_TOP=tb_lib_i2c
# ==============
