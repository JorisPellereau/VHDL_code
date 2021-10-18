

# == Makefile Configuration ==
SEL_STATION=LINUX
ROOT=$(PWD)/..
HDL_SIMU_PATH=~/SIMULATION_VHDL
PROJECT_NAME=PROJECT_TEST
WORK_DIR=UART_WORK
SCN_LIB_DIR=scn_lib_uart_display_ctrl
LIB_TB_TOP=lib_tb_uart_display_ctrl

LIB_LIST+=TOTO0
LIB_LIST+=TOTO1
LIB_LIST+=TOTO2
LIB_LIST+=TOTO3

# A configurer
LIB_ARGS+=

TRANSCRIPT_EN=OFF
# ============================
all: print_generic_rules
	@echo "== Makefile for XXXX PROJECT =="
	#make -s print_generic_rules

toto: prepare_libs
	$(vsim)

titi:
	$(vcom)

include MakefileGeneric
