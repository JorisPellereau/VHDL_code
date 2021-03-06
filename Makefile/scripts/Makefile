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
# ===============

# == DESIGN LIBRARIES ==
LIB_MAX7219=lib_max7219

# ======================


# == TESTBENCH LIBRARIES ==
LIB_TESTBENCH=lib_testbench
LIB_TB_TOP=lib_tb_top

# =========================


## == LIBRARY LIST AFFECTATION == ##

## == DESIGN LIBRARIES ==
LIB_LIST+=lib_max7219
## ======================

## == TESTBENCH LIBRARY ==
LIB_LIST+=$(LIB_TESTBENCH)
## =======================

## ============================== ##


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
	@echo "- Run test :"
	@echo "make run_test TEST=[TEST_NAME]"
	@echo "==============="
	@echo ""
	@echo "LIB_LIST : $(LIB_LIST)"
	@echo "VSIM_ARGS : $(VSIM_ARGS)"
	@echo "VSIM_G_ARGS : $(VSIM_G_ARGS)"
	@echo "GENERIC_TB_SRC_DIR : $(GENERIC_TB_SRC_DIR)"
	@echo "SOURCE GENERIC TB V FILES : $(src_gen_tb_v)"



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
	$(vlib) $(LIB_TB_TOP);

create_libs:
	cd $(WORK_DIR); \
	$(foreach list, $(LIB_LIST),$(vmap) $(LIB_TB_TOP) ./$(list);) \

libs:  prepare_libs create_libs
#===============================


# == DESIGN VHD FILE LIST ==
src_vhd_lib_max7219+=$(SRC_DIR)/pkg_max7219.vhd
src_vhd_lib_max7219+=$(SRC_DIR)/max7219_if.vhd
src_vhd_lib_max7219+=$(SRC_DIR)/max7219_msg_sel.vhd
# ==========================




## == TESTBENCH FILES == ##

# == TB VHD FILES ==
src_tb_vhd+=
#===================


# == GENERIC TB FILES ==
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/wait_event_tb.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/wait_event_wrapper.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/set_injector_tb.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/set_injector_wrapper.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/wait_duration_wrapper.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/check_level_wrapper.sv
src_gen_tb_v+=$(GENERIC_TB_SRC_DIR)/tb_tasks.sv
# ======================

# == TB SETUP & Internal modules ==
src_tb_v+=$(TB_SRC_DIR)/testbench_setup.sv
src_tb_v+=$(TB_SRC_DIR)/clk_gen.sv
# =================================

# == TB TOP ==
src_tb_v+=$(TB_SRC_DIR)/tb_top.sv
# ============

## ===================== ##



## == COMPILE DESIGN == ##

# Compile Design Library here
compile_design :
	cd $(WORK_DIR); \
	$(foreach list, $(src_vhd_lib_max7219), $(vcom) -work $(LIB_MAX7219) $(list);)

## ==================== ##


## == COMPILE TESTBENCH == ##

# == TB COMPILES VHD FILES ==
compile_tb_vhd_files :
	cd $(WORK_DIR); \
	$(foreach list, $(src_tb_vhd), $(vcom) -work $(LIB_TB_TOP) $(list);)
# ===========================

# == COMPILES GENERIC V FILES ==
compile_generic_tb_v_files :
	cd $(WORK_DIR); \
	$(foreach list, $(src_gen_tb_v), $(vlog) -work $(LIB_TESTBENCH) $(list);)
# ==============================

# == COMPILES TB V FILES ==
compile_tb_v_files :
	cd $(WORK_DIR); \
	$(foreach list, $(src_tb_v), $(vlog) -work $(LIB_TB_TOP) $(list);)
# =========================

# == COMPILE ALL TESTBENCH files ==
compile_testbench : compile_tb_vhd_files compile_generic_tb_v_files compile_tb_v_files
# =======================

## ======================= ##


# == COMPILE ALL ==
compile_all : clean libs compile_design compile_testbench
# =================


# == RUN TEST ==
run_test :
	cd $(WORK_DIR); \
	$(vsim) $(VSIM_ARGS) -l $(TRANSCRIPTS_DIR)/$(TEST)_transcript.txt $(LIB_TB_TOP).tb_top $(VSIM_G_ARGS)$(TEST).txt -do $(RUN_DO_DIR)/$(TEST)_run.do;
# ==============




##################################################
