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
# ======================


# == TESTBENCH LIBRARIES ==
LIB_TESTBENCH=lib_testbench
# =========================


# ==  LIB LIST ==
LIB_1=lib_rs232
LIB_TB_TOP=tb_lib_top
# ================

# == VCOM config ==
VCOM1=vcom -nologo -work
# =================

# == VLOG config ==
VLOG1=vlog -nologo -work
# ================




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
	$(vmap) $(LIB_TB_TOP) $(LIB_1); \

 
libs:  prepare_libs create_libs
# ===========================================


# == DESIGN VHD FILE LIST ==
src_lib_uart+=$(SRC_DIR)/lib_uart/pkg_uart.vhd
src_lib_uart+=$(SRC_DIR)/lib_uart/rx_uart.vhd
src_lib_uart+=$(SRC_DIR)/lib_uart/tx_uart.vhd
# ==========================


## == TESTBENCH FILES == ##


# == GENERIC TB FILES ==
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/wait_event_tb.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/wait_event_wrapper.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/set_injector_tb.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/set_injector_wrapper.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/wait_duration_wrapper.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/check_level_wrapper.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/tb_tasks.sv
# ======================

src_tb_lib_uart_v+=$(TB_SRC_DIR)/tb_lib_uart/testbench_setup.sv
src_tb_lib_uart_v+=$(TB_SRC_DIR)/tb_lib_uart/clk_gen.sv
src_tb_lib_uart_v+=$(TB_SRC_DIR)/tb_lib_uart/tb_top.sv

## ===================== ##


## == COMPILE DESIGN == ##



## ==================== ##


## == COMPILE TESTBENCH == ##



## ======================= ##


# == RUN TEST ==
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

