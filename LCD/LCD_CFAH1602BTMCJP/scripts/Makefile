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

# == Makefile Configuration ==
SEL_STATION=LINUX
ROOT=$(PWD)/..
PROJECT_NAME=LCD_CFAH1602BTMCJP
WORK_DIR=LCD_CFAH_WORK
TRANSCRIPT_EN=OFF
# ============================



# == SOURCES DIRECTORY ==

# =======================

# == DESIGN LIBRARIES ==
LIB_PKG_UTILS=lib_pkg_utils
LIB_CFAH1602=lib_CFAH1602
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
# ================

# ================ GHDL CONFIGURATION ================ #
#GHDL_COV_DIR_LIST+=UART_DISPLAY_CTRL_CODE_COVERAGE


# == COVERAGE LIBRARIES ==
#LIB_TB_TOP_UART_DISPLAY_CTRL_COVERAGE=lib_tb_top_uart_display_ctrl_coverage
# ========================

# == GHDL LIB LIST ==
# GHDL_LIB_LIST+=
# ===================

# == PYTHON SCRIPTS PATH ==
FILE_OPTI_SCRIPT=~/Documents/GitHub/Verilog/Testbench/scripts/python_scripts/file_optimisation.py
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


# == COLLECT DIRECTORY ==
# create_collect_dir:
# 	cd $(HDL_SIMU_PATH); \
# 	if [ ! -d  $(UART_COLLECT_DIR) ]; then \
# 	  mkdir $(UART_COLLECT_DIR); \
# 	fi

# create_memory_dump_dir:
# 	cd $(HDL_SIMU_PATH); \
# 	if [ ! -d  $(UART_MEMORY_DUMP_DIR) ]; then \
# 	  mkdir $(UART_MEMORY_DUMP_DIR); \
# 	fi
# =======================


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
# ==========================

# == TESTBENCH V FILES LIST ==
src_tb_v+=/home/linux-jp/Documents/GitHub/Verilog/Testbench/sources/TB_modules/LCD_CFAH_checker/LCD_CFAH_emul.sv
# =================================


# == Specific Testbench File List ==

# -- TB Unit itf
src_tb_lib_unit_lcd_cfah_itf_v+=$(TB_SRC_DIR)/tb_lib_unit_lcd_cfah_itf/testbench_setup.sv
src_tb_lib_unit_lcd_cfah_itf_v+=$(TB_SRC_DIR)/tb_lib_unit_lcd_cfah_itf/clk_gen.sv
src_tb_lib_unit_lcd_cfah_itf_v+=$(TB_SRC_DIR)/tb_lib_unit_lcd_cfah_itf/tb_top.sv

# -- TB Unit top
src_tb_lib_unit_lcd_cfah_top_v+=$(TB_SRC_DIR)/tb_lib_unit_lcd_cfah_top/testbench_setup.sv
src_tb_lib_unit_lcd_cfah_top_v+=$(TB_SRC_DIR)/tb_lib_unit_lcd_cfah_top/clk_gen.sv
src_tb_lib_unit_lcd_cfah_top_v+=$(TB_SRC_DIR)/tb_lib_unit_lcd_cfah_top/tb_top.sv
# ==================================

# == Coverage Testbench File List ==
# src_tb_coverage_unit_lcd_cfah_itf+=$(src_code_cov_tb_vhd)
# src_tb_coverage_unit_lcd_cfah_itf+=$(TB_SRC_DIR)/tb_lib_unit_lcd_cfah_itf/tb_top.vhd
# ==================================

## == COMPILE DESIGN == ##

compile_pkg_utils:
	make compile_design_vhd_files SRC_VHD="$(src_lib_pkg_utils)" VHD_DESIGN_LIB=$(LIB_PKG_UTILS)

compile_lcd_cfah:
	make compile_design_vhd_files SRC_VHD="$(src_lib_pkg_utils)" VHD_DESIGN_LIB=lib_CFAH1602
	make compile_design_vhd_files SRC_VHD="$(src_lib_CFAH1602)"  VHD_DESIGN_LIB=lib_CFAH1602


# == Compile Design Library here ==
compile_design_lcd_cfah : compile_pkg_utils compile_lcd_cfah
# ================================


## == COMPILE TESTBENCH == ##

compile_generic_tb_v_files:
	make compile_tb_v_files SRC_TB_V="$(src_gen_tb_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_ITF)
	make compile_tb_v_files SRC_TB_V="$(src_tb_data_collector_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_ITF)
	make compile_tb_v_files SRC_TB_V="$(src_gen_tb_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_TOP)
	make compile_tb_v_files SRC_TB_V="$(src_tb_data_collector_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_TOP)

compile_tb_unit_lcd_cfah_sources:
	make compile_tb_v_files SRC_TB_V="$(src_tb_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_ITF)
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_unit_lcd_cfah_itf_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_ITF)

compile_tb_unit_lcd_cfah_top:
	make compile_tb_v_files SRC_TB_V="$(src_tb_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_TOP)
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_unit_lcd_cfah_top_v)" TB_LIB_TOP=$(LIB_TB_UNIT_LCD_CFAH_TOP)

# == COMPILE ALL TESTBENCH files ==
# -- TB UNIT ITF
compile_tb_unit_lcd_cfah_itf : compile_generic_tb_v_files compile_tb_unit_lcd_cfah_sources

# -- TB UNIT Top
compile_tb_unit_lcd_cfah_top: compile_generic_tb_v_files compile_tb_unit_lcd_cfah_top
# =======================

# Compile TB UNIT LCD CFAH Interface
compile_all_unit_lcd_cfah_itf: clean_all create_project_dir libs compile_design_lcd_cfah compile_tb_unit_lcd_cfah_itf print_compile_logs_file
compile_all_unit_lcd_cfah_top: clean_all create_project_dir libs compile_design_lcd_cfah compile_tb_unit_lcd_cfah_top print_compile_logs_file 
# == SCENARII LIST ==
SCN_LIST+=LCD_CFAH_ITF_00
SCN_LIST+=LCD_CFAH_TOP_00
SCN_LIST+=LCD_CFAH_TOP_01
SCN_LIST+=LCD_CFAH_TOP_02
SCN_LIST+=LCD_CFAH_TOP_03
# =======================

# == LIB ARGS ==
LIB_ARGS=-L lib_pkg_utils -L lib_CFAH1602
# ==============


# == RUN TEST ==
run_tb_unit_lcd_cfah_itf:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON LIB_TB_TOP=$(LIB_TB_UNIT_LCD_CFAH_ITF) SCN_LIB_DIR=scn_lib_unit_lcd_cfah_itf

run_tb_unit_lcd_cfah_top:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON LIB_TB_TOP=$(LIB_TB_UNIT_LCD_CFAH_TOP) SCN_LIB_DIR=scn_lib_unit_lcd_cfah_top
# ==============


# == CODE COVERAGE ==

# # Compile 
# ghdl_gcc_compile_unit_lcd_cfah_itf_tb:
# 	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_vhd_lib_others)" GHDL_WORK_LIB_NAME=$(LIB_OTHERS) \
# 	COVERAGE_DIR=UNIT_LCD_CFAH_ITF_CODE_COVERAGE CODE_COV_EN=ON
# 	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_vhd_lib_max7219_interface)" GHDL_WORK_LIB_NAME=$(LIB_MAX7219_INTERFACE) \
# 	P_ARGS_EN=ON COVERAGE_DIR=UNIT_LCD_CFAH_ITF_CODE_COVERAGE CODE_COV_EN=ON
# 	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_vhd_lib_max7219_static)" GHDL_WORK_LIB_NAME=$(LIB_MAX7219_STATIC) \
# 	COVERAGE_DIR=UNIT_LCD_CFAH_ITF_CODE_COVERAGE CODE_COV_EN=ON
# 	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_vhd_lib_max7219_scroller)" GHDL_WORK_LIB_NAME=$(LIB_MAX7219_SCROLLER) \
# 	COVERAGE_DIR=UNIT_LCD_CFAH_ITF_CODE_COVERAGE CODE_COV_EN=ON
# 	echo $(P_ARGS)
# 	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_vhd_lib_max7219_controller)" GHDL_WORK_LIB_NAME=$(LIB_MAX7219_CONTROLLER) P_ARGS_EN=ON COVERAGE_DIR=UNIT_LCD_CFAH_ITF_CODE_COVERAGE CODE_COV_EN=ON
# 	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_lib_uart)" GHDL_WORK_LIB_NAME=$(LIB_UART) COVERAGE_DIR=UNIT_LCD_CFAH_ITF_CODE_COVERAGE CODE_COV_EN=ON
# 	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_vhd_lib_unit_lcd_cfah_itf)" GHDL_WORK_LIB_NAME=$(LIB_UNIT_LCD_CFAH_ITF) P_ARGS_EN=ON COVERAGE_DIR=UNIT_LCD_CFAH_ITF_CODE_COVERAGE CODE_COV_EN=ON
# 	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_code_cov_tb_vhd)" GHDL_WORK_LIB_NAME=$(LIB_CODE_COVERAGE) COVERAGE_DIR=UNIT_LCD_CFAH_ITF_CODE_COVERAGE
# 	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_tb_coverage_unit_lcd_cfah_itf)" GHDL_WORK_LIB_NAME=$(LIB_TB_TOP_UNIT_LCD_CFAH_ITF_COVERAGE) P_ARGS_EN=ON COVERAGE_DIR=UNIT_LCD_CFAH_ITF_CODE_COVERAGE
# 	make ghdl_gcc_elaboration_vhd_src GHDL_WORK_LIB_NAME=$(LIB_TB_TOP_UNIT_LCD_CFAH_ITF_COVERAGE) GHDL_TOP_UNIT=tb_top \
# 	P_ARGS_EN=ON COVERAGE_DIR=UNIT_LCD_CFAH_ITF_CODE_COVERAGE CODE_COV_EN=ON

# # SIMU_TIME must be passed as argument
# GHDL_RUN_ARGS_CONTROLLER+=--vcd=/home/linux-jp/SIMULATION_VHDL/run_code_cov_unit_lcd_cfah_itf.vcd
# ghdl_gcc_run_unit_lcd_cfah_itf_tb:
# 	make export_simu_time TEST_GROUP=UNIT_LCD_CFAH_ITF
# 	echo $(SIMU_TIME)
# 	make ghdl_gcc_run COVERAGE_DIR=UNIT_LCD_CFAH_ITF_CODE_COVERAGE GHDL_TOP_UNIT=tb_top TIME=$(SIMU_TIME) GHDL_GCC_RUN_ARGS=$(GHDL_RUN_ARGS_CONTROLLER)

# ghdl_gcc_gen_code_cov_controller_tb:
# 	make ghdl_gcc_lcov COVERAGE_DIR=UNIT_LCD_CFAH_ITF_CODE_COVERAGE
# 	make ghdl_gcc_genhtml COVERAGE_DIR=UNIT_LCD_CFAH_ITF_CODE_COVERAGE

# clean_code_cov_unit_lcd_cfah_itf:
# 	rm -rRf $(HDL_SIMU_PATH)/$(GHDL_WORK_DIR)/UNIT_LCD_CFAH_ITF_CODE_COVERAGE/*

# # TEST_GROUP must be passed as argument
# # SIMU_TIME must be passed as argument
# run_unit_lcd_cfah_itf_code_coverage: clean_code_cov_unit_lcd_cfah_itf ghdl_gcc_compile_unit_lcd_cfah_itf_tb ghdl_gcc_run_unit_lcd_cfah_itf_tb ghdl_gcc_gen_code_cov_controller_tb
# 	make ghdl_gcc_open_coverage_html COVERAGE_DIR=UNIT_LCD_CFAH_ITF_CODE_COVERAGE
# # ===================

# # TEST must be pass as argument
# generate_collect_opti_files:
# 	python $(FILE_OPTI_SCRIPT) $(UART_COLLECT_PATH)/$(TEST)_collect.txt  $(UART_COLLECT_PATH)/$(TEST)_collect_opti.txt

# generate_collect_all_opti_files:
# 	$(foreach list, $(UNIT_LCD_CFAH_ITF_TEST_LIST), python $(FILE_OPTI_SCRIPT) $(UART_COLLECT_PATH)/$(list)_collect.txt $(UART_COLLECT_PATH)/$(list)_collect_opti.txt;) \


# # == SONAR ==
# sonar_vhdl_file:
# 	make run_rc_sonnar SONAR_SRC_LIST="$(src_vhd_lib_unit_lcd_cfah_itf)"
# ===========
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGeneric
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGHDL
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileSonarqube
