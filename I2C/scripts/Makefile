############################################
#
#	Makefile for VHDL I2C tests
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

# Author : J.P
# Date   : 27/06/2021
#

ROOT=$(PWD)/..
WORK_DIR_NAME=I2C_WORK  # To Remane for the Project
WORK_DIR=/home/jorisp/MODELSIM_WORKS/$(WORK_DIR_NAME)



# == GENERIC TESTBENCH SOURCES DIRECTORY ==
GENERIC_TB_SRC_DIR=~/GitHub/Verilog/lib_testbench
#TB_UART_SRC_V_DIR=~/GitHub/Verilog/lib_tb_uart # A specific directory
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
# SRC_MAX7219_DIR=/home/jorisp/GitHub/VHDL_code/MAX7219/sources # Add Specific PATH
# =======================

# == VSIM ARGS ==
VSIM_ARGS+=-novopt -t ps -default_radix hexadecimal -fsmdebug
VSIM_G_ARGS+=-G/tb_top/SCN_FILE_PATH=$(SCN_DIR)/

ifeq ($(GUI), OFF)
	VSIM_ARGS=-c
endif


# ===============

# == DESIGN LIBRARIES ==

LIB_I2C=lib_i2c
# LIB_UART=lib_uart
# LIB_UART_DISPLAY_CTRL=lib_uart_display_ctrl

# LIB_OTHERS=lib_others
# LIB_MAX7219_STATIC=lib_max7219_static
# LIB_MAX7219_SCROLLER=lib_max7219_scroller
# LIB_MAX7219_CONTROLLER=lib_max7219_controller
# LIB_MAX7219_INTERFACE=lib_max7219_interface


# ======================


# == TESTBENCH LIBRARIES ==
LIB_TB_I2C_MASTER+=lib_tb_i2c_master
# =========================


# ==  LIB LIST ==
LIB_LIST+=$(LIB_I2C)
LIB_LIST+=$(LIB_TB_I2C_MASTER)
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
	@echo "make run_i2c_master_test TEST=[TEST_NB]"
	@echo "==============="
	@echo ""
	@echo "== SCENARII LIST =="
	@echo "$(SCN_LIST)"



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
src_vhd_lib_i2c+=$(SRC_DIR)/lib_i2c/pkg_i2c.vhd
src_vhd_lib_i2c+=$(SRC_DIR)/lib_i2c/i2c_master.vhd

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

# src_tb_uart_vhd+=$(SRC_DIR)/lib_uart/pkg_uart.vhd
# src_tb_uart_vhd+=$(SRC_DIR)/lib_uart/tx_uart.vhd
# src_tb_uart_vhd+=$(SRC_DIR)/lib_uart/rx_uart.vhd


# src_tb_uart_v+=$(TB_UART_SRC_V_DIR)/tb_uart_class.sv
# src_tb_uart_v+=$(TB_UART_SRC_V_DIR)/uart_checker_wrapper.sv

# src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/MAX7219_checker/max7219_checker_pkg.sv
# src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/MAX7219_checker/max7219_checker.sv
# src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/MAX7219_checker/max7219_checker_wrapper.sv
# src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/max7219_emul.sv
# src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/max7219_matrix_emul.sv
# src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/MAX7219_checker/max7219_spi_checker.sv

# =================================


# == Specific Testbench File List ==
src_tb_lib_i2c_master_v+=$(TB_SRC_DIR)/tb_lib_i2c_master/testbench_setup.sv
src_tb_lib_i2c_master_v+=$(TB_SRC_DIR)/tb_lib_i2c_master/clk_gen.sv
src_tb_lib_i2c_master_v+=$(TB_SRC_DIR)/tb_lib_i2c_master/tb_top.sv
# ==================================


# =================================

## ===================== ##


## == COMPILE DESIGN == ##

compile_i2c_master:
	cd $(WORK_DIR); \
	$(foreach list, $(src_vhd_lib_i2c), $(vcom) -work $(LIB_I2C) $(list);) \


# compile_others:
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_vhd_lib_others), $(vcom) -work $(LIB_OTHERS) $(list);) \

# compile_uart:
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_lib_uart), $(vcom) -work $(LIB_UART) $(list);) \

# compile_uart_display_ctrl:
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_vhd_lib_uart_display_ctrl), $(vcom) -work $(LIB_UART_DISPLAY_CTRL) $(list);) \

# compile_max7219_interface:
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_vhd_lib_max7219_interface), $(vcom) -work $(LIB_MAX7219_INTERFACE) $(list);) \


# compile_max7219_static:
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_vhd_lib_max7219_static), $(vcom) -work $(LIB_MAX7219_STATIC) $(list);) \
# 	$(foreach list, $(src_vhd_lib_others), $(vcom) -work $(LIB_MAX7219_STATIC) $(list);) \

# compile_max7219_scroller:
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_vhd_lib_max7219_scroller), $(vcom) -work $(LIB_MAX7219_SCROLLER) $(list);) \
# 	$(foreach list, $(src_vhd_lib_others), $(vcom) -work $(LIB_MAX7219_SCROLLER) $(list);) \

# compile_max7219_controller:
# 	cd $(WORK_DIR); \
# 	$(foreach list, $(src_vhd_lib_max7219_controller), $(vcom) -work $(LIB_MAX7219_CONTROLLER) $(list);) \


# Compile Design Library here
compile_design : compile_i2c_master

## ==================== ##


## == COMPILE TESTBENCH == ##


compile_generic_tb_v_files :
	cd $(WORK_DIR); \
	$(foreach list, $(src_gen_tb_v), $(vlog) -work $(LIB_TB_I2C_MASTER) $(list);) \

compile_tb_v_files :
	cd $(WORK_DIR); \
	$(foreach list, $(src_tb_lib_i2c_master_v), $(vlog) -work $(LIB_TB_I2C_MASTER) $(list);) \

# == COMPILE ALL TESTBENCH files ==

compile_testbench : compile_generic_tb_v_files compile_tb_v_files

# =======================

# == COMPILE ALL ==
compile_all : clean libs compile_design compile_testbench
# =================

## ======================= ##


# == GENERATE SCENARII ==

SCN_LIST+=$(SCN_DIR)/scn_lib_uart_display_ctrl/I2C_MASTER_00.py
# SCN_LIST+=$(SCN_DIR)/scn_lib_uart_display_ctrl/UART_DISPLAY_CTRL_01.py
# SCN_LIST+=$(SCN_DIR)/scn_lib_uart_display_ctrl/UART_DISPLAY_CTRL_02.py
# SCN_LIST+=$(SCN_DIR)/scn_lib_uart_display_ctrl/UART_DISPLAY_CTRL_03.py
# SCN_LIST+=$(SCN_DIR)/scn_lib_uart_display_ctrl/UART_DISPLAY_CTRL_04.py
# SCN_LIST+=$(SCN_DIR)/scn_lib_uart_display_ctrl/UART_DISPLAY_CTRL_05.py

generate_scn :
	cd $(SCN_DIR)/scn_lib_uart_display_ctrl/; \
	$(foreach list, $(SCN_LIST), python $(list);) \

# =======================

# == RUN TEST ==
run_i2c_master_test :
	cd $(SCN_DIR)/scn_lib_i2c_master; \
	python $(TEST).py; \
	cd $(TRANSCRIPTS_DIR); \
	rm $(TEST)_transcript.txt; \
	cd $(WORK_DIR); \
	$(vsim) $(VSIM_ARGS) $(LIB_TB_I2C_MASTER).tb_top -L lib_i2c -l $(TRANSCRIPTS_DIR)/$(TEST)_transcript.txt $(VSIM_G_ARGS)scn_lib_i2c_master/$(TEST).txt -do $(RUN_DO_DIR)/$(TEST)_run.do;
# ==============



# == GHDL Tests ==
GHDL_WORK_DIR=/home/jorisp/GHDL_UART_COMPILATION

ghdl_import_vhd_src:
	ghdl -i --workdir=$(GHDL_WORK_DIR)/works ~/GitHub/VHDL_code/RAM/TDPRAM/tdpram_sclk.vhd
	ghdl -i --workdir=$(GHDL_WORK_DIR)/lib_max7219_interface $(SRC_MAX7219_DIR)/lib_max7219_interface/*.vhd
	ghdl -i --workdir=$(GHDL_WORK_DIR)/lib_max7219_static $(SRC_MAX7219_DIR)/lib_max7219_static/*.vhd
	ghdl -i --workdir=$(GHDL_WORK_DIR)/lib_max7219_scroller $(SRC_MAX7219_DIR)/lib_max7219_scroller/*.vhd
	ghdl -i --workdir=$(GHDL_WORK_DIR)/lib_max7219_controller $(SRC_MAX7219_DIR)/lib_max7219_controller/*.vhd
	ghdl -i --workdir=$(GHDL_WORK_DIR)/lib_uart $(SRC_DIR)/lib_uart/*.vhd
	ghdl -i --workdir=$(GHDL_WORK_DIR)/lib_uart_display_ctrl $(SRC_DIR)/lib_uart_display_ctrl/*.vhd
	ghdl -i --workdir=$(GHDL_WORK_DIR)/works $(TB_SRC_DIR)/tb_lib_uart_display_ctrl/tb_top.vhd

ghdl_import_vhd_src_2:
	ghdl -i --workdir=$(GHDL_WORK_DIR)/works ~/GitHub/VHDL_code/RAM/TDPRAM/tdpram_sclk.vhd
	ghdl -i --workdir=$(GHDL_WORK_DIR)/works $(SRC_MAX7219_DIR)/lib_max7219_interface/*.vhd
	ghdl -i --workdir=$(GHDL_WORK_DIR)/works $(SRC_MAX7219_DIR)/lib_max7219_static/*.vhd
	ghdl -i --workdir=$(GHDL_WORK_DIR)/works $(SRC_MAX7219_DIR)/lib_max7219_scroller/*.vhd
	ghdl -i --workdir=$(GHDL_WORK_DIR)/works $(SRC_MAX7219_DIR)/lib_max7219_controller/*.vhd
	ghdl -i --workdir=$(GHDL_WORK_DIR)/works $(SRC_DIR)/lib_uart/*.vhd
	ghdl -i --workdir=$(GHDL_WORK_DIR)/works /home/jorisp/GitHub/VHDL_code/DE0_nano/lib_uart_max7219_top/*.vhd
	ghdl -i --workdir=$(GHDL_WORK_DIR)/works $(SRC_DIR)/lib_uart_display_ctrl/*.vhd
	ghdl -i --workdir=$(GHDL_WORK_DIR)/works $(TB_SRC_DIR)/tb_lib_uart_display_ctrl/tb_top.vhd


lib_misc=-P~/GitHub/VHDL_code/RAM/TDPRAM/
lib_uart_path=-P$(SRC_DIR)/lib_uart/
lib_max7219_interface_path=-P$(SRC_MAX7219_DIR)/lib_max7219_interface/
lib_max7219_static_path=-P$(SRC_MAX7219_DIR)/lib_max7219_static/
lib_max7219_scroller_path=-P$(SRC_MAX7219_DIR)/lib_max7219_scroller/
tb_lib_uart_display_ctrl_path=-P$(TB_SRC_DIR)/tb_lib_uart_display_ctrl/
lib_uart_max7219_top_path=-P/home/jorisp/GitHub/VHDL_code/DE0_nano/lib_uart_max7219_top/

ghdl_analyse_src_vhd:
	ghdl -a -fsynopsys --workdir=$(GHDL_WORK_DIR)/works $(lib_misc) $(lib_uart_path) $(lib_max7219_interface_path) $(lib_max7219_static_path) $(lib_max7219_scroller_path) $(tb_lib_uart_display_ctrl_path) $(lib_uart_max7219_top_path) $(TB_SRC_DIR)/tb_lib_uart_display_ctrl/tb_top.vhd
#$(lib_uart_path) $(lib_max7219_interface_path) $(lib_max7219_static_path) $(lib_max7219_scroller_path) $(tb_lib_uart_display_ctrl_path)


ghdl_analyse_and_elab:
	ghdl -m --workdir=$(GHDL_WORK_DIR)/works tb_top


ghdl_clean:
	ghdl --clean --workdir=$(GHDL_WORK_DIR)/works

# ================
