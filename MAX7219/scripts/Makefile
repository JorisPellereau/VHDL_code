# ========================================== #
#
# Makefile for MAX7219 blocks
#
# ========================================== #

# ========================================== #
# Author  : J.P
# Date    : 04/11/2021
# Version : 2.0
#         - Modif. avec MakefileGeneric
# ========================================== #

# == Makefile Configuration ==
SEL_STATION=LINUX
ROOT=$(PWD)/..
PROJECT_NAME=MAX7219
WORK_DIR=MAX7219_WORK
SCN_LIB_DIR=scn_lib_max7219_if
LIB_TB_TOP=lib_tb_max7219_if
TRANSCRIPT_EN=OFF
# ============================

# == SOURCES DIRECTORY ==
SRC_MAX7219_DIR=~/Documents/GitHub/VHDL_code/MAX7219/sources
# =======================

# == DESIGN LIBRARIES ==
LIB_MAX7219=lib_max7219
LIB_OTHERS=lib_others
LIB_MAX7219_STATIC=lib_max7219_static
LIB_MAX7219_SCROLLER=lib_max7219_scroller
LIB_MAX7219_CONTROLLER=lib_max7219_controller
LIB_MAX7219_INTERFACE=lib_max7219_interface
# ======================

# == TESTBENCH LIBRARIES ==
LIB_TB_TOP_MAX7219_IF=lib_tb_max7219_if
LIB_TB_TOP_MAX7219_STATIC=lib_tb_max7219_static
LIB_TB_TOP_MAX7219_SCROLLER=lib_tb_max7219_scroller
LIB_TB_TOP_MAX7219_CONTROLLER=lib_tb_max7219_controller
LIB_CODE_COVERAGE=lib_code_coverage
# =========================

# == COVERAGE LIBRARIES ==
LIB_TB_TOP_MAX7219_IF_COVERAGE=lib_tb_top_max7219_if_coverage
# ========================

# ==  LIB LIST ==
LIB_LIST+=$(LIB_OTHERS)
LIB_LIST+=$(LIB_MAX7219_STATIC)
LIB_LIST+=$(LIB_MAX7219_SCROLLER)
LIB_LIST+=$(LIB_MAX7219_CONTROLLER)
LIB_LIST+=$(LIB_MAX7219_INTERFACE)
LIB_LIST+=$(LIB_TB_TOP_MAX7219_IF)
LIB_LIST+=$(LIB_TB_TOP_MAX7219_IF_COVERAGE)
LIB_LIST+=$(LIB_CODE_COVERAGE)
# ================

# == GHDL LIB LIST ==
GHDL_LIB_LIST+=$(LIB_MAX7219_INTERFACE)
GHDL_LIB_LIST+=$(LIB_CODE_COVERAGE)
# ===================

all: print_generic_rules
	@echo ""
	@echo "Makefile for MAX7219 blocks tests"
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
	@echo "make compile_all"
	@echo ""
	@echo "=========================="
	@echo ""
	@echo "== RUN TESTS =="
	@echo "- Run Test of MAX7219 I/F :"
	@echo "make run_tb_max7219_if TEST=[TEST_NB]"
	@echo ""
	@echo "- Run All Tests of MAX7219 I/F in Console mode :"
	@echo "make run_all_tests_tb_max7219_if"
	@echo ""
	@echo ""
	@echo "- Run Test of MAX7219 Static"
	@echo "make run_tb_max7219_static TEST=[TEST_NB]"
	@echo ""
	@echo "- Run Test of MAX7219 Scroller"
	@echo "make run_tb_max7219_scroller TEST=[TEST_NB]"
	@echo ""
	@echo "- Run Test of MAX7219 Controller"
	@echo "make run_tb_max7219_controller TEST=[TEST_NB]"
	@echo ""
	@echo "==============="
	@echo ""
	@echo "== RUN CODE COVERAGE =="
	@echo ""
	@echo "Compile Testbench MAX7219 IF for Code Coverage"
	@echo "make ghdl_compile_max7219_if_tb"
	@echo ""
	@echo "Run Testbench MAX7219 IF for Code Coverage"
	@echo "make ghdl_run_max7219_if_tb"
	@echo ""
	@echo "======================="
	@echo ""
	@echo "== SCENARII LIST =="
	@echo "$(SCN_LIST)"
	@echo "==================="


# == DESIGN VHD FILE LIST ==
src_vhd_lib_others+=~/Documents/GitHub/VHDL_code/RAM/TDPRAM/tdpram_sclk.vhd

src_vhd_lib_max7219_static+=$(SRC_MAX7219_DIR)/lib_max7219_static/pkg_max7219_static.vhd
src_vhd_lib_max7219_static+=$(SRC_MAX7219_DIR)/lib_max7219_static/max7219_ram_decod.vhd
src_vhd_lib_max7219_static+=$(SRC_MAX7219_DIR)/lib_max7219_static/max7219_cmd_decod.vhd

src_vhd_lib_max7219_scroller+=$(SRC_MAX7219_DIR)/lib_max7219_scroller/pkg_max7219_scroller.vhd
src_vhd_lib_max7219_scroller+=$(SRC_MAX7219_DIR)/lib_max7219_scroller/max7219_ram2scroller_if.vhd
src_vhd_lib_max7219_scroller+=$(SRC_MAX7219_DIR)/lib_max7219_scroller/max7219_scroller_if.vhd
src_vhd_lib_max7219_scroller+=$(SRC_MAX7219_DIR)/lib_max7219_scroller/max7219_scroller_ctrl.vhd

src_vhd_lib_max7219_controller+=$(SRC_MAX7219_DIR)/lib_max7219_controller/pkg_max7219_controller.vhd
src_vhd_lib_max7219_controller+=$(SRC_MAX7219_DIR)/lib_max7219_controller/max7219_mux_sel.vhd
src_vhd_lib_max7219_controller+=$(SRC_MAX7219_DIR)/lib_max7219_controller/max7219_display_sequencer.vhd
src_vhd_lib_max7219_controller+=$(SRC_MAX7219_DIR)/lib_max7219_controller/max7219_config_if.vhd
src_vhd_lib_max7219_controller+=$(SRC_MAX7219_DIR)/lib_max7219_controller/max7219_display_controller.vhd

src_vhd_lib_max7219_interface+=$(SRC_MAX7219_DIR)/lib_max7219_interface/pkg_max7219_interface.vhd
src_vhd_lib_max7219_interface+=$(SRC_MAX7219_DIR)/lib_max7219_interface/max7219_if.vhd
# ==========================

# == TESTBENCH MAX7219 V FILES LIST ==
src_tb_v+=$(GENERIC_TB_SRC_DIR)/TB_modules/MAX7219_checker/max7219_checker_pkg.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/TB_modules/MAX7219_checker/max7219_checker.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/TB_modules/MAX7219_checker/max7219_checker_wrapper.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/TB_modules/max7219_emul.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/TB_modules/max7219_matrix_emul.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/TB_modules/MAX7219_checker/max7219_spi_checker.sv
# ====================================



# == Specific Testbench File List ==
src_tb_lib_max7219_if_v+=$(TB_SRC_DIR)/tb_lib_max7219_if/testbench_setup.sv
src_tb_lib_max7219_if_v+=$(TB_SRC_DIR)/tb_lib_max7219_if/clk_gen.sv
src_tb_lib_max7219_if_v+=$(TB_SRC_DIR)/tb_lib_max7219_if/tb_top.sv

src_tb_lib_max7219_static_v+=$(TB_SRC_DIR)/tb_lib_max7219_static/testbench_setup.sv
src_tb_lib_max7219_static_v+=$(TB_SRC_DIR)/tb_lib_max7219_static/clk_gen.sv
src_tb_lib_max7219_static_v+=$(TB_SRC_DIR)/tb_lib_max7219_static/tb_top.sv

src_tb_lib_max7219_scroller_v+=$(TB_SRC_DIR)/tb_lib_max7219_scroller/testbench_setup.sv
src_tb_lib_max7219_scroller_v+=$(TB_SRC_DIR)/tb_lib_max7219_scroller/clk_gen.sv
src_tb_lib_max7219_scroller_v+=$(TB_SRC_DIR)/tb_lib_max7219_scroller/tb_top.sv

src_tb_lib_max7219_controller_v+=$(TB_SRC_DIR)/tb_lib_max7219_controller/testbench_setup.sv
src_tb_lib_max7219_controller_v+=$(TB_SRC_DIR)/tb_lib_max7219_controller/clk_gen.sv
src_tb_lib_max7219_controller_v+=$(TB_SRC_DIR)/tb_lib_max7219_controller/tb_top.sv
# ==================================

# == Coverage Testbench File List ==
src_tb_coverage_max7219_if+=$(TB_SRC_DIR)/tb_lib_max7219_if/tb_top.vhd
src_tb_coverage_max7219_if+=$(src_code_cov_tb_vhd)
# ==================================


## == COMPILE DESIGN == ##

compile_others:
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_others)" VHD_DESIGN_LIB=$(LIB_OTHERS)

compile_max7219_interface:
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_max7219_interface)" VHD_DESIGN_LIB=$(LIB_MAX7219_INTERFACE)

compile_max7219_static:
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_max7219_static)" VHD_DESIGN_LIB=$(LIB_MAX7219_STATIC)
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_others)" VHD_DESIGN_LIB=$(LIB_MAX7219_STATIC)

compile_max7219_scroller:
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_max7219_scroller)" VHD_DESIGN_LIB=$(LIB_MAX7219_SCROLLER)
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_others)" VHD_DESIGN_LIB=$(LIB_MAX7219_SCROLLER)

compile_max7219_controller:
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_max7219_controller)" VHD_DESIGN_LIB=$(LIB_MAX7219_CONTROLLER)


# == Compile Design Library here ==
compile_design : compile_others compile_max7219_interface
#compile_max7219_static compile_max7219_scroller compile_max7219_controller
# ================================


## == COMPILE TESTBENCH == ##
compile_generic_tb_v_files:
	make compile_tb_v_files SRC_TB_V="$(src_gen_tb_v)" TB_LIB_TOP=$(LIB_TB_TOP_MAX7219_IF)
	make compile_tb_v_files SRC_TB_V="$(src_tb_data_collector_v)" TB_LIB_TOP=$(LIB_TB_TOP_MAX7219_IF)

compile_testbench_max719_if_sources:
	make compile_tb_v_files SRC_TB_V="$(src_tb_v)" TB_LIB_TOP=$(LIB_TB_TOP_MAX7219_IF)
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_max7219_if_v)" TB_LIB_TOP=$(LIB_TB_TOP_MAX7219_IF)

# compile_testbench_sources:
# 	make compile_tb_v_files SRC_TB_V="$(src_tb_v)" TB_LIB_TOP=$(LIB_TB_UART_DISPLAY_CTRL)
# 	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_uart_display_ctrl_v)" TB_LIB_TOP=$(LIB_TB_UART_DISPLAY_CTRL)

# == COMPILE ALL TESTBENCH files ==
compile_testbench : compile_generic_tb_v_files compile_testbench_max719_if_sources
# =======================

# == SCENARII LIST ==
# Python test list
SCN_LIST_MAX7219_IF+=MAX7219_IF_00.py
SCN_LIST_MAX7219_IF+=MAX7219_IF_01.py
SCN_LIST_MAX7219_IF+=MAX7219_IF_02.py
SCN_LIST_MAX7219_IF+=MAX7219_IF_03.py
SCN_LIST_MAX7219_IF+=MAX7219_IF_04.py

SCN_LIST+=$(SCN_LIST_MAX7219_IF)

# Name test list
MAX7219_IF_TEST_LIST+=MAX7219_IF_00
MAX7219_IF_TEST_LIST+=MAX7219_IF_01
MAX7219_IF_TEST_LIST+=MAX7219_IF_02
MAX7219_IF_TEST_LIST+=MAX7219_IF_03
MAX7219_IF_TEST_LIST+=MAX7219_IF_04
# =======================

# == LIB ARGS ==
LIB_ARGS=-L lib_max7219_interface
#-L lib_uart_display_ctrl
# ==============

# == Change G_LOAD_DURATION Generic for test MAX7219_IF_03 ==
# $(TEST) for single test
# $(TEST_LIST) for run_multiple_tests
ifeq ($(TEST), MAX7219_IF_03)
  VSIM_G_ARGS+=-G/tb_top/i_dut/G_LOAD_DURATION=40
else ifneq (, $(findstring MAX7219_IF_03, $(TEST_LIST)))
  VSIM_G_ARGS_FOR_LIST+=-G/tb_top/i_dut/G_LOAD_DURATION=40
endif

# == Change G_LOAD_DURATION and G_MAX_HALF_PERIOD Generics for test MAX7219_IF_04 ==
# $(TEST) for single test
# $(TEST_LIST) for run_multiple_tests
ifeq ($(TEST), MAX7219_IF_04)
  VSIM_G_ARGS+=-G/tb_top/i_dut/G_MAX_HALF_PERIOD=50
  VSIM_G_ARGS+=-G/tb_top/i_dut/G_LOAD_DURATION=40
else ifneq (, $(findstring MAX7219_IF_04, $(TEST_LIST)))
  VSIM_G_ARGS_FOR_LIST+=-G/tb_top/i_dut/G_MAX_HALF_PERIOD=50
  VSIM_G_ARGS_FOR_LIST+=-G/tb_top/i_dut/G_LOAD_DURATION=40
endif


# == RUN TEST ==
# Run single test of MAX7219 I/F
run_tb_max7219_if:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON

# Run All Tests MAX7219 in console Mode
run_all_tests_tb_max7219_if:
	make run_multiple_tests TEST_LIST="$(MAX7219_IF_TEST_LIST)" TRANSCRIPT_EN=ON GUI=OFF

# == GHDL Section ==

ghdl_compile_max7219_if_tb:
	make ghdl_analysis_vhd_src SRC_VHD="$(src_vhd_lib_max7219_interface)" GHDL_WORK_LIB_NAME=$(LIB_MAX7219_INTERFACE)
	make ghdl_analysis_vhd_src SRC_VHD="$(src_code_cov_tb_vhd)" GHDL_WORK_LIB_NAME=$(LIB_CODE_COVERAGE)
	make ghdl_analysis_vhd_src SRC_VHD="$(src_tb_coverage_max7219_if)" GHDL_WORK_LIB_NAME=$(LIB_TB_TOP_MAX7219_IF_COVERAGE) P_ARGS_EN=ON
	make ghdl_elaboration_vhd_src GHDL_WORK_LIB_NAME=$(LIB_TB_TOP_MAX7219_IF_COVERAGE) GHDL_TOP_UNIT=tb_top P_ARGS_EN=ON
	# make ghdl_import_vhd_src SRC_VHD="$(src_vhd_lib_max7219_interface)" VHD_LIB=$(LIB_MAX7219_INTERFACE)	
	# make ghdl_import_vhd_src SRC_VHD="$(src_tb_coverage_max7219_if)" VHD_LIB=$(LIB_MAX7219_INTERFACE)


CODE_COV_ARGS+=CODE_COV=ON CODE_COVERAGE_INJECTION_FILE="/home/linux-jp/SIMULATION_VHDL/test_collect_out.txt"
CODE_COV_ARGS+=CODE_COVERAGE_INJECTOR_DATA_WIDTH=20

ghdl_run_max7219_if_tb:
	make ghdl_run GHDL_WORK_LIB_NAME=$(LIB_TB_TOP_MAX7219_IF_COVERAGE) GHDL_TOP_UNIT=tb_top P_ARGS_EN=ON TIME=50ms $(CODE_COV_ARGS) 


#-P/home/linux-jp/SIMULATION_VHDL/MAX7219/MAX7219_WORK_GHDL/lib_max7219_interface
#ANALYSIS_ARGS+=
# ==================
#LIB_TB_TOP_MAX7219_IF_COVERAGE

include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGeneric
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGHDL
