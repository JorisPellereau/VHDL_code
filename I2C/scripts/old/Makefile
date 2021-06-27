############################################
#
#	Makefile for i2c test
#
############################################




ROOT=$(PWD)/..
WORK_DIR=$(ROOT)/work
SRC_DIR=$(ROOT)/sources
SCRIPTS_DIR=$(ROOT)/scripts


# ==  LIB LIST ==
LIB_1=lib_i2c
LIB_TB_TOP=tb_lib_top
# ================

# == VCOM config ==
VCOM1=vcom -nologo -work
# =================

# == VLOG config ==
VLOG1=vlog -nologo -work
# ================


all: echo "Hello test i2c"


# == CREATE WORK DIR. ==
create_dir:
	cd $(ROOT); \
	mkdir work;

clean:
	cd $(WORK_DIR); \
	rm -rRf *;

# == PREPARE LIBRARY ==
prepare_libs:
	cd $(WORK_DIR); \
	vlib ./${LIB_1}; \
	vlib ./$(LIB_TB_TOP);
	
create_libs:
	cd $(WORK_DIR); \
	vmap $(LIB_TB_TOP) ./$(LIB_1);	

 
#create_dir
libs:  prepare_libs create_libs
# ===========================================

src=    $(SRC_DIR)/pkg_i2c.vhd \
	$(SRC_DIR)/master_i2c.vhd \
	$(SRC_DIR)/test_master_i2c.vhd


compile_src : 
	cd $(WORK_DIR); \
	$(VCOM1) $(LIB_TB_TOP) $(src);
	
run_1 :
	cd $(WORK_DIR); \
	vsim  -novopt -t ps $(LIB_TB_TOP).test_master_i2c  -l transcript.txt -do $(SCRIPTS_DIR)/run.do;

run_test1: clean libs compile_src run_1

