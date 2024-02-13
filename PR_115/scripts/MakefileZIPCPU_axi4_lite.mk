# ========================================== #
#
# Makefile for PR115 blocks tests
#
# ========================================== #

# ========================================== #
# Author  : J.P
# Date    : 17/04/2021
# Version : 2.0
#         - Ajout MakefileGeneric
# ========================================== #

# Reminder :
# do ../../../Documents/GitHub/VHDL_code/Makefile/do_files_generic/add_dut_waves.do tb_top i_dut

# -- INCLUDES --

# --------------

# -- PROJECT Configuration --
ROOT=$(PWD)/..
PROJECT_NAME=ZIPCPU_AXI4_LITE_TOP
# ---------------------------

# -- SCENARII Configuration --
SCN_LIB_DIR=scn_lib_zipcpu_axi4_lite_top
# ----------------------------

# == ZIPCPU ==
CC        := /home/linux-jp/Documents/GitHub/zipcpu/sw/install/cross-tools/bin/zip-gcc
CPP       := /home/linux-jp/Documents/GitHub/zipcpu/sw/install/cross-tools/bin/zip-cpp
AS        := /home/linux-jp/Documents/GitHub/zipcpu/sw/install/cross-tools/bin/zip-as
LD        := /home/linux-jp/Documents/GitHub/zipcpu/sw/install/cross-tools/bin/zip-ld
OBJDUMP   := /home/linux-jp/Documents/GitHub/zipcpu/sw/install/cross-tools/bin/zip-objdump
ADDR2LINE := /home/linux-jp/Documents/GitHub/zipcpu/sw/install/cross-tools/bin/zip-addr2line
# ============


# -- SIMULATION Configuration --
RTL_Testbench_path=/home/linux-jp/Documents/GitHub
HDL_SIMU_PATH=/home/linux-jp/SIMULATION_VHDL
WORK_DIR=ZIPCPU_AXI4_LITE_TOP_WORK
LIB_TB_TOP=tb_lib_zipcpu_axi4_lite_top
NO_WLF=OFF
GUI=ON
TRANSCRIPT_EN=ON
DO_FILES_EN=ON
# ------------------------------

# == SOURCES DIRECTORY ==
SRC_ZIPCPU_VHD_DIR=~/Documents/GitHub/VHDL_code/PR_115/sources
SRC_ZIPCPU_DIR=~/Documents/GitHub/zipcpu/rtl
SRC_WBUART32_DIR=~/Documents/GitHub/wbuart32/rtl
SRC_LIB_WISHBONE_VHD_DIR=~/Documents/GitHub/VHDL_code/WISHBONE/sources/lib_wishbone
# =======================

# == DESIGN LIBRARIES ==
LIB_ZIPCPU=lib_zipcpu
LIB_WISHBONE=lib_wishbone
# ======================

# == TESTBENCH LIBRARIES ==
LIB_LIST+=tb_lib_zipcpu_axi4_lite_top
# =========================

# ==  LIB LIST ==
LIB_LIST+=lib_seg7
LIB_LIST+=lib_max7219_interface
LIB_LIST+=lib_max7219
LIB_LIST+=lib_pkg_utils
LIB_LIST+=lib_pulse_extender
LIB_LIST+=lib_axi4_lite
LIB_LIST+=lib_axi4_lite_7seg
LIB_LIST+=lib_axi4_lite_lcd
LIB_LIST+=lib_axi4_lite_max7219
LIB_LIST+=lib_axi4_lite_memory
LIB_LIST+=lib_axi4_lite_spi_master
LIB_LIST+=lib_axi4_lite_spi_slave
LIB_LIST+=lib_axi4_lite_i2c_master
LIB_LIST+=lib_CFAH1602_v2
LIB_LIST+=lib_ram_intel
LIB_LIST+=lib_fifo
LIB_LIST+=lib_fifo_wrapper
LIB_LIST+=lib_zipcpu_axi4_lite_top
LIB_LIST+=$(LIB_ZIPCPU)
LIB_LIST+=$(LIB_WISHBONE)
LIB_LIST+=lib_rom_intel
LIB_LIST+=lib_jtag_intel
LIB_LIST+=lib_spi_master
LIB_LIST+=lib_spi_slave
LIB_LIST+=lib_i2c
LIB_LIST+=lib_axi4_lite_gpio
# ================


# ZIPCPU Macro
# - Zipsystem Macros :
# -> VERILATOR
# -> VBENCH_TB
# -> OPT_MMU
# -> FORMAL

# == TESTBENCH VHD MODULES FILES LIST ==
SRC_LIB_SPI_MIRROR_TOP_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/DE0_nano/sources/lib_spi_mirror_top/
src_spi_mirror_top_vhd+=spi_mirror_top.vhd
# ======================================

# == TESTBENCH MODULES V FILES LIST ==
SRC_LCD_EMUL_DIR=/home/linux-jp/Documents/GitHub/RTL_Testbench/sources/TB_modules/LCD_CFAH_checker/
src_lcd_emul_v+=LCD_CFAH_emul.sv

SRC_SLAVE_I2C_DIR=$(RTL_Testbench_path)

# ====================================



# == Specific Testbench File List ==
src_tb_lib_zipcpu_axi4_lite_top_v+=testbench_setup.sv
src_tb_lib_zipcpu_axi4_lite_top_v+=clk_gen.sv
src_tb_lib_zipcpu_axi4_lite_top_v+=tb_top.sv
# ==================================

## == COMPILE TESTBENCH == ##
compile_generic_tb_v_files:
	make compile_tb_v_files SRC_TB_V="$(src_gen_tb_v)" TB_LIB_TOP=tb_lib_zipcpu_axi4_lite_top

# INC_DIR_TB_EN=ON
# Add include Directory
compile_generic_tb_v_files_jtag_axi4_lite_top:
	make compile_tb_v_files SRC_TB_V="$(GEN_MODULE_LIST)" LIB_TB_TOP=tb_lib_zipcpu_axi4_lite_top V_FILE_PATH=/home/linux-jp/Documents/GitHub WORK_DIR=ZIPCPU_AXI4_LITE_TOP_WORK PROJECT_NAME=ZIPCPU_AXI4_LITE_TOP INC_DIR_TB_EN=ON

compile_tb_zipcpu_axi4lite_vhd_files:
	make compile_tb_vhd_files SRC_TB_VHD="$(src_spi_mirror_top_vhd)" LIB_TB_TOP=tb_lib_zipcpu_axi4_lite_top VHD_FILE_PATH=$(SRC_LIB_SPI_MIRROR_TOP_DIR)

compile_tb_zipcpu_axi4_lite_top:
	make compile_tb_v_files SRC_TB_V="$(I2C_SLAVE_FILE_LIST)" LIB_TB_TOP=tb_lib_zipcpu_axi4_lite_top V_FILE_PATH=$(SRC_SLAVE_I2C_DIR)
	make compile_tb_v_files SRC_TB_V="$(src_lcd_emul_v)" LIB_TB_TOP=tb_lib_zipcpu_axi4_lite_top V_FILE_PATH=$(SRC_LCD_EMUL_DIR)
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_zipcpu_axi4_lite_top_v)" LIB_TB_TOP=tb_lib_zipcpu_axi4_lite_top V_FILE_PATH=$(TB_SRC_DIR)/tb_lib_zipcpu_axi4_lite_top/


# == COMPILE ALL ==
compile_all_zipcpu_axi4_lite_top :
	make clean_all ; \
	make create_simulation_dir ; \
	make libs ; \
	make compile_zipcpu_axi4_lite_top ; \
	make compile_generic_tb_v_files_jtag_axi4_lite_top ; \
	make compile_tb_zipcpu_axi4lite_vhd_files ; \
	make compile_tb_zipcpu_axi4_lite_top ; \
	make print_compile_logs_file

# == SCENARII LIST ==
SCN_LIST+=ZIPCPU_00.py

# =================

# == SCENARII LIST ======
SCN_LIST+=ZIPCPU_AXI4_LITE_TOP_00.py
# =======================

# == LIB ARGS ==
LIB_ARGS=$(foreach list,$(LIB_LIST),-L $(list) )
# ==============


# == RUN TEST ==
run_tb_zipcpu_axi4_lite_top:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON SCN_LIB_DIR=scn_lib_zipcpu_axi4_lite_top LIB_TB_TOP=tb_lib_zipcpu_axi4_lite_top 
# ==============

compile_s: 
	$(AS) ../scenarios/$(SCN_LIB_DIR)/$(TEST).s -o $(HDL_SIMU_PATH)/$(PROJECT_NAME)/scenarios/$(TEST).s.o

OBJDUMP_ARGS+=
OBJDUMP_ARGS+=-S -D -g

disasemble:
	$(OBJDUMP) $(OBJDUMP_ARGS) $(HDL_SIMU_PATH)/$(PROJECT_NAME)/scenarios/$(TEST).s.o


addr_to_line:
	$(ADDR2LINE) $(HDL_SIMU_PATH)/$(PROJECT_NAME)/scenarios/$(TEST).o

as:
	$(AS)
