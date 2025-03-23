# ========================================== #
#
# Makefile for MISC blocks tests
#
# ========================================== #

# Intel Tools Path
INTEL_TOOL_PATH = /home/linux-jp/Documents/GitHub/Python/FPGA_environment/

# MakefileInel Configuration

QUARTUS_PATH=/opt/Quartus/Quartus_20_1_1_nios_eds/quartus/bin
Q_PROJECT_NAME=synth_blocks
Q_PROJECT_PATH=/home/linux-jp/QUARTUS_PROJECTS/tests

REVISION=REV0
FAMILY=CYCLONEIV
DEVICE=EP4CE115F29C7
TOP_ENTITY=synth_blocks

EN_SH_SCRIPT=ON
SH_SCRIPT=/home/linux-jp/Documents/GitHub/VHDL_code/MISC/scripts/pin_assignments.tcl

all: print_generic_rules
	@echo ""
	@echo "Makefile for MISC blocks tests"
	@echo ""


sh_test:
	make qsh

sh_script_test:
	make qsh_script

DESIGN_FILE=/home/linux-jp/Documents/GitHub/VHDL_code/MISC/synth_blocks.vhd
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

READ_SETTINGS_FILES=off

asm_test:
	make qasm

MODEL=slow
MULTICORNER=ON
SDC_FILE=/home/linux-jp/Documents/GitHub/VHDL_code/MISC/scripts/synth_blocks.sdc
SPEED=7
TEMPERATURE_IN_C=25
#
VOLTAGE=7_slow_1200mv_85c

sta_test:
	make qsta


CHECK_CONSTRAINTS=both
COMBINED_MODEL=on
DATASHEET_FILE_NAME=
DO_MIN_ANALYSIS=on
FAST_MODEL=on
TAO_FILE_NAME=
TCO_TIME_TAN=
TH_TIME_TAN=
TPD_TIME_TAN=
TSU_TIME_TAN=

tan_test:
	make qtan


all_flow:
	rm -r /home/linux-jp/QUARTUS_PROJECTS/tests/*
	make sh_test
	make sh_script_test
	make map_test
	make fit_test


create_project_file:
	python3 $(INTEL_TOOL_PATH)/intel_tools.py --create_project_file $(FAMILY) $(REVISION) $(Q_PROJECT_NAME) qproject.tcl

#include ~/Documents/GitHub/VHDL_code/Makefile/MakefileGeneric
include /home/linux-jp/Documents/GitHub/Generics_Makefiles/Makefiles/MakefileIntel
