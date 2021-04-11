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
#
#
#
# Makefile for MAX7219 blocks tests
# Author : J.P
# Date   : 02/12/2020
#
# Version : 1.0 - Initialization for MAS7219 test
#
#

ROOT=$(PWD)/..
WORK_DIR_NAME=MAX7219_WORK
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

# == INIT Variables ==
COVER=OFF
# ====================

# == VSIM ARGS ==
VSIM_ARGS+=-novopt -t ps
VSIM_G_ARGS+=-G/tb_top/SCN_FILE_PATH=$(SCN_DIR)/

# Not supported on my Modelsim Licence
ifeq ($(COVER), ON)
	VSIM_ARGS+=-coverage
endif

ifeq ($(GUI), OFF)
	VSIM_ARGS=-c
endif


# ===============

# == DESIGN LIBRARIES ==
LIB_MAX7219=lib_max7219

LIB_OTHERS=lib_others
LIB_MAX7219_STATIC=lib_max7219_static
LIB_MAX7219_SCROLLER=lib_max7219_scroller
LIB_MAX7219_CONTROLLER=lib_max7219_controller
LIB_MAX7219_INTERFACE=lib_max7219_interface


# ======================


# == TESTBENCH LIBRARIES ==
LIB_TESTBENCH=lib_testbench
LIB_TB_TOP=lib_tb_top

LIB_TB_STATIC=lib_tb_static
LIB_TB_SCROLLER=lib_tb_scroller
LIB_TB_CONTROLLER=lib_tb_controller

# =========================


## == LIBRARY LIST AFFECTATION == ##

## == DESIGN LIBRARIES ==
LIB_LIST+=lib_max7219
## ======================

## == TESTBENCH LIBRARY ==
LIB_LIST+=$(LIB_TESTBENCH)
## =======================

## == SCENARIOS LIST == ##
STATIC_SCN_LIST+=MAX_STATIC_00
STATIC_SCN_LIST+=MAX_STATIC_01
STATIC_SCN_LIST+=MAX_STATIC_02
STATIC_SCN_LIST+=MAX_STATIC_03
STATIC_SCN_LIST+=MAX_STATIC_04
STATIC_SCN_LIST+=MAX_STATIC_05

SCROLLER_SCN_LIST+=MAX_SCROLLER_00
SCROLLER_SCN_LIST+=MAX_SCROLLER_01
SCROLLER_SCN_LIST+=MAX_SCROLLER_02
SCROLLER_SCN_LIST+=MAX_SCROLLER_03
SCROLLER_SCN_LIST+=MAX_SCROLLER_04

CONTROLLER_SCN_LIST+=MAX_CONTROLLER_00
CONTROLLER_SCN_LIST+=MAX_CONTROLLER_01
CONTROLLER_SCN_LIST+=MAX_CONTROLLER_02
CONTROLLER_SCN_LIST+=MAX_CONTROLLER_03
## ==================== ##

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
	@echo "- Run test MAX7219_STATIC :"
	@echo "make run_tb_max7219_static TEST=[TEST_NAME]"
	@echo ""
	@echo "- Run test MAX7219_SCROLLER :"
	@echo "make run_tb_max7219_scroller TEST=[TEST_NAME]"
	@echo ""
	@echo "- Run test MAX7219_CONTROLLER :"
	@echo "make run_tb_max7219_controller TEST=[TEST_NAME]"
	@echo ""
	@echo ""
	@echo ""
	@echo "- Run ALL MAX7219_STATIC Tests"
	@echo "make run_max7219_static_tests"
	@echo "==============="
	@echo ""
	@echo "== RUN SYMBOLATOR =="
	@echo "- Run Symbolator in order to generate PNG files :"
	@echo "make symbolator_generate_png"
	@echo "==============="
	@echo ""
	@echo "LIB_LIST           : $(LIB_LIST)"
	@echo "VSIM_ARGS          : $(VSIM_ARGS)"
	@echo "VSIM_G_ARGS        : $(VSIM_G_ARGS)"
	@echo ""
	@echo "GENERIC_TB_SRC_DIR        : $(GENERIC_TB_SRC_DIR)"
	@echo "SOURCE GENERIC TB V FILES : $(src_gen_tb_v)"
	@echo ""
	@echo "STATIC SCN LIST     : $(STATIC_SCN_LIST)"
	@echo "SCROLLER SCN LIST   : $(SCROLLER_SCN_LIST)"
	@echo "CONTROLLER SCN LIST : $(CONTROLLER_SCN_LIST)"



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
	$(vlib) $(LIB_MAX7219_INTERFACE); \
	$(vlib) $(LIB_MAX7219_STATIC); \
	$(vlib) $(LIB_MAX7219_SCROLLER); \
	$(vlib) $(LIB_MAX7219_CONTROLLER); \
	$(vlib) $(LIB_OTHERS); \
	$(vlib) $(LIB_TB_TOP); \
	$(vlib) $(LIB_TB_STATIC); \
	$(vlib) $(LIB_TB_SCROLLER); \
	$(vlib) $(LIB_TB_CONTROLLER); \

	#$(vlib) work; \

	#$(foreach list, $(LIB_LIST),$(vlib) ./$(list);) \
	#$(vlib) $(LIB_MAX7219_INTERFACE); \
	#$(vlib) $(LIB_MAX7219_STATIC); \
	#$(vlib) $(LIB_MAX7219_SCROLLER); \
	#$(vlib) $(LIB_MAX7219_CONTROLLER); \
	#$(vlib) $(LIB_TB_TOP); \



	#$(vlib) $(LIB_TB_STATIC); \
	#$(vlib) $(LIB_TB_SCROLLER); \
	#$(vlib) $(LIB_TB_CONTROLLER); \

create_libs:
	cd $(WORK_DIR); \
	$(vmap) $(LIB_MAX7219_INTERFACE) $(LIB_MAX7219_INTERFACE); \
	$(vmap) $(LIB_MAX7219_STATIC) $(LIB_MAX7219_STATIC); \
	$(vmap) $(LIB_MAX7219_SCROLLER) $(LIB_MAX7219_SCROLLER); \
	$(vmap) $(LIB_MAX7219_CONTROLLER) $(LIB_MAX7219_CONTROLLER); \
	$(vmap) $(LIB_TB_TOP) $(LIB_TB_TOP); \
	@echo "VMAP LIB STATIC"; \
	$(vmap) $(LIB_TB_STATIC) $(LIB_MAX7219_STATIC); \
	$(vmap) $(LIB_TB_STATIC) $(LIB_TB_TOP); \
	$(vmap) $(LIB_TB_STATIC) $(LIB_MAX7219_STATIC); \
	$(vmap) $(LIB_TB_STATIC) $(LIB_MAX7219_INTERFACE); \
	$(vmap) $(LIB_TB_STATIC) $(LIB_TB_STATIC); \
	@echo "VMAP LIB SCROLLER"; \
	$(vmap) $(LIB_MAX7219_SCROLLER) $(LIB_TB_SCROLLER); \
	$(vmap) $(LIB_MAX7219_INTERFACE) $(LIB_TB_SCROLLER); \
	$(vmap) $(LIB_TB_SCROLLER) $(LIB_TB_SCROLLER); \
	@echo "VMAP LIB CONTROLLER"; \
	$(vmap) $(LIB_TB_CONTROLLER) $(LIB_TB_CONTROLLER); \


	#$(vmap) work $(LIB_MAX7219_INTERFACE); \
	#$(vmap) work work; \

toto:
#	$(vmap) $(LIB_MAX7219_INTERFACE) $(LIB_TB_TOP); \
	#$(vmap) $(LIB_TB_TOP) $(LIB_TB_TOP); \

	#$(foreach list, $(LIB_LIST),$(vmap) $(list) $(list);) \
	#$(vmap) $(LIB_TB_STATIC) $(LIB_TB_TOP); \
	#$(vmap) $(LIB_TB_SCROLLER) $(LIB_TB_TOP); \
	#$(vmap) $(LIB_TB_CONTROLLER) $(LIB_TB_TOP); \
	#$(vmap) $(LIB_TB_TOP) $(LIB_TB_TOP); \
	#$(vmap) $(LIB_MAX7219_STATIC) $(LIB_TB_TOP)

#	$(foreach list, $(LIB_LIST),$(vmap) $(list) $(LIB_TB_TOP);) \
#	$(vmap) $(LIB_TB_STATIC) $(LIB_TB_TOP); \
#	$(vmap) $(LIB_TB_SCROLLER) $(LIB_TB_TOP); \
#	$(vmap) $(LIB_TB_CONTROLLER) $(LIB_TB_TOP); \
#	$(vmap) $(LIB_TB_TOP) $(LIB_TB_TOP); \
	#$(vmap) $(LIB_TB_STATIC) $(LIB_TESTBENCH); \
	#$(vmap) $(LIB_TB_SCROLLER) $(LIB_TESTBENCH); \
	#$(vmap) $(LIB_TB_CONTROLLER) $(LIB_TESTBENCH); \
	#$(foreach list, $(LIB_LIST),$(vmap) $(list) $(LIB_TB_STATIC);) \
	#$(foreach list, $(LIB_LIST),$(vmap) $(list) $(LIB_TB_SCROLLER);) \
	#$(foreach list, $(LIB_LIST),$(vmap) $(list) $(LIB_TB_CONTROLLER);) \

libs:  prepare_libs create_libs
#===============================


# == DESIGN VHD FILE LIST ==
src_vhd_lib_others+=~/GitHub/VHDL_code/RAM/TDPRAM/tdpram_sclk.vhd

#src_vhd_lib_max7219+=$(SRC_DIR)/pkg_max7219.vhd

src_vhd_lib_max7219_static+=$(SRC_DIR)/lib_max7219_static/pkg_max7219_static.vhd
src_vhd_lib_max7219_static+=$(SRC_DIR)/lib_max7219_static/max7219_ram_decod.vhd
src_vhd_lib_max7219_static+=$(SRC_DIR)/lib_max7219_static/max7219_cmd_decod.vhd

src_vhd_lib_max7219_scroller+=$(SRC_DIR)/lib_max7219_scroller/pkg_max7219_scroller.vhd
src_vhd_lib_max7219_scroller+=$(SRC_DIR)/lib_max7219_scroller/max7219_ram2scroller_if.vhd
src_vhd_lib_max7219_scroller+=$(SRC_DIR)/lib_max7219_scroller/max7219_scroller_if.vhd
src_vhd_lib_max7219_scroller+=$(SRC_DIR)/lib_max7219_scroller/max7219_scroller_ctrl.vhd

src_vhd_lib_max7219_controller+=$(SRC_DIR)/lib_max7219_controller/pkg_max7219_controller.vhd
src_vhd_lib_max7219_controller+=$(SRC_DIR)/lib_max7219_controller/max7219_mux_sel.vhd
src_vhd_lib_max7219_controller+=$(SRC_DIR)/lib_max7219_controller/max7219_display_sequencer.vhd
src_vhd_lib_max7219_controller+=$(SRC_DIR)/lib_max7219_controller/max7219_config_if.vhd
src_vhd_lib_max7219_controller+=$(SRC_DIR)/lib_max7219_controller/max7219_display_controller.vhd

src_vhd_lib_max7219_interface+=$(SRC_DIR)/lib_max7219_interface/pkg_max7219_interface.vhd
src_vhd_lib_max7219_interface+=$(SRC_DIR)/lib_max7219_interface/max7219_if.vhd
# ==========================




## == TESTBENCH FILES == ##

# == TB VHD FILES ==
src_tb_vhd+=$(TB_SRC_DIR)/tb_lib_max7219_scroller/load_ram_injector.vhd
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
#src_tb_v+=$(TB_SRC_DIR)/tb_lib_max7219_static/testbench_setup.sv
#src_tb_v+=$(TB_SRC_DIR)/tb_lib_max7219_static/clk_gen.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/MAX7219_checker/max7219_checker_pkg.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/MAX7219_checker/max7219_checker.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/MAX7219_checker/max7219_checker_wrapper.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/max7219_emul.sv
src_tb_v+=$(GENERIC_TB_SRC_DIR)/../TB_modules/max7219_matrix_emul.sv

#src_tb_v+=$(TB_SRC_DIR)/tb_lib_max7219_scroller/testbench_setup.sv
#src_tb_v+=$(TB_SRC_DIR)/tb_lib_max7219_scroller/clk_gen.sv


#src_tb_v+=$(TB_SRC_DIR)/tb_lib_max7219_controller/testbench_setup.sv
#src_tb_v+=$(TB_SRC_DIR)/tb_lib_max7219_controller/clk_gen.sv
# =================================

# == TB TOP ==

# TBD : different library

src_tb_static_v+=$(TB_SRC_DIR)/tb_lib_max7219_static/testbench_setup.sv
src_tb_static_v+=$(TB_SRC_DIR)/tb_lib_max7219_static/clk_gen.sv
src_tb_static_v+=$(TB_SRC_DIR)/tb_lib_max7219_static/tb_top.sv

src_tb_scroller_v+=$(TB_SRC_DIR)/tb_lib_max7219_scroller/testbench_setup.sv
src_tb_scroller_v+=$(TB_SRC_DIR)/tb_lib_max7219_scroller/clk_gen.sv
src_tb_scroller_v+=$(TB_SRC_DIR)/tb_lib_max7219_scroller/tb_top.sv

src_tb_controller_v+=$(TB_SRC_DIR)/tb_lib_max7219_controller/testbench_setup.sv
src_tb_controller_v+=$(TB_SRC_DIR)/tb_lib_max7219_controller/clk_gen.sv
src_tb_controller_v+=$(TB_SRC_DIR)/tb_lib_max7219_controller/tb_top.sv
# ============

## ===================== ##



## == COMPILE DESIGN == ##

compile_others:
	cd $(WORK_DIR); \
	$(foreach list, $(src_vhd_lib_others), $(vcom) -work $(LIB_OTHERS) $(list);) \
	$(foreach list, $(src_vhd_lib_others), $(vcom) -work $(LIB_TB_STATIC) $(list);) \
	$(foreach list, $(src_vhd_lib_others), $(vcom) -work $(LIB_TB_SCROLLER) $(list);) \
	$(foreach list, $(src_vhd_lib_others), $(vcom) -work $(LIB_TB_CONTROLLER) $(list);) \

compile_max7219_interface:
	cd $(WORK_DIR); \
	$(vcom) -work $(LIB_MAX7219_INTERFACE) $(SRC_DIR)/lib_max7219_interface/pkg_max7219_interface.vhd; \
	$(vcom) -work $(LIB_MAX7219_INTERFACE) $(SRC_DIR)/lib_max7219_interface/max7219_if.vhd; \
	$(vcom) -work $(LIB_TB_STATIC) $(SRC_DIR)/lib_max7219_interface/pkg_max7219_interface.vhd; \
	$(vcom) -work $(LIB_TB_STATIC) $(SRC_DIR)/lib_max7219_interface/max7219_if.vhd; \
	$(vcom) -work $(LIB_TB_SCROLLER) $(SRC_DIR)/lib_max7219_interface/pkg_max7219_interface.vhd; \
	$(vcom) -work $(LIB_TB_SCROLLER) $(SRC_DIR)/lib_max7219_interface/max7219_if.vhd; \
	$(vcom) -work $(LIB_TB_CONTROLLER) $(SRC_DIR)/lib_max7219_interface/pkg_max7219_interface.vhd; \
	$(vcom) -work $(LIB_TB_CONTROLLER) $(SRC_DIR)/lib_max7219_interface/max7219_if.vhd; \

compile_max7219_static:
	cd $(WORK_DIR); \
	$(foreach list, $(src_vhd_lib_max7219_static), $(vcom) -work $(LIB_MAX7219_STATIC) $(list);) \
	$(foreach list, $(src_vhd_lib_max7219_static), $(vcom) -work $(LIB_TB_STATIC) $(list);) \
	$(foreach list, $(src_vhd_lib_max7219_static), $(vcom) -work $(LIB_TB_CONTROLLER) $(list);) \

compile_max7219_scroller:
	cd $(WORK_DIR); \
	$(foreach list, $(src_vhd_lib_max7219_scroller), $(vcom) -work $(LIB_MAX7219_SCROLLER) $(list);) \
	$(foreach list, $(src_vhd_lib_max7219_scroller), $(vcom) -work $(LIB_TB_SCROLLER) $(list);) \
	$(foreach list, $(src_vhd_lib_max7219_scroller), $(vcom) -work $(LIB_TB_CONTROLLER) $(list);) \

compile_max7219_controller:
	cd $(WORK_DIR); \
	$(foreach list, $(src_vhd_lib_max7219_controller), $(vcom) -work $(LIB_MAX7219_CONTROLLER) $(list);) \
	$(foreach list, $(src_vhd_lib_max7219_controller), $(vcom) -work $(LIB_TB_CONTROLLER) $(list);) \



# Compile Design Library here
compile_design : compile_others compile_max7219_interface compile_max7219_static compile_max7219_scroller compile_max7219_controller


## ==================== ##


## == COMPILE TESTBENCH == ##

# == TB COMPILES VHD FILES ==
compile_tb_vhd_files :
	cd $(WORK_DIR); \
	$(foreach list, $(src_tb_vhd), $(vcom) -work $(LIB_TB_TOP) $(list);) \
	$(foreach list, $(src_tb_vhd), $(vcom) -work $(LIB_TB_STATIC) $(list);) \
	$(foreach list, $(src_tb_vhd), $(vcom) -work $(LIB_TB_SCROLLER) $(list);) \
	$(foreach list, $(src_tb_vhd), $(vcom) -work $(LIB_TB_CONTROLLER) $(list);) \
# ===========================

# == COMPILES GENERIC V FILES ==
compile_generic_tb_v_files :
	cd $(WORK_DIR); \
	$(foreach list, $(src_gen_tb_v), $(vlog) -work $(LIB_TB_TOP) $(list);) \
	$(foreach list, $(src_gen_tb_v), $(vlog) -work $(LIB_TB_STATIC) $(list);) \
	$(foreach list, $(src_gen_tb_v), $(vlog) -work $(LIB_TB_SCROLLER) $(list);) \
	$(foreach list, $(src_gen_tb_v), $(vlog) -work $(LIB_TB_CONTROLLER) $(list);) \
# ==============================

# == COMPILES TB V FILES ==
compile_tb_v_files :
	cd $(WORK_DIR); \
	$(foreach list, $(src_tb_v), $(vlog) -work $(LIB_TB_TOP) $(list);) \
	$(foreach list, $(src_tb_v), $(vlog) -work $(LIB_TB_STATIC) $(list);) \
	$(foreach list, $(src_tb_v), $(vlog) -work $(LIB_TB_SCROLLER) $(list);) \
	$(foreach list, $(src_tb_v), $(vlog) -work $(LIB_TB_CONTROLLER) $(list);) \
	$(foreach list, $(src_tb_static_v), $(vlog) -work $(LIB_TB_STATIC) $(list);) \
	$(foreach list, $(src_tb_scroller_v), $(vlog) -work $(LIB_TB_SCROLLER) $(list);) \
	$(foreach list, $(src_tb_controller_v), $(vlog) -work $(LIB_TB_CONTROLLER) $(list);) \


# == COMPILE ALL TESTBENCH files ==
compile_testbench : compile_tb_vhd_files compile_generic_tb_v_files compile_tb_v_files
# =======================

##======================= ##


# == COMPILE ALL ==
compile_all : clean libs compile_design compile_testbench
# =================


# == RUN TEST ==
run_tb_max7219_static :
	cd $(WORK_DIR); \
	$(vsim) $(VSIM_ARGS) $(LIB_TB_STATIC).tb_top -l $(TRANSCRIPTS_DIR)/$(TEST)_transcript.txt $(VSIM_G_ARGS)scn_lib_max7219_static/$(TEST).txt -do $(RUN_DO_DIR)/$(TEST)_run.do;
	#$(vsim) $(VSIM_ARGS) $(LIB_TB_TOP).tb_top -l $(TRANSCRIPTS_DIR)/$(TEST)_transcript.txt $(VSIM_G_ARGS)scn_lib_max7219_static/$(TEST).txt -do $(RUN_DO_DIR)/$(TEST)_run.do;


run_tb_max7219_scroller :
	cd $(WORK_DIR); \
	$(vsim) $(VSIM_ARGS) $(LIB_TB_SCROLLER).tb_top -l $(TRANSCRIPTS_DIR)/$(TEST)_transcript.txt $(VSIM_G_ARGS)scn_lib_max7219_scroller/$(TEST).txt -do $(RUN_DO_DIR)/$(TEST)_run.do;


run_tb_max7219_controller :
	cd $(WORK_DIR); \
	$(vsim) $(VSIM_ARGS) $(LIB_TB_CONTROLLER).tb_top -l $(TRANSCRIPTS_DIR)/$(TEST)_transcript.txt $(VSIM_G_ARGS)scn_lib_max7219_controller/$(TEST).txt -do $(RUN_DO_DIR)/$(TEST)_run.do;

# ==============

# == RUN ALL TEST ==
run_max7219_static_tests :
	$(foreach list, $(STATIC_SCN_LIST), make run_tb_max7219_static TEST=$(list);)

run_max7219_scroller_tests :
	$(foreach list, $(SCROLLER_SCN_LIST), make run_tb_max7219_scroller TEST=$(list);)

run_max7219_controller_tests :
	$(foreach list, $(CONTROLLER_SCN_LIST), make run_tb_max7219_controller TEST=$(list);)


##################################################


## Symbolator - Generate Symbole from Packages ##

# Lib_max7219_interface
I_DIR_SRC_INTERFACE=~/GitHub/VHDL_code/MAX7219/sources/lib_max7219_interface
O_DIR_PNG_INTERFACE=~/GitHub/VHDL_code/MAX7219/docs/images/images_lib_max_7219_interface

# Lib_max7219_static
I_DIR_SRC_STATIC=~/GitHub/VHDL_code/MAX7219/sources/lib_max7219_static
O_DIR_PNG_STATIC=~/GitHub/VHDL_code/MAX7219/docs/images/images_lib_max_7219_static

# Lib_max7219_scroller
I_DIR_SRC_SCROLLER=~/GitHub/VHDL_code/MAX7219/sources/lib_max7219_scroller
O_DIR_PNG_SCROLLER=~/GitHub/VHDL_code/MAX7219/docs/images/images_lib_max_7219_scroller

# Image in PNg format with transparent background
symbolator_generate_png:
	symbolator -i $(I_DIR_SRC_INTERFACE) -o $(O_DIR_PNG_INTERFACE) -f PNG -t
	symbolator -i $(I_DIR_SRC_STATIC) -o $(O_DIR_PNG_STATIC) -f PNG -t
	symbolator -i $(I_DIR_SRC_SCROLLER) -o $(O_DIR_PNG_SCROLLER) -f PNG -t
#################################################
