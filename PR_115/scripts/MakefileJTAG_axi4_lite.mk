# ========================================== #
#
# Makefile for JTAG_AXI4_LITE_TOP Block
#
# ========================================== #
# Author  : 
# Date    : 
# Version : 1.0
#         -
# ========================================== #

#.PHONY: MakefileJTAG_7seg.mk

# Execution :
# make -f MakefileJTAG_axi4_lite.mk compile_all_jtag_axi4_lite_top

# Reminder :
# do ../../../Documents/GitHub/VHDL_code/Makefile/do_files_generic/add_dut_waves.do tb_top i_dut



# -- PROJECT Configuration --
ROOT=$(PWD)/..
PROJECT_NAME=JTAG_AXI4_LITE_TOP
# ---------------------------

# -- SCENARII Configuration --
SCN_LIB_DIR=
# ----------------------------

# -- IP VITRUAL JTAG MENTOR SCRIPT
mentor_script=/home/linux-jp/Documents/GitHub/Quartus_Projects/PR_115_board/JTAG/JTAG_AXI4_LITE/ip_jtag/altera_vjtag/simulation/mentor/msim_setup.tcl

# -- SIMULATION Configuration --
RTL_Testbench_path=/home/linux-jp/Documents/GitHub
HDL_SIMU_PATH=/home/linux-jp/SIMULATION_VHDL
WORK_DIR=JTAG_AXI4_LITE_TOP_WORK
LIB_TB_TOP=tb_lib_jtag_axi4_lite_top
NO_WLF=OFF
GUI=ON
TRANSCRIPT_EN=ON
DO_FILES_EN=ON
# ------------------------------


# -- Compilation Configuration --
VCOM_ARGS+=
VLOG_ARGS+=
# -------------------------------


# Create Temporary Project
create_temp_proj_jtag_axi4_lite:
	make create_temp_project

# == DESIGN LIBRARIES ==

# ======================

# == TESTBENCH LIBRARIES ==
LIB_LIST+=tb_lib_jtag_axi4_lite_top

# =========================

# ==  LIB LIST ==
LIB_LIST+=lib_seg7
LIB_LIST+=lib_pkg_utils
LIB_LIST+=lib_pulse_extender
LIB_LIST+=lib_jtag_intel
LIB_LIST+=lib_axi4_lite
LIB_LIST+=lib_axi4_lite_7seg
LIB_LIST+=lib_axi4_lite_lcd
LIB_LIST+=lib_CFAH1602_v2
LIB_LIST+=lib_ram_intel
LIB_LIST+=lib_fifo
LIB_LIST+=lib_fifo_wrapper
LIB_LIST+=lib_jtag_axi4_lite_top
# ================



# == DESIGN VHD FILE LIST ==


# -- Design DIR PATH --
SRC_UTILS_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/PKG/sources/lib_pkg_utils/
SRC_AXI4_LITE_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite/
SRC_LIB_7SEG=/home/linux-jp/Documents/GitHub/VHDL_code/PR_115/sources/lib_seg7/
SRC_AXI4_LITE_7SEG_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite_7seg/
SRC_PULSE_EXTENDER_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/UTILS/sources/lib_pulse_extender/

SRC_LCD_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/LCD/LCD_CFAH1602BTMCJP/sources/lib_CFAH1602_v2/
SRC_AXI4_LITE_LCD_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite_lcd/

SRC_JTAG_INTF_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/Intel/JTAG/sources/lib_jtag_intel/


SRC_RESET_GEN_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/RESET/sources/

SRC_LIB_RAM_INTEL_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/RAM/sources/lib_ram_intel/
SRC_LIB_FIFO_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/FIFO/sources/lib_fifo/
SRC_LIB_FIFO_WRAPPER_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/FIFO/sources/lib_fifo_wrapper/

SRC_JTAG_AXI4_LITE_TOP_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/PR_115/sources/lib_jtag_axi4_lite_top/
# ---------------------

# Design Sources List
util_src_vhd += pkg_utils.vhd

rst_gen_src_vhd += reset_gen.vhd

src_lib_ram_intel_vhd+=sp_ram.vhd
src_lib_fifo_vhd+=fifo_sp_ram.vhd
src_lib_fifo_wrapper_vhd+=fifo_sp_ram_wrapper.vhd

axi4_lite_custom_src_vhd += pkg_axi4_lite_interco_custom.vhd

axi4_lite_src_vhd += axi4_lite_slave_itf.vhd
axi4_lite_src_vhd += axi4_lite_master.vhd

axi4_lite_src_vhd += pkg_axi4_lite_interco.vhd
axi4_lite_src_vhd += axi4_lite_interco_1_to_n.vhd

seg_src_vhd += seg7_lut.vhd
seg_src_vhd += seg7x8.vhd

axi4_lite_7seg_src_vhd += axi4_lite_7segs_pkg.vhd
axi4_lite_7seg_src_vhd += axi4_lite_7segs_registers.vhd
axi4_lite_7seg_src_vhd += axi4_lite_7segs.vhd

src_pulse_extender_vhd += bit_extender.vhd

src_jtag_intf_vhd += vjtag_intf.vhd

src_lcd_vhd+=pkg_lcd_cfah_types_and_func.vhd
src_lcd_vhd+=pkg_lcd_cfah.vhd
src_lcd_vhd+=lcd_cfah_itf.vhd
src_lcd_vhd+=lcd_cfah_cmd_generator.vhd
src_lcd_vhd+=lcd_cfah_polling.vhd
src_lcd_vhd+=lcd_cfah_init.vhd
src_lcd_vhd+=lcd_cfah_main_fsm.vhd
src_lcd_vhd+=lcd_cfah_update_display_fsm.vhd
src_lcd_vhd+=lcd_cfah_update_display.vhd
src_lcd_vhd+=lcd_cfah_top.vhd

src_axi4_lite_lcd_vhd+=axi4_lite_lcd_pkg.vhd
src_axi4_lite_lcd_vhd+=axi4_lite_lcd_registers.vhd
src_axi4_lite_lcd_vhd+=axi4_lite_lcd.vhd

src_jtag_axi4_lite_top_vhd += pkg_jtag_axi4_lite_top.vhd
src_jtag_axi4_lite_top_vhd += jtag_axi4_lite_core.vhd
src_jtag_axi4_lite_top_vhd += jtag_axi4_lite_top.vhd
# ==========================

# == TESTBENCH UART V FILES LIST ==

# =================================


# == Specific Testbench File List ==
src_tb_lib_jtag_axi4_lite_top_v+=testbench_setup.sv
src_tb_lib_jtag_axi4_lite_top_v+=clk_gen.sv
src_tb_lib_jtag_axi4_lite_top_v+=tb_top.sv
# ==================================


## == COMPILE DESIGN == ##
compile_jtag_axi4_lite_top:
	make compile_design_vhd_files SRC_VHD="$(util_src_vhd)" VHD_DESIGN_LIB=lib_pkg_utils VHD_FILE_PATH=$(SRC_UTILS_DIR) WORK_DIR=JTAG_AXI4_LITE_TOP_WORK PROJECT_NAME=JTAG_AXI4_LITE_TOP; \
	make compile_design_vhd_files SRC_VHD="$(rst_gen_src_vhd)" VHD_DESIGN_LIB=lib_jtag_axi4_lite_top VHD_FILE_PATH=$(SRC_RESET_GEN_DIR) WORK_DIR=JTAG_AXI4_LITE_TOP_WORK PROJECT_NAME=JTAG_AXI4_LITE_TOP; \
	make compile_design_vhd_files SRC_VHD="$(src_lib_ram_intel_vhd)" VHD_DESIGN_LIB=lib_ram_intel VHD_FILE_PATH=$(SRC_LIB_RAM_INTEL_DIR) WORK_DIR=JTAG_AXI4_LITE_TOP_WORK PROJECT_NAME=JTAG_AXI4_LITE_TOP; \
	make compile_design_vhd_files SRC_VHD="$(src_lib_fifo_vhd)" VHD_DESIGN_LIB=lib_fifo VHD_FILE_PATH=$(SRC_LIB_FIFO_DIR) WORK_DIR=JTAG_AXI4_LITE_TOP_WORK PROJECT_NAME=JTAG_AXI4_LITE_TOP; \
	make compile_design_vhd_files SRC_VHD="$(src_lib_fifo_wrapper_vhd)" VHD_DESIGN_LIB=lib_fifo_wrapper VHD_FILE_PATH=$(SRC_LIB_FIFO_WRAPPER_DIR) WORK_DIR=JTAG_AXI4_LITE_TOP_WORK PROJECT_NAME=JTAG_AXI4_LITE_TOP; \
	make compile_design_vhd_files SRC_VHD="$(seg_src_vhd)" VHD_DESIGN_LIB=lib_seg7 VHD_FILE_PATH=$(SRC_LIB_7SEG) WORK_DIR=JTAG_AXI4_LITE_TOP_WORK PROJECT_NAME=JTAG_AXI4_LITE_TOP; \
	make compile_design_vhd_files SRC_VHD="$(axi4_lite_custom_src_vhd)" VHD_DESIGN_LIB=lib_axi4_lite VHD_FILE_PATH=$(SRC_JTAG_AXI4_LITE_TOP_DIR) WORK_DIR=JTAG_AXI4_LITE_TOP_WORK PROJECT_NAME=JTAG_AXI4_LITE_TOP; \
	make compile_design_vhd_files SRC_VHD="$(axi4_lite_src_vhd)" VHD_DESIGN_LIB=lib_axi4_lite VHD_FILE_PATH=$(SRC_AXI4_LITE_DIR) WORK_DIR=JTAG_AXI4_LITE_TOP_WORK PROJECT_NAME=JTAG_AXI4_LITE_TOP; \
	make compile_design_vhd_files SRC_VHD="$(axi4_lite_7seg_src_vhd)" VHD_DESIGN_LIB=lib_axi4_lite_7seg VHD_FILE_PATH=$(SRC_AXI4_LITE_7SEG_DIR) WORK_DIR=JTAG_AXI4_LITE_TOP_WORK PROJECT_NAME=JTAG_AXI4_LITE_TOP; \
	make compile_design_vhd_files SRC_VHD="$(src_pulse_extender_vhd)" VHD_DESIGN_LIB=lib_pulse_extender VHD_FILE_PATH=$(SRC_PULSE_EXTENDER_DIR) WORK_DIR=JTAG_AXI4_LITE_TOP_WORK PROJECT_NAME=JTAG_AXI4_LITE_TOP; \
	make compile_design_vhd_files SRC_VHD="$(src_jtag_intf_vhd)" VHD_DESIGN_LIB=lib_jtag_intel VHD_FILE_PATH=$(SRC_JTAG_INTF_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_jtag_7seg_top_vhd)" VHD_DESIGN_LIB=lib_jtag_axi4_lite_top VHD_FILE_PATH=$(SRC_JTAG_7SEG_TOP_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_lcd_vhd)" VHD_DESIGN_LIB=lib_CFAH1602_v2 VHD_FILE_PATH=$(SRC_LCD_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_axi4_lite_lcd_vhd)" VHD_DESIGN_LIB=lib_axi4_lite_lcd VHD_FILE_PATH=$(SRC_AXI4_LITE_LCD_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_jtag_axi4_lite_top_vhd)" VHD_DESIGN_LIB=lib_jtag_axi4_lite_top VHD_FILE_PATH=$(SRC_JTAG_AXI4_LITE_TOP_DIR); \



compile_altera_vjag_jtag_axi4_lite_top:
	cd $(HDL_SIMU_PATH)/$(PROJECT_NAME)/$(WORK_DIR); \
	$(vsim) -c -do $(DO_FILES_DIR)/mentor_jtag_axi4_lite_top.do -do exit;\

# ========================

## == COMPILE TESTBENCH == ##

# INC_DIR_TB_EN=ON
# Add include Directory
compile_generic_tb_v_files_jtag_axi4_lite_top:
	make compile_tb_v_files SRC_TB_V="$(GEN_MODULE_LIST)" LIB_TB_TOP=tb_lib_jtag_axi4_lite_top V_FILE_PATH=/home/linux-jp/Documents/GitHub WORK_DIR=JTAG_AXI4_LITE_TOP_WORK PROJECT_NAME=JTAG_AXI4_LITE_TOP INC_DIR_TB_EN=ON

compile_tb_jtag_axi4_lite_top:
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_jtag_axi4_lite_top_v)" LIB_TB_TOP=tb_lib_jtag_axi4_lite_top V_FILE_PATH=$(TB_SRC_DIR)/tb_lib_jtag_axi4_lite_top/

# =======================

# == COMPILE ALL ==
compile_all_jtag_axi4_lite_top :
	make clean_all ; \
	make create_simulation_dir ; \
	make compile_altera_vjag_jtag_axi4_lite_top; \
	make libs ; \
	make compile_jtag_axi4_lite_top ; \
	make compile_generic_tb_v_files_jtag_axi4_lite_top ; \
	make compile_tb_jtag_axi4_lite_top ; \
	make print_compile_logs_file

#	make libs

#compile_jtag_7seg_top  compile_generic_tb_v_files_7seg compile_tb_jtag_7seg_top print_compile_logs_file
#compile_generic_tb_v_files_7seg


#compile_generic_tb_v_files compile_tb_jtag_7seg_top print_compile_logs_file
# =================

# == SCENARII LIST ======
SCN_LIST+=JTAG_AXI4_LITE_TOP_00.py
# =======================

# == LIB ARGS ==
# work_lib : library create by mentor.do file. It contains altera_jtag module
# altera_mf_ver : library create by mentor.do file. It contains sld_altera_jtag module
LIB_ARGS=-L lib_pkg_utils -L lib_pulse_extender -L lib_jtag_intel -L lib_axi4_lite -L lib_axi4_lite_7seg -L lib_jtag_axi4_lite_top -L lib_seg7 -L work_lib -L altera_mf_ver -L lib_axi4_lite_lcd -L lib_CFAH1602_v2 -L lib_ram_intel -L lib_fifo -L lib_fifo_wrapper
# ==============

#VSIM_G_ARGS+=-G/tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/sld_node_ir_width=32
#VSIM_G_ARGS+=-G/tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/sld_node_n_scan=2
#VSIM_G_ARGS+=-G/tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/sld_node_total_length=12
# SCNA TYPE : 0001
# DR TYPE : 0010
#VSIM_G_ARGS+=-G/tb_top/i_dut_0/i_altera_vjtag_0/virtual_jtag_0/user_input/sld_node_sim_action="((1,1,1,6),(1,2,5,6))"
#RUN_ARGS+= -do $(DO_FILES_DIR)/mentor.do

# == RUN TEST ==
run_tb_jtag_axi4_lite_top:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON SCN_LIB_DIR=scn_lib_jtag_axi4_lite_top LIB_TB_TOP=tb_lib_jtag_axi4_lite_top 
# ==============
