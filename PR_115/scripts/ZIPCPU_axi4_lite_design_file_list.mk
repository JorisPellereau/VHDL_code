# == DESIGN VHD FILE LIST ==

# -- Design DIR PATH --
# /!\ : add a '/' at the end of the DIR path !
SRC_UTILS_DIR                = /home/linux-jp/Documents/GitHub/VHDL_code/PKG/sources/lib_pkg_utils/
SRC_AXI4_LITE_DIR            = /home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite/
SRC_LIB_7SEG                 = /home/linux-jp/Documents/GitHub/VHDL_code/PR_115/sources/lib_seg7/
SRC_AXI4_LITE_7SEG_DIR       = /home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite_7seg/
SRC_PULSE_EXTENDER_DIR       = /home/linux-jp/Documents/GitHub/VHDL_code/UTILS/sources/lib_pulse_extender/
SRC_LCD_DIR                  = /home/linux-jp/Documents/GitHub/VHDL_code/LCD/LCD_CFAH1602BTMCJP/sources/lib_CFAH1602_v2/
SRC_AXI4_LITE_LCD_DIR        = /home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite_lcd/
SRC_AXI4_LITE_MEMORY_DIR     = /home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite_memory/
SRC_RESET_GEN_DIR            = /home/linux-jp/Documents/GitHub/VHDL_code/RESET/sources/
SRC_LIB_RAM_INTEL_DIR        = /home/linux-jp/Documents/GitHub/VHDL_code/RAM/sources/lib_ram_intel/
SRC_LIB_FIFO_DIR             = /home/linux-jp/Documents/GitHub/VHDL_code/FIFO/sources/lib_fifo/
SRC_LIB_FIFO_WRAPPER_DIR     = /home/linux-jp/Documents/GitHub/VHDL_code/FIFO/sources/lib_fifo_wrapper/
SRC_LIB_ROM_INTEL_DIR        = /home/linux-jp/Documents/GitHub/VHDL_code/ROM/sources/lib_rom_intel/
SRC_LIB_JTAG_INTEL_DIR       = /home/linux-jp/Documents/GitHub/VHDL_code/Intel/JTAG/sources/lib_jtag_intel/
SRC_ZIPCPU_AXI4_LITE_TOP_DIR = /home/linux-jp/Documents/GitHub/VHDL_code/PR_115/sources/lib_zipcpu_axi4_lite_top/

# MAX7219
SRC_LIB_MAX7219_INTERFACE_DIR = /home/linux-jp/Documents/GitHub/VHDL_code/MAX7219/sources/lib_max7219_interface/
SRC_LIB_MAX7219_DIR           = /home/linux-jp/Documents/GitHub/VHDL_code/MAX7219/sources/lib_max7219/
SRC_AXI4_LITE_MAX7219_DIR     = /home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite_max7219/

# SPI MASTER
SRC_LIB_SPI_MASTER_DIR       = /home/linux-jp/Documents/GitHub/VHDL_code/SPI/sources/lib_spi_master/
SRC_AXI4_LITE_SPI_MASTER_DIR = /home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite_spi_master/

# SPI SLAVE
SRC_LIB_SPI_SLAVE_DIR       = /home/linux-jp/Documents/GitHub/VHDL_code/SPI/sources/lib_spi_slave/
SRC_AXI4_LITE_SPI_SLAVE_DIR = /home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite_spi_slave/

# I2C Master
SRC_LIB_I2C_DIR              = /home/linux-jp/Documents/GitHub/VHDL_code/I2C/sources/lib_i2c/
SRC_AXI4_LITE_I2C_MASTER_DIR = /home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite_i2c_master/

# GPO
SRC_LIB_AXI4_LITE_GPO_DIR = /home/linux-jp/Documents/GitHub/VHDL_code/AXI/AXI4_Lite/sources/lib_axi4_lite_gpio/

# -- ZIPCPU PATH --
SRC_ZIPCPU_EX_DIR          = $(SRC_ZIPCPU_DIR)/ex/
SRC_ZIPCPU_CORE_DIR        = $(SRC_ZIPCPU_DIR)/core/
SRC_ZIPCPU_PERIPHERALS_DIR = $(SRC_ZIPCPU_DIR)/peripherals/
SRC_ZIPCPU_DMA_DIR         = $(SRC_ZIPCPU_DIR)/zipdma/
SRC_ZIPCPU_TOP_DIR         = $(SRC_ZIPCPU_DIR)/

SRC_ZIPCPU_WBUART32_DIR = $(SRC_WBUART32_DIR)/
SRC_LIB_WISHBONE_DIR    = $(SRC_LIB_WISHBONE_VHD_DIR)/
# ---------------------

# == WishBone UART ==
src_lib_zipcpu_wbuart32_v+= skidbuffer_zipuart.v
src_lib_zipcpu_wbuart32_v+= rxuartlite.v
src_lib_zipcpu_wbuart32_v+= rxuart.v
src_lib_zipcpu_wbuart32_v+= txuartlite.v
src_lib_zipcpu_wbuart32_v+= txuart.v
src_lib_zipcpu_wbuart32_v+= ufifo.v
#src_lib_zipcpu_wbuart32_v+= wbuart-insert.v
src_lib_zipcpu_wbuart32_v+= wbuart.v
src_lib_zipcpu_wbuart32_v+= axiluart.v
# ===================

# Design Sources List
util_src_vhd += pkg_utils.vhd

rst_gen_src_vhd += reset_gen.vhd

src_lib_ram_intel_vhd+=sp_ram.vhd
src_lib_fifo_vhd+=fifo_sp_ram.vhd
src_lib_fifo_vhd+=fifo_sp_ram_fast.vhd
src_lib_fifo_wrapper_vhd+=fifo_sp_ram_wrapper.vhd
src_lib_fifo_wrapper_vhd+=fifo_sp_ram_fast_wrapper.vhd

src_lib_rom_intel_vhd+=pkg_sp_rom.vhd
src_lib_rom_intel_vhd+=sp_rom.vhd

axi4_lite_custom_src_vhd += pkg_axi4_lite_interco_custom.vhd

axi4_lite_src_vhd += axi4_lite_slave_itf.vhd
axi4_lite_src_vhd += axi4_lite_master.vhd

axi4_lite_src_vhd += pkg_axi4_lite_interco.vhd
axi4_lite_src_vhd += slave_sel_decoder.vhd
axi4_lite_src_vhd += axi4_lite_interco_1_to_n.vhd

seg_src_vhd += seg7_lut.vhd
seg_src_vhd += seg7x8.vhd

max7219_interface_src_vhd+=max7219_if.vhd

max7219_src_vhd+=start_max7219_if.vhd
max7219_src_vhd+=wr_fifo_mngt.vhd
max7219_src_vhd+=max7219_ctrl.vhd

axi4_lite_7seg_src_vhd += axi4_lite_7segs_pkg.vhd
axi4_lite_7seg_src_vhd += axi4_lite_7segs_registers.vhd
axi4_lite_7seg_src_vhd += axi4_lite_7segs.vhd

src_pulse_extender_vhd += bit_extender.vhd

# LCD
src_lcd_vhd+=pkg_lcd_cfah_types_and_func.vhd
src_lcd_vhd+=pkg_lcd_cfah.vhd
src_lcd_vhd+=lcd_cfah_itf.vhd
src_lcd_vhd+=lcd_cfah_cmd_generator.vhd
src_lcd_vhd+=lcd_cfah_polling.vhd
src_lcd_vhd+=lcd_cfah_init.vhd
src_lcd_vhd+=lcd_cfah_main_fsm.vhd
src_lcd_vhd+=lcd_cfah_update_display_fsm.vhd
src_lcd_vhd+=lcd_cfah_update_display.vhd
src_lcd_vhd+=lcd_cfah_top.vhd

src_axi4_lite_lcd_vhd+=axi4_lite_lcd_pkg.vhd
src_axi4_lite_lcd_vhd+=axi4_lite_lcd_registers.vhd
src_axi4_lite_lcd_vhd+=axi4_lite_lcd.vhd

src_axi4_lite_max7219_vhd+=axi4_lite_max7219_pkg.vhd
src_axi4_lite_max7219_vhd+=axi4_lite_max7219_registers.vhd
src_axi4_lite_max7219_vhd+=axi4_lite_max7219.vhd

src_axi4_lite_memory_vhd+=axi4_lite_rom_ctrl.vhd
src_axi4_lite_memory_vhd+=axi4_lite_memory.vhd

# SPI MASTER
src_spi_master_vhd+=spi_master_itf.vhd
src_spi_master_vhd+=spi_master.vhd

src_axi4_lite_spi_master_vhd+=axi4_lite_spi_master_pkg.vhd
src_axi4_lite_spi_master_vhd+=axi4_lite_spi_master_registers.vhd
src_axi4_lite_spi_master_vhd+=axi4_lite_spi_master.vhd

# SPI SLAVE
src_spi_slave_vhd+=spi_slave_itf.vhd
src_spi_slave_vhd+=spi_slave.vhd

src_axi4_lite_spi_slave_vhd+=axi4_lite_spi_slave_pkg.vhd
src_axi4_lite_spi_slave_vhd+=axi4_lite_spi_slave_registers.vhd
src_axi4_lite_spi_slave_vhd+=axi4_lite_spi_slave.vhd

# I2C MASTER
src_lib_i2c_vhd+=i2c_master_itf.vhd
src_lib_i2c_vhd+=i2c_master.vhd

src_lib_axi4_lite_i2c_master_vhd+=axi4_lite_i2c_master_pkg.vhd
src_lib_axi4_lite_i2c_master_vhd+=axi4_lite_i2c_master_registers.vhd
src_lib_axi4_lite_i2c_master_vhd+=axi4_lite_i2c_master.vhd

# GPO
src_lib_axi4_lite_gpo_vhd += axi4_lite_gpo_pkg.vhd
src_lib_axi4_lite_gpo_vhd += axi4_lite_gpo_registers.vhd
src_lib_axi4_lite_gpo_vhd += axi4_lite_gpo.vhd

# VJTAG Interface
src_lib_jtag_intel_vhd+=vjtag_intf.vhd

# TOP
src_zipcpu_axi4_lite_top_vhd += pkg_zipcpu_axi4_lite_top.vhd
src_zipcpu_axi4_lite_top_vhd += zipcpu_axi4_lite_core.vhd
src_zipcpu_axi4_lite_top_vhd += resynchro.vhd
src_zipcpu_axi4_lite_top_vhd += tristate.vhd
src_zipcpu_axi4_lite_top_vhd += zipcpu_axi4_lite_top.vhd

src_lib_wishbone_vhd+=wb_slv_memory.vhd
# ==========================

# == ZIPCPU FILES ==
# Compile ex files
src_lib_zipcpu_ex_v+=fwb_counter.v
src_lib_zipcpu_ex_v+=fwb_master.v
src_lib_zipcpu_ex_v+=fwb_slave.v
src_lib_zipcpu_ex_v+=sfifo.v
src_lib_zipcpu_ex_v+=skidbuffer.v
src_lib_zipcpu_ex_v+=wbarbiter.v
src_lib_zipcpu_ex_v+=wbdblpriarb.v
src_lib_zipcpu_ex_v+=wbpriarbiter.v
src_lib_zipcpu_ex_v+=busdelay.v

# Compile core files
src_lib_zipcpu_core_v+= axidcache.v
src_lib_zipcpu_core_v+= axiicache.v
src_lib_zipcpu_core_v+= axilfetch.v
src_lib_zipcpu_core_v+= axilops.v
src_lib_zipcpu_core_v+= axilpipe.v
src_lib_zipcpu_core_v+= axiops.v
src_lib_zipcpu_core_v+= axipipe.v
src_lib_zipcpu_core_v+= cpuops.v
src_lib_zipcpu_core_v+= dblfetch.v
src_lib_zipcpu_core_v+= dcache.v
src_lib_zipcpu_core_v+= div.v
src_lib_zipcpu_core_v+= idecode.v
src_lib_zipcpu_core_v+= iscachable.v
src_lib_zipcpu_core_v+= memops.v
src_lib_zipcpu_core_v+= mpyop.v
src_lib_zipcpu_core_v+= pfcache.v
src_lib_zipcpu_core_v+= pipefetch.v
src_lib_zipcpu_core_v+= pipemem.v
src_lib_zipcpu_core_v+= prefetch.v
src_lib_zipcpu_core_v+= slowmpy.v
src_lib_zipcpu_core_v+= zipcore.v
src_lib_zipcpu_core_v+= zipwb.v

# Compile peripherals
src_lib_zipcpu_peripherals_v+= icontrol.v
src_lib_zipcpu_peripherals_v+= wbdmac.v
src_lib_zipcpu_peripherals_v+= wbwatchdog.v
src_lib_zipcpu_peripherals_v+= zipcounter.v
src_lib_zipcpu_peripherals_v+= zipjiffies.v
src_lib_zipcpu_peripherals_v+= zipmmu.v
src_lib_zipcpu_peripherals_v+= ziptimer.v
src_lib_zipcpu_peripherals_v+= axilperiphs.v

# Compile ZipDMA
src_lib_zipcpu_dma_v+= zipdma_ctrl.v
src_lib_zipcpu_dma_v+= zipdma_fsm.v
src_lib_zipcpu_dma_v+= zipdma_mm2s.v
src_lib_zipcpu_dma_v+= zipdma_rxgears.v
src_lib_zipcpu_dma_v+= zipdma_s2mm.v
src_lib_zipcpu_dma_v+= zipdma_txgears.v
src_lib_zipcpu_dma_v+= zipdma.v


# Compile zipcpu
#src_lib_zipcpu_v+= cpudefs.v
src_lib_zipcpu_v+= zipaxil.v
src_lib_zipcpu_v+= zipaxi.v
src_lib_zipcpu_v+= zipbones.v
src_lib_zipcpu_v+= zipsystem.v
# ========================

## == COMPILE DESIGN == ##
compile_zipcpu_axi4_lite_top:
	make compile_zipcpu_ex; \
	make compile_zipcpu_core; \
	make compile_zipcpu_peripherals; \
	make compile_zipcpu_dma; \
	make compile_zipuart; \
	make compile_zipcpu; \
	make compile_design_vhd_files SRC_VHD="$(util_src_vhd)"                     VHD_DESIGN_LIB=lib_pkg_utils              VHD_FILE_PATH=$(SRC_UTILS_DIR); \
	make compile_design_vhd_files SRC_VHD="$(rst_gen_src_vhd)"                  VHD_DESIGN_LIB=lib_zipcpu_axi4_lite_top   VHD_FILE_PATH=$(SRC_RESET_GEN_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_lib_ram_intel_vhd)"            VHD_DESIGN_LIB=lib_ram_intel              VHD_FILE_PATH=$(SRC_LIB_RAM_INTEL_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_lib_rom_intel_vhd)"            VHD_DESIGN_LIB=lib_rom_intel              VHD_FILE_PATH=$(SRC_LIB_ROM_INTEL_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_lib_jtag_intel_vhd)"           VHD_DESIGN_LIB=lib_jtag_intel             VHD_FILE_PATH=$(SRC_LIB_JTAG_INTEL_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_lib_fifo_vhd)"                 VHD_DESIGN_LIB=lib_fifo                   VHD_FILE_PATH=$(SRC_LIB_FIFO_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_lib_fifo_wrapper_vhd)"         VHD_DESIGN_LIB=lib_fifo_wrapper           VHD_FILE_PATH=$(SRC_LIB_FIFO_WRAPPER_DIR); \
	make compile_design_vhd_files SRC_VHD="$(seg_src_vhd)"                      VHD_DESIGN_LIB=lib_seg7                   VHD_FILE_PATH=$(SRC_LIB_7SEG); \
	make compile_design_vhd_files SRC_VHD="$(axi4_lite_custom_src_vhd)"         VHD_DESIGN_LIB=lib_axi4_lite              VHD_FILE_PATH=$(SRC_ZIPCPU_AXI4_LITE_TOP_DIR); \
	make compile_design_vhd_files SRC_VHD="$(axi4_lite_src_vhd)"                VHD_DESIGN_LIB=lib_axi4_lite              VHD_FILE_PATH=$(SRC_AXI4_LITE_DIR); \
	make compile_design_vhd_files SRC_VHD="$(axi4_lite_7seg_src_vhd)"           VHD_DESIGN_LIB=lib_axi4_lite_7seg         VHD_FILE_PATH=$(SRC_AXI4_LITE_7SEG_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_pulse_extender_vhd)"           VHD_DESIGN_LIB=lib_pulse_extender         VHD_FILE_PATH=$(SRC_PULSE_EXTENDER_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_jtag_7seg_top_vhd)"            VHD_DESIGN_LIB=lib_zipcpu_axi4_lite_top   VHD_FILE_PATH=$(SRC_JTAG_7SEG_TOP_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_lcd_vhd)"                      VHD_DESIGN_LIB=lib_CFAH1602_v2            VHD_FILE_PATH=$(SRC_LCD_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_axi4_lite_lcd_vhd)"            VHD_DESIGN_LIB=lib_axi4_lite_lcd          VHD_FILE_PATH=$(SRC_AXI4_LITE_LCD_DIR); \
	make compile_design_vhd_files SRC_VHD="$(max7219_interface_src_vhd)"        VHD_DESIGN_LIB=lib_max7219_interface      VHD_FILE_PATH=$(SRC_LIB_MAX7219_INTERFACE_DIR); \
	make compile_design_vhd_files SRC_VHD="$(max7219_src_vhd)"                  VHD_DESIGN_LIB=lib_max7219                VHD_FILE_PATH=$(SRC_LIB_MAX7219_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_axi4_lite_max7219_vhd)"        VHD_DESIGN_LIB=lib_axi4_lite_max7219      VHD_FILE_PATH=$(SRC_AXI4_LITE_MAX7219_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_spi_master_vhd)"               VHD_DESIGN_LIB=lib_spi_master             VHD_FILE_PATH=$(SRC_LIB_SPI_MASTER_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_axi4_lite_spi_master_vhd)"     VHD_DESIGN_LIB=lib_axi4_lite_spi_master   VHD_FILE_PATH=$(SRC_AXI4_LITE_SPI_MASTER_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_spi_slave_vhd)"                VHD_DESIGN_LIB=lib_spi_slave              VHD_FILE_PATH=$(SRC_LIB_SPI_SLAVE_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_axi4_lite_spi_slave_vhd)"      VHD_DESIGN_LIB=lib_axi4_lite_spi_slave    VHD_FILE_PATH=$(SRC_AXI4_LITE_SPI_SLAVE_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_lib_i2c_vhd)"                  VHD_DESIGN_LIB=lib_i2c                    VHD_FILE_PATH=$(SRC_LIB_I2C_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_lib_axi4_lite_i2c_master_vhd)" VHD_DESIGN_LIB=lib_axi4_lite_i2c_master   VHD_FILE_PATH=$(SRC_AXI4_LITE_I2C_MASTER_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_lib_axi4_lite_gpo_vhd)" 	    VHD_DESIGN_LIB=lib_axi4_lite_gpio         VHD_FILE_PATH=$(SRC_LIB_AXI4_LITE_GPO_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_axi4_lite_memory_vhd)"         VHD_DESIGN_LIB=lib_axi4_lite_memory       VHD_FILE_PATH=$(SRC_AXI4_LITE_MEMORY_DIR); \
	make compile_design_vhd_files SRC_VHD="$(src_zipcpu_axi4_lite_top_vhd)"     VHD_DESIGN_LIB=lib_zipcpu_axi4_lite_top   VHD_FILE_PATH=$(SRC_ZIPCPU_AXI4_LITE_TOP_DIR); \


compile_wishbone_src:
	make compile_design_vhd_files SRC_VHD="$(src_lib_wishbone_vhd)" VHD_DESIGN_LIB=$(LIB_WISHBONE)

compile_zipcpu_ex:
	make compile_design_v_files SRC_V="$(src_lib_zipcpu_ex_v)" V_DESIGN_LIB=lib_zipcpu V_FILE_PATH=$(SRC_ZIPCPU_EX_DIR);

compile_zipcpu_core:
	make compile_design_v_files SRC_V="$(src_lib_zipcpu_core_v)" V_DESIGN_LIB=lib_zipcpu V_FILE_PATH=$(SRC_ZIPCPU_CORE_DIR) VLOG_ARGS="+define+IDECODE";

compile_zipcpu_peripherals:
	make compile_design_v_files SRC_V="$(src_lib_zipcpu_peripherals_v)" V_DESIGN_LIB=lib_zipcpu V_FILE_PATH=$(SRC_ZIPCPU_PERIPHERALS_DIR);
compile_zipcpu_dma:
	make compile_design_v_files SRC_V="$(src_lib_zipcpu_dma_v)" V_DESIGN_LIB=lib_zipcpu V_FILE_PATH=$(SRC_ZIPCPU_DMA_DIR);

compile_zipcpu:
	make compile_design_v_files SRC_V="$(src_lib_zipcpu_v)" V_DESIGN_LIB=lib_zipcpu V_FILE_PATH=$(SRC_ZIPCPU_TOP_DIR);

compile_zipuart:
	make compile_design_v_files SRC_V="$(src_lib_zipcpu_wbuart32_v)" V_DESIGN_LIB=lib_zipcpu V_FILE_PATH=$(SRC_ZIPCPU_WBUART32_DIR);
