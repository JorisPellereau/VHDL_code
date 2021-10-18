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
HDL_SIMU_PATH=~/SIMULATION_VHDL
PROJECT_NAME=UART
WORK_DIR=UART_WORK
SCN_LIB_DIR=scn_lib_uart_display_ctrl
LIB_TB_TOP=lib_tb_uart_display_ctrl
TRANSCRIPT_EN=OFF
# ============================

#ROOT=$(PWD)/..
#WORK_DIR_NAME=UART_WORK
#WORK_DIR=/home/jorisp/MODELSIM_WORKS/$(WORK_DIR_NAME)
#WORK_DIR=~/SIMULATION_VHDL/UART/$(WORK_DIR_NAME)



# == GENERIC TESTBENCH SOURCES DIRECTORY ==
#GENERIC_TB_SRC_DIR=~/Documents/GitHub/Verilog/lib_testbench
#TB_UART_SRC_V_DIR=~/Documents/GitHub/Verilog/lib_tb_uart
# =========================================

# == TESTBENCH SPECIFIC SOURCES DIRECTORY ==
#TB_SRC_DIR=$(ROOT)/tb_sources
# ==========================================

# == PROJECT DIRECTORIES ==
# SCRIPTS_DIR=$(ROOT)/scripts
# RUN_DO_DIR=$(ROOT)/do_files/run_files
# TRANSCRIPTS_DIR=$(ROOT)/transcripts
# WLF_DIR=$(ROOT)/WLF
# SCN_DIR=$(ROOT)/scenarios
# =========================

# == MODELSIM ALIAS ==
# vsim=/opt/intelFPGA/18.1/modelsim_ase/bin/vsim
# vlib=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vlib
# vmap=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vmap
# vcom=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vcom
# vlog=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vlog

# vsim=/opt/Modelsim/modelsim_ase/bin/vsim
# vlib=/opt/Modelsim/modelsim_ase/linuxaloem/vlib
# vmap=/opt/Modelsim/modelsim_ase/linuxaloem/vmap
# vcom=/opt/Modelsim/modelsim_ase/linuxaloem/vcom
# vlog=/opt/Modelsim/modelsim_ase/linuxaloem/vlog
# ====================

# == SOURCES DIRECTORY ==
#SRC_DIR=$(ROOT)/sources
SRC_MAX7219_DIR=~/Documents/GitHub/VHDL_code/MAX7219/sources
# =======================

# == VSIM ARGS ==
# VSIM_ARGS+=-novopt -t ps -default_radix hexadecimal -fsmdebug
# VSIM_G_ARGS+=-G/tb_top/SCN_FILE_PATH=$(SCN_DIR)/

# ifeq ($(GUI), OFF)
# 	VSIM_ARGS=-c
# endif


# ===============

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



all: print_generic_rules
	@echo ""
	@echo "Makefile for compilation & Simulation with Modelsim"
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
	@echo "== SCENARII LIST =="
	@echo "$(SCN_LIST)"



# == CREATE WORK DIR. ==
# create_dir:
# 	cd $(ROOT); \
# 	mkdir transcripts; \
# 	mkdir do_files; \
# 	mkdir WLF; \
# 	mkdir sources; \
# 	mkdir tb_sources; \
# 	mkdir scenarios; \
# 	cd ./do_files; \
# 	mkdir run_files; \
# 	mkdir waves; \

# create_work:
# 	cd ~/MODELSIM_WORKS/; \
# 	mkdir $(WORK_DIR_NAME); \

# ======================


# == CLEAN PROJECT ==
# clean:
# 	cd $(WORK_DIR); \
# 	rm -rRf *;

# ====================


# == PREPARE MODELSIM LIBRARY ==
# prepare_libs:
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(LIB_LIST), $(vlib) ./$(list);) \

# create_libs:
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(LIB_LIST), $(vmap) $(list) $(list);) \


# libs:  prepare_libs create_libs
# ===========================================


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


## == TESTBENCH FILES == ##


# == GENERIC TB FILES ==
# src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/wait_event_tb.sv
# src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/wait_event_wrapper.sv
# src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/set_injector_tb.sv
# src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/set_injector_wrapper.sv
# src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/wait_duration_wrapper.sv
# src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/check_level_wrapper.sv
# src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/tb_modules_custom_class.sv
# src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/tb_tasks.sv
# ======================

# == TESTBENCH UART V FILES LIST ==
src_tb_uart_vhd+=$(SRC_DIR)/lib_uart/pkg_uart.vhd
src_tb_uart_vhd+=$(SRC_DIR)/lib_uart/tx_uart.vhd
src_tb_uart_vhd+=$(SRC_DIR)/lib_uart/rx_uart.vhd


src_tb_uart_v+=$(TB_UART_SRC_V_DIR)/tb_uart_class.sv
src_tb_uart_v+=$(TB_UART_SRC_V_DIR)/uart_checker_wrapper.sv

src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/MAX7219_checker/max7219_checker_pkg.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/MAX7219_checker/max7219_checker.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/MAX7219_checker/max7219_checker_wrapper.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/max7219_emul.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/max7219_matrix_emul.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/MAX7219_checker/max7219_spi_checker.sv

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
	make compile_design_vhd_files SRC_VHD=$(src_vhd_lib_others) VHD_DESIGN_LIB=$(LIB_OTHERS)
#	$(foreach list, $(src_vhd_lib_others), $(vcom) -work $(LIB_OTHERS) $(list);) \

compile_uart:
	make compile_design_vhd_files SRC_VHD=$(src_lib_uart) VHD_DESIGN_LIB=$(LIB_UART)

# compile_uart:
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_lib_uart), $(vcom) -work $(LIB_UART) $(list);) \

compile_uart_display_ctrl:
	make compile_design_vhd_files SRC_VHD=$(src_vhd_lib_uart_display_ctrl) VHD_DESIGN_LIB=$(LIB_UART_DISPLAY_CTRL)

# compile_uart_display_ctrl:
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_vhd_lib_uart_display_ctrl), $(vcom) -work $(LIB_UART_DISPLAY_CTRL) $(list);) \


compile_max7219_interface:
	make compile_design_vhd_files SRC_VHD=$(src_vhd_lib_max7219_interface) VHD_DESIGN_LIB=$(LIB_MAX7219_INTERFACE)

# compile_max7219_interface:
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_vhd_lib_max7219_interface), $(vcom) -work $(LIB_MAX7219_INTERFACE) $(list);) \

#	$(vcom) -work $(LIB_MAX7219_INTERFACE) $(SRC_MAX7219_DIR)/lib_max7219_interface/pkg_max7219_interface.vhd; \

compile_max7219_static:
	make compile_design_vhd_files SRC_VHD=$(src_vhd_lib_max7219_static) VHD_DESIGN_LIB=$(LIB_MAX7219_STATIC)
	make compile_design_vhd_files SRC_VHD=$(src_vhd_lib_others) VHD_DESIGN_LIB=$(LIB_MAX7219_STATIC)

# compile_max7219_static:
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_vhd_lib_max7219_static), $(vcom) -work $(LIB_MAX7219_STATIC) $(list);) \
# 	$(foreach list, $(src_vhd_lib_others), $(vcom) -work $(LIB_MAX7219_STATIC) $(list);) \

compile_max7219_scroller:
	make compile_design_vhd_files SRC_VHD=$(src_vhd_lib_max7219_scroller) VHD_DESIGN_LIB=$(LIB_MAX7219_SCROLLER)
	make compile_design_vhd_files SRC_VHD=$(src_vhd_lib_others) VHD_DESIGN_LIB=$(LIB_MAX7219_SCROLLER)

# compile_max7219_scroller:
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_vhd_lib_max7219_scroller), $(vcom) -work $(LIB_MAX7219_SCROLLER) $(list);) \
# 	$(foreach list, $(src_vhd_lib_others), $(vcom) -work $(LIB_MAX7219_SCROLLER) $(list);) \

compile_max7219_controller:
	make compile_design_vhd_files SRC_VHD=$(src_vhd_lib_max7219_controller) VHD_DESIGN_LIB=$(LIB_MAX7219_CONTROLLER)

# compile_max7219_controller:
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_vhd_lib_max7219_controller), $(vcom) -work $(LIB_MAX7219_CONTROLLER) $(list);) \


# == Compile Design Library here ==
compile_design : compile_others compile_max7219_interface compile_max7219_static compile_max7219_scroller compile_max7219_controller compile_uart compile_uart_display_ctrl
# ================================


## == COMPILE TESTBENCH == ##
compile_tb_uart_vhd_files:
	make compile_tb_vhd_files SRC_TB_VHD=$(src_tb_uart_vhd) TB_LIB_TOP=$(LIB_TB_UART_DISPLAY_CTRL)

# compile_uart_vhd_files :
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_tb_uart_vhd), $(vcom) -work $(LIB_TB_UART_DISPLAY_CTRL) $(list);) \

compile_generic_tb_v_files:
	make compile_tb_v_files SRC_TB_V=$(src_gen_tb_v) TB_LIB_TOP=$(LIB_TB_UART_DISPLAY_CTRL)
	make compile_tb_v_files SRC_TB_V=$(src_tb_uart_v) TB_LIB_TOP=$(LIB_TB_UART_DISPLAY_CTRL)


# compile_generic_tb_v_files :
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_gen_tb_v), $(vlog) -work $(LIB_TB_UART_DISPLAY_CTRL) $(list);) \
# 	$(foreach list, $(src_tb_uart_v), $(vlog) -work $(LIB_TB_UART_DISPLAY_CTRL) $(list);) \

compile_testbench_sources:
	make compile_tb_v_files SRC_TB_V=$(src_tb_v) TB_LIB_TOP=$(LIB_TB_UART_DISPLAY_CTRL)
	make compile_tb_v_files SRC_TB_V=$(src_tb_lib_uart_display_ctrl_v) TB_LIB_TOP=$(LIB_TB_UART_DISPLAY_CTRL)

# compile_tb_v_files :
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_tb_v), $(vlog) -work $(LIB_TB_UART_DISPLAY_CTRL) $(list);) \
# 	$(foreach list, $(src_tb_lib_uart_display_ctrl_v), $(vlog) -work $(LIB_TB_UART_DISPLAY_CTRL) $(list);) \

# == COMPILE ALL TESTBENCH files ==
compile_testbench : compile_tb_uart_vhd_files compile_generic_tb_v_files compile_testbench_sources
# =======================

# == COMPILE ALL ==
compile_all : clean_all create_project_dir libs compile_design compile_testbench
# =================

## ======================= ##


# == GENERATE SCENARII ==

SCN_LIST+=$(SCN_DIR)/scn_lib_uart_display_ctrl/UART_DISPLAY_CTRL_00.py
SCN_LIST+=$(SCN_DIR)/scn_lib_uart_display_ctrl/UART_DISPLAY_CTRL_01.py
SCN_LIST+=$(SCN_DIR)/scn_lib_uart_display_ctrl/UART_DISPLAY_CTRL_02.py
SCN_LIST+=$(SCN_DIR)/scn_lib_uart_display_ctrl/UART_DISPLAY_CTRL_03.py
SCN_LIST+=$(SCN_DIR)/scn_lib_uart_display_ctrl/UART_DISPLAY_CTRL_04.py
SCN_LIST+=$(SCN_DIR)/scn_lib_uart_display_ctrl/UART_DISPLAY_CTRL_05.py



# =======================

# == RUN TEST ==

run_tb_uart_display_ctrl :
	cd $(SCN_DIR)/scn_lib_uart_display_ctrl/; \
	python $(TEST).py; \
	cd $(TRANSCRIPTS_DIR); \
	rm $(TEST)_transcript.txt; \
	cd $(WORK_DIR); \
	$(vsim) $(VSIM_ARGS) $(LIB_TB_UART_DISPLAY_CTRL).tb_top -L lib_max7219_controller -L lib_uart_display_ctrl -l $(TRANSCRIPTS_DIR)/$(TEST)_transcript.txt $(VSIM_G_ARGS)scn_lib_uart_display_ctrl/$(TEST).txt -do $(RUN_DO_DIR)/$(TEST)_run.do;

#$(vsim) $(VSIM_ARGS) $(LIB_TB_UART_DISPLAY_CTRL).tb_top -l $(TRANSCRIPTS_DIR)/$(TEST)_transcript.txt $(VSIM_G_ARGS)scn_lib_uart_display_ctrl/$(TEST).txt -do $(RUN_DO_DIR)/$(TEST)_run.do;
# ==============






include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGeneric
