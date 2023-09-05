# ========================================== #
#
# Makefile for PR115 blocks tests
#
# ========================================== #

# ========================================== #
# Author  : J.P
# Date    : 17/04/2021
# Version : 2.0
#         - Ajout MakefileGeneric
# ========================================== #

# -- INCLUDES --
include /home/linux-jp/Documents/GitHub/Generics_Makefiles/Makefiles/MakefileGeneric
include /home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/makefiles/generic_modules_files.mk
# --------------

# == Makefile Configuration ==
SEL_STATION=LINUX
ROOT=$(PWD)/..
PROJECT_NAME=PR_115
WORK_DIR=PR115_WORK
TRANSCRIPT_EN=OFF
# ============================

# == ZIPCPU ==
CC      := /home/linux-jp/Documents/GitHub/zipcpu/sw/install/cross-tools/bin/zip-gcc
CPP     := /home/linux-jp/Documents/GitHub/zipcpu/sw/install/cross-tools/bin/zip-cpp
AS      := /home/linux-jp/Documents/GitHub/zipcpu/sw/install/cross-tools/bin/zip-as
LD      := /home/linux-jp/Documents/GitHub/zipcpu/sw/install/cross-tools/bin/zip-ld
OBJDUMP := /home/linux-jp/Documents/GitHub/zipcpu/sw/install/cross-tools/bin/zip-objdump
# ============



# == SOURCES DIRECTORY ==
SRC_ZIPCPU_VHD_DIR=~/Documents/GitHub/VHDL_code/PR_115/sources
SRC_ZIPCPU_DIR=~/Documents/GitHub/zipcpu/rtl
SRC_WBUART32_DIR=~/Documents/GitHub/wbuart32/rtl
SRC_LIB_WISHBONE_VHD_DIR=~/Documents/GitHub/VHDL_code/WISHBONE/sources/lib_wishbone
# =======================

# == DESIGN LIBRARIES ==
LIB_ZIPCPU=lib_zipcpu
LIB_WISHBONE=lib_wishbone
# ======================

# == TESTBENCH LIBRARIES ==
LIB_TB_ZIPCPU+=tb_lib_zipcpu
# =========================

# ==  LIB LIST ==
LIB_LIST+=$(LIB_ZIPCPU)
LIB_LIST+=$(LIB_TB_ZIPCPU)
LIB_LIST+=$(LIB_WISHBONE)
# ================



all: print_generic_rules
	@echo ""
	@echo "Makefile for PR115 blocks tests"
	@echo ""
	@echo "== SOURCES COMPILATIONS =="
	@echo ""
	@echo "- Compile Design & Testbench :"
	@echo "make compile_zipcpu"
	@echo "=========================="



SCN_LIB_DIR=scn_lib_zipcpu
LIB_TB_TOP=$(LIB_TB_ZIPCPU)

# == DESIGN VHD FILE LIST ==
src_lib_zipcpu_vhd+=$(SRC_ZIPCPU_VHD_DIR)/lib_zipcpu/zip_cpu_wrapper.vhd

src_lib_wishbone_vhd=$(SRC_LIB_WISHBONE_VHD_DIR)/wb_slv_memory.vhd

# ==========================

# == DESIGN V FILE LIST ==

# == WishBone UART ==
src_lib_zipcpu_v+=$(SRC_WBUART32_DIR)/axiluart.v
src_lib_zipcpu_v+=$(SRC_WBUART32_DIR)/rxuartlite.v
src_lib_zipcpu_v+=$(SRC_WBUART32_DIR)/rxuart.v
src_lib_zipcpu_v+=$(SRC_WBUART32_DIR)/skidbuffer.v
src_lib_zipcpu_v+=$(SRC_WBUART32_DIR)/txuartlite.v
src_lib_zipcpu_v+=$(SRC_WBUART32_DIR)/txuart.v
src_lib_zipcpu_v+=$(SRC_WBUART32_DIR)/ufifo.v
src_lib_zipcpu_v+=$(SRC_WBUART32_DIR)/wbuart-insert.v
src_lib_zipcpu_v+=$(SRC_WBUART32_DIR)/wbuart.v
# ===================

# == ZIPCPU FILES ==
# Compile ex files
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/ex/fwb_counter.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/ex/fwb_master.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/ex/fwb_slave.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/ex/sfifo.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/ex/skidbuffer.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/ex/wbarbiter.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/ex/wbdblpriarb.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/ex/wbpriarbiter.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/ex/busdelay.v

# Compile core files
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/axidcache.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/axiicache.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/axilfetch.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/axilops.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/axilpipe.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/axiops.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/axipipe.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/cpuops.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/dblfetch.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/dcache.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/div.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/idecode.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/iscachable.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/memops.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/mpyop.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/pfcache.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/pipefetch.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/pipemem.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/prefetch.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/slowmpy.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/zipcore.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/core/zipwb.v

# Compile peripherals
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/peripherals/axilperiphs.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/peripherals/icontrol.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/peripherals/wbdmac.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/peripherals/wbwatchdog.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/peripherals/zipcounter.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/peripherals/zipjiffies.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/peripherals/zipmmu.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/peripherals/ziptimer.v

# Compile ZipDMA
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/zipdma/zipdma_ctrl.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/zipdma/zipdma_fsm.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/zipdma/zipdma_mm2s.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/zipdma/zipdma_rxgears.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/zipdma/zipdma_s2mm.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/zipdma/zipdma_txgears.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/zipdma/zipdma.v


# Compile zipcpu
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/cpudefs.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/zipaxil.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/zipaxi.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/zipbones.v
src_lib_zipcpu_v+=$(SRC_ZIPCPU_DIR)/zipsystem.v
# ========================

# ZIPCPU Macro
# - Zipsystem Macros :
# -> VERILATOR
# -> VBENCH_TB
# -> OPT_MMU
# -> FORMAL



# == Specific Testbench File List ==
src_tb_lib_zipcpu_v+=$(TB_SRC_DIR)/tb_lib_zipcpu/testbench_setup.sv
src_tb_lib_zipcpu_v+=$(TB_SRC_DIR)/tb_lib_zipcpu/clk_gen.sv
src_tb_lib_zipcpu_v+=$(TB_SRC_DIR)/tb_lib_zipcpu/tb_top.sv
# ==================================


## == COMPILE DESIGN == ##
compile_wishbone_src:
	make compile_design_vhd_files SRC_VHD="$(src_lib_wishbone_vhd)" VHD_DESIGN_LIB=$(LIB_WISHBONE)

compile_zipcpu:
	make compile_design_v_files SRC_V="$(src_lib_zipcpu_v)" V_DESIGN_LIB=$(LIB_ZIPCPU)
	make compile_design_vhd_files SRC_VHD="$(src_lib_zipcpu_vhd)" VHD_DESIGN_LIB=$(LIB_ZIPCPU)

# == Compile Design Library here ==
compile_design : compile_wishbone_src compile_zipcpu
# ================================


## == COMPILE TESTBENCH == ##
compile_generic_tb_v_files:
	make compile_tb_v_files SRC_TB_V="$(src_gen_tb_v)" TB_LIB_TOP=$(LIB_TB_ZIPCPU)


 compile_testbench_sources:
	make compile_tb_v_files SRC_TB_V="$(src_tb_lib_zipcpu_v)" TB_LIB_TOP=$(LIB_TB_ZIPCPU)


# == COMPILE ALL TESTBENCH files ==
compile_all_zipcpu : compile_design compile_generic_tb_v_files compile_testbench_sources
# =======================

#compile_all_uart_display_ctrl: compile_design compile_testbench print_compile_logs_file

# == SCENARII LIST ==
SCN_LIST+=ZIPCPU_00.py

# =======================

# == LIB ARGS ==
LIB_ARGS=-L lib_zipcpu -L lib_wishbone
# ==============


# == RUN TEST ==
run_zipcpu_test:
	make run_test TRANSCRIPT_EN=ON DO_FILES_EN=ON
# ==============

compile_s: 
	$(AS) test.s -o test.o

disasemble:
	$(OBJDUMP) -S -D -g test.o

#include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGeneric
#include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGHDL
#include ~/Documents/GitHub/VHDL_code/Makefile/MakefileSonarqube
