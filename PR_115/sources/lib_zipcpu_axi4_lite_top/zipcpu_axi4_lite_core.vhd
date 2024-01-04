-------------------------------------------------------------------------------
-- Title      : Core of JTAG AXI4 Lite
-- Project    : 
-------------------------------------------------------------------------------
-- File       : jtag_axi4_lite_core.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-18
-- Last update: 2024-01-04
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
    G_EXTERNAL_INTERRUPT_NB : integer                := 16    -- External Interruption of the ZIPCPU Configuration
    );
  port (
    clk_sys   : in std_logic;                                 -- Clock System
    rst_n_sys : in std_logic;                                 -- Asynchronous Reset

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

  -- # AXI4 Lite ZIPCPU PERIPHERALS signals --
  -- Write Address Channel signals
  signal awvalid_periphs : std_logic;                                                      -- Address Write Valid
  signal awaddr_periphs  : std_logic_vector(C_AXI4_LITE_PERIPHS_ADDR_WIDTH - 1 downto 0);  -- Address Write
  signal awprot_periphs  : std_logic_vector(2 downto 0);                                   -- Adress Write Prot
  signal awready_periphs : std_logic;                                                      -- Address Write Ready

  -- Write Data Channel
  signal wvalid_periphs : std_logic;                                              -- Write Data Valid
  signal wdata_periphs  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);        -- Write Data
  signal wstrb_periphs  : std_logic_vector((G_AXI_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
  signal wready_periphs : std_logic;                                              -- Write data Ready

  -- Write Response Channel
  signal bready_periphs : std_logic;                     -- Write Channel Response
  signal bvalid_periphs : std_logic;                     -- Write Response Channel Valid
  signal bresp_periphs  : std_logic_vector(1 downto 0);  -- Write Response Channel resp

  -- Read Address Channel
  signal arvalid_periphs : std_logic;                                                      -- Read Channel Valid
  signal araddr_periphs  : std_logic_vector(C_AXI4_LITE_PERIPHS_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  signal arprot_periphs  : std_logic_vector(2 downto 0);                                   --  Read Address channel Ready Prot
  signal arready_periphs : std_logic;                                                      -- Read Address Channel Ready

  -- Read Data Channel
  signal rready_periphs : std_logic;                                        -- Read Data Channel Ready
  signal rvalid_periphs : std_logic;                                        -- Read Data Channel Valid
  signal rdata_periphs  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  signal rresp_periphs  : std_logic_vector(1 downto 0);                     -- Read Data Channel Response
  -- ------------------------

  -- # AXI4 Lite LCD signals --
  -- Write Address Channel signals
  signal awvalid_lcd : std_logic;                                                  -- Address Write Valid
  signal awaddr_lcd  : std_logic_vector(C_AXI4_LITE_LCD_ADDR_WIDTH - 1 downto 0);  -- Address Write
  signal awprot_lcd  : std_logic_vector(2 downto 0);                               -- Adress Write Prot
  signal awready_lcd : std_logic;                                                  -- Address Write Ready

  -- Write Data Channel
  signal wvalid_lcd : std_logic;                                              -- Write Data Valid
  signal wdata_lcd  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);        -- Write Data
  signal wstrb_lcd  : std_logic_vector((G_AXI_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
  signal wready_lcd : std_logic;                                              -- Write data Ready

  -- Write Response Channel
  signal bready_lcd : std_logic;                     -- Write Channel Response
  signal bvalid_lcd : std_logic;                     -- Write Response Channel Valid
  signal bresp_lcd  : std_logic_vector(1 downto 0);  -- Write Response Channel resp

  -- Read Address Channel
  signal arvalid_lcd : std_logic;                                                  -- Read Channel Valid
  signal araddr_lcd  : std_logic_vector(C_AXI4_LITE_LCD_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  signal arprot_lcd  : std_logic_vector(2 downto 0);                               --  Read Address channel Ready Prot
  signal arready_lcd : std_logic;                                                  -- Read Address Channel Ready

  -- Read Data Channel
  signal rready_lcd : std_logic;                                        -- Read Data Channel Ready
  signal rvalid_lcd : std_logic;                                        -- Read Data Channel Valid
  signal rdata_lcd  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  signal rresp_lcd  : std_logic_vector(1 downto 0);                     -- Read Data Channel Response
  -- ------------------------

  -- # AXI4 Lite 7 SEGS signals --
  -- Write Address Channel signals
  signal awvalid_7segs : std_logic;                                                    -- Address Write Valid
  signal awaddr_7segs  : std_logic_vector(C_AXI4_LITE_7SEGS_ADDR_WIDTH - 1 downto 0);  -- Address Write
  signal awprot_7segs  : std_logic_vector(2 downto 0);                                 -- Adress Write Prot
  signal awready_7segs : std_logic;                                                    -- Address Write Ready

  -- Write Data Channel
  signal wvalid_7segs : std_logic;                                              -- Write Data Valid
  signal wdata_7segs  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);        -- Write Data
  signal wstrb_7segs  : std_logic_vector((G_AXI_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
  signal wready_7segs : std_logic;                                              -- Write data Ready

  -- Write Response Channel
  signal bready_7segs : std_logic;                     -- Write Channel Response
  signal bvalid_7segs : std_logic;                     -- Write Response Channel Valid
  signal bresp_7segs  : std_logic_vector(1 downto 0);  -- Write Response Channel resp

  -- Read Address Channel
  signal arvalid_7segs : std_logic;                                                    -- Read Channel Valid
  signal araddr_7segs  : std_logic_vector(C_AXI4_LITE_7SEGS_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  signal arprot_7segs  : std_logic_vector(2 downto 0);                                 --  Read Address channel Ready Prot
  signal arready_7segs : std_logic;                                                    -- Read Address Channel Ready

  -- Read Data Channel
  signal rready_7segs : std_logic;                                        -- Read Data Channel Ready
  signal rvalid_7segs : std_logic;                                        -- Read Data Channel Valid
  signal rdata_7segs  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  signal rresp_7segs  : std_logic_vector(1 downto 0);                     -- Read Data Channel Response
  -- ------------------------

  -- # AXI4 Lite MAX7219 signals --
  -- Write Address Channel signals
  signal awvalid_max7219 : std_logic;                                                      -- Address Write Valid
  signal awaddr_max7219  : std_logic_vector(C_AXI4_LITE_MAX7219_ADDR_WIDTH - 1 downto 0);  -- Address Write
  signal awprot_max7219  : std_logic_vector(2 downto 0);                                   -- Adress Write Prot
  signal awready_max7219 : std_logic;                                                      -- Address Write Ready

  -- Write Data Channel
  signal wvalid_max7219 : std_logic;                                              -- Write Data Valid
  signal wdata_max7219  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);        -- Write Data
  signal wstrb_max7219  : std_logic_vector((G_AXI_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
  signal wready_max7219 : std_logic;                                              -- Write data Ready

  -- Write Response Channel
  signal bready_max7219 : std_logic;                     -- Write Channel Response
  signal bvalid_max7219 : std_logic;                     -- Write Response Channel Valid
  signal bresp_max7219  : std_logic_vector(1 downto 0);  -- Write Response Channel resp

  -- Read Address Channel
  signal arvalid_max7219 : std_logic;                                                      -- Read Channel Valid
  signal araddr_max7219  : std_logic_vector(C_AXI4_LITE_MAX7219_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  signal arprot_max7219  : std_logic_vector(2 downto 0);                                   --  Read Address channel Ready Prot
  signal arready_max7219 : std_logic;                                                      -- Read Address Channel Ready

  -- Read Data Channel
  signal rready_max7219 : std_logic;                                        -- Read Data Channel Ready
  signal rvalid_max7219 : std_logic;                                        -- Read Data Channel Valid
  signal rdata_max7219  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  signal rresp_max7219  : std_logic_vector(1 downto 0);                     -- Read Data Channel Response
  -- ------------------------

  -- # AXI4 Lite ZIPUART signals --
  -- Write Address Channel signals
  signal awvalid_zipuart : std_logic;                                                      -- Address Write Valid
  signal awaddr_zipuart  : std_logic_vector(C_AXI4_LITE_ZIPUART_ADDR_WIDTH - 1 downto 0);  -- Address Write
  signal awprot_zipuart  : std_logic_vector(2 downto 0);                                   -- Adress Write Prot
  signal awready_zipuart : std_logic;                                                      -- Address Write Ready

  -- Write Data Channel
  signal wvalid_zipuart : std_logic;                                              -- Write Data Valid
  signal wdata_zipuart  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);        -- Write Data
  signal wstrb_zipuart  : std_logic_vector((G_AXI_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
  signal wready_zipuart : std_logic;                                              -- Write data Ready

  -- Write Response Channel
  signal bready_zipuart : std_logic;                     -- Write Channel Response
  signal bvalid_zipuart : std_logic;                     -- Write Response Channel Valid
  signal bresp_zipuart  : std_logic_vector(1 downto 0);  -- Write Response Channel resp

  -- Read Address Channel
  signal arvalid_zipuart : std_logic;                                                      -- Read Channel Valid
  signal araddr_zipuart  : std_logic_vector(C_AXI4_LITE_ZIPUART_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  signal arprot_zipuart  : std_logic_vector(2 downto 0);                                   --  Read Address channel Ready Prot
  signal arready_zipuart : std_logic;                                                      -- Read Address Channel Ready

  -- Read Data Channel
  signal rready_zipuart : std_logic;                                        -- Read Data Channel Ready
  signal rvalid_zipuart : std_logic;                                        -- Read Data Channel Valid
  signal rdata_zipuart  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  signal rresp_zipuart  : std_logic_vector(1 downto 0);                     -- Read Data Channel Response
  -- ------------------------

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

begin  -- architecture rtl

  -- Set DEBUG Port of the CPU to '0'
  -- awvalid_zipaxil_dbg <= '0';
  -- awaddr_zipaxil_dbg  <= (others => '0');
  -- awprot_zipaxil_dbg  <= (others => '0');
  -- wvalid_zipaxil_dbg  <= '0';
  -- wdata_zipaxil_dbg   <= (others => '0');
  -- wstrb_zipaxil_dbg   <= (others => '0');
  -- bready_zipaxil_dbg  <= '0';
  -- arvalid_zipaxil_dbg <= '0';
  -- araddr_zipaxil_dbg  <= (others => '0');
  -- arprot_zipaxil_dbg  <= (others => '0');
  -- rready_zipaxil_dbg  <= '0';

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
      OPT_PIPELINED        => "0",      --'Pipelined access
      RESET_ADDRESS        => x"00000000",
      START_HALTED         => "0",
      SWAP_WSTRB           => "1",
      OPT_MPY              => 3,
      OPT_DIV              => "1",
      OPT_SHIFTS           => "1",
      OPT_LOCK             => "1",
      OPT_FPU              => "0",
      OPT_EARLY_BRANCHING  => "1",
      OPT_CIS              => "1",      --"0",      -- Compressed Instruction not used
      OPT_LOWPOWER         => "0",
      OPT_DISTRIBUTED_REGS => "1",
      OPT_DBGPORT          => "0",      -- Same as start halted
      OPT_TRACE_PORT       => "0",
      OPT_PROFILER         => "0",
      OPT_USERMODE         => "1",
      RESET_DURATION       => 10,
      OPT_SIM              => "0",
      OPT_CLKGATE          => "0"
      )
    port map(
      S_AXI_ACLK    => clk_sys,
      S_AXI_ARESETN => rst_n_sys,
      i_interrupt   => zipcpu_interrupt,
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


  -- Interconnect Master's connected to AXI4 Lite Slave
  -- Index 0 -> AXI4 Lite 7SEGMENTS
  -- Index 1 -> AXI4 Lite LCD
  -- Index 2 -> AXI4 Lite ZIPCPU PERIPHerals
  -- Index 3 -> AXI4 Lite MAX7219
  -- Index 4 -> AXI4 Lite ZIPUART

  -- # - SEGMENTS Interconnexion
  -- Write Addr Channel
  awvalid_7segs        <= awvalid_interco_m(0);
  awaddr_7segs         <= awaddr_interco_m(0)(C_AXI4_LITE_7SEGS_ADDR_WIDTH - 1 downto 0);
  awprot_7segs         <= awprot_interco_m(0);
  awready_interco_m(0) <= awready_7segs;

  -- Write Data Channel
  wvalid_7segs        <= wvalid_interco_m(0);
  wdata_7segs         <= wdata_interco_m(0);
  wstrb_7segs         <= wstrb_interco_m(0);
  wready_interco_m(0) <= wready_7segs;

  -- Write Response Channel
  bready_7segs        <= bready_interco_m(0);
  bvalid_interco_m(0) <= bvalid_7segs;
  bresp_interco_m(0)  <= bresp_7segs;

  -- Read Addr Channel
  arvalid_7segs        <= arvalid_interco_m(0);
  araddr_7segs         <= araddr_interco_m(0)(C_AXI4_LITE_7SEGS_ADDR_WIDTH - 1 downto 0);
  arprot_7segs         <= arprot_interco_m(0);
  arready_interco_m(0) <= arready_7segs;

  -- Read DAta Channel
  rready_7segs        <= rready_interco_m(0);
  rvalid_interco_m(0) <= rvalid_7segs;
  rdata_interco_m(0)  <= rdata_7segs;
  rresp_interco_m(0)  <= rresp_7segs;


  -- # - LCD Interconnexion
  -- Write Addr Channel
  awvalid_lcd          <= awvalid_interco_m(1);
  awaddr_lcd           <= awaddr_interco_m(1)(C_AXI4_LITE_LCD_ADDR_WIDTH - 1 downto 0);
  awprot_lcd           <= awprot_interco_m(1);
  awready_interco_m(1) <= awready_lcd;

  -- Write Data Channel
  wvalid_lcd          <= wvalid_interco_m(1);
  wdata_lcd           <= wdata_interco_m(1);
  wstrb_lcd           <= wstrb_interco_m(1);
  wready_interco_m(1) <= wready_lcd;

  -- Write Response Channel
  bready_lcd          <= bready_interco_m(1);
  bvalid_interco_m(1) <= bvalid_lcd;
  bresp_interco_m(1)  <= bresp_lcd;

  -- Read Addr Channel
  arvalid_lcd          <= arvalid_interco_m(1);
  araddr_lcd           <= araddr_interco_m(1)(C_AXI4_LITE_LCD_ADDR_WIDTH - 1 downto 0);
  arprot_lcd           <= arprot_interco_m(1);
  arready_interco_m(1) <= arready_lcd;

  -- Read DAta Channel
  rready_lcd          <= rready_interco_m(1);
  rvalid_interco_m(1) <= rvalid_lcd;
  rdata_interco_m(1)  <= rdata_lcd;
  rresp_interco_m(1)  <= rresp_lcd;

  -- # - ZIPCPU PERIPHERALS Interconnexion
  -- Write Addr Channel
  awvalid_periphs      <= awvalid_interco_m(2);
  awaddr_periphs       <= awaddr_interco_m(2)(C_AXI4_LITE_PERIPHS_ADDR_WIDTH - 1 downto 0);
  awprot_periphs       <= awprot_interco_m(2);
  awready_interco_m(2) <= awready_periphs;

  -- Write Data Channel
  wvalid_periphs      <= wvalid_interco_m(2);
  wdata_periphs       <= wdata_interco_m(2);
  wstrb_periphs       <= wstrb_interco_m(2);
  wready_interco_m(2) <= wready_periphs;

  -- Write Response Channel
  bready_periphs      <= bready_interco_m(2);
  bvalid_interco_m(2) <= bvalid_periphs;
  bresp_interco_m(2)  <= bresp_periphs;

  -- Read Addr Channel
  arvalid_periphs      <= arvalid_interco_m(2);
  araddr_periphs       <= araddr_interco_m(2)(C_AXI4_LITE_PERIPHS_ADDR_WIDTH - 1 downto 0);
  arprot_periphs       <= arprot_interco_m(2);
  arready_interco_m(2) <= arready_periphs;

  -- Read DAta Channel
  rready_periphs      <= rready_interco_m(2);
  rvalid_interco_m(2) <= rvalid_periphs;
  rdata_interco_m(2)  <= rdata_periphs;
  rresp_interco_m(2)  <= rresp_periphs;

  -- # - AXI4 LITE MAX7219 Interconnexion
  -- Write Addr Channel
  awvalid_max7219      <= awvalid_interco_m(3);
  awaddr_max7219       <= awaddr_interco_m(3)(C_AXI4_LITE_MAX7219_ADDR_WIDTH - 1 downto 0);
  awprot_max7219       <= awprot_interco_m(3);
  awready_interco_m(3) <= awready_max7219;

  -- Write Data Channel
  wvalid_max7219      <= wvalid_interco_m(3);
  wdata_max7219       <= wdata_interco_m(3);
  wstrb_max7219       <= wstrb_interco_m(3);
  wready_interco_m(3) <= wready_max7219;

  -- Write Response Channel
  bready_max7219      <= bready_interco_m(3);
  bvalid_interco_m(3) <= bvalid_max7219;
  bresp_interco_m(3)  <= bresp_max7219;

  -- Read Addr Channel
  arvalid_max7219      <= arvalid_interco_m(3);
  araddr_max7219       <= araddr_interco_m(3)(C_AXI4_LITE_MAX7219_ADDR_WIDTH - 1 downto 0);
  arprot_max7219       <= arprot_interco_m(3);
  arready_interco_m(3) <= arready_max7219;

  -- Read DAta Channel
  rready_max7219      <= rready_interco_m(3);
  rvalid_interco_m(3) <= rvalid_max7219;
  rdata_interco_m(3)  <= rdata_max7219;
  rresp_interco_m(3)  <= rresp_max7219;

  -- # - AXI4 LITE ZIPUART Interconnexion
  -- Write Addr Channel
  awvalid_zipuart      <= awvalid_interco_m(4);
  awaddr_zipuart       <= awaddr_interco_m(4)(C_AXI4_LITE_ZIPUART_ADDR_WIDTH - 1 downto 0);
  awprot_zipuart       <= awprot_interco_m(4);
  awready_interco_m(4) <= awready_zipuart;

  -- Write Data Channel
  wvalid_zipuart      <= wvalid_interco_m(4);
  wdata_zipuart       <= wdata_interco_m(4);
  wstrb_zipuart       <= wstrb_interco_m(4);
  wready_interco_m(4) <= wready_zipuart;

  -- Write Response Channel
  bready_zipuart      <= bready_interco_m(4);
  bvalid_interco_m(4) <= bvalid_zipuart;
  bresp_interco_m(4)  <= bresp_zipuart;

  -- Read Addr Channel
  arvalid_zipuart      <= arvalid_interco_m(4);
  araddr_zipuart       <= araddr_interco_m(4)(C_AXI4_LITE_ZIPUART_ADDR_WIDTH - 1 downto 0);
  arprot_zipuart       <= arprot_interco_m(4);
  arready_interco_m(4) <= arready_zipuart;

  -- Read DAta Channel
  rready_zipuart      <= rready_interco_m(4);
  rvalid_interco_m(4) <= rvalid_zipuart;
  rdata_interco_m(4)  <= rdata_zipuart;
  rresp_interco_m(4)  <= rresp_zipuart;

  interrupt_vector <= (others => '0');

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

      S_AXI_AWVALID => awvalid_periphs,
      S_AXI_AWREADY => awready_periphs,
      S_AXI_AWADDR  => awaddr_periphs,
      S_AXI_AWPROT  => awprot_periphs,

      S_AXI_WVALID => wvalid_periphs,
      S_AXI_WREADY => wready_periphs,
      S_AXI_WDATA  => wdata_periphs,
      S_AXI_WSTRB  => wstrb_periphs,

      S_AXI_BVALID => bvalid_periphs,
      S_AXI_BREADY => bready_periphs,
      S_AXI_BRESP  => bresp_periphs,

      S_AXI_ARVALID => arvalid_periphs,
      S_AXI_ARREADY => arready_periphs,
      S_AXI_ARADDR  => araddr_periphs,
      S_AXI_ARPROT  => arprot_periphs,

      S_AXI_RVALID => rvalid_periphs,
      S_AXI_RREADY => rready_periphs,
      S_AXI_RDATA  => rdata_periphs,
      S_AXI_RRESP  => rresp_periphs,

      i_cpu_reset      => '0',
      i_cpu_halted     => '0',
      i_cpu_gie        => '0',
      i_cpu_pfstall    => '0',
      i_cpu_opstall    => '0',
      i_cpu_icount     => '0',
      i_ivec           => interrupt_vector,
      o_interrupt      => zipcpu_interrupt,
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
      awvalid => awvalid_7segs,
      awaddr  => awaddr_7segs,
      awprot  => awprot_7segs,
      awready => awready_7segs,

      -- Write Data Channel
      wvalid => wvalid_7segs,
      wdata  => wdata_7segs,
      wstrb  => wstrb_7segs,
      wready => wready_7segs,

      -- Write Response Channel
      bready => bready_7segs,
      bvalid => bvalid_7segs,
      bresp  => bresp_7segs,

      -- Read Address Channel
      arvalid => arvalid_7segs,
      araddr  => araddr_7segs,
      arprot  => arprot_7segs,
      arready => arready_7segs,

      -- Read Data Channel
      rready => rready_7segs,
      rvalid => rvalid_7segs,
      rdata  => rdata_7segs,
      rresp  => rresp_7segs,

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
      awvalid => awvalid_lcd,
      awaddr  => awaddr_lcd,
      awprot  => awprot_lcd,
      awready => awready_lcd,

      -- Write Data Channel
      wvalid => wvalid_lcd,
      wdata  => wdata_lcd,
      wstrb  => wstrb_lcd,
      wready => wready_lcd,

      -- Write Response Channel
      bready => bready_lcd,
      bvalid => bvalid_lcd,
      bresp  => bresp_lcd,

      -- Read Address Channel
      arvalid => arvalid_lcd,
      araddr  => araddr_lcd,
      arprot  => arprot_lcd,
      arready => arready_lcd,

      -- Read Data Channel
      rready => rready_lcd,
      rvalid => rvalid_lcd,
      rdata  => rdata_lcd,
      rresp  => rresp_lcd,

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
      awvalid => awvalid_max7219,
      awaddr  => awaddr_max7219,
      awprot  => awprot_max7219,
      awready => awready_max7219,

      -- Write Data Channel
      wvalid => wvalid_max7219,
      wdata  => wdata_max7219,
      wstrb  => wstrb_max7219,
      wready => wready_max7219,

      -- Write Response Channel
      bready => bready_max7219,
      bvalid => bvalid_max7219,
      bresp  => bresp_max7219,

      -- Read Address Channel
      arvalid => arvalid_max7219,
      araddr  => araddr_max7219,
      arprot  => arprot_max7219,
      arready => arready_max7219,

      -- Read Data Channel
      rready => rready_max7219,
      rvalid => rvalid_max7219,
      rdata  => rdata_max7219,
      rresp  => rresp_max7219,

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

      S_AXI_AWVALID => awvalid_zipuart,
      S_AXI_AWREADY => awready_zipuart,
      S_AXI_AWADDR  => awaddr_zipuart,
      S_AXI_AWPROT  => awprot_zipuart,

      S_AXI_WVALID => wvalid_zipuart,
      S_AXI_WREADY => wready_zipuart,
      S_AXI_WDATA  => wdata_zipuart,
      S_AXI_WSTRB  => wstrb_zipuart,

      S_AXI_BVALID => bvalid_zipuart,
      S_AXI_BREADY => bready_zipuart,
      S_AXI_BRESP  => bresp_zipuart,

      S_AXI_ARVALID => arvalid_zipuart,
      S_AXI_ARREADY => arready_zipuart,
      S_AXI_ARADDR  => araddr_zipuart,
      S_AXI_ARPROT  => arprot_zipuart,

      S_AXI_RVALID => rvalid_zipuart,
      S_AXI_RREADY => rready_zipuart,
      S_AXI_RDATA  => rdata_zipuart,
      S_AXI_RRESP  => rresp_zipuart,

      i_uart_rx => i_rx_uart,
      o_uart_tx => o_tx_uart,

      i_cts_n => i_cts_n,
      o_rts_n => o_rts_n,

      o_uart_rx_int     => open,
      o_uart_tx_int     => open,
      o_uart_rxfifo_int => open,
      o_uart_txfifo_int => open
      );

  -- ZIPCPU Single outputs
  ledr_int(0)           <= cmd_reset;
  ledr_int(1)           <= halted;
  ledr_int(2)           <= gie;
  ledr_int(3)           <= op_stall;
  ledr_int(4)           <= pf_stall;
  ledr_int(5)           <= i_count;
  ledr_int(17 downto 6) <= (others => '0');
  -- Outputs
  ledr                  <= ledr_int;
  o_lcd_on              <= lcd_on_int;
  ledg(7 downto 0)      <= (others => '0');
  ledg(8)               <= lcd_on_int;

end architecture rtl;




