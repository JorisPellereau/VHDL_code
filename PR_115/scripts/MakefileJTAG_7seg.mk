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
#include /home/linux-jp/Documents/GitHub/Generics_Makefiles/Makefiles/MakefileGeneric
#include /home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/makefiles/generic_modules_files.mk
# --------------

#GEN_MAKEFILE=/home/linux-jp/Documents/GitHub/Generics_Makefiles/Makefiles/MakefileGeneric

# -- MODELSIM Configuration --
#vsim=/opt/Modelsim/modelsim_ase/bin/vsim
#vlib=/opt/Modelsim/modelsim_ase/linuxaloem/vlib
#vmap=/opt/Modelsim/modelsim_ase/linuxaloem/vmap
#vcom=/opt/Modelsim/modelsim_ase/linuxaloem/vcom
#vlog=/opt/Modelsim/modelsim_ase/linuxaloem/vlog
# ----------------------------

# -- PROJECT Configuration --
ROOT=$(PWD)/..
PROJECT_NAME=JTAG_7SEG_TOP
# ---------------------------

# -- SCENARII Configuration --
SCN_LIB_DIR=
# ----------------------------

# -- IP VITRUAL JTAG MENTOR SCRIPT
mentor_script=/home/linux-jp/Documents/GitHub/Quartus_Projects/PR_115_board/JTAG/JTAG_7SEG/ip_jtag/altera_vjtag/simulation/mentor/msim_setup.tcl

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
#LIB_LIST+=work
# ================



#all: 
#	@echo "# =========================== #"
#	@echo "# Makefile for JTAG_7SEG_TOP blocks tests"
#	@echo "# =========================== #"
#	@echo ""
#	@echo ""




# == DESIGN VHD FILE LIST ==
#include TBD_files.mk
#lib_TBD_path=TBD_path

SRC_UTILS_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/PKG/sources/lib_pkg_utils/
SRC_AXI4_LITE_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite/
SRC_LIB_7SEG=/home/linux-jp/Documents/GitHub/VHDL_code/PR_115/sources/lib_seg7/
SRC_AXI4_LITE_7SEG_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite_7seg/
SRC_PULSE_EXTENDER_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/UTILS/sources/lib_pulse_extender/
SRC_JTAG_INTF_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/Intel/JTAG/sources/lib_jtag_intel/
SRC_JTAG_7SEG_TOP_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/PR_115/sources/lib_jtag_7seg_top/
SRC_RESET_GEN_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/RESET/sources/

util_src_vhd += pkg_utils.vhd

rst_gen_src_vhd += reset_gen.vhd

axi4_lite_src_vhd += axi4_lite_slave_itf.vhd
axi4_lite_src_vhd += axi4_lite_master.vhd

seg_src_vhd += seg7_lut.vhd
seg_src_vhd += seg7x8.vhd

axi4_lite_7seg_src_vhd += axi4_lite_7segs_pkg.vhd
axi4_lite_7seg_src_vhd += axi4_lite_7segs_registers.vhd
axi4_lite_7seg_src_vhd += axi4_lite_7segs.vhd

src_pulse_extender_vhd += bit_extender.vhd

src_jtag_intf_vhd += vjtag_intf.vhd

src_jtag_7seg_top_vhd += jtag_7seg_top.vhd
# ==========================




# == Specific Testbench File List ==
src_tb_lib_jtag_7seg_top_v+=testbench_setup.sv
src_tb_lib_jtag_7seg_top_v+=clk_gen.sv
src_tb_lib_jtag_7seg_top_v+=tb_top.sv
# ==================================


## == COMPILE DESIGN == ##
compile_jtag_7seg_top:
	make compile_design_vhd_files SRC_VHD="$(util_src_vhd)" VHD_DESIGN_LIB=lib_pkg_utils VHD_FILE_PATH=$(SRC_UTILS_DIR) WORK_DIR=JTAG_7SEG_TOP_WORK PROJECT_NAME=JTAG_7SEG_TOP; \
	make compile_design_vhd_files SRC_VHD="$(rst_gen_src_vhd)" VHD_DESIGN_LIB=lib_jtag_7seg_top VHD_FILE_PATH=$(SRC_RESET_GEN_DIR) WORK_DIR=JTAG_7SEG_TOP_WORK PROJECT_NAME=JTAG_7SEG_TOP; \
	make compile_design_vhd_files SRC_VHD="$(seg_src_vhd)" VHD_DESIGN_LIB=lib_seg7 VHD_FILE_PATH=$(SRC_LIB_7SEG) WORK_DIR=JTAG_7SEG_TOP_WORK PROJECT_NAME=JTAG_7SEG_TOP; \
	make compile_design_vhd_files SRC_VHD="$(axi4_lite_src_vhd)" VHD_DESIGN_LIB=lib_axi4_lite VHD_FILE_PATH=$(SRC_AXI4_LITE_DIR) WORK_DIR=JTAG_7SEG_TOP_WORK PROJECT_NAME=JTAG_7SEG_TOP; \
	make compile_design_vhd_files SRC_VHD="$(axi4_lite_7seg_src_vhd)" VHD_DESIGN_LIB=lib_axi4_lite_7seg VHD_FILE_PATH=$(SRC_AXI4_LITE_7SEG_DIR) WORK_DIR=JTAG_7SEG_TOP_WORK PROJECT_NAME=JTAG_7SEG_TOP; \
	make compile_design_vhd_files SRC_VHD="$(src_pulse_extender_vhd)" VHD_DESIGN_LIB=lib_pulse_extender VHD_FILE_PATH=$(SRC_PULSE_EXTENDER_DIR) WORK_DIR=JTAG_7SEG_TOP_WORK PROJECT_NAME=JTAG_7SEG_TOP; \
	make compile_design_vhd_files SRC_VHD="$(src_jtag_intf_vhd)" VHD_DESIGN_LIB=lib_jtag_intel VHD_FILE_PATH=$(SRC_JTAG_INTF_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_jtag_7seg_top_vhd)" VHD_DESIGN_LIB=lib_jtag_7seg_top VHD_FILE_PATH=$(SRC_JTAG_7SEG_TOP_DIR); \

compile_altera_vjag:
	cd $(HDL_SIMU_PATH)/$(PROJECT_NAME)/$(WORK_DIR); \
	$(vsim) -c -do $(DO_FILES_DIR)/mentor.do -do exit;\

# ========================

## == COMPILE TESTBENCH == ##


compile_generic_tb_v_files_7seg:
	make compile_tb_v_files SRC_TB_V="$(GEN_MODULE_LIST)" LIB_TB_TOP=tb_lib_jtag_7seg_top V_FILE_PATH=/home/linux-jp/Documents/GitHub WORK_DIR=JTAG_7SEG_TOP_WORK PROJECT_NAME=JTAG_7SEG_TOP

compile_tb_jtag_7seg_top:
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_jtag_7seg_top_v)" LIB_TB_TOP=tb_lib_jtag_7seg_top V_FILE_PATH=$(TB_SRC_DIR)/tb_lib_jtag_7seg_top/

# =======================

# == COMPILE ALL ==
compile_all_jtag_7seg_top : clean_all create_simulation_dir compile_altera_vjag libs compile_jtag_7seg_top  compile_generic_tb_v_files_7seg compile_tb_jtag_7seg_top print_compile_logs_file
#compile_generic_tb_v_files_7seg


#compile_generic_tb_v_files compile_tb_jtag_7seg_top print_compile_logs_file
# =================

# == SCENARII LIST ======
SCN_LIST+=TBD_000.py
# =======================

# == LIB ARGS ==
# work_lib : library create by mentor.do file. It contains altera_jtag module
# altera_mf_ver : library create by mentor.do file. It contains sld_altera_jtag module
LIB_ARGS=-L lib_pkg_utils -L lib_pulse_extender -L lib_jtag_intel -L lib_axi4_lite -L lib_axi4_lite_7seg -L lib_jtag_7seg_top -L lib_seg7 -L work_lib -L altera_mf_ver
# ==============

#VSIM_G_ARGS+=-G/tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/sld_node_ir_width=32
ifeq ($(TEST), JTAG_7SEG_TOP_00)

	VSIM_G_ARGS+=-G/tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/sld_node_n_scan=2
	VSIM_G_ARGS+=-G/tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/sld_node_total_length=12
	# SCNA TYPE : 0001
	# DR TYPE : 0010
	VSIM_G_ARGS+=-G/tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/sld_node_sim_action="((1,1,1,6),(1,2,5,6))"
endif
#RUN_ARGS+= -do $(DO_FILES_DIR)/mentor.do
# == RUN TEST ==
run_tb_jtag_7seg_top:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON SCN_LIB_DIR=scn_lib_jtag_7seg_top LIB_TB_TOP=tb_lib_jtag_7seg_top 
# ==============

