# ========================================== #
#
# Makefile for MISC blocks tests
#
# ========================================== #

# MakefileInel Configuration

QUARTUS_PATH=/opt/Quartus/Quartus_20_1_1_nios_eds/quartus/bin
Q_PROJECT_NAME=proj_bascule_d
Q_PROJECT_PATH=/home/linux-jp/QUARTUS_PROJECTS/tests

REVISION=REV0
FAMILY=CYCLONEIV
DEVICE=EP4CE115F29C7
TOP_ENTITY=bascule_d

EN_SH_SCRIPT=OFF
SH_SCRIPT=/home/linux-jp/Documents/GitHub/VHDL_code/MISC/scripts/pin_assignments.tcl

all: print_generic_rules
	@echo ""
	@echo "Makefile for MISC blocks tests"
	@echo ""


sh_test:
	make qsh

DESIGN_FILE=/home/linux-jp/Documents/GitHub/VHDL_code/MISC/bascule_d.vhd
EFFORT=auto
ENABLE_WYSIWYG_RESYNTHESIS=OFF
FAMILY=CYCLONEIVE
IGNORE_CARRY_BUFFER=off
IGNORE_CASCADE_BUFFERS=off
INCREMENTAL_COMPILATION=full_incremental_compilation
OPTIMIZE=balanced
PARALLEL=ON
SYNTH_SRC_LIST=$(DESIGN_FILE)

map_test:
	make qmap

EARLY_TIMING_ESTIMATE=realistic
FIT_EFFORT=auto
FMAX=50mhz
INNER_NUM=1
ONE_FIT_ATTEMPT=off
OPTIMIZE_IO_REGISTER_FOR_TIMING=on
PACK_REGISTER=auto
SEED=1
TCO_TIME=10 ns
TDC=ON
TPD_TIME=10 ns
TSU_TIME=10 ns
#CHECK_NETLIST=ON

fit_test:
	make qfit


MODEL=slow
MULTICORNER=on
SDC_FILE=
SPEED=50 mhz
TEMPERATURE_IN_C=25
VOLTAGE=1200

sta_test:
	make qsta


include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGeneric
include ~/Documents/GitHub/VHDL_code/Makefile/MakefileIntel
