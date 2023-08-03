# ========================================== #
#
# Makefile for VGA_ADV7123
#
# ========================================== #
# Author  : 
# Date    : 
# Version : 1.0
#         -
# ========================================== #

# -- INCLUDES --
include ~/Documents/GitHub/Generics_Makefiles/Makefiles/MakefileGeneric
include ~/Documents/GitHub/RTL_Testbench/scripts/makefiles/generic_modules_files.mk
# --------------

# -- MODELSIM Configuration --
vsim=/opt/Modelsim/modelsim_ase/bin/vsim
vlib=/opt/Modelsim/modelsim_ase/linuxaloem/vlib
vmap=/opt/Modelsim/modelsim_ase/linuxaloem/vmap
vcom=/opt/Modelsim/modelsim_ase/linuxaloem/vcom
vlog=/opt/Modelsim/modelsim_ase/linuxaloem/vlog
# ----------------------------

# -- PROJECT Configuration --
ROOT=$(PWD)/..
PROJECT_NAME=VGA_ADV7123
# ---------------------------

# -- SCENARII Configuration --
SCN_LIB_DIR=
# ----------------------------

# -- SIMULATION Configuration --
RTL_Testbench_path=~/RTL_Testbench
HDL_SIMU_PATH=/home/linux-jp/SIMULATION_VHDL
WORK_DIR=VGA_ADV7123_WORK
LIB_TB_TOP= 
NO_WLF=OFF
GUI=ON
TRANSCRIPT_EN=ON
DO_FILES_EN=ON
# ------------------------------


# -- Compilation Configuration --
VCOM_ARGS+=
VLOG_ARGS+=
# -------------------------------



# == DESIGN LIBRARIES ==

# ======================

# == TESTBENCH LIBRARIES ==

# =========================

# ==  LIB LIST ==
LIB_LIST+=lib_adv7123
LIB_LIST+=tb_lib_adv7123
# ================



all: 
	@echo "# =========================== #"
	@echo "# Makefile for VGA_ADV7123 blocks tests"
	@echo "# =========================== #"
	@echo ""
	@echo ""




# == DESIGN VHD FILE LIST ==
include adv7123_files.mk
lib_7123_path=/home/linux-jp/Documents/GitHub/VHDL_code/VGA/VGA_ADV7123/sources/lib_adv7123/
# ==========================

# == TESTBENCH UART V FILES LIST ==

# =================================


# == Specific Testbench File List ==
src_tb_lib_adv7123_v+=$(TB_SRC_DIR)/tb_lib_adv7123/testbench_setup.sv
src_tb_lib_adv7123_v+=$(TB_SRC_DIR)/tb_lib_adv7123/clk_gen.sv
src_tb_lib_adv7123_v+=$(TB_SRC_DIR)/tb_lib_adv7123/tb_top.sv
# ==================================


## == COMPILE DESIGN == ##
compile_adv7123:
	make compile_design_vhd_files SRC_VHD="$(ADV7123_FILE_LIST)" VHD_DESIGN_LIB=lib_adv7123 VHD_FILE_PATH=$(lib_7123_path)

# ========================

## == COMPILE TESTBENCH == ##


compile_generic_tb_v_files:
	make compile_tb_v_files SRC_TB_V="$(GEN_MODULE_LIST)" LIB_TB_TOP=tb_lib_adv7123 V_FILE_PATH=~/Documents/GitHub/

compile_tb_adv7123:
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_adv7123_v)" LIB_TB_TOP=tb_lib_adv7123

# =======================

# == COMPILE ALL ==
compile_all_adv7123 : clean_all create_simulation_dir libs compile_adv7123 compile_generic_tb_v_files compile_tb_adv7123 print_compile_logs_file
# =================

# == SCENARII LIST ======
SCN_LIST+=ADV7123_00.py
# =======================

# == LIB ARGS ==
LIB_ARGS=-L lib_adv7123
# ==============


# == RUN TEST ==
run_tb_adv7123:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON SCN_LIB_DIR=scn_lib_adv7123 LIB_TB_TOP=tb_lib_adv7123
# ==============

