#
#	Makefile for Compilation & Simulation with modelsim
#

# Repository Organization
# /(ROOT)
# 	|__ /scripts        => Scripts - Makefile
#	|__ /sources        => Design VHD - V files
#	|__ /tb_sources     => TestBench  files
#	|__ /do_files       => Do Files
#	     |__ /run_files => Run .do
#	     |__ /waves     => Waves .do

# MAKEFILE for MAX7219 Tests

# 
ROOT=$(PWD)/..
WORK_DIR_NAME=MAX7219_WORK
WORK_DIR=$(ROOT)/$(WORK_DIR_NAME)

# == SOURCES DIRECTORY ==
SRC_DIR=$(ROOT)/sources
SRC_RAM_VHD=$(ROOT)/../RAM/TDPRAM
TB_SRC_DIR=$(ROOT)/tb_sources
TB_V_SRC_DIR=$(ROOT)/../../Verilog/TB_modules
SRC_MISC_VHD=$(ROOT)/../MISC/Digits_decod
SRC_ALG_VHD=$(ROOT)/../Algorithm/Integer_division

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

# Library List
LIB_1=lib_max7219
#LIB_2=lib_2
LIB_TB_TOP=lib_tb_top



# .vhd file compilation
#VCOM1=$(vcom) -nologo -work



# .v file compilation
#VLOG1=$(vlog) -nologo -work



all: 
	@echo ""
	@echo "Makefile for compilation & Simulation with Modelsim"
	@echo ""
	@echo "MAX7219 Tests & Simulation"
	@echo ""
	@echo "======     PROJECT CONFIGURATION      ======"
	@echo "- Create Work Directory : "
	@echo "make create_dir"
	@echo ""
	@echo "- Clean work repository : "
	@echo "make clean"
	@echo ""
	@echo "- Prepare Modelsim Library :"
	@echo "make libs"
	@echo ""
	@echo "============================================"
	@echo ""
	@echo ""
	@echo "====== SOURCES COMPILATIONS           ======"
	@echo "- Compile Design - VHD files :"
	@echo "make compile_vhd_src"
	@echo ""
	@echo "- Compile Design - V files :"
	@echo "make compile_v_src"
	@echo ""
	@echo "- Compile TestBench sources - VHD files :"
	@echo "make compile_tb_vhd_src"
	@echo ""
	@echo "- Compile all :"
	@echo "make compile_all"
	@echo ""
	@echo "============================================"
	@echo ""
	@echo ""
	@echo "======     RUN TESTS MAX7219          ======"
	@echo "- Run test : MAX7219_CMD_DECOD :"
	@echo "make run_test_max7219_cmd_decod"
	@echo ""
	@echo "- Run test : MAX7219_MATRIX_DISPLAY"
	@echo "make run_test_max7219_matrix_display"
	@echo ""
	@echo "- Run test : UINT DIVISION"
	@echo "make run_test_uint_division"
	@echo "============================================"



# == PREPARE PROJECT ==
create_dir:
	cd $(ROOT); \
	mkdir $(WORK_DIR_NAME);
# ======================


# == CLEAN PROJECT ==
clean:
	cd $(WORK_DIR); \
	rm -rRf *;
# ====================


# == PREPARE MODELSIM LIBRARY ==
prepare_libs:
	cd $(WORK_DIR); \
	$(vlib) ./${LIB_1}; \
	$(vlib) ./$(LIB_TB_TOP);

create_libs:
	cd $(WORK_DIR); \
	$(vmap) $(LIB_TB_TOP) ./$(LIB_1);		

libs:  prepare_libs create_libs
# =============================


# == VHD FILES LIST ==
src_vhd=	$(SRC_DIR)/pkg_max7219.vhd \
		$(SRC_DIR)/max7219_if.vhd \
		$(SRC_DIR)/max7219_ram_decod.vhd \
		$(SRC_RAM_VHD)/tdpram_sclk.vhd \
		$(SRC_DIR)/max7219_cmd_decod.vhd \
		$(SRC_DIR)/max7219_ram_sequencer.vhd\
		$(SRC_DIR)/max7219_display_manager.vhd \
		$(SRC_DIR)/max7219_config_matrix.vhd \
		$(SRC_DIR)/max7219_digit2conf.vhd \
		$(SRC_DIR)/max7219_cmd_organizer.vhd \
		$(SRC_ALG_VHD)/uint_division.vhd \
		$(SRC_MISC_VHD)/digits_decod_shift.vhd \
		$(SRC_DIR)/max7219_matrix_display.vhd \


src_tb_vhd=	$(TB_SRC_DIR)/test_max7219_cmd_decod.vhd \
		$(TB_SRC_DIR)/test_max7219_matrix_display.vhd \
		$(SRC_MISC_VHD)/test_digits_decod.vhd \
		$(SRC_ALG_VHD)/test_uint_division.vhd
# =====================


# == V FILES LIST ==
src_v=		$(SRC_DIR)/file_1.v \
		$(SRC_DIR)/file_2.v \
		$(SRC_DIR)/file_3.v \
		$(SRC_DIR)/file_4.v

src_tb_v=	$(TB_V_SRC_DIR)/max7219_emul.sv \
		$(TB_V_SRC_DIR)/max7219_display_n_matrix.sv
# ==================


# == COMPIlES VHD SOURCES FILES ==
compile_vhd_src :
	cd $(WORK_DIR); \
	$(vcom) -work  ${LIB_1} $(src_vhd);


compile_tb_vhd_src :
	cd $(WORK_DIR); \
	$(vcom) -work $(LIB_TB_TOP) $(src_tb_vhd);
# ================================

# == COMPILES V FILES ==
compile_tb_v_files :
	cd $(WORK_DIR); \
	$(vlog) -work $(LIB_TB_TOP) $(src_tb_v)
# ======================

compile_all: clean libs compile_vhd_src compile_tb_v_files compile_tb_vhd_src

# == TEST1 ==
entity_test1=test_max7219_cmd_decod
run_test1=run_max7219_cmd_decod.do
trans_test1=test_max7219_cmd_decod.txt
wave_test1=wave_test_max7219_cmd_decod
run_test_max7219_cmd_decod : clean libs compile_vhd_src compile_tb_v_files compile_tb_vhd_src
	cd $(WORK_DIR); \
	$(vsim)  -novopt -t ps -wlf $(WLF_DIR)/$(wave_test1).wlf $(LIB_TB_TOP).$(entity_test1) -l $(TRANSCRIPTS_DIR)/$(trans_test1) -do $(RUN_DO_DIR)/$(run_test1);
# ===========


# TEST 2
# == TEST MATRIX DISPLAY ==
entity_test2=test_max7219_matrix_display
run_test2=run_max7219_matrix_display.do
trans_test2=test_max7219_matrix_display.txt
wave_test2=wave_test_max7219_matrix_display
run_test_max7219_matrix_display : clean libs compile_vhd_src compile_tb_v_files compile_tb_vhd_src
	cd $(WORK_DIR); \
	$(vsim)  -novopt -t ps -wlf $(WLF_DIR)/$(wave_test2).wlf $(LIB_TB_TOP).$(entity_test2) -l $(TRANSCRIPTS_DIR)/$(trans_test2) -do $(RUN_DO_DIR)/$(run_test2);

# =========================

# TEST 3
# == TEST UINT DIVISION ==
entity_test3=test_uint_division
run_test3=run_uint_division.do
trans_test3=test_uint_division.txt
wave_test3=wave_test_uint_division
run_test_uint_division : clean libs compile_vhd_src compile_tb_v_files compile_tb_vhd_src
	cd $(WORK_DIR); \
	$(vsim)  -novopt -t ps -wlf $(WLF_DIR)/$(wave_test3).wlf $(LIB_TB_TOP).$(entity_test3) -l $(TRANSCRIPTS_DIR)/$(trans_test3); # -do $(RUN_DO_DIR)/$(run_test3);

# ========================

# Launch modelsim Simulation in console
run_csl_1 : 	compile_vhd_src
		cd $(WORK_DIR); \
		vsim -c -wlf wave.wlf -t ps $(LIB_TB_TOP).arch_vhd  -l transcript.txt -do $(SCRIPTS_DIR)/run.do;
