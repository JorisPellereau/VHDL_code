############################################
#
#	Makefile for test unitary test
#
############################################




ROOT=$(PWD)/..
WORK_DIR=$(ROOT)/work
SRC_DIR=$(ROOT)/sources
SCRIPTS_DIR=$(ROOT)/scripts


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

