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
#	     |__ /testbench_setup.sv
#	     |__ /tb_top.sv
#	|__ /do_files       => Do Files
#	     |__ /run_files => Run .do
#	     |__ /waves     => Waves .do
#	|__ /scenarios      => Scenario list
#	|__ /WLF            => WLF files
#	|__ /transcripts    => Transcripts files

ROOT=$(PWD)/..
WORK_DIR_NAME=TOTO_WORK
WORK_DIR=$(ROOT)/$(WORK_DIR_NAME)

# == GENERIC TESTBENCH SOURCES DIRECTORY ==
GENERIC_TB_SRC_DIR=~/GitHub/Verilog/lib_testbench
# =========================================

# == TESTBENCH SOURCES DIRECTORY ==
TB_SRC_DIR=$(ROOT)/tb_sources
# =================================

SCRIPTS_DIR=$(ROOT)/scripts
RUN_DO_DIR=$(ROOT)/do_files/run_files
TRANSCRIPTS_DIR=$(ROOT)/transcripts
WLF_DIR=$(ROOT)/WLF
SCN_DIR=$(ROOT)/scenarios


# MODELSIM ALIAS
vsim=/opt/intelFPGA/18.1/modelsim_ase/bin/vsim
vlib=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vlib
vmap=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vmap
vcom=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vcom
vlog=/opt/intelFPGA/18.1/modelsim_ase/linuxaloem/vlog


# == SOURCES DIRECTORY ==
SRC_DIR=$(ROOT)/TOTO
# =======================

# == VSIM ARGS ==
VSIM_ARGS+=-novopt -t ps
VSIM_G_ARGS+=-G/tb_top/i_tb_seq_wrapper_0/SCN_FILE_PATH=$(SCN_DIR)/
# ===============

# == LIBRARY LIST AFFECTATION ==
LIB_LIST+=TOTO
LIB_LIST+=TARA
TB_LIB_LIST+=lib_tb_top
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
	@echo "== RUN TESTS =="
	@echo "- Run test : :"
	@echo "make run_test TEST=[TEST_NAME]"
	@echo "==============="
	@echo ""
	@echo "LIB_LIST : $(LIB_LIST)"
	@echo "TB_LIB_LIST : $(TB_LIB_LIST)"
	@echo "VSIM_ARGS : $(VSIM_ARGS)"
	@echo "VSIM_G_ARGS : $(VSIM_G_ARGS)"
	@echo "GENERIC_TB_SRC_DIR : $(GENERIC_TB_SRC_DIR)"



# == PREPARE PROJECT ==
create_dir:
	cd $(ROOT); \
	mkdir $(WORK_DIR_NAME); \
	mkdir transcripts; \
	mkdir do_files; \
	mkdir WLF; \
	mkdir sources; \
	mkdir tb_sources; \
	mkdir scenarios; \
	cd ./do_files; \
	mkdir run_files; \
	mkdir waves; \
# ======================


# == CLEAN PROJECT ==
clean:
	cd $(WORK_DIR); \
	rm -rRf *;
# ====================


# == PREPARE MODELSIM LIBRARY ==
prepare_libs:
	cd $(WORK_DIR); \
	$(foreach list, $(LIB_LIST),$(vlib) ./$(list);) \
	$(foreach tb_list, $(TB_LIB_LIST),$(vlib) ./$(tb_list);)

create_libs:
	cd $(WORK_DIR); \
	$(vmap) $(TB_LIB_TOP) ./$(LIB_LIST);

libs:  prepare_libs create_libs
#=============================



# == GENERIC TESTBENCH FILE LIST ==
src_gen_tb_v=	$(GENERIC_TB_SRC_DIR)/sequencer.sv \
		$(GENERIC_TB_SRC_DIR)/decoder.sv \
		$(GENERIC_TB_SRC_DIR)/set_injector.sv \
		$(GENERIC_TB_SRC_DIR)/wait_event.sv \
		$(GENERIC_TB_SRC_DIR)/check_level.sv \
		$(GENERIC_TB_SRC_DIR)/tb_seq_wrapper.sv \
# =================================


# == TESTBENCH FILE LIST ==
src_tb_v=	$(TB_SRC_DIR)/testbench_setup.sv \
		$(TB_SRC_DIR)/clk_gen.sv \
		$(TB_SRC_DIR)/tb_top.sv \



src_tb_vhd=	$(TB_SRC_DIR)/max7219_if.vhd \
#==========================


# == DESIGN VHD FILE LIST ==
src_vhd=
# ==========================




# == COMPILES TESTBENCH V FILES ==
compile_tb_v :
	cd $(WORK_DIR); \
	$(vlog) -work $(TB_LIB_LIST) $(src_gen_tb_v); \
	$(vlog) -work $(TB_LIB_LIST) $(src_tb_v)
# ================================

# == COMPILES TESTBENCH VHD FILES ==
compile_tb_vhd :
	cd $(WORK_DIR); \
	$(vcom) -work $(TB_LIB_LIST) $(src_tb_vhd);
# ================================

# == RUN TEST ==
run_test : clean libs compile_tb_v
	cd $(WORK_DIR); \
	$(vsim) $(VSIM_ARGS) -l $(TRANSCRIPTS_DIR)/$(TEST)_transcript.txt $(TB_LIB_LIST).tb_top $(VSIM_G_ARGS)$(TEST).txt -do $(RUN_DO_DIR)/$(TEST)_run.do;
# ==============

