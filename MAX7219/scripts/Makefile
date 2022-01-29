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
#SCN_LIB_DIR=scn_lib_max7219_if
LIB_TB_TOP=lib_tb_max7219_if
TRANSCRIPT_EN=OFF
# ============================

# == Collect File Directory ==
MAX7219_COLLECT_DIR=MAX7219_COLLECT
MAX7219_COLLECT_PATH=$(HDL_SIMU_PATH)/$(MAX7219_COLLECT_DIR)
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


# ==  LIB LIST ==
LIB_LIST+=work
LIB_LIST+=$(LIB_OTHERS)
LIB_LIST+=$(LIB_MAX7219_STATIC)
LIB_LIST+=$(LIB_MAX7219_SCROLLER)
LIB_LIST+=$(LIB_MAX7219_CONTROLLER)
LIB_LIST+=$(LIB_MAX7219_INTERFACE)
LIB_LIST+=$(LIB_TB_TOP_MAX7219_IF)
LIB_LIST+=$(LIB_TB_TOP_MAX7219_IF_COVERAGE)
LIB_LIST+=$(LIB_TB_TOP_MAX7219_STATIC_COVERAGE)
LIB_LIST+=$(LIB_CODE_COVERAGE)
# ================



# ================ GHDL CONFIGURATION ================ #
GHDL_COV_DIR_LIST+=MAX7219_IF_CODE_COVERAGE
GHDL_COV_DIR_LIST+=MAX7219_STATIC_CODE_COVERAGE

# == COVERAGE LIBRARIES ==
LIB_TB_TOP_MAX7219_IF_COVERAGE=lib_tb_top_max7219_if_coverage
LIB_TB_TOP_MAX7219_STATIC_COVERAGE=lib_tb_top_max7219_static_coverage
# ========================

# == GHDL LIB LIST ==
GHDL_LIB_LIST+=$(LIB_MAX7219_INTERFACE)
GHDL_LIB_LIST+=$(LIB_CODE_COVERAGE)
GHDL_LIB_LIST+=$(LIB_MAX7219_STATIC)
# ===================

# == PYTHON SCRIPTS PATH ==
FILE_OPTI_SCRIPT=~/Documents/GitHub/Verilog/Testbench/scripts/python_scripts/file_optimisation.py
# =========================

# ==================================================== #


all: print_generic_rules
	@echo "Makefile for MAX7219 blocks tests"
	@echo ""
	@echo "== SOURCES COMPILATIONS =="
	@echo ""
	@echo "# -- DESIGNS COMPILATIONS -- #"
	@echo "- Compile DESIGN MAX7219 IF"
	@echo "make compile_design_max7219_if"
	@echo ""
	@echo "- Compile DESIGN MAX7219 STATIC"
	@echo "make compile_design_max7219_static"
	@echo ""
	@echo "# -------------------------- #"
	@echo ""
	@echo "# -- TESTBENCHS COMPILATIONS -- #"
	@echo "- Compile TESBENCH MAX7219 IF"
	@echo "make compile_testbench_max7219_if"
	@echo ""
	@echo "- Compile TESTBENCH MAX7219 STATIC"
	@echo "make compile_testbench_max7219_static"
	@echo ""
	@echo "# ----------------------------- #"
	@echo ""
	@echo "# -- COMPILE ALL (DESIGN + TB) -- #"
	@echo "- Compile design and TB MAX7219 IF"
	@echo "make compile_all_max7219_if"
	@echo ""
	@echo "- Compile design and TB MAX7219 STATIC"
	@echo "make compile_all_max7219_static"
	@echo "# ------------------------------- #"
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
	@echo "== RUN TEST WITH GHDL =="
	@echo "Compile Testbench MAX7219 IF with GHDL"
	@echo "make ghdl_compile_max7219_if_tb"
	@echo ""
	@echo "Run Testbench MAX7219 IF with GHSL"
	@echo "make ghdl_run_max7219_if_tb"
	@echo "========================"
	@echo ""
	@echo "== RUN CODE COVERAGE =="
	@echo "-- MAX7219 IF --"
	@echo "Compile Testbench MAX7219 IF for Code Coverage"
	@echo "make ghdl_gcc_compile_max7219_if_tb"
	@echo ""
	@echo "Run Testbench MAX7219 IF for Code Coverage"
	@echo "make ghdl_gcc_run_max7219_if_tb SIMU_TIME=XXms"
	@echo ""
	@echo "Run Coverage and open result : "
	@echo "make run_max7219_if_code_coverage SIMU_TIME=XXms"
	@echo ""
	@echo "------"
	@echo ""
	@echo "-- MAX7219 STATIC --"
	@echo "Compile Testbench MAX7219 STATIC for Code Coverage"
	@echo "make ghdl_gcc_compile_max7219_static_tb"
	@echo ""
	@echo "make ghdl_gcc_run_max7219_static_tb SIMU_TIME=XXms"
	@echo ""
	@echo "Run Coverage and open result : "
	@echo "make run_max7219_static_code_coverage SIMU_TIME=XXms1"
	@echo ""
	@echo "======================="
	@echo ""
	@echo "== PYTHON SCRIPTS =="
	@echo "make genarate_collect_opti_files TEST=XXX"
	@echo "===================="
	@echo ""
	@echo "== SCENARII LIST =="
	@echo "$(SCN_LIST)"
	@echo "==================="


# == COLLECT DIRECTORY ==
create_collect_dir:
	cd $(HDL_SIMU_PATH); \
	if [ ! -d  $(MAX7219_COLLECT_DIR) ]; then \
	  mkdir $(MAX7219_COLLECT_DIR); \
	fi
# =======================
# == DESIGN VHD FILE LIST ==
src_vhd_lib_others+=~/Documents/GitHub/VHDL_code/RAM/TDPRAM/tdpram_sclk.vhd

src_vhd_lib_max7219_static+=$(SRC_MAX7219_DIR)/lib_max7219_static/pkg_max7219_static.vhd
src_vhd_lib_max7219_static+=~/Documents/GitHub/VHDL_code/RAM/TDPRAM/tdpram_sclk.vhd
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
src_tb_coverage_max7219_if+=$(src_code_cov_tb_vhd)
src_tb_coverage_max7219_if+=$(TB_SRC_DIR)/tb_lib_max7219_if/tb_top.vhd

src_tb_coverage_max7219_static+=$(src_code_cov_tb_vhd)
src_tb_coverage_max7219_static+=$(TB_SRC_DIR)/tb_lib_max7219_static/tb_top.vhd
# ==================================


## == COMPILE DESIGN == ##

compile_others:
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_others)" VHD_DESIGN_LIB=$(LIB_OTHERS)

compile_max7219_interface:
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_max7219_interface)" VHD_DESIGN_LIB=$(LIB_MAX7219_INTERFACE)

compile_max7219_static:
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_others)" VHD_DESIGN_LIB=$(LIB_MAX7219_STATIC)
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_max7219_static)" VHD_DESIGN_LIB=$(LIB_MAX7219_STATIC)

compile_max7219_scroller:
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_max7219_scroller)" VHD_DESIGN_LIB=$(LIB_MAX7219_SCROLLER)
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_others)" VHD_DESIGN_LIB=$(LIB_MAX7219_SCROLLER)

compile_max7219_controller:
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_max7219_controller)" VHD_DESIGN_LIB=$(LIB_MAX7219_CONTROLLER)


# == Compile Design Library here ==
compile_design_max7219_if: compile_others compile_max7219_interface
compile_design_max7219_static: compile_others compile_max7219_static

compile_design : compile_design_max7219_if compile_design_max7219_static
#compile_max7219_static compile_max7219_scroller compile_max7219_controller
# ================================


## == COMPILE TESTBENCH == ##
compile_generic_tb_v_files:
	make compile_tb_v_files SRC_TB_V="$(src_gen_tb_v)" TB_LIB_TOP=$(LIB_TB_TOP_MAX7219_IF)
	make compile_tb_v_files SRC_TB_V="$(src_tb_data_collector_v)" TB_LIB_TOP=$(LIB_TB_TOP_MAX7219_IF)
	make compile_tb_v_files SRC_TB_V="$(src_gen_tb_v)" TB_LIB_TOP=$(LIB_TB_TOP_MAX7219_STATIC)
	make compile_tb_v_files SRC_TB_V="$(src_tb_data_collector_v)" TB_LIB_TOP=$(LIB_TB_TOP_MAX7219_STATIC)

compile_testbench_max7219_if_sources:
	make compile_tb_v_files SRC_TB_V="$(src_tb_v)" TB_LIB_TOP=$(LIB_TB_TOP_MAX7219_IF)
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_max7219_if_v)" TB_LIB_TOP=$(LIB_TB_TOP_MAX7219_IF)

compile_testbench_max7219_static_sources:
	make compile_tb_v_files SRC_TB_V="$(src_tb_v)" TB_LIB_TOP=$(LIB_TB_TOP_MAX7219_STATIC)
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_max7219_static_v)" TB_LIB_TOP=$(LIB_TB_TOP_MAX7219_STATIC)


# == COMPILE ALL TESTBENCH files ==

compile_testbench_max7219_if: compile_generic_tb_v_files compile_testbench_max7219_if_sources
compile_testbench_max7219_static: compile_generic_tb_v_files compile_testbench_max7219_static_sources

compile_testbench : compile_testbench_max7219_if compile_testbench_max7219_static
# =======================

# == COMPILE ALL DESIGN & TB ==
compile_all_max7219_if: compile_design_max7219_if compile_testbench_max7219_if print_compile_logs_file
compile_all_max7219_static: compile_design_max7219_static compile_testbench_max7219_static print_compile_logs_file
# =============================

# == SCENARII LIST ==
# Python test list
SCN_LIST_MAX7219_IF+=MAX7219_IF_00.py
SCN_LIST_MAX7219_IF+=MAX7219_IF_01.py
SCN_LIST_MAX7219_IF+=MAX7219_IF_02.py
SCN_LIST_MAX7219_IF+=MAX7219_IF_03.py
SCN_LIST_MAX7219_IF+=MAX7219_IF_04.py

SCN_LIST_MAX7219_STATIC+=MAX7219_STATIC_00.py
SCN_LIST_MAX7219_STATIC+=MAX7219_STATIC_01.py
SCN_LIST_MAX7219_STATIC+=MAX7219_STATIC_02.py
SCN_LIST_MAX7219_STATIC+=MAX7219_STATIC_03.py
SCN_LIST_MAX7219_STATIC+=MAX7219_STATIC_05.py

SCN_LIST+=$(SCN_LIST_MAX7219_IF)
SCN_LIST+=$(SCN_LIST_MAX7219_STATIC)

# Name test list
MAX7219_IF_TEST_LIST+=MAX7219_IF_00
MAX7219_IF_TEST_LIST+=MAX7219_IF_01
MAX7219_IF_TEST_LIST+=MAX7219_IF_02
MAX7219_IF_TEST_LIST+=MAX7219_IF_03
MAX7219_IF_TEST_LIST+=MAX7219_IF_04

MAX7219_STATIC_TEST_LIST+=MAX7219_STATIC_00
MAX7219_STATIC_TEST_LIST+=MAX7219_STATIC_01
MAX7219_STATIC_TEST_LIST+=MAX7219_STATIC_02
MAX7219_STATIC_TEST_LIST+=MAX7219_STATIC_03
MAX7219_STATIC_TEST_LIST+=MAX7219_STATIC_05
# =======================

# == LIB ARGS ==
#LIB_ARGS=-L lib_max7219_interface
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

LIB_ARGS_MAX7219_IF="-L lib_max7219_interface"
run_tb_max7219_if:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON SCN_LIB_DIR=scn_lib_max7219_if LIB_TB_TOP=lib_tb_max7219_if LIB_ARGS=$(LIB_ARGS_MAX7219_IF)
#TB_LIB_TOP=$(LIB_TB_TOP_MAX7219_IF)


LIB_ARGS_MAX7219_STATIC="-L lib_max7219_static -L lib_max7219_interface"
run_tb_max7219_static:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON SCN_LIB_DIR=scn_lib_max7219_static LIB_TB_TOP=lib_tb_max7219_static LIB_ARGS=$(LIB_ARGS_MAX7219_STATIC)
#TB_LIB_TOP=$(LIB_TB_TOP_MAX7219_STATIC)

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


CODE_COV_ARGS+=CODE_COV=ON CODE_COVERAGE_INJECTION_FILE="/home/linux-jp/SIMULATION_VHDL/MAX7219_COLLECT"
CODE_COV_ARGS+=CODE_COVERAGE_INJECTOR_DATA_WIDTH=18


# SIMU_TIME must be passed as argument
ghdl_run_max7219_if_tb:
	make ghdl_run GHDL_WORK_LIB_NAME=$(LIB_TB_TOP_MAX7219_IF_COVERAGE) GHDL_TOP_UNIT=tb_top P_ARGS_EN=ON TIME=$(SIMU_TIME) $(CODE_COV_ARGS) 


# == CODE COV SECTION ==

# -- MAX7219 IF --
ghdl_gcc_compile_max7219_if_tb: 
	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_vhd_lib_max7219_interface)" GHDL_WORK_LIB_NAME=$(LIB_MAX7219_INTERFACE) \
	COVERAGE_DIR=MAX7219_IF_CODE_COVERAGE
	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_code_cov_tb_vhd)" GHDL_WORK_LIB_NAME=$(LIB_CODE_COVERAGE) \
	COVERAGE_DIR=MAX7219_IF_CODE_COVERAGE
	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_tb_coverage_max7219_if)" GHDL_WORK_LIB_NAME=$(LIB_TB_TOP_MAX7219_IF_COVERAGE) \
	P_ARGS_EN=ON COVERAGE_DIR=MAX7219_IF_CODE_COVERAGE
	make ghdl_gcc_elaboration_vhd_src GHDL_WORK_LIB_NAME=$(LIB_TB_TOP_MAX7219_IF_COVERAGE) GHDL_TOP_UNIT=tb_top \
	P_ARGS_EN=ON COVERAGE_DIR=MAX7219_IF_CODE_COVERAGE

GHDL_RUN_ARGS_IF+=--vcd=/home/linux-jp/SIMULATION_VHDL/run_code_cov_max7219_if.vcd
ghdl_gcc_run_max7219_if_tb:
	make ghdl_gcc_run COVERAGE_DIR=MAX7219_IF_CODE_COVERAGE GHDL_TOP_UNIT=tb_top TIME=$(SIMU_TIME) GHDL_GCC_RUN_ARGS=$(GHDL_RUN_ARGS_IF)

ghdl_gcc_gen_code_cov_if_tb:
	make ghdl_gcc_lcov COVERAGE_DIR=MAX7219_IF_CODE_COVERAGE
	make ghdl_gcc_genhtml COVERAGE_DIR=MAX7219_IF_CODE_COVERAGE

clean_code_cov_if_tb_dir:
	rm -rRf $(HDL_SIMU_PATH)/$(GHDL_WORK_DIR)/MAX7219_IF_CODE_COVERAGE/*

# SIMU_TIME must be passed as argument
run_max7219_if_code_coverage: clean_code_cov_if_tb_dir ghdl_gcc_compile_max7219_if_tb ghdl_gcc_run_max7219_if_tb ghdl_gcc_gen_code_cov_if_tb
	make ghdl_gcc_open_coverage_html COVERAGE_DIR=MAX7219_IF_CODE_COVERAGE
# -----


# -- MAX7219 CMD DECOD --
ghdl_gcc_compile_max7219_static_tb:
	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_vhd_lib_others)" GHDL_WORK_LIB_NAME=$(LIB_OTHERS) \
	COVERAGE_DIR=MAX7219_STATIC_CODE_COVERAGE
	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_vhd_lib_max7219_static)" GHDL_WORK_LIB_NAME=$(LIB_MAX7219_STATIC) \
	COVERAGE_DIR=MAX7219_STATIC_CODE_COVERAGE
	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_code_cov_tb_vhd)" GHDL_WORK_LIB_NAME=$(LIB_CODE_COVERAGE) \
	COVERAGE_DIR=MAX7219_IF_CODE_COVERAGE
	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_tb_coverage_max7219_static)" \
	GHDL_WORK_LIB_NAME=$(LIB_TB_TOP_MAX7219_STATIC_COVERAGE) P_ARGS_EN=ON COVERAGE_DIR=MAX7219_STATIC_CODE_COVERAGE
	make ghdl_gcc_elaboration_vhd_src GHDL_WORK_LIB_NAME=$(LIB_TB_TOP_MAX7219_STATIC_COVERAGE) GHDL_TOP_UNIT=tb_top \
	P_ARGS_EN=ON COVERAGE_DIR=MAX7219_STATIC_CODE_COVERAGE

#	make ghdl_gcc_analysis_vhd_src SRC_VHD="$(src_code_cov_tb_vhd)" GHDL_WORK_LIB_NAME=$(LIB_CODE_COVERAGE) \
#	COVERAGE_DIR=MAX7219_STATIC_CODE_COVERAGE
# SIMU_TIME must be passed as argument
GHDL_RUN_ARGS_STATIC+=--vcd=/home/linux-jp/SIMULATION_VHDL/run_code_cov_max7219_static.vcd
ghdl_gcc_run_max7219_static_tb:
	make ghdl_gcc_run COVERAGE_DIR=MAX7219_STATIC_CODE_COVERAGE GHDL_TOP_UNIT=tb_top TIME=$(SIMU_TIME) GHDL_GCC_RUN_ARGS=$(GHDL_RUN_ARGS_STATIC)

ghdl_gcc_gen_code_cov_static_tb:
	make ghdl_gcc_lcov COVERAGE_DIR=MAX7219_STATIC_CODE_COVERAGE
	make ghdl_gcc_genhtml COVERAGE_DIR=MAX7219_STATIC_CODE_COVERAGE

clean_code_cov_static_tb_dir:
	rm -rRf $(HDL_SIMU_PATH)/$(GHDL_WORK_DIR)/MAX7219_STATIC_CODE_COVERAGE/*

# SIMU_TIME must be passed as argument
run_max7219_static_code_coverage: clean_code_cov_static_tb_dir ghdl_gcc_compile_max7219_static_tb ghdl_gcc_run_max7219_static_tb ghdl_gcc_gen_code_cov_static_tb
	make ghdl_gcc_open_coverage_html COVERAGE_DIR=MAX7219_STATIC_CODE_COVERAGE
# -----------------------

# TEST must be pass as argument
generate_collect_opti_files:
	python $(FILE_OPTI_SCRIPT) $(MAX7219_COLLECT_PATH)/$(TEST)_collect.txt  $(MAX7219_COLLECT_PATH)/$(TEST)_collect_opti.txt

generate_collect_all_opti_files:
	python $(FILE_OPTI_SCRIPT) $(MAX7219_COLLECT_PATH)/MAX7219_IF_00_collect.txt $(MAX7219_COLLECT_PATH)/MAX7219_IF_00_collect_opti.txt
	python $(FILE_OPTI_SCRIPT) $(MAX7219_COLLECT_PATH)/MAX7219_IF_01_collect.txt $(MAX7219_COLLECT_PATH)/MAX7219_IF_01_collect_opti.txt
	python $(FILE_OPTI_SCRIPT) $(MAX7219_COLLECT_PATH)/MAX7219_IF_02_collect.txt $(MAX7219_COLLECT_PATH)/MAX7219_IF_02_collect_opti.txt
	python $(FILE_OPTI_SCRIPT) $(MAX7219_COLLECT_PATH)/MAX7219_IF_03_collect.txt $(MAX7219_COLLECT_PATH)/MAX7219_IF_03_collect_opti.txt
	python $(FILE_OPTI_SCRIPT) $(MAX7219_COLLECT_PATH)/MAX7219_IF_04_collect.txt $(MAX7219_COLLECT_PATH)/MAX7219_IF_04_collect_opti.txt;
	python $(FILE_OPTI_SCRIPT) $(MAX7219_COLLECT_PATH)/MAX7219_STATIC_00_collect.txt $(MAX7219_COLLECT_PATH)/MAX7219_STATIC_00_collect_opti.txt
	python $(FILE_OPTI_SCRIPT) $(MAX7219_COLLECT_PATH)/MAX7219_STATIC_01_collect.txt $(MAX7219_COLLECT_PATH)/MAX7219_STATIC_01_collect_opti.txt
	python $(FILE_OPTI_SCRIPT) $(MAX7219_COLLECT_PATH)/MAX7219_STATIC_02_collect.txt $(MAX7219_COLLECT_PATH)/MAX7219_STATIC_02_collect_opti.txt
	python $(FILE_OPTI_SCRIPT) $(MAX7219_COLLECT_PATH)/MAX7219_STATIC_03_collect.txt $(MAX7219_COLLECT_PATH)/MAX7219_STATIC_03_collect_opti.txt
	python $(FILE_OPTI_SCRIPT) $(MAX7219_COLLECT_PATH)/MAX7219_STATIC_04_collect.txt $(MAX7219_COLLECT_PATH)/MAX7219_STATIC_04_collect_opti.txt


include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGeneric
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGHDL
