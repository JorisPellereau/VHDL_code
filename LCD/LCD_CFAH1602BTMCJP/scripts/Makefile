# ========================================== #
#
# Makefile for LCD CFAH blocks tests
#
# ========================================== #

# ========================================== #
# Author  : J.P
# Date    : 19/11/2022
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
PROJECT_NAME=LCD_CFAH1602BTMCJP
WORK_DIR=LCD_CFAH_WORK
TRANSCRIPT_EN=OFF

# -- SIMULATION Configuration --
RTL_Testbench_path=~/RTL_Testbench
HDL_SIMU_PATH=/home/linux-jp/SIMULATION_VHDL
NO_WLF=OFF
GUI=ON
TRANSCRIPT_EN=ON
DO_FILES_EN=ON
# ------------------------------




# == SOURCES DIRECTORY ==

# =======================

# == DESIGN LIBRARIES ==
LIB_PKG_UTILS=lib_pkg_utils
LIB_CFAH1602=lib_CFAH1602
LIB_CFAH1602_v2=lib_CFAH1602_v2
# ======================

# == TESTBENCH LIBRARIES ==
LIB_TB_UNIT_LCD_CFAH_ITF=lib_tb_lib_unit_lcd_cfah_itf
LIB_TB_UNIT_LCD_CFAH_TOP=lib_tb_unit_lcd_cfah_top
# =========================

# ==  LIB LIST ==
LIB_LIST+=work
LIB_LIST+=$(LIB_PKG_UTILS)
LIB_LIST+=$(LIB_CFAH1602)
LIB_LIST+=$(LIB_TB_UNIT_LCD_CFAH_ITF)
LIB_LIST+=$(LIB_CFAH1602_v2)
# ================



# == PYTHON SCRIPTS PATH ==
#FILE_OPTI_SCRIPT=~/Documents/GitHub/Verilog/Testbench/scripts/python_scripts/file_optimisation.py
# =========================

all: print_generic_rules
	@echo ""
	@echo "Makefile for UART blocks tests"
	@echo ""
	@echo "== SOURCES COMPILATIONS =="
	@echo ""
	@echo "- Design Sources Compilation :"
	@echo "make compile_design"
	@echo ""	
	@echo "- Compile Testbench :"
	@echo "make compile_testbench"
	@echo ""
	@echo "- Compile Design & Testbench :"
	@echo "make compile_all_unit_lcd_cfah_itf"
	@echo ""
	@echo "=========================="
	@echo ""
	@echo ""
	@echo "=== RUN CODE COVERAGE ==="
	@echo ""
	@echo ""
	@echo "========================="
	@echo "== RUN TESTS =="
	@echo "- run_tb_unit_lcd_cfah_itf"
	@echo "make TEST=[TEST_NB]"
	@echo "==============="
	@echo ""
	@echo "== PYTHON SCRIPTS =="
	@echo "make genarate_collect_opti_files TEST=XXX"
	@echo "make generate_collect_all_opti_files"
	@echo "===================="
	@echo ""
	@echo "== SCENARII LIST =="
	@echo "$(SCN_LIST)"
	@echo "==================="




LIB_TB_TOP=$(LIB_TB_UNIT_LCD_CFAH_ITF)

# == DESIGN VHD FILE LIST ==

src_lib_pkg_utils=/home/linux-jp/Documents/GitHub/VHDL_code/PKG/sources/lib_pkg_utils/pkg_utils.vhd
src_lib_CFAH1602+=$(SRC_DIR)/lib_CFAH1602/pkg_lcd_cfah_types_and_func.vhd
src_lib_CFAH1602+=$(SRC_DIR)/lib_CFAH1602/pkg_lcd_cfah.vhd
src_lib_CFAH1602+=$(SRC_DIR)/lib_CFAH1602/lcd_cfah_itf.vhd
src_lib_CFAH1602+=$(SRC_DIR)/lib_CFAH1602/lcd_cfah_cmd_generator.vhd
src_lib_CFAH1602+=$(SRC_DIR)/lib_CFAH1602/lcd_cfah_polling_busy.vhd
src_lib_CFAH1602+=$(SRC_DIR)/lib_CFAH1602/lcd_cfah_cmd_buffer.vhd
src_lib_CFAH1602+=$(SRC_DIR)/lib_CFAH1602/lcd_cfah_cgram_buffer.vhd
src_lib_CFAH1602+=$(SRC_DIR)/lib_CFAH1602/lcd_cfah_init.vhd
src_lib_CFAH1602+=$(SRC_DIR)/lib_CFAH1602/lcd_cfah_lines_buffer.vhd
src_lib_CFAH1602+=$(SRC_DIR)/lib_CFAH1602/lcd_cfah_update_display.vhd
src_lib_CFAH1602+=$(SRC_DIR)/lib_CFAH1602/lcd_cfah_update_cgram.vhd
src_lib_CFAH1602+=$(SRC_DIR)/lib_CFAH1602/lcd_cfah_top.vhd





# -- SOURCES DIR --
SRC_UTILS_DIR=/home/linux-jp/Documents/GitHub/VHDL_code/PKG/sources/lib_pkg_utils/
SRC_LIB_CFAH1602_v2_DIR=$(SRC_DIR)/lib_CFAH1602_v2/
SRC_LIB_CFAH1602_DIR=$(SRC_DIR)/lib_CFAH1602/


src_lib_cfah1602_vhd+=lcd_cfah_itf.vhd
src_lib_cfah1602_vhd+=lcd_cfah_cmd_generator.vhd


util_src_vhd += pkg_utils.vhd

src_vhd_lib_CFAH1602_v2+=pkg_lcd_cfah_types_and_func.vhd
src_vhd_lib_CFAH1602_v2+=pkg_lcd_cfah.vhd
src_vhd_lib_CFAH1602_v2+=lcd_cfah_itf.vhd
src_vhd_lib_CFAH1602_v2+=lcd_cfah_cmd_generator.vhd
src_vhd_lib_CFAH1602_v2+=lcd_cfah_init.vhd
src_vhd_lib_CFAH1602_v2+=lcd_cfah_main_fsm.vhd
src_vhd_lib_CFAH1602_v2+=lcd_cfah_polling.vhd
src_vhd_lib_CFAH1602_v2+=lcd_cfah_top.vhd

# ==========================

# == TESTBENCH V FILES LIST ==
SRC_TB_V_DIR=/home/linux-jp/Documents/GitHub/Verilog/Testbench/sources/TB_modules/LCD_CFAH_checker/
src_tb_v+=LCD_CFAH_emul.sv
# =================================


# == Specific Testbench File List ==

# -- TB Unit itf
src_tb_lib_unit_lcd_cfah_itf_v+=$(TB_SRC_DIR)/tb_lib_unit_lcd_cfah_itf/testbench_setup.sv
src_tb_lib_unit_lcd_cfah_itf_v+=$(TB_SRC_DIR)/tb_lib_unit_lcd_cfah_itf/clk_gen.sv
src_tb_lib_unit_lcd_cfah_itf_v+=$(TB_SRC_DIR)/tb_lib_unit_lcd_cfah_itf/tb_top.sv

# -- TB Unit top
SRC_TB_LIB_UNIT_LCD_CFAH_TOP_DIR=$(TB_SRC_DIR)/tb_lib_unit_lcd_cfah_top/

src_tb_lib_unit_lcd_cfah_top_v+=testbench_setup.sv
src_tb_lib_unit_lcd_cfah_top_v+=clk_gen.sv
src_tb_lib_unit_lcd_cfah_top_v+=tb_top.sv
# ==================================

# == Coverage Testbench File List ==
# src_tb_coverage_unit_lcd_cfah_itf+=$(src_code_cov_tb_vhd)
# src_tb_coverage_unit_lcd_cfah_itf+=$(TB_SRC_DIR)/tb_lib_unit_lcd_cfah_itf/tb_top.vhd
# ==================================

## == COMPILE DESIGN == ##
compile_lcd_cfah_top:
	make compile_design_vhd_files SRC_VHD="$(util_src_vhd)" VHD_DESIGN_LIB=$(LIB_PKG_UTILS) VHD_FILE_PATH=$(SRC_UTILS_DIR) WORK_DIR=$(WORK_DIR) PROJECT_NAME=$(PROJECT_NAME); \
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_CFAH1602_v2)" VHD_DESIGN_LIB=$(LIB_CFAH1602_v2) VHD_FILE_PATH=$(SRC_LIB_CFAH1602_v2_DIR) WORK_DIR=$(WORK_DIR) PROJECT_NAME=$(PROJECT_NAME); \



# ========================


compile_pkg_utils:
	make compile_design_vhd_files SRC_VHD="$(src_lib_pkg_utils)" VHD_DESIGN_LIB=$(LIB_PKG_UTILS)

compile_lcd_cfah:
	make compile_design_vhd_files SRC_VHD="$(src_lib_pkg_utils)" VHD_DESIGN_LIB=lib_CFAH1602
	make compile_design_vhd_files SRC_VHD="$(src_lib_CFAH1602)"  VHD_DESIGN_LIB=lib_CFAH1602


# == Compile Design Library here ==
compile_design_lcd_cfah : compile_pkg_utils compile_lcd_cfah 
# ================================


## == COMPILE TESTBENCH == ##
compile_generic_tb_v_files_lcd_top:
	make compile_tb_v_files SRC_TB_V="$(GEN_MODULE_LIST)" LIB_TB_TOP=$(LIB_TB_UNIT_LCD_CFAH_TOP) V_FILE_PATH=/home/linux-jp/Documents/GitHub WORK_DIR=$(WORK_DIR) PROJECT_NAME=$(PROJECT_NAME)


compile_generic_tb_v_files:
	make compile_tb_v_files SRC_TB_V="$(src_gen_tb_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_ITF)
	make compile_tb_v_files SRC_TB_V="$(src_tb_data_collector_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_ITF)
	make compile_tb_v_files SRC_TB_V="$(src_gen_tb_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_TOP)
	make compile_tb_v_files SRC_TB_V="$(src_tb_data_collector_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_TOP)

compile_tb_unit_lcd_cfah_sources:
	make compile_tb_v_files SRC_TB_V="$(src_tb_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_ITF)
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_unit_lcd_cfah_itf_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_ITF)

# Compile TB UNIT LCD CFAH TOP
compile_tb_unit_lcd_cfah_top:
	make compile_tb_v_files SRC_TB_V="$(src_tb_v)" LIB_TB_TOP=$(LIB_TB_UNIT_LCD_CFAH_TOP) V_FILE_PATH=$(SRC_TB_V_DIR); \
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_unit_lcd_cfah_top_v)" LIB_TB_TOP=$(LIB_TB_UNIT_LCD_CFAH_TOP) V_FILE_PATH=$(SRC_TB_LIB_UNIT_LCD_CFAH_TOP_DIR); \

#	make compile_tb_v_files SRC_TB_V="$(src_tb_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_TOP)
#	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_unit_lcd_cfah_top_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_TOP)

# == COMPILE ALL TESTBENCH files ==
# -- TB UNIT ITF
compile_tb_unit_lcd_cfah_itf : compile_generic_tb_v_files compile_tb_unit_lcd_cfah_sources

# -- TB UNIT Top
#compile_tb_unit_lcd_cfah_top: compile_generic_tb_v_files compile_tb_unit_lcd_cfah_top
# =======================

# Compile TB UNIT LCD CFAH Interface
compile_all_unit_lcd_cfah_itf: clean_all create_project_dir libs compile_design_lcd_cfah compile_tb_unit_lcd_cfah_itf print_compile_logs_file
compile_all_unit_lcd_cfah_top: clean_all create_project_dir libs compile_design_lcd_cfah compile_tb_unit_lcd_cfah_top print_compile_logs_file


# Compile All LCD CFAH TOP
compile_all_lcd_cfah_top: clean_all create_simulation_dir libs
	make compile_lcd_cfah_top; \
	make compile_generic_tb_v_files_lcd_top; \
	make compile_tb_unit_lcd_cfah_top; \
	make print_compile_logs_file; \



# == SCENARII LIST ==
SCN_LIST+=LCD_CFAH_ITF_00
SCN_LIST+=LCD_CFAH_TOP_00
SCN_LIST+=LCD_CFAH_TOP_01
SCN_LIST+=LCD_CFAH_TOP_02
SCN_LIST+=LCD_CFAH_TOP_03
# =======================

# == LIB ARGS ==
LIB_ARGS=-L lib_pkg_utils -L lib_CFAH1602 -L lib_CFAH1602_v2
# ==============


# == RUN TEST ==
run_tb_unit_lcd_cfah_itf:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON LIB_TB_TOP=$(LIB_TB_UNIT_LCD_CFAH_ITF) SCN_LIB_DIR=scn_lib_unit_lcd_cfah_itf


# Run test for LCD CFAH TOP
run_tb_unit_lcd_cfah_top:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON LIB_TB_TOP=$(LIB_TB_UNIT_LCD_CFAH_TOP) SCN_LIB_DIR=scn_lib_unit_lcd_cfah_top
# ==============

