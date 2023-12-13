# -- INCLUDES --
include /home/linux-jp/Documents/GitHub/Generics_Makefiles/Makefiles/MakefileGeneric
include /home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/makefiles/generic_modules_files.mk
include /home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/makefiles/tb_modules_lib_path.mk
include /home/linux-jp/Documents/GitHub/RTL_Testbench/scripts/makefiles/axi4lite_master_files.mk
#include MakefileAXI4_lite.mk
include MakefileAXI4_lite_MAX7219.mk
# --------------



# -- MODELSIM Configuration --
vsim=/opt/Modelsim/modelsim_ase/bin/vsim
vlib=/opt/Modelsim/modelsim_ase/linuxaloem/vlib
vmap=/opt/Modelsim/modelsim_ase/linuxaloem/vmap
vcom=/opt/Modelsim/modelsim_ase/linuxaloem/vcom
vlog=/opt/Modelsim/modelsim_ase/linuxaloem/vlog
# ----------------------------


all:
	echo "Main Makefile of AXI4 Lite"


create_simulation_dir_max7219:
	make create_simulation_dir PROJECT_NAME=AXI4_LITE_MAX7219 WORK_DIR=AXI4_LITE_MAX7219_WORK



