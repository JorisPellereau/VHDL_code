# ========================================== #
#
# Makefile for FIFO
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
PROJECT_NAME=FIFOS
# ---------------------------

# -- SCENARII Configuration --
SCN_LIB_DIR=
# ----------------------------

# -- SIMULATION Configuration --
RTL_Testbench_path=~/RTL_Testbench
HDL_SIMU_PATH=/home/linux-jp/SIMULATION_VHDL
WORK_DIR=FIFOS_WORK
LIB_TB_TOP=tb_lib_fifo
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
LIB_LIST+=lib_ram_intel
LIB_LIST+=lib_fifo
LIB_LIST+=tb_lib_fifo
# ================



all: 
	@echo "# =========================== #"
	@echo "# Makefile for FIFOS blocks tests"
	@echo "# =========================== #"
	@echo ""
	@echo ""




# == DESIGN VHD FILE LIST ==
include TBD_files.mk


lib_fifo_path=/home/linux-jp/Documents/GitHub/VHDL_code/FIFO/sources/lib_fifo/

FIFO_FILE_LIST+=fifo_sp_ram.vhd
# ==========================

# == TESTBENCH UART V FILES LIST ==

# =================================


# == Specific Testbench File List ==
src_tb_lib_fifo_v+=$(TB_SRC_DIR)/tb_lib_fifo/testbench_setup.sv
src_tb_lib_fifo_v+=$(TB_SRC_DIR)/tb_lib_fifo/clk_gen.sv
src_tb_lib_fifo_v+=$(TB_SRC_DIR)/tb_lib_fifo/tb_top.sv
# ==================================


## == COMPILE DESIGN == ##
compile_fifo:
	make compile_design_vhd_files SRC_VHD="$(FIFO_FILE_LIST)" VHD_DESIGN_LIB=lib_fifo VHD_FILE_PATH=$(lib_fifo_path)

# ========================

## == COMPILE TESTBENCH == ##


compile_generic_tb_v_files:
	make compile_tb_v_files SRC_TB_V="$(GEN_MODULE_LIST)" LIB_TB_TOP=tb_lib_fifo V_FILE_PATH=~/Documents/GitHub/

compile_tb_TBD:
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_TBD_v)" LIB_TB_TOP=tb_lib_fifo

# =======================

# == COMPILE ALL ==
compile_all_TBD : clean_all create_simulation_dir libs compile_TBD compile_generic_tb_v_files compile_tb_TBD print_compile_logs_file
# =================

# == SCENARII LIST ======
SCN_LIST+=TBD_000.py
# =======================

# == LIB ARGS ==
LIB_ARGS=-L
# ==============


# == RUN TEST ==
run_tb_TBD:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON SCN_LIB_DIR=scn_lib_TBD LIB_TB_TOP=tb_lib_TBD
# ==============

