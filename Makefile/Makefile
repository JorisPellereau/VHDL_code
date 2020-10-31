#
#	Makefile for Compilation & Simulation with modelsim
#

# Repository Organization
# /(ROOT)
# 	|__ /scripts        => Scripts - Makefile
#	|__ /sources        => Design VHD - V files
#	     |__ /lib_x
#	     |__ /lib_y
#	|__ /tb_sources     => Specific TestBench files
#	     |__ /tb_top.sv
#	|__ /do_files       => Do Files
#	     |__ /run_files => Run .do
#	     |__ /waves     => Waves .do
#	|__ /scenario       => Scenario list
#	|__ /WLF            => WLF files
#	|__ /transcripts    => Transcripts files

ROOT=$(PWD)/..
WORK_DIR_NAME=TB_WORK
WORK_DIR=$(ROOT)/$(WORK_DIR_NAME)

# == GENERIC TESTBENCH SOURCES DIRECTORY ==
GENERIC_TB_SRC_DIR=~/GitHub/Verilog/lib_testbench
# =========================================

SCRIPTS_DIR=$(ROOT)/scripts
RUN_DO_DIR=$(ROOT)/do_files/run_files
TRANSCRIPTS_DIR=$(ROOT)/transcripts
WLF_DIR=$(ROOT)/WLF

# MODELSIM ALIAS
vsim=/opt/intelFPGA/18.1/modelsim_ase/bin/vsim
vlib=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vlib
vmap=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vmap
vcom=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vcom
vlog=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vlog


# == SOURCES DIRECTORY ==
SRC_DIR=$(ROOT)/TOTO

LIB_LIST=
TB_LIB_LIST=


# == LIBRARY LIST AFFECTATION ==
LIB_LIST += TOTO
TB_LIB_LIST += lib_tb_top
# ==============================

all: 
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
	@echo "- Source Compilation :"
	@echo "make compile_src"
	@echo ""
	@echo "- Compile all :"
	@echo "make compile_tb"
	@echo ""
	@echo "=========================="
	@echo ""
	@echo "======     RUN TESTS MAX7219          ======"
	@echo "- Run test : :"
	@echo "make run_test TEST=[TEST_NAME]"
	@echo "============================================"


# == PREPARE PROJECT ==
create_dir:
	cd $(ROOT); \
	mkdir $(WORK_DIR_NAME); \
	mkdir transcripts; \
	mkdir do_files; \
	mkdir WLF;
	mkdir sources; \
	mkdir tb_sources;
# ======================


# == CLEAN PROJECT ==
clean:
	cd $(WORK_DIR); \
	rm -rRf *;
# ====================


# == PREPARE MODELSIM LIBRARY ==
prepare_libs:
	cd $(WORK_DIR); \
	$(vlib) ./$(LIB_LIST); \
	$(vlib) ./$(TB_LIB_LIST);

create_libs:
	cd $(WORK_DIR); \
	$(vmap) $(TB_LIB_TOP) ./$(LIB_LIST);

libs:  prepare_libs create_libs
#=============================

