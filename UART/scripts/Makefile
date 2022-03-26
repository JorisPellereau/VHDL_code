# ========================================== #
#
# Makefile for UART blocks tests
#
# ========================================== #

# ========================================== #
# Author  : J.P
# Date    : 17/04/2021
# Version : 2.0
#         - Ajout MakefileGeneric
# ========================================== #

# == Makefile Configuration ==
SEL_STATION=LINUX
ROOT=$(PWD)/..
PROJECT_NAME=UART
WORK_DIR=UART_WORK
TRANSCRIPT_EN=OFF
# ============================

# == Collect File Directory ==
UART_COLLECT_DIR=UART_COLLECT
UART_COLLECT_PATH=$(HDL_SIMU_PATH)/$(UART_COLLECT_DIR)
# ============================

# == SOURCES DIRECTORY ==
SRC_MAX7219_DIR=~/Documents/GitHub/VHDL_code/MAX7219/sources
# =======================

# == DESIGN LIBRARIES ==
LIB_UART=lib_uart
LIB_UART_DISPLAY_CTRL=lib_uart_display_ctrl

LIB_OTHERS=lib_others
LIB_MAX7219_STATIC=lib_max7219_static
LIB_MAX7219_SCROLLER=lib_max7219_scroller
LIB_MAX7219_CONTROLLER=lib_max7219_controller
LIB_MAX7219_INTERFACE=lib_max7219_interface
# ======================

# == TESTBENCH LIBRARIES ==
LIB_TB_UART_DISPLAY_CTRL+=lib_tb_uart_display_ctrl
# =========================

# ==  LIB LIST ==
LIB_LIST+=$(LIB_UART)
LIB_LIST+=$(LIB_UART_DISPLAY_CTRL)
LIB_LIST+=$(LIB_OTHERS)
LIB_LIST+=$(LIB_MAX7219_STATIC)
LIB_LIST+=$(LIB_MAX7219_SCROLLER)
LIB_LIST+=$(LIB_MAX7219_CONTROLLER)
LIB_LIST+=$(LIB_MAX7219_INTERFACE)
LIB_LIST+=$(LIB_TB_UART_DISPLAY_CTRL)
# ================

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
	@echo "make compile_all"
	@echo "make compile_all_uart_display_ctrl"
	@echo "=========================="
	@echo ""
	@echo "== RUN TESTS =="
	@echo "- Run Test of UART display controller"
	@echo "make run_tb_uart_display_ctrl TEST=[TEST_NB]"
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
create_collect_dir:
	cd $(HDL_SIMU_PATH); \
	if [ ! -d  $(UART_COLLECT_DIR) ]; then \
	  mkdir $(UART_COLLECT_DIR); \
	fi
# =======================

SCN_LIB_DIR=scn_lib_uart_display_ctrl
LIB_TB_TOP=lib_tb_uart_display_ctrl

# == DESIGN VHD FILE LIST ==
src_lib_uart+=$(SRC_DIR)/lib_uart/pkg_uart.vhd
src_lib_uart+=$(SRC_DIR)/lib_uart/rx_uart.vhd
src_lib_uart+=$(SRC_DIR)/lib_uart/tx_uart.vhd

src_vhd_lib_uart_display_ctrl+=$(SRC_DIR)/lib_uart_display_ctrl/pkg_uart_max7219_display_ctrl.vhd
src_vhd_lib_uart_display_ctrl+=$(SRC_DIR)/lib_uart_display_ctrl/uart_cmd_decod.vhd
src_vhd_lib_uart_display_ctrl+=$(SRC_DIR)/lib_uart_display_ctrl/sequencer_uart_cmd.vhd
src_vhd_lib_uart_display_ctrl+=$(SRC_DIR)/lib_uart_display_ctrl/static_ram_mngr.vhd
src_vhd_lib_uart_display_ctrl+=$(SRC_DIR)/lib_uart_display_ctrl/dyn_ram_mngr.vhd
src_vhd_lib_uart_display_ctrl+=$(SRC_DIR)/lib_uart_display_ctrl/matrix_config_mngr.vhd
src_vhd_lib_uart_display_ctrl+=$(SRC_DIR)/lib_uart_display_ctrl/run_pattern_mngt.vhd
src_vhd_lib_uart_display_ctrl+=$(SRC_DIR)/lib_uart_display_ctrl/uart_max7219_display_ctrl.vhd
src_vhd_lib_uart_display_ctrl+=$(SRC_DIR)/lib_uart_display_ctrl/uart_max7219_display_ctrl_wrapper.vhd

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

# == TESTBENCH UART V FILES LIST ==
src_tb_uart_vhd+=$(SRC_DIR)/lib_uart/pkg_uart.vhd
src_tb_uart_vhd+=$(SRC_DIR)/lib_uart/tx_uart.vhd
src_tb_uart_vhd+=$(SRC_DIR)/lib_uart/rx_uart.vhd

src_tb_uart_v+=$(TB_UART_SRC_V_DIR)/tb_uart_class.sv
src_tb_uart_v+=$(TB_UART_SRC_V_DIR)/uart_checker_wrapper.sv

src_tb_v+=$(GENERIC_TB_SRC_DIR)/TB_modules/MAX7219_checker/max7219_checker_pkg.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/TB_modules/MAX7219_checker/max7219_checker.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/TB_modules/MAX7219_checker/max7219_checker_wrapper.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/TB_modules/max7219_emul.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/TB_modules/max7219_matrix_emul.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/TB_modules/MAX7219_checker/max7219_spi_checker.sv

# =================================


# == Specific Testbench File List ==
src_tb_lib_uart_display_ctrl_v+=$(TB_SRC_DIR)/tb_lib_uart_display_ctrl/testbench_setup.sv
src_tb_lib_uart_display_ctrl_v+=$(TB_SRC_DIR)/tb_lib_uart_display_ctrl/clk_gen.sv
src_tb_lib_uart_display_ctrl_v+=$(TB_SRC_DIR)/tb_lib_uart_display_ctrl/tb_top.sv
# ==================================



## == COMPILE DESIGN == ##

compile_others:
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_others)" VHD_DESIGN_LIB=$(LIB_OTHERS)

compile_uart:
	make compile_design_vhd_files SRC_VHD="$(src_lib_uart)" VHD_DESIGN_LIB=$(LIB_UART)

compile_uart_display_ctrl:
	make compile_design_vhd_files SRC_VHD="$(src_vhd_lib_uart_display_ctrl)" VHD_DESIGN_LIB=$(LIB_UART_DISPLAY_CTRL)

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
compile_design : compile_others compile_max7219_interface compile_max7219_static compile_max7219_scroller compile_max7219_controller compile_uart compile_uart_display_ctrl
# ================================


## == COMPILE TESTBENCH == ##
compile_tb_uart_vhd_files:
	make compile_tb_vhd_files SRC_TB_VHD="$(src_tb_uart_vhd)" TB_LIB_TOP=$(LIB_TB_UART_DISPLAY_CTRL)

compile_generic_tb_v_files:
	make compile_tb_v_files SRC_TB_V="$(src_gen_tb_v)" TB_LIB_TOP=$(LIB_TB_UART_DISPLAY_CTRL)
	make compile_tb_v_files SRC_TB_V="$(src_tb_uart_v)" TB_LIB_TOP=$(LIB_TB_UART_DISPLAY_CTRL)
	make compile_tb_v_files SRC_TB_V="$(src_tb_data_collector_v)" TB_LIB_TOP=$(LIB_TB_UART_DISPLAY_CTRL)

compile_testbench_sources:
	make compile_tb_v_files SRC_TB_V="$(src_tb_v)" TB_LIB_TOP=$(LIB_TB_UART_DISPLAY_CTRL)
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_uart_display_ctrl_v)" TB_LIB_TOP=$(LIB_TB_UART_DISPLAY_CTRL)

# == COMPILE ALL TESTBENCH files ==
compile_testbench : compile_tb_uart_vhd_files compile_generic_tb_v_files compile_testbench_sources
# =======================

compile_all_uart_display_ctrl: compile_design compile_testbench print_compile_logs_file

# == SCENARII LIST ==
SCN_LIST+=UART_DISPLAY_CTRL_00.py
SCN_LIST+=UART_DISPLAY_CTRL_01.py
SCN_LIST+=UART_DISPLAY_CTRL_02.py
SCN_LIST+=UART_DISPLAY_CTRL_03.py
SCN_LIST+=UART_DISPLAY_CTRL_04.py
SCN_LIST+=UART_DISPLAY_CTRL_05.py


UART_DISPLAY_CTRL_TEST_LIST+=UART_DISPLAY_CTRL_00
# =======================

# == LIB ARGS ==
LIB_ARGS=-L lib_max7219_controller -L lib_uart_display_ctrl
# ==============


# == RUN TEST ==
run_tb_uart_display_ctrl:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON
# ==============


# TEST must be pass as argument
generate_collect_opti_files:
	python $(FILE_OPTI_SCRIPT) $(UART_COLLECT_PATH)/$(TEST)_collect.txt  $(UART_COLLECT_PATH)/$(TEST)_collect_opti.txt

generate_collect_all_opti_files:
	$(foreach list, $(UART_DISPLAY_CTRL_TEST_LIST), python $(FILE_OPTI_SCRIPT) $(UART_COLLECT_PATH)/$(list)_collect.txt $(UART_COLLECT_PATH)/$(list)_collect_opti.txt;) \


include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGeneric
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGHDL
