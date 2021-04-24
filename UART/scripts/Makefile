############################################
#
#	Makefile for UART blocks tests
#
############################################
# Repository Organization
# /(ROOT)
# 	|__ /scripts        => Scripts - Makefile
#	|__ /sources        => Design VHD - V files
#	     |__ /lib_x
#	     |__ /lib_y
#	|__ /tb_sources     => Specific TestBench files
#	     |__ /testbench_setup.sv
#	     |__ /tb_top.sv
#	|__ /do_files       => Do Files
#	     |__ /run_files => Run .do
#	     |__ /waves     => Waves .do
#	|__ /scenarios      => Scenario list
#	|__ /WLF            => WLF files
#	|__ /transcripts    => Transcripts files
#
#
#

# Author : J.P
# Date   : 17/04/2021
#

ROOT=$(PWD)/..
WORK_DIR_NAME=UART_WORK
WORK_DIR=/home/jorisp/MODELSIM_WORKS/$(WORK_DIR_NAME)



# == GENERIC TESTBENCH SOURCES DIRECTORY ==
GENERIC_TB_SRC_DIR=~/GitHub/Verilog/lib_testbench
TB_UART_SRC_V_DIR=~/GitHub/Verilog/lib_tb_uart
# =========================================

# == TESTBENCH SPECIFIC SOURCES DIRECTORY ==
TB_SRC_DIR=$(ROOT)/tb_sources
# ==========================================

# == PROJECT DIRECTORIES ==
SCRIPTS_DIR=$(ROOT)/scripts
RUN_DO_DIR=$(ROOT)/do_files/run_files
TRANSCRIPTS_DIR=$(ROOT)/transcripts
WLF_DIR=$(ROOT)/WLF
SCN_DIR=$(ROOT)/scenarios
# =========================

# == MODELSIM ALIAS ==
vsim=/opt/intelFPGA/18.1/modelsim_ase/bin/vsim
vlib=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vlib
vmap=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vmap
vcom=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vcom
vlog=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vlog
# ====================

# == SOURCES DIRECTORY ==
SRC_DIR=$(ROOT)/sources
SRC_MAX7219_DIR=/home/jorisp/GitHub/VHDL_code/MAX7219/sources
# =======================

# == VSIM ARGS ==
VSIM_ARGS+=-novopt -t ps
VSIM_G_ARGS+=-G/tb_top/SCN_FILE_PATH=$(SCN_DIR)/

ifeq ($(GUI), OFF)
	VSIM_ARGS=-c
endif


# ===============

# == DESIGN LIBRARIES ==
LIB_UART=lib_uart
LIB_UART_DISPLAY_CTRL=lib_uart_display_ctrl

LIB_MAX7219=lib_max7219

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
LIB_LIST+=$(LIB_MAX7219)
LIB_LIST+=$(LIB_OTHERS)
LIB_LIST+=$(LIB_MAX7219_STATIC)
LIB_LIST+=$(LIB_MAX7219_SCROLLER)
LIB_LIST+=$(LIB_MAX7219_CONTROLLER)
LIB_LIST+=$(LIB_MAX7219_INTERFACE)
LIB_LIST+=$(LIB_TB_UART_DISPLAY_CTRL)
# ================



all: 
	@echo ""
	@echo "Makefile for compilation & Simulation with Modelsim"
	@echo ""
	@echo "== PROJECT CONFIGURATION =="
	@echo "- Create Work Directory : "
	@echo "make create_dir"
	@echo ""
	@echo "- Clean work repository : "
	@echo "make clean"
	@echo ""
	@echo "- Prepare Modelsim Library :"
	@echo "make libs"
	@echo ""
	@echo "==========================="
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
	@echo "- Run Test of UART display controller"
	@echo "make run_tb_uart_display_ctrl TEST=[TEST_NB]"
	@echo "==============="
	@echo ""


# == CREATE WORK DIR. ==
create_dir:
	cd $(ROOT); \
	mkdir transcripts; \
	mkdir do_files; \
	mkdir WLF; \
	mkdir sources; \
	mkdir tb_sources; \
	mkdir scenarios; \
	cd ./do_files; \
	mkdir run_files; \
	mkdir waves; \

create_work:
	cd /home/jorisp/MODELSIM_WORKS/; \
	mkdir $(WORK_DIR_NAME); \

# ======================


# == CLEAN PROJECT ==
clean:
	cd $(WORK_DIR); \
	rm -rRf *;

# ====================


# == PREPARE MODELSIM LIBRARY ==
prepare_libs:
	cd $(WORK_DIR); \
	$(foreach list, $(LIB_LIST), $(vlib) ./$(list);) \

create_libs:
	cd $(WORK_DIR); \
	$(foreach list, $(LIB_LIST), $(vmap) $(list) $(list);) \


libs:  prepare_libs create_libs
# ===========================================


# == DESIGN VHD FILE LIST ==
src_lib_uart+=$(SRC_DIR)/lib_uart/pkg_uart.vhd
src_lib_uart+=$(SRC_DIR)/lib_uart/rx_uart.vhd
src_lib_uart+=$(SRC_DIR)/lib_uart/tx_uart.vhd

src_vhd_lib_others+=~/GitHub/VHDL_code/RAM/TDPRAM/tdpram_sclk.vhd

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


## == TESTBENCH FILES == ##


# == GENERIC TB FILES ==
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/wait_event_tb.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/wait_event_wrapper.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/set_injector_tb.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/set_injector_wrapper.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/wait_duration_wrapper.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/check_level_wrapper.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/tb_modules_custom_class.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/tb_tasks.sv
# ======================

# == TESTBENCH UART V FILES LIST ==
src_tb_uart_vhd+=$(TB_UART_SRC_VHD_DIR)/pkg_uart.vhd
src_tb_uart_vhd+=$(TB_UART_SRC_VHD_DIR)/tx_uart.vhd
src_tb_uart_vhd+=$(TB_UART_SRC_VHD_DIR)/rx_uart.vhd


src_tb_uart_v+=$(TB_UART_SRC_V_DIR)/tb_uart_class.sv
src_tb_uart_v+=$(TB_UART_SRC_V_DIR)/uart_checker_wrapper.sv

src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/MAX7219_checker/max7219_checker_pkg.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/MAX7219_checker/max7219_checker.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/MAX7219_checker/max7219_checker_wrapper.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/max7219_emul.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/max7219_matrix_emul.sv

# =================================


# == Specific Testbench File List ==
src_tb_lib_uart_display_ctrl_v+=$(TB_SRC_DIR)/tb_lib_uart_display_ctrl/testbench_setup.sv
src_tb_lib_uart_display_ctrl_v+=$(TB_SRC_DIR)/tb_lib_uart_display_ctrl/clk_gen.sv
src_tb_lib_uart_display_ctrl_v+=$(TB_SRC_DIR)/tb_lib_uart_display_ctrl/tb_top.sv


# ==================================


# =================================

## ===================== ##


## == COMPILE DESIGN == ##

compile_others:
	cd $(WORK_DIR); \
	$(foreach list, $(src_vhd_lib_others), $(vcom) -work $(LIB_OTHERS) $(list);) \


compile_max7219_interface:
	cd $(WORK_DIR); \
	$(vcom) -work $(LIB_MAX7219_INTERFACE) $(SRC_MAX7219_DIR)/lib_max7219_interface/pkg_max7219_interface.vhd; \

compile_max7219_static:
	cd $(WORK_DIR); \
	$(foreach list, $(src_vhd_lib_max7219_static), $(vcom) -work $(LIB_MAX7219_STATIC) $(list);) \

compile_max7219_scroller:
	cd $(WORK_DIR); \
	$(foreach list, $(src_vhd_lib_max7219_scroller), $(vcom) -work $(LIB_MAX7219_SCROLLER) $(list);) \

compile_max7219_controller:
	cd $(WORK_DIR); \
	$(foreach list, $(src_vhd_lib_max7219_controller), $(vcom) -work $(LIB_MAX7219_CONTROLLER) $(list);) \

# Compile Design Library here
compile_design : compile_others compile_max7219_interface compile_max7219_static compile_max7219_scroller compile_max7219_controller

## ==================== ##


## == COMPILE TESTBENCH == ##
compile_generic_tb_v_files :
	cd $(WORK_DIR); \
	$(foreach list, $(src_gen_tb_v), $(vlog) -work $(LIB_TB_UART_DISPLAY_CTRL) $(list);) \
	$(foreach list, $(src_tb_uart_v), $(vlog) -work $(LIB_TB_UART_DISPLAY_CTRL) $(list);) \


compile_tb_v_files :
	cd $(WORK_DIR); \
	$(foreach list, $(src_tb_v), $(vlog) -work $(LIB_TB_UART_DISPLAY_CTRL) $(list);) \


# == COMPILE ALL TESTBENCH files ==
compile_testbench : compile_generic_tb_v_files compile_tb_v_files
# =======================

# == COMPILE ALL ==
compile_all : clean libs compile_design compile_testbench
# =================

## ======================= ##


# == RUN TEST ==

run_tb_uart_display_ctrl :
	cd $(WORK_DIR); \
	$(vsim) $(VSIM_ARGS) tb_top -l $(TRANSCRIPTS_DIR)/$(TEST)_transcript.txt $(VSIM_G_ARGS)scn_lib_uart_display_ctrl/$(TEST).txt -do $(RUN_DO_DIR)/$(TEST)_run.do;

#$(vsim) $(VSIM_ARGS) $(LIB_TB_UART_DISPLAY_CTRL).tb_top -l $(TRANSCRIPTS_DIR)/$(TEST)_transcript.txt $(VSIM_G_ARGS)scn_lib_uart_display_ctrl/$(TEST).txt -do $(RUN_DO_DIR)/$(TEST)_run.do;
# ==============







# == OLD ==
src=    $(SRC_DIR)/pkg_rs232.vhd \
	$(SRC_DIR)/tx_rs232.vhd \
	$(SRC_DIR)/rx_uart.vhd \
	$(SRC_DIR)/test_tx_rs232.vhd \
	$(SRC_DIR)/test_robustesse_1.vhd

compile_src : 
	cd $(WORK_DIR); \
	$(VCOM1) $(LIB_TB_TOP) $(src);

run_1 :
	cd $(WORK_DIR); \
	vsim  -novopt -t ps $(LIB_TB_TOP).test_tx_rs232  -l transcript.txt -do $(SCRIPTS_DIR)/run.do;

run_2 :
	cd $(WORK_DIR); \
	vsim  -novopt -t ps $(LIB_TB_TOP).test_robustesse  -l transcript.txt -do $(SCRIPTS_DIR)/wave_robustesse.do;

run_test1: clean libs compile_src run_1

run_test_robustesse : clean libs compile_src run_2

