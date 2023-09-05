# ========================================== #
#
# Makefile for JTAG_7SEG_TOP Block
#
# ========================================== #
# Author  : 
# Date    : 
# Version : 1.0
#         -
# ========================================== #

# -- INCLUDES --
include /home/linux-jp/Documents/GitHub/Generics_Makefiles/Makefiles/MakefileGeneric
include /home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/makefiles/generic_modules_files.mk
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
PROJECT_NAME=JTAG_7SEG_TOP
# ---------------------------

# -- SCENARII Configuration --
SCN_LIB_DIR=
# ----------------------------

# -- SIMULATION Configuration --
RTL_Testbench_path=~/RTL_Testbench
HDL_SIMU_PATH=/home/linux-jp/SIMULATION_VHDL
WORK_DIR=JTAG_7SEG_TOP_WORK
LIB_TB_TOP=tb_lib_jtag_7seg_top
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
LIB_LIST+=tb_lib_jtag_7seg_top

# =========================

# ==  LIB LIST ==
LIB_LIST+=lib_seg7
LIB_LIST+=lib_pkg_utils
LIB_LIST+=lib_pulse_extender
LIB_LIST+=lib_jtag_intel
LIB_LIST+=lib_axi4_lite
LIB_LIST+=lib_axi4_lite_7seg
LIB_LIST+=lib_jtag_7seg_top

# ================



all: 
	@echo "# =========================== #"
	@echo "# Makefile for JTAG_7SEG_TOP blocks tests"
	@echo "# =========================== #"
	@echo ""
	@echo ""




# == DESIGN VHD FILE LIST ==
#include TBD_files.mk
#lib_TBD_path=TBD_path

SRC_UTILS_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/PKG/sources/lib_pkg_utils
SRC_AXI4_LITE_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite
SRC_LIB_7SEG=/home/linux-jp/Documents/GitHub/VHDL_code/PR_115/sources/lib_seg7
SRC_AXI4_LITE_7SEG_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite_7seg
SRC_PULSE_EXTENDER_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/UTILS/sources/lib_pulse_extender

util_src_vhd +=$(SRC_UTILS_DIR)/pkg_utils.vhd

axi4_lite_src_vhd +=$(SRC_AXI4_LITE_DIR)/axi4_lite_slave_itf.vhd
axi4_lite_src_vhd +=$(SRC_AXI4_LITE_DIR)/axi4_lite_master.vhd

seg_src_vhd +=$(SRC_LIB_7SEG)/seg7_lut.vhd
seg_src_vhd +=$(SRC_LIB_7SEG)/seg7x8.vhd

axi4_lite_7seg_src_vhd += $(SRC_AXI4_LITE_7SEG_DIR)/axi4_lite_7segs_pkg.vhd
axi4_lite_7seg_src_vhd += $(SRC_AXI4_LITE_7SEG_DIR)/axi4_lite_7segs_registers.vhd
axi4_lite_7seg_src_vhd += $(SRC_AXI4_LITE_7SEG_DIR)/axi4_lite_7segs.vhd

src_pulse_extender_vhd += $(SRC_PULSE_EXTENDER_DIR)/bit_extender.vhd

# ==========================

# == TESTBENCH UART V FILES LIST ==

# =================================


# == Specific Testbench File List ==
src_tb_lib_jtag_7seg_top_v+=$(TB_SRC_DIR)/tb_lib_jtag_7seg_top/testbench_setup.sv
src_tb_lib_jtag_7seg_top_v+=$(TB_SRC_DIR)/tb_lib_jtag_7seg_top/clk_gen.sv
src_tb_lib_jtag_7seg_top_v+=$(TB_SRC_DIR)/tb_lib_jtag_7seg_top/tb_top.sv
# ==================================


## == COMPILE DESIGN == ##
compile_jtag_7seg_top:
	make compile_design_vhd_files SRC_VHD="$(util_src_vhd)" VHD_DESIGN_LIB=lib_pkg_utils VHD_FILE_PATH=$(SRC_UTILS_DIR) WORK_DIR=JTAG_7SEG_TOP_WORK PROJECT_NAME=JTAG_7SEG_TOP
	make compile_design_vhd_files SRC_VHD="$(seg_src_vhd)" VHD_DESIGN_LIB=lib_seg7 VHD_FILE_PATH=$(SRC_LIB_7SEG) WORK_DIR=JTAG_7SEG_TOP_WORK PROJECT_NAME=JTAG_7SEG_TOP
	make compile_design_vhd_files SRC_VHD="$(axi4_lite_src_vhd)" VHD_DESIGN_LIB=lib_axi4_lite VHD_FILE_PATH=$(SRC_AXI4_LITE_DIR) WORK_DIR=JTAG_7SEG_TOP_WORK PROJECT_NAME=JTAG_7SEG_TOP
	make compile_design_vhd_files SRC_VHD="$(axi4_lite_7seg_src_vhd)" VHD_DESIGN_LIB=lib_axi4_lite_7seg VHD_FILE_PATH=$(SRC_AXI4_LITE_7SEG_DIR) WORK_DIR=JTAG_7SEG_TOP_WORK PROJECT_NAME=JTAG_7SEG_TOP
	make compile_design_vhd_files SRC_VHD="$(src_pulse_extender_vhd)" VHD_DESIGN_LIB=lib_pulse_extender VHD_FILE_PATH=$(SRC_PULSE_EXTENDER_DIR) WORK_DIR=JTAG_7SEG_TOP_WORK PROJECT_NAME=JTAG_7SEG_TOP


# ========================

## == COMPILE TESTBENCH == ##


compile_generic_tb_v_files_7seg:
	make compile_tb_v_files SRC_TB_V="$(GEN_MODULE_LIST)" LIB_TB_TOP=tb_lib_jtag_7seg_top V_FILE_PATH=/home/linux-jp/Documents/GitHub WORK_DIR=JTAG_7SEG_TOP_WORK PROJECT_NAME=JTAG_7SEG_TOP

compile_tb_jtag_7seg_top:
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_jtag_7seg_top_v)" LIB_TB_TOP=tb_lib_jtag_7seg_top V_FILE_PATH=$(TB_SRC_DIR)/tb_lib_jtag_7seg_top/

# =======================

# == COMPILE ALL ==
compile_all_jtag_7seg_top : clean_all create_simulation_dir libs compile_jtag_7seg_top compile_generic_tb_v_files_7seg


#compile_generic_tb_v_files compile_tb_jtag_7seg_top print_compile_logs_file
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

