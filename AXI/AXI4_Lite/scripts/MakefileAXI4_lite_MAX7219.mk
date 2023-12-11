# ========================================== #
#
# Makefile for AXI4 Lite MAX7219 blocks tests
#
# ========================================== #

# ========================================== #
# Author  : J.P
# Date    : 08/12/2023
# Version : 1.0
#         - Creation
# ========================================== #

# Reminder :
# do ../../../Documents/GitHub/VHDL_code/Makefile/do_files_generic/add_dut_waves.do tb_top i_dut

# -- INCLUDES --

# --------------

# -- PROJECT Configuration --
ROOT=$(PWD)/..
PROJECT_NAME=AXI4_LITE_MAX7219
# ---------------------------

# -- SCENARII Configuration --
SCN_LIB_DIR=scn_lib_axi4_lite_max7219
# ----------------------------



# -- SIMULATION Configuration --
RTL_Testbench_path=/home/linux-jp/Documents/GitHub
HDL_SIMU_PATH=/home/linux-jp/SIMULATION_VHDL
WORK_DIR=AXI4_LITE_MAX7219_WORK
LIB_TB_TOP=tb_lib_axi4_lite_max7219
NO_WLF=OFF
GUI=ON
TRANSCRIPT_EN=ON
DO_FILES_EN=ON
# ------------------------------

# == SOURCES DIRECTORY ==
SRC_MAX7219_VHD_DIR=~/Documents/GitHub/VHDL_code/MAX7219/sources/lib_max7219
# =======================

# == DESIGN LIBRARIES ==
LIB_MAX7219=lib_max7219
# ======================

# == TESTBENCH LIBRARIES ==
LIB_LIST+=$(LIB_TB_TOP)
# =========================

# ==  LIB LIST ==
LIB_LIST+=lib_max7219_interface
LIB_LIST+=lib_max7219
LIB_LIST+=lib_pkg_utils
LIB_LIST+=lib_axi4_lite
LIB_LIST+=lib_ram_intel
LIB_LIST+=lib_fifo
LIB_LIST+=lib_fifo_wrapper
# ================



# == DESIGN VHD FILE LIST ==

# -- Design DIR PATH --
SRC_UTILS_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/PKG/sources/lib_pkg_utils/
SRC_AXI4_LITE_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite/


SRC_LIB_RAM_INTEL_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/RAM/sources/lib_ram_intel/
SRC_LIB_FIFO_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/FIFO/sources/lib_fifo/
SRC_LIB_FIFO_WRAPPER_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/FIFO/sources/lib_fifo_wrapper/

SRC_LIB_MAX7219_INTERFACE_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/MAX7219/sources/lib_max7219_interface/
SRC_LIB_MAX7219_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/MAX7219/sources/lib_max7219/

SRC_LIB_AXI4_LITE_MAX7219_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite_max7219/


# Design Sources List
util_src_vhd+=pkg_utils.vhd

src_lib_ram_intel_vhd+=sp_ram.vhd
src_lib_fifo_vhd+=fifo_sp_ram.vhd
src_lib_fifo_wrapper_vhd+=fifo_sp_ram_wrapper.vhd

axi4_lite_src_vhd += axi4_lite_slave_itf.vhd

max7219_interface_src_vhd+=pkg_max7219_interface.vhd
max7219_interface_src_vhd+=max7219_if.vhd

max7219_src_vhd+=start_max7219_if.vhd
max7219_src_vhd+=wr_fifo_mngt.vhd
max7219_src_vhd+=max7219_ctrl.vhd

axi4_lite_max7219_src_vhd+=axi4_lite_max7219_pkg.vhd
axi4_lite_max7219_src_vhd+=axi4_lite_max7219_registers.vhd
axi4_lite_max7219_src_vhd+=axi4_lite_max7219.vhd
# ==========================



# == TESTBENCH MODULES V FILES LIST ==
SRC_LCD_EMUL_DIR=/home/linux-jp/Documents/GitHub/RTL_Testbench/sources/TB_modules/LCD_CFAH_checker/
src_lcd_emul_v+=LCD_CFAH_emul.sv
# ====================================



# == Specific Testbench File List ==
src_tb_lib_axi4_lite_max7219_v+=testbench_setup.sv
src_tb_lib_axi4_lite_max7219_v+=clk_gen.sv
src_tb_lib_axi4_lite_max7219_v+=tb_top.sv
# ==================================


## == COMPILE DESIGN == ##
compile_axi4_lite_max7219:
	make compile_design_vhd_files SRC_VHD="$(util_src_vhd)" VHD_DESIGN_LIB=lib_pkg_utils VHD_FILE_PATH=$(SRC_UTILS_DIR) WORK_DIR=AXI4_LITE_MAX7219_WORK PROJECT_NAME=AXI4_LITE_MAX7219; \
	make compile_design_vhd_files SRC_VHD="$(src_lib_ram_intel_vhd)" VHD_DESIGN_LIB=lib_ram_intel VHD_FILE_PATH=$(SRC_LIB_RAM_INTEL_DIR) WORK_DIR=AXI4_LITE_MAX7219_WORK PROJECT_NAME=AXI4_LITE_MAX7219; \
	make compile_design_vhd_files SRC_VHD="$(src_lib_fifo_vhd)" VHD_DESIGN_LIB=lib_fifo VHD_FILE_PATH=$(SRC_LIB_FIFO_DIR) WORK_DIR=AXI4_LITE_MAX7219_WORK PROJECT_NAME=AXI4_LITE_MAX7219; \
	make compile_design_vhd_files SRC_VHD="$(src_lib_fifo_wrapper_vhd)" VHD_DESIGN_LIB=lib_fifo_wrapper VHD_FILE_PATH=$(SRC_LIB_FIFO_WRAPPER_DIR) WORK_DIR=AXI4_LITE_MAX7219_WORK PROJECT_NAME=AXI4_LITE_MAX7219; \
	make compile_design_vhd_files SRC_VHD="$(axi4_lite_src_vhd)" VHD_DESIGN_LIB=lib_axi4_lite VHD_FILE_PATH=$(SRC_AXI4_LITE_DIR) WORK_DIR=AXI4_LITE_MAX7219_WORK PROJECT_NAME=AXI4_LITE_MAX7219; \
	make compile_design_vhd_files SRC_VHD="$(max7219_interface_src_vhd)" VHD_DESIGN_LIB=lib_max7219_interface VHD_FILE_PATH=$(SRC_LIB_MAX7219_INTERFACE_DIR) WORK_DIR=AXI4_LITE_MAX7219_WORK PROJECT_NAME=AXI4_LITE_MAX7219; \
make compile_design_vhd_files SRC_VHD="$(max7219_src_vhd)" VHD_DESIGN_LIB=lib_max7219 VHD_FILE_PATH=$(SRC_LIB_MAX7219_DIR) WORK_DIR=AXI4_LITE_MAX7219_WORK PROJECT_NAME=AXI4_LITE_MAX7219; \
	make compile_design_vhd_files SRC_VHD="$(axi4_lite_max7219_src_vhd)" VHD_DESIGN_LIB=lib_axi4_lite_max7219 VHD_FILE_PATH=$(SRC_LIB_AXI4_LITE_MAX7219_DIR) WORK_DIR=AXI4_LITE_MAX7219_WORK PROJECT_NAME=AXI4_LITE_MAX7219; \



# == Compile Design Library here ==

# ================================


## == COMPILE TESTBENCH == ##
#compile_generic_tb_v_files:
#	make compile_tb_v_files SRC_TB_V="$(src_gen_tb_v)" TB_LIB_TOP=tb_lib_axi4_lite_max7219

# INC_DIR_TB_EN=ON
# Add include Directory
compile_generic_tb_v_files_axi4_lite_max7219:
	make compile_tb_v_files SRC_TB_V="$(GEN_MODULE_LIST)" LIB_TB_TOP=tb_lib_axi4_lite_max7219 V_FILE_PATH=/home/linux-jp/Documents/GitHub WORK_DIR=AXI4_LITE_MAX7219_WORK PROJECT_NAME=AXI4_LITE_MAX7219 INC_DIR_TB_EN=ON

compile_tb_axi4_lite_max7219:
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_axi4_lite_max7219_v)" LIB_TB_TOP=tb_lib_axi4_lite_max7219 V_FILE_PATH=$(TB_SRC_DIR)/tb_lib_axi4_lite_max7219/


# == COMPILE ALL TESTBENCH files ==

# =================================

# == COMPILE ALL ==
compile_all_axi4_lite_max7219:
	make clean_all; \
	make create_simulation_dir; \
	make libs; \
	make compile_axi4_lite_max7219; \
	make compile_generic_tb_v_files_axi4_lite_max7219 ; \
	make compile_tb_axi4_lite_max7219
	make print_compile_logs_file





# == SCENARII LIST ======
SCN_LIST+=AXI4_LITE_MAX7219_00.py
# =======================

# == LIB ARGS ==
LIB_ARGS=$(foreach list,$(LIB_LIST),-L $(list) )

#-L lib_pkg_utils -L lib_axi4_lite  -L lib_ram_intel -L lib_fifo -L lib_fifo_wrapper
# ==============


# == RUN TEST ==
run_tb_axi4_lite_max7219:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON SCN_LIB_DIR=scn_lib_axi4_lite_max7219 LIB_TB_TOP=tb_lib_axi4_lite_max7219
# ==============
