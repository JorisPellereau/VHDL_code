-------------------------------------------------------------------------------
-- Title      : Core of JTAG AXI4 Lite
-- Project    : 
-------------------------------------------------------------------------------
-- File       : jtag_axi4_lite_core.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-18
-- Last update: 2024-02-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-18  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_axi4_lite;
use lib_axi4_lite.pkg_axi4_lite_interco_cutom.all;
use lib_axi4_lite.pkg_axi4_lite_interco.all;

library lib_rom_intel;
use lib_rom_intel.pkg_sp_rom.all;

library lib_max7219;
library lib_axi4_lite_7seg;
library lib_axi4_lite_lcd;
library lib_axi4_lite_max7219;
library lib_axi4_lite_memory;
library lib_axi4_lite_spi_master;
library lib_axi4_lite_spi_slave;
library lib_axi4_lite_i2c_master;
library lib_zipcpu_axi4_lite_top;
library lib_zipcpu;
library lib_jtag_intel;
library lib_pulse_extender;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_zipcpu_axi4_lite_top;
use lib_zipcpu_axi4_lite_top.pkg_zipcpu_axi4_lite_top.all;

entity zipcpu_axi4_lite_core is
  generic (
    G_AXI_DATA_WIDTH        : integer range 32 to 64 := 32;   -- AXI DATA WIDTH
    G_AXI_ADDR_WIDTH        : integer range 8 to 64  := 16;   -- AXI ADDR WIDTH
    G_SLAVE_NB              : integer range 2 to 16  := 2;    -- Number of AXI4 Lite Slave
    G_CLK_PERIOD_NS         : integer                := 20;   -- Clock Period in ns
    G_BIDIR_POLARITY_READ   : std_logic              := '0';  -- BIDIR SEL Polarity
    G_FIFO_ADDR_WIDTH       : integer                := 10;   -- FIFO ADDR WIDTH
    G_ROM_ADDR_WIDTH        : integer                := 8;    -- ROM Addr Width - Shall have the size : G_AXI4_LITE_ADDR_WIDTH / 4
    G_ROM_INIT              : t_rom_32bits;                   -- Rom Initialization
    G_EXTERNAL_INTERRUPT_NB : integer                := 16;   -- External Interruption of the ZIPCPU Configuration
    G_SPI_SIZE              : integer range 1 to 4   := 4     -- SPI Size
    );
  port (
    clk_sys   : in std_logic;                                 -- Clock System
    rst_n_sys : in std_logic;                                 -- Asynchronous Reset

    -- PUSH-BUTTONS
    key_1 : in std_logic;               -- KEY 1 - clk_sys clock domain
    key_2 : in std_logic;               -- KEY 2 - clk_sys clock domain    
    key_3 : in std_logic;               -- KEY 3 - clk_sys clock domain

    -- 7 Segments
    o_seg0 : out std_logic_vector(6 downto 0);  -- SEG 0
    o_seg1 : out std_logic_vector(6 downto 0);  -- SEG 1
    o_seg2 : out std_logic_vector(6 downto 0);  -- SEG 2
    o_seg3 : out std_logic_vector(6 downto 0);  -- SEG 3
    o_seg4 : out std_logic_vector(6 downto 0);  -- SEG 4
    o_seg5 : out std_logic_vector(6 downto 0);  -- SEG 5
    o_seg6 : out std_logic_vector(6 downto 0);  -- SEG 6
    o_seg7 : out std_logic_vector(6 downto 0);  -- SEG 7

    -- LCD I/F
    i_lcd_data  : in  std_logic_vector(7 downto 0);  -- Data from LCD
    o_lcd_wdata : out std_logic_vector(7 downto 0);  -- LCD WData    
    o_lcd_rw    : out std_logic;                     -- R/W command
    o_lcd_en    : out std_logic;                     -- LCD Enable
    o_lcd_rs    : out std_logic;                     -- LCD RS
    o_lcd_on    : out std_logic;                     -- LCD ON Management
    o_bidir_sel : out std_logic;                     -- Bidir Selector

    -- MAX7219 Interface
    o_max7219_clk  : out std_logic;     -- MAX7219 Clock
    o_max7219_load : out std_logic;     -- MAX7219 LOAD
    o_max7219_data : out std_logic;     -- MAX7219 DATA

    -- UART Interface
    i_rx_uart : in  std_logic;          -- RX UART
    o_tx_uart : out std_logic;          -- TX UART
    i_cts_n   : in  std_logic;          -- CTS
    o_rts_n   : out std_logic;          -- RTS

    -- SPI MASTER I/F
    spi_clk  : out std_logic;                                  -- MASTER SPI Clock
    spi_cs_n : out std_logic;                                  -- MASTER SPI Chip Select
    spi_do   : out std_logic_vector(G_SPI_SIZE - 1 downto 0);  -- SPI Data Out
    spi_di   : in  std_logic_vector(G_SPI_SIZE - 1 downto 0);  -- SPI Data In

    -- SPI SLAVE I/F
    spi_slave_clk  : in  std_logic;                                  -- SPI Slave input clock
    spi_slave_cs_n : in  std_logic;                                  -- SPI Slave Chip select
    spi_slave_do   : out std_logic_vector(G_SPI_SIZE - 1 downto 0);  -- Output SPI SLAVE
    spi_slave_di   : in  std_logic_vector(G_SPI_SIZE - 1 downto 0);  -- Input SPI SLAVE

    -- I2C Master EEPROM I/F
    sclk_eeprom    : out std_logic;     -- SCLK
    sclk_en_eeprom : out std_logic;     -- Enable SCLK
    sda_in_eeprom  : in  std_logic;     -- Input Data
    sda_out_eeprom : out std_logic;     -- Output Data
    sda_en_eeprom  : out std_logic;     -- Enable SDA

    -- RED LEDS
    ledr : out std_logic_vector(17 downto 0);  -- RED LEDS

    -- GREEN LEDS
    ledg : out std_logic_vector(8 downto 0)  -- GREEN LEDS
    );

end entity zipcpu_axi4_lite_core;

architecture rtl of zipcpu_axi4_lite_core is

  -- == COMPONENTS ==
  -- Component Altera VJTAG with 6 IR length
  component altera_vjtag is
    port (
      tdi                : out std_logic;                                        -- tdi
      tdo                : in  std_logic                    := 'X';              -- tdo
      ir_in              : out std_logic_vector(7 downto 0);                     -- ir_in
      ir_out             : in  std_logic_vector(7 downto 0) := (others => 'X');  -- ir_out
      virtual_state_cdr  : out std_logic;                                        -- virtual_state_cdr
      virtual_state_sdr  : out std_logic;                                        -- virtual_state_sdr
      virtual_state_e1dr : out std_logic;                                        -- virtual_state_e1dr
      virtual_state_pdr  : out std_logic;                                        -- virtual_state_pdr
      virtual_state_e2dr : out std_logic;                                        -- virtual_state_e2dr
      virtual_state_udr  : out std_logic;                                        -- virtual_state_udr
      virtual_state_cir  : out std_logic;                                        -- virtual_state_cir
      virtual_state_uir  : out std_logic;                                        -- virtual_state_uir
      tck                : out std_logic                                         -- clk
      );
  end component altera_vjtag;

  component zipaxil is
    generic (
      C_DBG_ADDR_WIDTH     : integer                       := 8;
      ADDRESS_WIDTH        : integer                       := 32;
      C_AXI_DATA_WIDTH     : integer                       := 32;
      OPT_LGICACHE         : integer                       := 0;
      OPT_LGDCACHE         : integer                       := 0;
      OPT_PIPELINED        : std_logic_vector(0 downto 0)  := "1";
      RESET_ADDRESS        : std_logic_vector(31 downto 0) := (others => '0');
      START_HALTED         : std_logic_vector(0 downto 0)  := "0";
      SWAP_WSTRB           : std_logic_vector(0 downto 0)  := "1";
      OPT_MPY              : integer                       := 3;
      OPT_DIV              : std_logic_vector(0 downto 0)  := "1";
      OPT_SHIFTS           : std_logic_vector(0 downto 0)  := "1";
      OPT_LOCK             : std_logic_vector(0 downto 0)  := "1";
      OPT_FPU              : std_logic_vector(0 downto 0)  := "0";
      OPT_EARLY_BRANCHING  : std_logic_vector(0 downto 0)  := "1";
      OPT_CIS              : std_logic_vector(0 downto 0)  := "1";
      OPT_LOWPOWER         : std_logic_vector(0 downto 0)  := "0";
      OPT_DISTRIBUTED_REGS : std_logic_vector(0 downto 0)  := "1";
      OPT_DBGPORT          : std_logic_vector(0 downto 0)  := "0";
      OPT_TRACE_PORT       : std_logic_vector(0 downto 0)  := "0";
      OPT_PROFILER         : std_logic_vector(0 downto 0)  := "0";
      OPT_USERMODE         : std_logic_vector(0 downto 0)  := "1";
      RESET_DURATION       : integer                       := 10;
      OPT_SIM              : std_logic_vector(0 downto 0)  := "0";
      OPT_CLKGATE          : std_logic_vector(0 downto 0)  := "0"
      );
    port (

      S_AXI_ACLK    : in std_logic;
      S_AXI_ARESETN : in std_logic;

      i_interrupt : in std_logic;
      i_cpu_reset : in std_logic;

      S_DBG_AWVALID : in  std_logic;
      S_DBG_AWREADY : out std_logic;

      S_DBG_AWADDR : in std_logic_vector(C_DBG_ADDR_WIDTH - 1 downto 0);

      S_DBG_AWPROT : in std_logic_vector(2 downto 0);

      S_DBG_WVALID : in  std_logic;
      S_DBG_WREADY : out std_logic;
      S_DBG_WDATA  : in  std_logic_vector(31 downto 0);
      S_DBG_WSTRB  : in  std_logic_vector(3 downto 0);

      S_DBG_BVALID : out std_logic;
      S_DBG_BREADY : in  std_logic;

      S_DBG_BRESP : out std_logic_vector(1 downto 0);

      S_DBG_ARVALID : in  std_logic;
      S_DBG_ARREADY : out std_logic;

      S_DBG_ARADDR : in std_logic_vector(7 downto 0);

      S_DBG_ARPROT : in std_logic_vector(2 downto 0);

      S_DBG_RVALID : out std_logic;
      S_DBG_RREADY : in  std_logic;

      S_DBG_RDATA : out std_logic_vector(31 downto 0);

      S_DBG_RRESP : out std_logic_vector(1 downto 0);


      M_INSN_AWVALID : out std_logic;
      M_INSN_AWREADY : in  std_logic;


      M_INSN_AWADDR : out std_logic_vector(ADDRESS_WIDTH-1 downto 0);
      M_INSN_AWPROT : out std_logic_vector(2 downto 0);

      M_INSN_WVALID : out std_logic;
      M_INSN_WREADY : in  std_logic;
      M_INSN_WDATA  : out std_logic_vector(C_AXI_DATA_WIDTH-1 downto 0);
      M_INSN_WSTRB  : out std_logic_vector((C_AXI_DATA_WIDTH/8)-1 downto 0);

      M_INSN_BVALID : in  std_logic;
      M_INSN_BREADY : out std_logic;
      M_INSN_BRESP  : in  std_logic_vector(1 downto 0);

      M_INSN_ARVALID : out std_logic;
      M_INSN_ARREADY : in  std_logic;
      M_INSN_ARADDR  : out std_logic_vector(ADDRESS_WIDTH-1 downto 0);
      M_INSN_ARPROT  : out std_logic_vector(2 downto 0);

      M_INSN_RVALID : in  std_logic;
      M_INSN_RREADY : out std_logic;
      M_INSN_RDATA  : in  std_logic_vector(C_AXI_DATA_WIDTH-1 downto 0);
      M_INSN_RRESP  : in  std_logic_vector(1 downto 0);

      M_DATA_AWVALID : out std_logic;
      M_DATA_AWREADY : in  std_logic;
      M_DATA_AWADDR  : out std_logic_vector(ADDRESS_WIDTH-1 downto 0);


      M_DATA_AWPROT : out std_logic_vector(2 downto 0);

      M_DATA_WVALID : out std_logic;
      M_DATA_WREADY : in  std_logic;
      M_DATA_WDATA  : out std_logic_vector(C_AXI_DATA_WIDTH-1 downto 0);
      M_DATA_WSTRB  : out std_logic_vector((C_AXI_DATA_WIDTH/8)-1 downto 0);

      M_DATA_BVALID : in  std_logic;
      M_DATA_BREADY : out std_logic;
      M_DATA_BRESP  : in  std_logic_vector(1 downto 0);


      M_DATA_ARVALID : out std_logic;
      M_DATA_ARREADY : in  std_logic;
      M_DATA_ARADDR  : out std_logic_vector(ADDRESS_WIDTH-1 downto 0);

      M_DATA_ARPROT : out std_logic_vector(2 downto 0);

      M_DATA_RVALID : in  std_logic;
      M_DATA_RREADY : out std_logic;
      M_DATA_RDATA  : in  std_logic_vector(C_AXI_DATA_WIDTH-1 downto 0);
      M_DATA_RRESP  : in  std_logic_vector(1 downto 0);

      o_cmd_reset : out std_logic;
      o_halted    : out std_logic;
      o_gie       : out std_logic;
      o_op_stall  : out std_logic;
      o_pf_stall  : out std_logic;
      o_i_count   : out std_logic;

      o_cpu_debug  : out std_logic_vector(31 downto 0);
      o_prof_stb   : out std_logic;
      o_prof_addr  : out std_logic_vector(ADDRESS_WIDTH - 1 downto 0);
      o_prof_ticks : out std_logic_vector(31 downto 0)

      );
  end component;

  -- Component axilperiphs
  component axilperiphs
    generic (
      C_AXI_ADDR_WIDTH    : integer                      := 6;
      C_AXI_DATA_WIDTH    : integer                      := 32;
      OPT_SKIDBUFFER      : std_logic_vector(0 downto 0) := "1";
      OPT_LOWPOWER        : std_logic_vector(0 downto 0) := "0";
      EXTERNAL_INTERRUPTS : integer                      := 1;
      OPT_COUNTERS        : std_logic_vector(0 downto 0) := "1";
      ADDRLSB             : integer                      := 8-3
      );
    port (

      S_AXI_ACLK    : in std_logic;
      S_AXI_ARESETN : in std_logic;

      S_AXI_AWVALID : in  std_logic;
      S_AXI_AWREADY : out std_logic;
      S_AXI_AWADDR  : in  std_logic_vector(C_AXI_ADDR_WIDTH-1 downto 0);
      S_AXI_AWPROT  : in  std_logic_vector(2 downto 0);

      S_AXI_WVALID : in  std_logic;
      S_AXI_WREADY : out std_logic;
      S_AXI_WDATA  : in  std_logic_vector(C_AXI_DATA_WIDTH - 1 downto 0);
      S_AXI_WSTRB  : in  std_logic_vector((C_AXI_DATA_WIDTH/8) - 1 downto 0);

      S_AXI_BVALID : out std_logic;
      S_AXI_BREADY : in  std_logic;
      S_AXI_BRESP  : out std_logic_vector(1 downto 0);

      S_AXI_ARVALID : in  std_logic;
      S_AXI_ARREADY : out std_logic;
      S_AXI_ARADDR  : in  std_logic_vector(C_AXI_ADDR_WIDTH-1 downto 0);
      S_AXI_ARPROT  : in  std_logic_vector(2 downto 0);

      S_AXI_RVALID : out std_logic;
      S_AXI_RREADY : in  std_logic;
      S_AXI_RDATA  : out std_logic_vector(C_AXI_DATA_WIDTH - 1 downto 0);
      S_AXI_RRESP  : out std_logic_vector(1 downto 0);

      i_cpu_reset      : in  std_logic;
      i_cpu_halted     : in  std_logic;
      i_cpu_gie        : in  std_logic;
      i_cpu_pfstall    : in  std_logic;
      i_cpu_opstall    : in  std_logic;
      i_cpu_icount     : in  std_logic;
      i_ivec           : in  std_logic_vector(EXTERNAL_INTERRUPTS - 1 downto 0);
      o_interrupt      : out std_logic;
      o_watchdog_reset : out std_logic
      );
  end component;

  component axiluart
    generic (
      INITIAL_SETUP                 : std_logic_vector(30 downto 0) := "000" & x"0000019";
      LGFLEN                        : std_logic_vector(3 downto 0)  := x"4";
      HARDWARE_FLOW_CONTROL_PRESENT : std_logic_vector(0 downto 0)  := "1";
      LCLLGFLEN                     : std_logic_vector(3 downto 0)  := x"4";
      C_AXI_ADDR_WIDTH              : integer                       := 4;
      C_AXI_DATA_WIDTH              : integer                       := 32;
      OPT_SKIDBUFFER                : std_logic_vector(0 downto 0)  := "0";
      OPT_LOWPOWER                  : std_logic_vector(0 downto 0)  := "0";
      ADDRLSB                       : integer
      );
    port (
      S_AXI_ACLK    : in std_logic;
      S_AXI_ARESETN : in std_logic;

      S_AXI_AWVALID : in  std_logic;
      S_AXI_AWREADY : out std_logic;
      S_AXI_AWADDR  : in  std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0);
      S_AXI_AWPROT  : in  std_logic_vector(2 downto 0);

      S_AXI_WVALID : in  std_logic;
      S_AXI_WREADY : out std_logic;
      S_AXI_WDATA  : in  std_logic_vector(C_AXI_DATA_WIDTH - 1 downto 0);
      S_AXI_WSTRB  : in  std_logic_vector(C_AXI_DATA_WIDTH/8 - 1 downto 0);

      S_AXI_BVALID : out std_logic;
      S_AXI_BREADY : in  std_logic;
      S_AXI_BRESP  : out std_logic_vector(1 downto 0);

      S_AXI_ARVALID : in  std_logic;
      S_AXI_ARREADY : out std_logic;
      S_AXI_ARADDR  : in  std_logic_vector(C_AXI_ADDR_WIDTH - 1 downto 0);
      S_AXI_ARPROT  : in  std_logic_vector(2 downto 0);

      S_AXI_RVALID : out std_logic;
      S_AXI_RREADY : in  std_logic;
      S_AXI_RDATA  : out std_logic_vector(C_AXI_DATA_WIDTH - 1 downto 0);
      S_AXI_RRESP  : out std_logic_vector(1 downto 0);

      i_uart_rx : in  std_logic;
      o_uart_tx : out std_logic;

      i_cts_n : in  std_logic;
      o_rts_n : out std_logic;

      o_uart_rx_int     : out std_logic;
      o_uart_tx_int     : out std_logic;
      o_uart_rxfifo_int : out std_logic;
      o_uart_txfifo_int : out std_logic
      );
  end component;


  -- == INTERNAL Signals ==

  --Signals and registers declared for VJI instance
  signal tck   : std_logic;
  signal tdi   : std_logic;
  signal tdo   : std_logic;
  signal cdr   : std_logic;
  signal e1dr  : std_logic;
  signal e2dr  : std_logic;
  signal pdr   : std_logic;
  signal sdr   : std_logic;
  signal udr   : std_logic;
  signal uir   : std_logic;
  signal cir   : std_logic;
  signal ir_in : std_logic_vector(7 downto 0);

  -- VJTAG Signals
  signal start_clk_jtag      : std_logic;
  signal addr_vjtag          : std_logic_vector(7 downto 0);
  signal rnw_vjtag           : std_logic;
  signal strobe_vjtag        : std_logic_vector((32/8) - 1 downto 0);
  signal wdata_vjtag         : std_logic_vector(31 downto 0);
  signal rdata_vjtag         : std_logic_vector(32 - 1 downto 0);
  signal access_status_vjtag : std_logic_vector(1 downto 0);
  signal master_wdata        : std_logic_vector(32 - 1 downto 0);
  signal start_master        : std_logic;  -- Start Master

  signal key_1_p      : std_logic;      -- KEY 1 piped one time
  signal key_1_f_edge : std_logic;      -- Rising edge of KEY 1 f edge


  -- ZIPAXIL Signals

  signal zipcpu_interrupt : std_logic;  -- ZIPCPU Interrupt
  signal cmd_reset        : std_logic;
  signal halted           : std_logic;
  signal gie              : std_logic;
  signal op_stall         : std_logic;
  signal pf_stall         : std_logic;
  signal i_count          : std_logic;

  signal prof_addr : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- PROF Addr

  -- # ZIPAXIL DEBUG Interface --
  -- Write Address Channel signals
  signal awvalid_zipaxil_dbg : std_logic;                     -- Address Write Valid
  signal awaddr_zipaxil_dbg  : std_logic_vector(7 downto 0);  -- Address Write
  signal awprot_zipaxil_dbg  : std_logic_vector(2 downto 0);  -- Adress Write Prot
  signal awready_zipaxil_dbg : std_logic;                     -- Address Write Ready

  -- Write Data Channel
  signal wvalid_zipaxil_dbg : std_logic;                                              -- Write Data Valid
  signal wdata_zipaxil_dbg  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);        -- Write Data
  signal wstrb_zipaxil_dbg  : std_logic_vector((G_AXI_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
  signal wready_zipaxil_dbg : std_logic;                                              -- Write data Ready

  -- Write Response Channel
  signal bready_zipaxil_dbg : std_logic;                     -- Write Channel Response
  signal bvalid_zipaxil_dbg : std_logic;                     -- Write Response Channel Valid
  signal bresp_zipaxil_dbg  : std_logic_vector(1 downto 0);  -- Write Response Channel resp

  -- Read Address Channel
  signal arvalid_zipaxil_dbg : std_logic;                     -- Read Channel Valid
  signal araddr_zipaxil_dbg  : std_logic_vector(7 downto 0);  -- Read Address channel Ready
  signal arprot_zipaxil_dbg  : std_logic_vector(2 downto 0);  --  Read Address channel Ready Prot
  signal arready_zipaxil_dbg : std_logic;                     -- Read Address Channel Ready

  -- Read Data Channel
  signal rready_zipaxil_dbg : std_logic;                                        -- Read Data Channel Ready
  signal rvalid_zipaxil_dbg : std_logic;                                        -- Read Data Channel Valid
  signal rdata_zipaxil_dbg  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  signal rresp_zipaxil_dbg  : std_logic_vector(1 downto 0);                     -- Read Data Channel Response


  -- # ZIPAXIL MASTER Instruction bus --
  -- Write Address Channel signals
  signal awvalid_master_instr : std_logic;                                        -- Address Write Valid
  signal awaddr_master_instr  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Address Write
  signal awprot_master_instr  : std_logic_vector(2 downto 0);                     -- Adress Write Prot
  signal awready_master_instr : std_logic;                                        -- Address Write Ready

  -- Write Data Channel
  signal wvalid_master_instr : std_logic;                                              -- Write Data Valid
  signal wdata_master_instr  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);        -- Write Data
  signal wstrb_master_instr  : std_logic_vector((G_AXI_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
  signal wready_master_instr : std_logic;                                              -- Write data Ready

  -- Write Response Channel
  signal bready_master_instr : std_logic;                     -- Write Channel Response
  signal bvalid_master_instr : std_logic;                     -- Write Response Channel Valid
  signal bresp_master_instr  : std_logic_vector(1 downto 0);  -- Write Response Channel resp

  -- Read Address Channel
  signal arvalid_master_instr : std_logic;                                        -- Read Channel Valid
  signal araddr_master_instr  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  signal arprot_master_instr  : std_logic_vector(2 downto 0);                     --  Read Address channel Ready Prot
  signal arready_master_instr : std_logic;                                        -- Read Address Channel Ready

  -- Read Data Channel
  signal rready_master_instr : std_logic;                                        -- Read Data Channel Ready
  signal rvalid_master_instr : std_logic;                                        -- Read Data Channel Valid
  signal rdata_master_instr  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  signal rresp_master_instr  : std_logic_vector(1 downto 0);                     -- Read Data Channel Response
  -- ------------------------

  -- # ZIPAXIL MASTER DATA bus --
  -- Write Address Channel signals
  signal awvalid_master_data : std_logic;                                        -- Address Write Valid
  signal awaddr_master_data  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Address Write
  signal awprot_master_data  : std_logic_vector(2 downto 0);                     -- Adress Write Prot
  signal awready_master_data : std_logic;                                        -- Address Write Ready

  -- Write Data Channel
  signal wvalid_master_data : std_logic;                                              -- Write Data Valid
  signal wdata_master_data  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);        -- Write Data
  signal wstrb_master_data  : std_logic_vector((G_AXI_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
  signal wready_master_data : std_logic;                                              -- Write data Ready

  -- Write Response Channel
  signal bready_master_data : std_logic;                     -- Write Channel Response
  signal bvalid_master_data : std_logic;                     -- Write Response Channel Valid
  signal bresp_master_data  : std_logic_vector(1 downto 0);  -- Write Response Channel resp

  -- Read Address Channel
  signal arvalid_master_data : std_logic;                                        -- Read Channel Valid
  signal araddr_master_data  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  signal arprot_master_data  : std_logic_vector(2 downto 0);                     --  Read Address channel Ready Prot
  signal arready_master_data : std_logic;                                        -- Read Address Channel Ready

  -- Read Data Channel
  signal rready_master_data : std_logic;                                        -- Read Data Channel Ready
  signal rvalid_master_data : std_logic;                                        -- Read Data Channel Valid
  signal rdata_master_data  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  signal rresp_master_data  : std_logic_vector(1 downto 0);                     -- Read Data Channel Response
  -- ------------------------


  -- ------------------------


  ------------------

  signal interrupt_vector : std_logic_vector(G_EXTERNAL_INTERRUPT_NB - 1 downto 0);  -- Vector of Interrupt

  -- # AXI4 Lite Interconnect Masters signals
  signal awvalid_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Address Write Valid
  signal awaddr_interco_m  : t_addr_array(0 to G_SLAVE_NB - 1);          -- Address Write    
  signal awprot_interco_m  : t_prot_array(0 to G_SLAVE_NB - 1);          -- Adress Write Prot
  signal awready_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Address Write Ready

  signal wvalid_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Write Data Valid
  signal wdata_interco_m  : t_data_array(0 to G_SLAVE_NB - 1);          -- Write Data
  signal wstrb_interco_m  : t_wstrb_array(0 to G_SLAVE_NB - 1);
  signal wready_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Write data Ready

  signal bready_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Write Channel Response
  signal bvalid_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Write Response Channel Valid
  signal bresp_interco_m  : t_resp_array(0 to G_SLAVE_NB - 1);          -- Write Response Channel resp

  signal arvalid_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Read Channel Valid
  signal araddr_interco_m  : t_addr_array(0 to G_SLAVE_NB - 1);          -- Read Address channel Ready
  signal arprot_interco_m  : t_prot_array(0 to G_SLAVE_NB - 1);          -- Read Address channel Ready Prot
  signal arready_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Read Address Channel Ready

  signal rready_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Read Data Channel Ready
  signal rvalid_interco_m : std_logic_vector(G_SLAVE_NB - 1 downto 0);  -- Read Data Channel Valid
  signal rdata_interco_m  : t_data_array(0 to G_SLAVE_NB - 1);          -- Read Data Channel rdata
  signal rresp_interco_m  : t_resp_array(0 to G_SLAVE_NB - 1);          -- Read Data Channel Resp
  -- # ----------------------


  -- SPI SLAVE --
  signal spi_slave_it : std_logic;      -- SPI Slave Interruption  
  ---------------
  signal start_clk    : std_logic;      -- Start in CLK clock domain
  signal start_clk_p1 : std_logic;      -- Start in CLK clock domain
  signal start_clk_p2 : std_logic;      -- Start in CLK clock domain

  signal start_clk_r_edge : std_logic;  -- Rising Edge of start

  signal done_master   : std_logic;     -- Done signal in clk clock domain
  signal done_extended : std_logic;     -- Done signal extended in clk clock domain


  signal done_extended_clk_jtag_p1     : std_logic;  -- Done extended resynchronize in clk_jtag clock domain
  signal done_extended_clk_jtag_p2     : std_logic;  -- Done extended resynchronize in clk_jtag clock domain
  signal done_extended_clk_jtag        : std_logic;  -- Done extended resynchronize in clk_jtag clock domain
  signal done_extended_clk_jtag_r_edge : std_logic;  -- rising edge

  signal ledr_int   : std_logic_vector(17 downto 0);  -- RED LEDS
  signal shift_reg  : std_logic_vector(31 downto 0);  -- Get TDI data
  signal lcd_on_int : std_logic;                      -- Internal LCD ON

  signal leds_gpo_int : std_logic_vector(C_GPO_WIDTH - 1 downto 0);  -- LEDS GPO outputs

  -- == DEBUG ==
  signal spi_wdata    : std_logic_vector(7 downto 0);
  signal spi_wdata_p  : std_logic_vector(7 downto 0);
  signal spi_write_en : std_logic;
begin  -- architecture rtl


  -- Instanciation of VIRTUAL JTAG Controller
  -- Generated from Quartus II
  inst_altera_vjtag_0 : altera_vjtag
    port map (
      tdo                => tdo,
      tck                => tck,
      tdi                => tdi,
      ir_in              => ir_in(7 downto 0),
      ir_out             => open,
      virtual_state_cdr  => cdr,
      virtual_state_e1dr => e1dr,
      virtual_state_e2dr => e2dr,
      virtual_state_pdr  => pdr,
      virtual_state_sdr  => sdr,
      virtual_state_udr  => udr,
      virtual_state_uir  => uir,
      virtual_state_cir  => cir
      );



  -- Virtual JTAG Instanciation
  -- TCK JTAG has a maximal frequency of 10MHz and may vary
  ii_vjtag_intf_0 : entity lib_jtag_intel.vjtag_intf
    generic map (
      G_DATA_WIDTH => 32,
      G_ADDR_WIDTH => 8,
      G_IR_WIDTH   => 8
      )
    port map(
      clk_jtag   => tck,
      rst_n_jtag => rst_n_sys,          --'1',                -- TBD pas de reset ..

      tdi   => tdi,
      tdo   => tdo,
      ir_in => ir_in(7 downto 0),
      sdr   => sdr,
      udr   => udr,
      cdr   => cdr,

      addr          => addr_vjtag,
      data_out      => wdata_vjtag,
      data_in       => rdata_vjtag,
      data_in_val   => done_extended_clk_jtag_r_edge,
      access_status => access_status_vjtag,  -- not resynchronized in clk_jtag clock domain /!\
      rnw           => rnw_vjtag,            -- not resynchronized in clk_jtag clock domain /!\
      strobe        => strobe_vjtag,         -- not resynchronized in clk_jtag clock domain /!\
      start         => start_clk_jtag
      );

  -- purpose: Double resynchronization of start_clk_jtag in clk clock domain
  p_resynch_start : process (clk_sys, rst_n_sys) is
  begin  -- process p_resynch_start
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      start_clk_p1 <= '0';
      start_clk_p2 <= '0';
      start_clk    <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      start_clk_p1 <= start_clk_jtag;
      start_clk_p2 <= start_clk_p1;
      start_clk    <= start_clk_p2;
    end if;
  end process p_resynch_start;

  -- Rising edge detection of start
  start_clk_r_edge <= start_clk_p2 and not start_clk;

  -- purpose: Resynchronization in tck clock domain of the signal done_extended
  p_ressynch_done_extended : process (tck, rst_n_sys) is
  begin  -- process p_ressynch_done_extended
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      done_extended_clk_jtag_p1 <= '0';
      done_extended_clk_jtag_p2 <= '0';
      done_extended_clk_jtag    <= '0';
    elsif rising_edge(tck) then         -- rising clock edge
      done_extended_clk_jtag_p1 <= done_extended;
      done_extended_clk_jtag_p2 <= done_extended_clk_jtag_p1;
      done_extended_clk_jtag    <= done_extended_clk_jtag_p2;
    end if;
  end process p_ressynch_done_extended;


  done_extended_clk_jtag_r_edge <= done_extended_clk_jtag_p2 and not done_extended_clk_jtag;


  -- Instanciation of bit extender
  -- Extender the pulse done_master in x width in order to be detected in the
  -- slower clock domain clk_jtag
  i_bit_extender_0 : entity lib_pulse_extender.bit_extender
    generic map(
      G_PULSE_WIDTH => 2*5
      )
    port map (
      clk_sys   => clk_sys,
      rst_n     => rst_n_sys,
      pulse_in  => done_master,
      pulse_out => done_extended
      );


  -- Instanciation of AXI4 LITE MASTER
  -- Connected to the DEBUG AXIL Bus of the ZIPCPU
  i_axi4_lite_master_0 : entity lib_axi4_lite.axi4_lite_master
    generic map(
      G_DATA_WIDTH => 32,
      G_ADDR_WIDTH => 8
      )
    port map(
      clk   => clk_sys,
      rst_n => rst_n_sys,

      start         => start_clk_r_edge,
      addr          => addr_vjtag,
      rnw           => rnw_vjtag,
      strobe        => strobe_vjtag,
      master_wdata  => wdata_vjtag,
      done          => done_master,
      master_rdata  => rdata_vjtag,
      access_status => access_status_vjtag,

      awvalid => awvalid_zipaxil_dbg,
      awaddr  => awaddr_zipaxil_dbg,
      awprot  => awprot_zipaxil_dbg,
      awready => awready_zipaxil_dbg,

      wvalid => wvalid_zipaxil_dbg,
      wdata  => wdata_zipaxil_dbg,
      wstrb  => wstrb_zipaxil_dbg,
      wready => wready_zipaxil_dbg,

      bready => bready_zipaxil_dbg,
      bvalid => bvalid_zipaxil_dbg,
      bresp  => bresp_zipaxil_dbg,

      arvalid => arvalid_zipaxil_dbg,
      araddr  => araddr_zipaxil_dbg,
      arprot  => arprot_zipaxil_dbg,
      arready => arready_zipaxil_dbg,

      rready => rready_zipaxil_dbg,
      rvalid => rvalid_zipaxil_dbg,
      rdata  => rdata_zipaxil_dbg,
      rresp  => rresp_zipaxil_dbg
      );



  -- ZIPAXIL Instanciation
  i_zipaxil_0 : zipaxil
    generic map (
      C_DBG_ADDR_WIDTH     => 8,
      ADDRESS_WIDTH        => G_AXI_ADDR_WIDTH,
      C_AXI_DATA_WIDTH     => G_AXI_DATA_WIDTH,
      OPT_LGICACHE         => 0,
      OPT_LGDCACHE         => 0,
      OPT_PIPELINED        => "0",        --'Pipelined access
      RESET_ADDRESS        => x"00000000",
      START_HALTED         => "0",
      SWAP_WSTRB           => "1",
      OPT_MPY              => 3,
      OPT_DIV              => "1",
      OPT_SHIFTS           => "1",
      OPT_LOCK             => "1",
      OPT_FPU              => "0",
      OPT_EARLY_BRANCHING  => C_OPT_EARLY_BRANCHING,
      OPT_CIS              => "1",        --"0",      -- Compressed Instruction not used
      OPT_LOWPOWER         => "0",
      OPT_DISTRIBUTED_REGS => "1",
      OPT_DBGPORT          => "0",        -- Same as start halted
      OPT_TRACE_PORT       => "0",
      OPT_PROFILER         => "0",
      OPT_USERMODE         => C_OPT_USERMODE,
      RESET_DURATION       => C_RESET_DURATION,
      OPT_SIM              => "0",
      OPT_CLKGATE          => "0"
      )
    port map(
      S_AXI_ACLK    => clk_sys,
      S_AXI_ARESETN => rst_n_sys,
      i_interrupt   => zipcpu_interrupt,  -- From ZIPAXILPERIPH
      i_cpu_reset   => '0',

      S_DBG_AWVALID => awvalid_zipaxil_dbg,
      S_DBG_AWREADY => awready_zipaxil_dbg,
      S_DBG_AWADDR  => awaddr_zipaxil_dbg,
      S_DBG_AWPROT  => awprot_zipaxil_dbg,

      S_DBG_WVALID => wvalid_zipaxil_dbg,
      S_DBG_WREADY => wready_zipaxil_dbg,
      S_DBG_WDATA  => wdata_zipaxil_dbg,
      S_DBG_WSTRB  => wstrb_zipaxil_dbg,

      S_DBG_BVALID => bvalid_zipaxil_dbg,
      S_DBG_BREADY => bready_zipaxil_dbg,

      S_DBG_BRESP => bresp_zipaxil_dbg,

      S_DBG_ARVALID => arvalid_zipaxil_dbg,
      S_DBG_ARREADY => arready_zipaxil_dbg,
      S_DBG_ARADDR  => araddr_zipaxil_dbg,

      S_DBG_ARPROT => arprot_zipaxil_dbg,

      S_DBG_RVALID => rvalid_zipaxil_dbg,
      S_DBG_RREADY => rready_zipaxil_dbg,
      S_DBG_RDATA  => rdata_zipaxil_dbg,

      S_DBG_RRESP => rresp_zipaxil_dbg,

      -- Instruction bus (master)
      M_INSN_AWVALID => awvalid_master_instr,
      M_INSN_AWREADY => awready_master_instr,
      M_INSN_AWADDR  => awaddr_master_instr,
      M_INSN_AWPROT  => awprot_master_instr,

      M_INSN_WVALID => wvalid_master_instr,
      M_INSN_WREADY => wready_master_instr,
      M_INSN_WDATA  => wdata_master_instr,
      M_INSN_WSTRB  => wstrb_master_instr,

      M_INSN_BVALID => bvalid_master_instr,
      M_INSN_BREADY => bready_master_instr,
      M_INSN_BRESP  => bresp_master_instr,

      M_INSN_ARVALID => arvalid_master_instr,
      M_INSN_ARREADY => arready_master_instr,
      M_INSN_ARADDR  => araddr_master_instr,
      M_INSN_ARPROT  => arprot_master_instr,

      M_INSN_RVALID => rvalid_master_instr,
      M_INSN_RREADY => rready_master_instr,
      M_INSN_RDATA  => rdata_master_instr,
      M_INSN_RRESP  => rresp_master_instr,

      -- DAta Bus Master
      M_DATA_AWVALID => awvalid_master_data,
      M_DATA_AWREADY => awready_master_data,
      M_DATA_AWADDR  => awaddr_master_data,

      M_DATA_AWPROT => awprot_master_data,
      M_DATA_WVALID => wvalid_master_data,

      M_DATA_WREADY => wready_master_data,
      M_DATA_WDATA  => wdata_master_data,
      M_DATA_WSTRB  => wstrb_master_data,

      M_DATA_BVALID => bvalid_master_data,
      M_DATA_BREADY => bready_master_data,
      M_DATA_BRESP  => bresp_master_data,

      M_DATA_ARVALID => arvalid_master_data,
      M_DATA_ARREADY => arready_master_data,
      M_DATA_ARADDR  => araddr_master_data,

      M_DATA_ARPROT => arprot_master_data,

      M_DATA_RVALID => rvalid_master_data,
      M_DATA_RREADY => rready_master_data,
      M_DATA_RDATA  => rdata_master_data,
      M_DATA_RRESP  => rresp_master_data,

      o_cmd_reset => cmd_reset,
      o_halted    => halted,
      o_gie       => gie,
      o_op_stall  => op_stall,
      o_pf_stall  => pf_stall,
      o_i_count   => i_count,

      o_cpu_debug => open,

      o_prof_stb   => open,
      o_prof_addr  => prof_addr,
      o_prof_ticks => open
      );



  -- Instanciation of ZIP CPU ROM for instruction
  i_axi4_lite_memory_0 : entity lib_axi4_lite_memory.axi4_lite_memory
    generic map (
      G_AXI4_LITE_ADDR_WIDTH => G_AXI_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI_DATA_WIDTH,
      G_ROM_ADDR_WIDTH       => G_ROM_ADDR_WIDTH,  -- ROM Addr Width - Shall have the size : G_AXI4_LITE_ADDR_WIDTH / 4
      G_ROM_INIT             => G_ROM_INIT
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- Write Address Channel signals
      awvalid => awvalid_master_instr,
      awaddr  => awaddr_master_instr,
      awprot  => awprot_master_instr,
      awready => awready_master_instr,

      -- Write Data Channel
      wvalid => wvalid_master_instr,
      wdata  => wdata_master_instr,
      wstrb  => wstrb_master_instr,
      wready => wready_master_instr,

      -- Write Response Channel
      bready => bready_master_instr,
      bvalid => bvalid_master_instr,
      bresp  => bresp_master_instr,

      -- Read Address Channel
      arvalid => arvalid_master_instr,
      araddr  => araddr_master_instr,
      arprot  => arprot_master_instr,
      arready => arready_master_instr,

      -- Read Data Channel
      rready => rready_master_instr,
      rvalid => rvalid_master_instr,
      rdata  => rdata_master_instr,
      rresp  => rresp_master_instr
      );





  -- AXI4 Lite Interconnect
  i_axi4_lite_interco_1_to_n : entity lib_axi4_lite.axi4_lite_interco_1_to_n
    generic map (
      G_AXI_DATA_WIDTH => G_AXI_DATA_WIDTH,
      G_AXI_ADDR_WIDTH => G_AXI_ADDR_WIDTH,
      G_SLAVE_NB       => G_SLAVE_NB
      )
    port map (
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- SLAVE INTERFACE

      -- Write Address Channel signals
      awvalid_s => awvalid_master_data,
      awaddr_s  => awaddr_master_data,
      awprot_s  => awprot_master_data,
      awready_s => awready_master_data,

      -- Write Data Channel
      wvalid_s => wvalid_master_data,
      wdata_s  => wdata_master_data,
      wstrb_s  => wstrb_master_data,
      wready_s => wready_master_data,

      -- Write Response Channel
      bready_s => bready_master_data,
      bvalid_s => bvalid_master_data,
      bresp_s  => bresp_master_data,

      -- Read Address Channel
      arvalid_s => arvalid_master_data,
      araddr_s  => araddr_master_data,
      arprot_s  => arprot_master_data,
      arready_s => arready_master_data,

      -- Read Data Channel
      rready_s => rready_master_data,
      rvalid_s => rvalid_master_data,
      rdata_s  => rdata_master_data,
      rresp_s  => rresp_master_data,


      -- MASTERS Interface
      awvalid_m => awvalid_interco_m,
      awaddr_m  => awaddr_interco_m,
      awprot_m  => awprot_interco_m,
      awready_m => awready_interco_m,

      wvalid_m => wvalid_interco_m,
      wdata_m  => wdata_interco_m,
      wstrb_m  => wstrb_interco_m,
      wready_m => wready_interco_m,

      bready_m => bready_interco_m,
      bvalid_m => bvalid_interco_m,
      bresp_m  => bresp_interco_m,

      arvalid_m => arvalid_interco_m,
      araddr_m  => araddr_interco_m,
      arprot_m  => arprot_interco_m,
      arready_m => arready_interco_m,

      rready_m => rready_interco_m,
      rvalid_m => rvalid_interco_m,
      rdata_m  => rdata_interco_m,
      rresp_m  => rresp_interco_m
      );


  p_pipe_key_1 : process (clk_sys, rst_n_sys) is
  begin  -- process p_pipe_key_1
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      key_1_p <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      key_1_p <= key_1;
    end if;
  end process p_pipe_key_1;

  key_1_f_edge <= not key_1 and key_1_p;

  -- Interruption vector affectation
  interrupt_vector(0) <= spi_slave_it;  -- Interrupt vector connected to the SPI SLAVE Interrupt
  interrupt_vector(1) <= key_1_f_edge;  -- Interruption from KEY 1 - on falling edge of KEY1

  -- Instanciation of AXIPERIPH
  i_axilperiphs_0 : axilperiphs
    generic map (
      C_AXI_ADDR_WIDTH    => C_AXI4_LITE_PERIPHS_ADDR_WIDTH,
      C_AXI_DATA_WIDTH    => C_AXI_DATA_WIDTH,
      OPT_SKIDBUFFER      => "1",       -- 1'b1,
      OPT_LOWPOWER        => "0",
      EXTERNAL_INTERRUPTS => G_EXTERNAL_INTERRUPT_NB,
      OPT_COUNTERS        => "0",
      ADDRLSB             => log2(C_AXI_DATA_WIDTH)-3
      )
    port map (
      S_AXI_ACLK    => clk_sys,
      S_AXI_ARESETN => rst_n_sys,

      S_AXI_AWVALID => awvalid_interco_m(C_ZIPCPU_PERIPH_IDX),
      S_AXI_AWREADY => awready_interco_m(C_ZIPCPU_PERIPH_IDX),
      S_AXI_AWADDR  => awaddr_interco_m(C_ZIPCPU_PERIPH_IDX)(C_AXI4_LITE_PERIPHS_ADDR_WIDTH - 1 downto 0),
      S_AXI_AWPROT  => awprot_interco_m(C_ZIPCPU_PERIPH_IDX),

      S_AXI_WVALID => wvalid_interco_m(C_ZIPCPU_PERIPH_IDX),
      S_AXI_WREADY => wready_interco_m(C_ZIPCPU_PERIPH_IDX),
      S_AXI_WDATA  => wdata_interco_m(C_ZIPCPU_PERIPH_IDX),
      S_AXI_WSTRB  => wstrb_interco_m(C_ZIPCPU_PERIPH_IDX),

      S_AXI_BVALID => bvalid_interco_m(C_ZIPCPU_PERIPH_IDX),
      S_AXI_BREADY => bready_interco_m(C_ZIPCPU_PERIPH_IDX),
      S_AXI_BRESP  => bresp_interco_m(C_ZIPCPU_PERIPH_IDX),

      S_AXI_ARVALID => arvalid_interco_m(C_ZIPCPU_PERIPH_IDX),
      S_AXI_ARREADY => arready_interco_m(C_ZIPCPU_PERIPH_IDX),
      S_AXI_ARADDR  => araddr_interco_m(C_ZIPCPU_PERIPH_IDX)(C_AXI4_LITE_PERIPHS_ADDR_WIDTH - 1 downto 0),
      S_AXI_ARPROT  => arprot_interco_m(C_ZIPCPU_PERIPH_IDX),

      S_AXI_RVALID => rvalid_interco_m(C_ZIPCPU_PERIPH_IDX),
      S_AXI_RREADY => rready_interco_m(C_ZIPCPU_PERIPH_IDX),
      S_AXI_RDATA  => rdata_interco_m(C_ZIPCPU_PERIPH_IDX),
      S_AXI_RRESP  => rresp_interco_m(C_ZIPCPU_PERIPH_IDX),

      i_cpu_reset      => '0',
      i_cpu_halted     => '0',
      i_cpu_gie        => '0',
      i_cpu_pfstall    => '0',
      i_cpu_opstall    => '0',
      i_cpu_icount     => '0',
      i_ivec           => interrupt_vector,
      o_interrupt      => zipcpu_interrupt,  -- To ZIPCPU
      o_watchdog_reset => open
      );

  -- Instanciation of AXI4 LITE 7 SEGMENT Controller
  i_axi4_lite_7segs_0 : entity lib_axi4_lite_7seg.axi4_lite_7segs
    generic map (
      G_AXI4_LITE_ADDR_WIDTH => C_AXI4_LITE_7SEGS_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI_DATA_WIDTH
      )
    port map (
      clk   => clk_sys,
      rst_n => rst_n_sys,

      -- Write Address Channel signals
      awvalid => awvalid_interco_m(C_7SEGMENTS_IDX),
      awaddr  => awaddr_interco_m(C_7SEGMENTS_IDX)(C_AXI4_LITE_7SEGS_ADDR_WIDTH - 1 downto 0),
      awprot  => awprot_interco_m(C_7SEGMENTS_IDX),
      awready => awready_interco_m(C_7SEGMENTS_IDX),

      -- Write Data Channel
      wvalid => wvalid_interco_m(C_7SEGMENTS_IDX),
      wdata  => wdata_interco_m(C_7SEGMENTS_IDX),
      wstrb  => wstrb_interco_m(C_7SEGMENTS_IDX),
      wready => wready_interco_m(C_7SEGMENTS_IDX),

      -- Write Response Channel
      bready => bready_interco_m(C_7SEGMENTS_IDX),
      bvalid => bvalid_interco_m(C_7SEGMENTS_IDX),
      bresp  => bresp_interco_m(C_7SEGMENTS_IDX),

      -- Read Address Channel
      arvalid => arvalid_interco_m(C_7SEGMENTS_IDX),
      araddr  => araddr_interco_m(C_7SEGMENTS_IDX)(C_AXI4_LITE_7SEGS_ADDR_WIDTH - 1 downto 0),
      arprot  => arprot_interco_m(C_7SEGMENTS_IDX),
      arready => arready_interco_m(C_7SEGMENTS_IDX),

      -- Read Data Channel
      rready => rready_interco_m(C_7SEGMENTS_IDX),
      rvalid => rvalid_interco_m(C_7SEGMENTS_IDX),
      rdata  => rdata_interco_m(C_7SEGMENTS_IDX),
      rresp  => rresp_interco_m(C_7SEGMENTS_IDX),

      -- 7 Segments
      o_seg0 => o_seg0,
      o_seg1 => o_seg1,
      o_seg2 => o_seg2,
      o_seg3 => o_seg3,
      o_seg4 => o_seg4,
      o_seg5 => o_seg5,
      o_seg6 => o_seg6,
      o_seg7 => o_seg7
      );

  -- Instanciation of AXI4 Lite LCD
  i_axi4_lite_lcd_0 : entity lib_axi4_lite_lcd.axi4_lite_lcd
    generic map (
      G_AXI4_LITE_ADDR_WIDTH => C_AXI4_LITE_LCD_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI_DATA_WIDTH,
      G_CLK_PERIOD_NS        => G_CLK_PERIOD_NS,
      G_BIDIR_POLARITY_READ  => G_BIDIR_POLARITY_READ,
      G_FIFO_ADDR_WIDTH      => G_FIFO_ADDR_WIDTH
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- Write Address Channel signals
      awvalid => awvalid_interco_m(C_LCD_IDX),
      awaddr  => awaddr_interco_m(C_LCD_IDX)(C_AXI4_LITE_LCD_ADDR_WIDTH -1 downto 0),
      awprot  => awprot_interco_m(C_LCD_IDX),
      awready => awready_interco_m(C_LCD_IDX),

      -- Write Data Channel
      wvalid => wvalid_interco_m(C_LCD_IDX),
      wdata  => wdata_interco_m(C_LCD_IDX),
      wstrb  => wstrb_interco_m(C_LCD_IDX),
      wready => wready_interco_m(C_LCD_IDX),

      -- Write Response Channel
      bready => bready_interco_m(C_LCD_IDX),
      bvalid => bvalid_interco_m(C_LCD_IDX),
      bresp  => bresp_interco_m(C_LCD_IDX),

      -- Read Address Channel
      arvalid => arvalid_interco_m(C_LCD_IDX),
      araddr  => araddr_interco_m(C_LCD_IDX)(C_AXI4_LITE_LCD_ADDR_WIDTH -1 downto 0),
      arprot  => arprot_interco_m(C_LCD_IDX),
      arready => arready_interco_m(C_LCD_IDX),

      -- Read Data Channel
      rready => rready_interco_m(C_LCD_IDX),
      rvalid => rvalid_interco_m(C_LCD_IDX),
      rdata  => rdata_interco_m(C_LCD_IDX),
      rresp  => rresp_interco_m(C_LCD_IDX),

      -- LCD I/F
      i_lcd_data  => i_lcd_data,
      o_lcd_wdata => o_lcd_wdata,
      o_lcd_rw    => o_lcd_rw,
      o_lcd_en    => o_lcd_en,
      o_lcd_rs    => o_lcd_rs,
      o_lcd_on    => lcd_on_int,
      o_bidir_sel => o_bidir_sel
      );

  -- Instanciation of the MAX7219 AXI Controller
  i_axi4_lite_max7219_0 : entity lib_axi4_lite_max7219.axi4_lite_max7219
    generic map (
      G_AXI4_LITE_ADDR_WIDTH => C_AXI4_LITE_MAX7219_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI_DATA_WIDTH,
      G_MATRIX_NB            => 4
      )
    port map (
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- Write Address Channel signals
      awvalid => awvalid_interco_m(C_MAX7219_IDX),
      awaddr  => awaddr_interco_m(C_MAX7219_IDX)(C_AXI4_LITE_MAX7219_ADDR_WIDTH - 1 downto 0),
      awprot  => awprot_interco_m(C_MAX7219_IDX),
      awready => awready_interco_m(C_MAX7219_IDX),

      -- Write Data Channel
      wvalid => wvalid_interco_m(C_MAX7219_IDX),
      wdata  => wdata_interco_m(C_MAX7219_IDX),
      wstrb  => wstrb_interco_m(C_MAX7219_IDX),
      wready => wready_interco_m(C_MAX7219_IDX),

      -- Write Response Channel
      bready => bready_interco_m(C_MAX7219_IDX),
      bvalid => bvalid_interco_m(C_MAX7219_IDX),
      bresp  => bresp_interco_m(C_MAX7219_IDX),

      -- Read Address Channel
      arvalid => arvalid_interco_m(C_MAX7219_IDX),
      araddr  => araddr_interco_m(C_MAX7219_IDX)(C_AXI4_LITE_MAX7219_ADDR_WIDTH - 1 downto 0),
      arprot  => arprot_interco_m(C_MAX7219_IDX),
      arready => arready_interco_m(C_MAX7219_IDX),

      -- Read Data Channel
      rready => rready_interco_m(C_MAX7219_IDX),
      rvalid => rvalid_interco_m(C_MAX7219_IDX),
      rdata  => rdata_interco_m(C_MAX7219_IDX),
      rresp  => rresp_interco_m(C_MAX7219_IDX),

      -- MAX7219 I/F
      o_max7219_load => o_max7219_load,
      o_max7219_data => o_max7219_data,
      o_max7219_clk  => o_max7219_clk
      );

  -- Instanciation of the ZIPAXIL Function
  i_axiluart_0 : axiluart
    generic map (
      INITIAL_SETUP                 => C_ZIPUART_INIT_SETUP,
      LGFLEN                        => C_ZIPUART_LGFLEN,
      HARDWARE_FLOW_CONTROL_PRESENT => C_ZIPUART_HW_FLOW_CTRL,
      LCLLGFLEN                     => C_ZIPUART_LGFLEN,
      C_AXI_ADDR_WIDTH              => 32,  --C_AXI4_LITE_ZIPUART_ADDR_WIDTH,
      C_AXI_DATA_WIDTH              => C_AXI_DATA_WIDTH,
      OPT_SKIDBUFFER                => C_ZIPUART_OPT_SKIDBUFFER,
      OPT_LOWPOWER                  => C_ZIPUART_LOWPOWER,
      ADDRLSB                       => log2(C_AXI_DATA_WIDTH)-3
      )
    port map(
      S_AXI_ACLK    => clk_sys,
      S_AXI_ARESETN => rst_n_sys,

      S_AXI_AWVALID => awvalid_interco_m(C_ZIPUART_IDX),
      S_AXI_AWREADY => awready_interco_m(C_ZIPUART_IDX),
      S_AXI_AWADDR  => awaddr_interco_m(C_ZIPUART_IDX)(C_AXI4_LITE_ZIPUART_ADDR_WIDTH - 1 downto 0),
      S_AXI_AWPROT  => awprot_interco_m(C_ZIPUART_IDX),

      S_AXI_WVALID => wvalid_interco_m(C_ZIPUART_IDX),
      S_AXI_WREADY => wready_interco_m(C_ZIPUART_IDX),
      S_AXI_WDATA  => wdata_interco_m(C_ZIPUART_IDX),
      S_AXI_WSTRB  => wstrb_interco_m(C_ZIPUART_IDX),

      S_AXI_BVALID => bvalid_interco_m(C_ZIPUART_IDX),
      S_AXI_BREADY => bready_interco_m(C_ZIPUART_IDX),
      S_AXI_BRESP  => bresp_interco_m(C_ZIPUART_IDX),

      S_AXI_ARVALID => arvalid_interco_m(C_ZIPUART_IDX),
      S_AXI_ARREADY => arready_interco_m(C_ZIPUART_IDX),
      S_AXI_ARADDR  => araddr_interco_m(C_ZIPUART_IDX)(C_AXI4_LITE_ZIPUART_ADDR_WIDTH - 1 downto 0),
      S_AXI_ARPROT  => arprot_interco_m(C_ZIPUART_IDX),

      S_AXI_RVALID => rvalid_interco_m(C_ZIPUART_IDX),
      S_AXI_RREADY => rready_interco_m(C_ZIPUART_IDX),
      S_AXI_RDATA  => rdata_interco_m(C_ZIPUART_IDX),
      S_AXI_RRESP  => rresp_interco_m(C_ZIPUART_IDX),

      i_uart_rx => i_rx_uart,
      o_uart_tx => o_tx_uart,

      i_cts_n => i_cts_n,
      o_rts_n => o_rts_n,

      o_uart_rx_int     => open,
      o_uart_tx_int     => open,
      o_uart_rxfifo_int => open,
      o_uart_txfifo_int => open
      );


  -- Instanciation of AXI4 Lite SPI MASTER
  i_axi4_lite_spi_master_0 : entity lib_axi4_lite_spi_master.axi4_lite_spi_master
    generic map(
      G_AXI4_LITE_ADDR_WIDTH => C_AXI4_LITE_SPI_MASTER_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI_DATA_WIDTH,
      G_SPI_SIZE             => G_SPI_SIZE,
      G_SPI_DATA_WIDTH       => C_SPI_DATA_WIDTH,
      G_FIFO_DATA_WIDTH      => C_SPI_FIFO_DATA_WIDTH,
      G_FIFO_DEPTH           => C_FIFO_DEPTH
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- Write Address Channel signals
      awvalid => awvalid_interco_m(C_SPI_MASTER_IDX),
      awaddr  => awaddr_interco_m(C_SPI_MASTER_IDX)(C_AXI4_LITE_SPI_MASTER_ADDR_WIDTH - 1 downto 0),
      awprot  => awprot_interco_m(C_SPI_MASTER_IDX),
      awready => awready_interco_m(C_SPI_MASTER_IDX),

      -- Write Data Channel
      wvalid => wvalid_interco_m(C_SPI_MASTER_IDX),
      wdata  => wdata_interco_m(C_SPI_MASTER_IDX),
      wstrb  => wstrb_interco_m(C_SPI_MASTER_IDX),
      wready => wready_interco_m(C_SPI_MASTER_IDX),

      -- Write Response Channel
      bready => bready_interco_m(C_SPI_MASTER_IDX),
      bvalid => bvalid_interco_m(C_SPI_MASTER_IDX),
      bresp  => bresp_interco_m(C_SPI_MASTER_IDX),

      -- Read Address Channel
      arvalid => arvalid_interco_m(C_SPI_MASTER_IDX),
      araddr  => araddr_interco_m(C_SPI_MASTER_IDX)(C_AXI4_LITE_SPI_MASTER_ADDR_WIDTH - 1 downto 0),
      arprot  => arprot_interco_m(C_SPI_MASTER_IDX),
      arready => arready_interco_m(C_SPI_MASTER_IDX),

      -- Read Data Channel
      rready => rready_interco_m(C_SPI_MASTER_IDX),
      rvalid => rvalid_interco_m(C_SPI_MASTER_IDX),
      rdata  => rdata_interco_m(C_SPI_MASTER_IDX),
      rresp  => rresp_interco_m(C_SPI_MASTER_IDX),

      -- SPI MASTER I/F
      spi_clk  => spi_clk,
      spi_cs_n => spi_cs_n,
      spi_do   => spi_do,
      spi_di   => spi_di
      );


  -- Instanciation AXI4 Lite SPI Slave
  i_axi4_lite_spi_slave_0 : entity lib_axi4_lite_spi_slave.axi4_lite_spi_slave
    generic map (
      G_AXI4_LITE_ADDR_WIDTH => C_AXI4_LITE_SPI_SLAVE_ADDR_WIDTH,  -- AXI4 Lite ADDR WIDTH
      G_AXI4_LITE_DATA_WIDTH => G_AXI_DATA_WIDTH,                  -- AXI4 Lite DATA WIDTH
      G_SPI_SIZE             => 4,                                 -- SPI Size
      G_SPI_DATA_WIDTH       => 8,                                 -- SPI DATA WIDTH
      G_FIFO_DATA_WIDTH      => 8,                                 -- FIFO DATA WIDTH
      G_FIFO_DEPTH           => 1024,                              -- FIFO DEPTH
      G_CPHA                 => '1',                               -- CPHA HARD Configuration
      G_CPOL                 => '0'                                -- CPOL HARD Configuration
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- Write Address Channel signals
      awvalid => awvalid_interco_m(C_SPI_SLAVE_IDX),
      awaddr  => awaddr_interco_m(C_SPI_SLAVE_IDX)(C_AXI4_LITE_SPI_SLAVE_ADDR_WIDTH - 1 downto 0),
      awprot  => awprot_interco_m(C_SPI_SLAVE_IDX),
      awready => awready_interco_m(C_SPI_SLAVE_IDX),

      -- Write Data Channel
      wvalid => wvalid_interco_m(C_SPI_SLAVE_IDX),
      wdata  => wdata_interco_m(C_SPI_SLAVE_IDX),
      wstrb  => wstrb_interco_m(C_SPI_SLAVE_IDX),
      wready => wready_interco_m(C_SPI_SLAVE_IDX),

      -- Write Response Channel
      bready => bready_interco_m(C_SPI_SLAVE_IDX),
      bvalid => bvalid_interco_m(C_SPI_SLAVE_IDX),
      bresp  => bresp_interco_m(C_SPI_SLAVE_IDX),

      -- Read Address Channel
      arvalid => arvalid_interco_m(C_SPI_SLAVE_IDX),
      araddr  => araddr_interco_m(C_SPI_SLAVE_IDX)(C_AXI4_LITE_SPI_SLAVE_ADDR_WIDTH - 1 downto 0),
      arprot  => arprot_interco_m(C_SPI_SLAVE_IDX),
      arready => arready_interco_m(C_SPI_SLAVE_IDX),

      -- Read Data Channel
      rready => rready_interco_m(C_SPI_SLAVE_IDX),
      rvalid => rvalid_interco_m(C_SPI_SLAVE_IDX),
      rdata  => rdata_interco_m(C_SPI_SLAVE_IDX),
      rresp  => rresp_interco_m(C_SPI_SLAVE_IDX),

      -- SPI SLAVE I/F
      spi_clk      => spi_slave_clk,
      spi_cs_n     => spi_slave_cs_n,
      spi_do       => spi_slave_do,
      spi_di       => spi_slave_di,
      spi_slave_it => spi_slave_it
      );

  -- Instanciation of I2C Master AXI4 Lite - EEPROM management
  i_axi4_lite_i2c_master_eeprom_0 : entity lib_axi4_lite_i2c_master.axi4_lite_i2c_master
    generic map(
      G_AXI4_LITE_ADDR_WIDTH => C_AXI4_LITE_I2C_MASTER_EEPROM_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI_DATA_WIDTH,
      G_NB_DATA              => 256,      -- FIFO DATA WIDTH
      G_FIFO_DATA_WIDTH      => 8,        -- FIFO DATA WIDTH
      G_FIFO_DEPTH           => 1024,     -- FIFO DEPTH
      G_I2C_FREQ             => 400000,   -- '0' : 100kHz - '1' : 400kHz
      G_CLKSYS_FREQ          => 50000000  -- clk_sys frequency
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- Write Address Channel signals
      awvalid => awvalid_interco_m(C_I2C_MASTER_EEPROM_IDX),
      awaddr  => awaddr_interco_m(C_I2C_MASTER_EEPROM_IDX)(C_AXI4_LITE_I2C_MASTER_EEPROM_ADDR_WIDTH - 1 downto 0),
      awprot  => awprot_interco_m(C_I2C_MASTER_EEPROM_IDX),
      awready => awready_interco_m(C_I2C_MASTER_EEPROM_IDX),

      -- Write Data Channel
      wvalid => wvalid_interco_m(C_I2C_MASTER_EEPROM_IDX),
      wdata  => wdata_interco_m(C_I2C_MASTER_EEPROM_IDX),
      wstrb  => wstrb_interco_m(C_I2C_MASTER_EEPROM_IDX),
      wready => wready_interco_m(C_I2C_MASTER_EEPROM_IDX),

      -- Write Response Channel
      bready => bready_interco_m(C_I2C_MASTER_EEPROM_IDX),
      bvalid => bvalid_interco_m(C_I2C_MASTER_EEPROM_IDX),
      bresp  => bresp_interco_m(C_I2C_MASTER_EEPROM_IDX),

      -- Read Address Channel
      arvalid => arvalid_interco_m(C_I2C_MASTER_EEPROM_IDX),
      araddr  => araddr_interco_m(C_I2C_MASTER_EEPROM_IDX)(C_AXI4_LITE_I2C_MASTER_EEPROM_ADDR_WIDTH - 1 downto 0),
      arprot  => arprot_interco_m(C_I2C_MASTER_EEPROM_IDX),
      arready => arready_interco_m(C_I2C_MASTER_EEPROM_IDX),

      -- Read Data Channel
      rready => rready_interco_m(C_I2C_MASTER_EEPROM_IDX),
      rvalid => rvalid_interco_m(C_I2C_MASTER_EEPROM_IDX),
      rdata  => rdata_interco_m(C_I2C_MASTER_EEPROM_IDX),
      rresp  => rresp_interco_m(C_I2C_MASTER_EEPROM_IDX),

      -- I2C MASTER I/F   
      sclk    => sclk_eeprom,
      sclk_en => sclk_en_eeprom,
      sda_in  => sda_in_eeprom,
      sda_out => sda_out_eeprom,
      sda_en  => sda_en_eeprom
      );

  -- Instanciation of GPO AXI4 Lite
  i_axi4_lite_gpo_0 : entity lib_axi4_lite_gpio.axi4_lite_gpo
    generic map (
      G_AXI4_LITE_ADDR_WIDTH => C_AXI4_LITE_GPO_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI_DATA_WIDTH,
      G_GPO_WIDTH            => C_GPO_WIDTH
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- Write Address Channel signals
      awvalid => awvalid_interco_m(C_GPO_IDX),
      awaddr  => awaddr_interco_m(C_GPO_IDX)(C_AXI4_LITE_GPO_ADDR_WIDTH - 1 downto 0),
      awprot  => awprot_interco_m(C_GPO_IDX),
      awready => awready_interco_m(C_GPO_IDX),

      -- Write Data Channel
      wvalid => wvalid_interco_m(C_GPO_IDX),
      wdata  => wdata_interco_m(C_GPO_IDX),
      wstrb  => wstrb_interco_m(C_GPO_IDX),
      wready => wready_interco_m(C_GPO_IDX),

      -- Write Response Channel
      bready => bready_interco_m(C_GPO_IDX),
      bvalid => bvalid_interco_m(C_GPO_IDX),
      bresp  => bresp_interco_m(C_GPO_IDX),

      -- Read Address Channel
      arvalid => arvalid_interco_m(C_GPO_IDX),
      araddr  => araddr_interco_m(C_GPO_IDX)(C_AXI4_LITE_GPO_ADDR_WIDTH - 1 downto 0),
      arprot  => arprot_interco_m(C_GPO_IDX),
      arready => arready_interco_m(C_GPO_IDX),

      -- Read Data Channel
      rready => rready_interco_m(C_GPO_IDX),
      rvalid => rvalid_interco_m(C_GPO_IDX),
      rdata  => rdata_interco_m(C_GPO_IDX),
      rresp  => rresp_interco_m(C_GPO_IDX),

      -- GPO Control
      gpo => leds_gpo_int
      );


  -- == DEBUG ==
  p_spi_wdata_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_spi_wdata_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      spi_wdata_p <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge
      if(spi_write_en = '1') then
        spi_wdata_p <= spi_wdata;
      end if;
    end if;
  end process p_spi_wdata_mngt;

  -- ZIPCPU Single outputs
  ledr_int(0)            <= cmd_reset;
  ledr_int(1)            <= halted;
  ledr_int(2)            <= gie;
  ledr_int(3)            <= op_stall;
  ledr_int(4)            <= pf_stall;
  ledr_int(5)            <= i_count;
  ledr_int(17 downto 10) <= spi_wdata_p;  -- DEBUG PURPOSE

  ledr_int(9 downto 6) <= (others => '0');

  -- == Outputs Affectations ==
  ledr             <= ledr_int;
  o_lcd_on         <= lcd_on_int;
  ledg(7 downto 0) <= leds_gpo_int; -- FROM GPO
  ledg(8)          <= lcd_on_int;

end architecture rtl;




