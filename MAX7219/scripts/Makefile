#
#	Makefile for Compilation & Simulation with modelsim
#

# Repository Organization
# /(ROOT)
# 	|__ /scripts    => Scripts - Makefile
#	|__ /sources    => Design VHD - V files
#	|__ /tb_sources => TestBench  files
#	|__ /do_files   => Do Files

# MAKEFILE for MAX7219 Tests

# 
ROOT=$(PWD)/..
WORK_DIR_NAME=MAX7219_WORK
WORK_DIR=$(ROOT)/$(WORK_DIR_NAME)
SRC_DIR=$(ROOT)/sources
SRC_RAM_VHD=$(ROOT)/../RAM/TDPRAM
SCRIPTS_DIR=$(ROOT)/scripts

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
	@echo "Makefile for compilation & Simulation with Modelsim"
	@echo ""
	@echo "MAX7219 Tests & Simulation"
	@echo ""
	@echo ""
	@echo "- Create Work Directory : "
	@echo "make create_dir"
	@echo ""
	@echo "- Clean work repository : "
	@echo "make clean"
	@echo ""
	@echo "- Prepare Modelsim Library :"
	@echo "make libs"
	@echo ""
	@echo "- Compile Design - VHD files :"
	@echo "make compile_vhd_src"
	@echo ""
	@echo "- Compile V files :"
	@echo "make compile_v_src"
	@echo ""
	@echo "Run VHD simulation :"
	@echo "make run_vhd_1"


# create work dir
create_dir:
	cd $(ROOT); \
	mkdir $(WORK_DIR_NAME);

# Delete files inside work dir.
clean:
	cd $(WORK_DIR); \
	rm -rRf *;


# prepare Modelsim Library
prepare_libs:
	cd $(WORK_DIR); \
	$(vlib) ./${LIB_1}; \
	$(vlib) ./$(LIB_TB_TOP);

create_libs:
	cd $(WORK_DIR); \
	$(vmap) $(LIB_TB_TOP) ./$(LIB_1);		


# prepare and create_dir
libs:  prepare_libs create_libs


# List of vhd file
src_vhd=	$(SRC_DIR)/pkg_max7219.vhd \
		$(SRC_DIR)/max7219_if.vhd \
		$(SRC_DIR)/max7219_ram_decod.vhd \
		$(SRC_RAM_VHD)/tdpram_sclk.vhd \
		$(SRC_DIR)/max7219_cmd_decod.vhd


# List of v file
src_v=		$(SRC_DIR)/file_1.v \
		$(SRC_DIR)/file_2.v \
		$(SRC_DIR)/file_3.v \
		$(SRC_DIR)/file_4.v




# Compile vhd files in LIB_TB_TOP
compile_vhd_src :
	cd $(WORK_DIR); \
	$(vcom) -work  ${LIB_1} $(src_vhd);


# Compile v files in LIB_TB_TOP
compile_v_src : clean libs
	cd $(WORK_DIR); \
	$(VLOG1) $(LIB_TB_TOP) $(src_v);


# Launch VHD simulation in GUI
run_vhd_1 :	compile_vhd_src
		cd $(WORK_DIR); \
		vsim  -novopt -t ps $(LIB_TB_TOP).arch_vhd  -l transcript.txt -do $(SCRIPTS_DIR)/run.do;

# Launch modelsim Simulation in console
run_csl_1 : 	compile_vhd_src
		cd $(WORK_DIR); \
		vsim -c -wlf wave.wlf -t ps $(LIB_TB_TOP).arch_vhd  -l transcript.txt -do $(SCRIPTS_DIR)/run.do;
