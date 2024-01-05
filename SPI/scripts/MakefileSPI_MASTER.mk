# ========================================== #
#
# Makefile for SPI MASTER blocks tests
#
# ========================================== #

# ========================================== #
# Author  : J.P
# Date    : 05/01/2024
# Version : 1.0
#         - Creation fichier
# ========================================== #

# Reminder :
# do ../../../Documents/GitHub/VHDL_code/Makefile/do_files_generic/add_dut_waves.do tb_top i_dut

# -- INCLUDES --

# --------------

# -- PROJECT Configuration --
ROOT=$(PWD)/..
PROJECT_NAME=SPI_MASTER
# ---------------------------

# -- SCENARII Configuration --
#SCN_LIB_DIR=scn_lib_spi_master
# ----------------------------


# -- SIMULATION Configuration --
RTL_Testbench_path=/home/linux-jp/Documents/GitHub
HDL_SIMU_PATH=/home/linux-jp/SIMULATION_VHDL
WORK_DIR=SPI_MASTER_WORK
LIB_TB_TOP=tb_lib_spi_master
NO_WLF=OFF
GUI=ON
TRANSCRIPT_EN=ON
DO_FILES_EN=ON
# ------------------------------

# == SOURCES DIRECTORY ==

# =======================

# == DESIGN LIBRARIES ==

# ======================

# == TESTBENCH LIBRARIES ==
LIB_LIST+=tb_lib_spi_master
# =========================

# ==  LIB LIST ==
LIB_LIST+=lib_pkg_utils
LIB_LIST+=lib_ram_intel
LIB_LIST+=lib_fifo
LIB_LIST+=lib_fifo_wrapper
LIB_LIST+=lib_spi_master
# ================



# == DESIGN VHD FILE LIST ==

# -- Design DIR PATH --
SRC_UTILS_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/PKG/sources/lib_pkg_utils/

SRC_LIB_RAM_INTEL_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/RAM/sources/lib_ram_intel/
SRC_LIB_FIFO_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/FIFO/sources/lib_fifo/
SRC_LIB_FIFO_WRAPPER_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/FIFO/sources/lib_fifo_wrapper/

SRC_LIB_SPI_MASTER_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/SPI/sources/lib_spi_master/
# ---------------------



# Design Sources List
util_src_vhd += pkg_utils.vhd


src_lib_ram_intel_vhd+=sp_ram.vhd
src_lib_fifo_vhd+=fifo_sp_ram_fast.vhd
src_lib_fifo_wrapper_vhd+=fifo_sp_ram_fast_wrapper.vhd

src_spi_master_vhd+=spi_master_itf.vhd
src_spi_master_vhd+=spi_master.vhd

# ==========================


# == TESTBENCH MODULES V FILES LIST ==

# ====================================



# == Specific Testbench File List ==
src_tb_lib_spi_master_v+=testbench_setup.sv
src_tb_lib_spi_master_v+=clk_gen.sv
src_tb_lib_spi_master_v+=tb_top.sv
# ==================================


## == COMPILE DESIGN == ##
compile_spi_master:
	make compile_design_vhd_files SRC_VHD="$(util_src_vhd)" VHD_DESIGN_LIB=lib_pkg_utils VHD_FILE_PATH=$(SRC_UTILS_DIR) WORK_DIR=SPI_MASTER_WORK PROJECT_NAME=SPI_MASTER; \
	make compile_design_vhd_files SRC_VHD="$(src_lib_ram_intel_vhd)" VHD_DESIGN_LIB=lib_ram_intel VHD_FILE_PATH=$(SRC_LIB_RAM_INTEL_DIR) WORK_DIR=SPI_MASTER_WORK PROJECT_NAME=SPI_MASTER; \
	make compile_design_vhd_files SRC_VHD="$(src_lib_rom_intel_vhd)" VHD_DESIGN_LIB=lib_rom_intel VHD_FILE_PATH=$(SRC_LIB_ROM_INTEL_DIR) WORK_DIR=SPI_MASTER_WORK PROJECT_NAME=SPI_MASTER; \
	make compile_design_vhd_files SRC_VHD="$(src_lib_fifo_vhd)" VHD_DESIGN_LIB=lib_fifo VHD_FILE_PATH=$(SRC_LIB_FIFO_DIR) WORK_DIR=SPI_MASTER_WORK PROJECT_NAME=SPI_MASTER; \
	make compile_design_vhd_files SRC_VHD="$(src_lib_fifo_wrapper_vhd)" VHD_DESIGN_LIB=lib_fifo_wrapper VHD_FILE_PATH=$(SRC_LIB_FIFO_WRAPPER_DIR) WORK_DIR=SPI_MASTER_WORK PROJECT_NAME=SPI_MASTER; \
	make compile_design_vhd_files SRC_VHD="$(src_spi_master_vhd)" VHD_DESIGN_LIB=lib_spi_master VHD_FILE_PATH=$(SRC_LIB_SPI_MASTER_DIR) WORK_DIR=SPI_MASTER_WORK PROJECT_NAME=SPI_MASTER; \

# ================================


## == COMPILE TESTBENCH == ##
compile_generic_tb_v_files:
	make compile_tb_v_files SRC_TB_V="$(src_gen_tb_v)" TB_LIB_TOP=tb_lib_spi_master

# INC_DIR_TB_EN=ON
# Add include Directory
compile_generic_tb_v_files_spi_master:
	make compile_tb_v_files SRC_TB_V="$(GEN_MODULE_LIST)" LIB_TB_TOP=tb_lib_spi_master V_FILE_PATH=/home/linux-jp/Documents/GitHub WORK_DIR=SPI_MASTER_WORK PROJECT_NAME=SPI_MASTER INC_DIR_TB_EN=ON

compile_tb_spi_master:
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_spi_master_v)" LIB_TB_TOP=tb_lib_spi_master V_FILE_PATH=$(TB_SRC_DIR)/tb_lib_spi_master/


# == COMPILE ALL TESTBENCH files ==

# =======================

# == COMPILE ALL ==
compile_all_spi_master :
	make clean_all ; \
	make create_simulation_dir ; \
	make libs ; \
	make compile_spi_master; \
	make compile_generic_tb_v_files_spi_master; \
	make compile_tb_spi_master; \
	make print_compile_logs_file

# == SCENARII LIST ==
SCN_LIST+=
# =================

# == SCENARII LIST ======
SCN_LIST+=SPI_MASTER_00.py
# =======================

# == LIB ARGS ==
LIB_ARGS=$(foreach list,$(LIB_LIST),-L $(list) )
# ==============


# == RUN TEST ==
run_tb_spi_master:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON SCN_LIB_DIR=scn_lib_spi_master LIB_TB_TOP=tb_lib_spi_master
# ==============
