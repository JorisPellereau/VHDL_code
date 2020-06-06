#
#	Makefile for Compilation & Simulation with modelsim
#

# Repository Organization
# /(ROOT)
# 	|__ /scripts => Makefile
#	|__ /sources => VHD - V files
#	|__ /work    => Modelsim Libs



# 
ROOT=$(PWD)/..
WORK_DIR=$(ROOT)/work
SRC_DIR=$(ROOT)/sources
SCRIPTS_DIR=$(ROOT)/scripts


# Library List
LIB_1=lib_1
LIB_2=lib_2
LIB_TB_TOP=lib_tb_top



# .vhd file compilation
VCOM1=vcom -nologo -work



# .v file compilation
VLOG1=vlog -nologo -work



all: 
	@echo "Makefile for compilation & Simulation with Modelsim"
	@echo ""
	@echo "Clean work reposotory : "
	@echo "make clean"
	@echo ""
	@echo "Prepare Modelsim Library :"
	@echo "make libs"
	@echo ""
	@echo "Compile VHD files :"
	@echo "make compile_vhd_src"
	@echo ""
	@echo "Compile V files :"
	@echo "make compile_v_src"
	@echo ""
	@echo "Run VHD simulation :"
	@echo "make run_vhd_1"


# create work dir
create_dir:
	cd $(ROOT); \
	mkdir work;

# Delete files inside work dir.
clean:
	cd $(WORK_DIR); \
	rm -rRf *;


# prepare Modelsim Library
prepare_libs:
	cd $(WORK_DIR); \
	vlib ./${LIB_1}; \
	vlib ./${LIB_2}; \
	vlib ./$(LIB_TB_TOP);

create_libs:
	cd $(WORK_DIR); \
	vmap $(LIB_TB_TOP) ./$(LIB_1);	
	vmap $(LIB_TB_TOP) ./$(LIB_2);	


# prepare and create_dir
libs:  prepare_libs create_libs


# List of vhd file
src_vhd=	$(SRC_DIR)/file_1.vhd \
		$(SRC_DIR)/file_2.vhd \
		$(SRC_DIR)/file_3.vhd \
		$(SRC_DIR)/file_4.vhd


# List of v file
src_v=		$(SRC_DIR)/file_1.v \
		$(SRC_DIR)/file_2.v \
		$(SRC_DIR)/file_3.v \
		$(SRC_DIR)/file_4.v




# Compile vhd files in LIB_TB_TOP
compile_vhd_src : clean libs
	cd $(WORK_DIR); \
	$(VCOM1) $(LIB_TB_TOP) $(src_vhd);


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