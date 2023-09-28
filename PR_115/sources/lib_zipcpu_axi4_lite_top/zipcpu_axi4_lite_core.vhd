-------------------------------------------------------------------------------
-- Title      : Core of JTAG AXI4 Lite
-- Project    : 
-------------------------------------------------------------------------------
-- File       : jtag_axi4_lite_core.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-18
-- Last update: 2023-09-28
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

library lib_axi4_lite_7seg;
library lib_axi4_lite_lcd;
library lib_zipcpu_axi4_lite_top;

entity zipcpu_axi4_lite_core is
  generic (
    G_AXI_DATA_WIDTH      : integer range 32 to 64 := 32;    -- AXI DATA WIDTH
    G_AXI_ADDR_WIDTH      : integer range 8 to 64  := 16;    -- AXI ADDR WIDTH
    G_SLAVE_NB            : integer range 2 to 16  := 2;     -- Number of AXI4 Lite Slave
    G_CLK_PERIOD_NS       : integer                := 20;    -- Clock Period in ns
    G_BIDIR_POLARITY_READ : std_logic              := '0';   -- BIDIR SEL Polarity
    G_FIFO_ADDR_WIDTH     : integer                := 10;    -- FIFO ADDR WIDTH
    G_SIMULATION          : boolean                := false  -- Simulation Purpose
    );
  port (
    clk_sys   : in std_logic;                                -- Clock System
    rst_n_sys : in std_logic;                                -- Asynchronous Reset

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

    -- RED LEDS
    ledr : out std_logic_vector(17 downto 0);  -- RED LEDS

    -- GREEN LEDS
    ledg : out std_logic_vector(8 downto 0)  -- GREEN LEDS
    );

end entity zipcpu_axi4_lite_core;

architecture rtl of zipcpu_axi4_lite_core is

  -- == COMPONENTS ==




  -- == INTERNAL Signals ==
  -- ZIPAXIL Signals

  -- # ZIPAXIL DEBUG Interface --
  -- Write Address Channel signals
  signal awvalid_zipaxil_dbg : std_logic;                                        -- Address Write Valid
  signal awaddr_zipaxil_dbg  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Address Write
  signal awprot_zipaxil_dbg  : std_logic_vector(2 downto 0);                     -- Adress Write Prot
  signal awready_zipaxil_dbg : std_logic;                                        -- Address Write Ready

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
  signal arvalid_zipaxil_dbg : std_logic;                                        -- Read Channel Valid
  signal araddr_zipaxil_dbg  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  signal arprot_zipaxil_dbg  : std_logic_vector(2 downto 0);                     --  Read Address channel Ready Prot
  signal arready_zipaxil_dbg : std_logic;                                        -- Read Address Channel Ready

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

  -- VJTAG Signals
  signal start_clk_jtag     : std_logic;
  signal addr_vjtag         : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);
  signal rnw                : std_logic;
  signal strobe             : std_logic_vector((G_AXI_DATA_WIDTH/8) - 1 downto 0);
  signal master_wdata_vjtag : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);
  signal master_rdata       : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);
  signal access_status      : std_logic_vector(1 downto 0);
  signal master_wdata       : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);
  signal start_master       : std_logic;  -- Start Master
  signal addr_master        : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);
  signal rnw_master         : std_logic;
  signal strobe_master      : std_logic_vector((G_AXI_DATA_WIDTH/8) - 1 downto 0);

  -- # AXI4 Lite MASTER signals --
  -- Write Address Channel signals
  signal awvalid_master : std_logic;                                        -- Address Write Valid
  signal awaddr_master  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Address Write
  signal awprot_master  : std_logic_vector(2 downto 0);                     -- Adress Write Prot
  signal awready_master : std_logic;                                        -- Address Write Ready

  -- Write Data Channel
  signal wvalid_master : std_logic;                                              -- Write Data Valid
  signal wdata_master  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);        -- Write Data
  signal wstrb_master  : std_logic_vector((G_AXI_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
  signal wready_master : std_logic;                                              -- Write data Ready

  -- Write Response Channel
  signal bready_master : std_logic;                     -- Write Channel Response
  signal bvalid_master : std_logic;                     -- Write Response Channel Valid
  signal bresp_master  : std_logic_vector(1 downto 0);  -- Write Response Channel resp

  -- Read Address Channel
  signal arvalid_master : std_logic;                                        -- Read Channel Valid
  signal araddr_master  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  signal arprot_master  : std_logic_vector(2 downto 0);                     --  Read Address channel Ready Prot
  signal arready_master : std_logic;                                        -- Read Address Channel Ready

  -- Read Data Channel
  signal rready_master : std_logic;                                        -- Read Data Channel Ready
  signal rvalid_master : std_logic;                                        -- Read Data Channel Valid
  signal rdata_master  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  signal rresp_master  : std_logic_vector(1 downto 0);                     -- Read Data Channel Response
  -- ------------------------


  -- # AXI4 Lite LCD signals --
  -- Write Address Channel signals
  signal awvalid_lcd : std_logic;                                        -- Address Write Valid
  signal awaddr_lcd  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Address Write
  signal awprot_lcd  : std_logic_vector(2 downto 0);                     -- Adress Write Prot
  signal awready_lcd : std_logic;                                        -- Address Write Ready

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
  signal arvalid_lcd : std_logic;                                        -- Read Channel Valid
  signal araddr_lcd  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  signal arprot_lcd  : std_logic_vector(2 downto 0);                     --  Read Address channel Ready Prot
  signal arready_lcd : std_logic;                                        -- Read Address Channel Ready

  -- Read Data Channel
  signal rready_lcd : std_logic;                                        -- Read Data Channel Ready
  signal rvalid_lcd : std_logic;                                        -- Read Data Channel Valid
  signal rdata_lcd  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  signal rresp_lcd  : std_logic_vector(1 downto 0);                     -- Read Data Channel Response
  -- ------------------------

  -- # AXI4 Lite 7 SEGS signals --
  -- Write Address Channel signals
  signal awvalid_7segs : std_logic;                                        -- Address Write Valid
  signal awaddr_7segs  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Address Write
  signal awprot_7segs  : std_logic_vector(2 downto 0);                     -- Adress Write Prot
  signal awready_7segs : std_logic;                                        -- Address Write Ready

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
  signal arvalid_7segs : std_logic;                                        -- Read Channel Valid
  signal araddr_7segs  : std_logic_vector(G_AXI_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
  signal arprot_7segs  : std_logic_vector(2 downto 0);                     --  Read Address channel Ready Prot
  signal arready_7segs : std_logic;                                        -- Read Address Channel Ready

  -- Read Data Channel
  signal rready_7segs : std_logic;                                        -- Read Data Channel Ready
  signal rvalid_7segs : std_logic;                                        -- Read Data Channel Valid
  signal rdata_7segs  : std_logic_vector(G_AXI_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
  signal rresp_7segs  : std_logic_vector(1 downto 0);                     -- Read Data Channel Response
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

  -- ZIPAXIL Instanciation
  i_zipaxil_0 : entity lib_zipcpu.zipaxil
    generic map (
      C_DBG_ADDR_WIDTH     => G_AXI_ADDR_WIDTH,
      ADDRESS_WIDTH        => G_AXI_ADDR_WIDTH,
      C_AXI_DATA_WIDTH     => G_AXI_DATA_WIDTH,
      OPT_LGICACHE         => 0,
      OPT_LGDCACHE         => 0,
      OPT_PIPELINED        => '1',
      RESET_ADDRESS        => (others => '0'),
      START_HALTED         => "0",
      SWAP_WSTRB           => "1",
      OPT_MPY              => 3,
      OPT_DIV              => "1",
      OPT_SHIFTS           => "1",
      OPT_LOCK             => "1",
      OPT_FPU              => "0",
      OPT_EARLY_BRANCHING  => "1",
      OPT_CIS              => "1",
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
      i_interrupt   => '0',
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
      S_DBG_BREADY => bresp_zipaxil_dbg,

      S_DBG_BRESP => bresp_zipaxil_dbg,

      S_DBG_ARVALID => arvalid_zipaxil_dbg,
      S_DBG_ARREADY => arready_zipaxil_dbg,
      S_DBG_ARADDR  => araddr_zipaxil_dbg,

      S_DBG_ARPROT => arprot_zipaxil_dbg,

      S_DBG_RVALID => rvalid_zipaxil_dbg,
      S_DBG_RREADY => rresp_zipaxil_dbg,
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

      o_cmd_reset => open,
      o_halted    => open,
      o_gie       => open,
      o_op_stall  => open,
      o_pf_stall  => open,
      o_i_count   => open,

      o_cpu_debug => open,

      o_prof_stb   => open,
      o_prof_addr  => open,
      o_prof_ticks => open
      );







  -- Instanciation of AXI4 LITE MASTER
  i_axi4_lite_master_0 : entity lib_axi4_lite.axi4_lite_master
    generic map(
      G_DATA_WIDTH => G_AXI_DATA_WIDTH,
      G_ADDR_WIDTH => G_AXI_ADDR_WIDTH
      )
    port map(
      clk   => clk_sys,
      rst_n => rst_n_sys,

      start         => start_master,
      addr          => addr_master,
      rnw           => rnw_master,
      strobe        => strobe_master,
      master_wdata  => master_wdata,
      done          => done_master,
      master_rdata  => master_rdata,
      access_status => access_status,

      awvalid => awvalid_master,
      awaddr  => awaddr_master,
      awprot  => awprot_master,
      awready => awready_master,

      wvalid => wvalid_master,
      wdata  => wdata_master,
      wstrb  => wstrb_master,
      wready => wready_master,

      bready => bready_master,
      bvalid => bvalid_master,
      bresp  => bresp_master,

      arvalid => arvalid_master,
      araddr  => araddr_master,
      arprot  => arprot_master,
      arready => arready_master,

      rready => rready_master,
      rvalid => rvalid_master,
      rdata  => rdata_master,
      rresp  => rresp_master
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
      awvalid_s => awvalid_master,
      awaddr_s  => awaddr_master,
      awprot_s  => awprot_master,
      awready_s => awready_master,

      -- Write Data Channel
      wvalid_s => wvalid_master,
      wdata_s  => wdata_master,
      wstrb_s  => wstrb_master,
      wready_s => wready_master,

      -- Write Response Channel
      bready_s => bready_master,
      bvalid_s => bvalid_master,
      bresp_s  => bresp_master,

      -- Read Address Channel
      arvalid_s => arvalid_master,
      araddr_s  => araddr_master,
      arprot_s  => arprot_master,
      arready_s => arready_master,

      -- Read Data Channel
      rready_s => rready_master,
      rvalid_s => rvalid_master,
      rdata_s  => rdata_master,
      rresp_s  => rresp_master,


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

  -- # - SEGMENTS Interconnexion
-- Write Addr Channel
  awvalid_7segs        <= awvalid_interco_m(0);
  awaddr_7segs         <= awaddr_interco_m(0);
  awprot_7segs         <= awprot_interco_m(0);
  awready_interco_m(0) <= awready_7segs;

  -- Write Data Channel
  wvalid_7segs        <= wvalid_interco_m(0);
  wdata_7segs         <= wdata_interco_m(0);
  wstrb_7segs         <= wstrb_interco_m(0);
  wready_interco_m(0) <= wready_7segs;

  -- Write Response Channem
  bready_7segs        <= bready_interco_m(0);
  bvalid_interco_m(0) <= bvalid_7segs;
  bresp_interco_m(0)  <= bresp_7segs;

  -- Read Addr Channel
  arvalid_7segs        <= arvalid_interco_m(0);
  araddr_7segs         <= araddr_interco_m(0);
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
  awaddr_lcd           <= awaddr_interco_m(1);
  awprot_lcd           <= awprot_interco_m(1);
  awready_interco_m(1) <= awready_lcd;

  -- Write Data Channel
  wvalid_lcd          <= wvalid_interco_m(1);
  wdata_lcd           <= wdata_interco_m(1);
  wstrb_lcd           <= wstrb_interco_m(1);
  wready_interco_m(1) <= wready_lcd;

  -- Write Response Channem
  bready_lcd          <= bready_interco_m(1);
  bvalid_interco_m(1) <= bvalid_lcd;
  bresp_interco_m(1)  <= bresp_lcd;

  -- Read Addr Channel
  arvalid_lcd          <= arvalid_interco_m(1);
  araddr_lcd           <= araddr_interco_m(1);
  arprot_lcd           <= arprot_interco_m(1);
  arready_interco_m(1) <= arready_lcd;

  -- Read DAta Channel
  rready_lcd          <= rready_interco_m(1);
  rvalid_interco_m(1) <= rvalid_lcd;
  rdata_interco_m(1)  <= rdata_lcd;
  rresp_interco_m(1)  <= rresp_lcd;


  -- Instanciation of AXI4 LITE 7 SEGMENT Controller
  i_axi4_lite_7segs_0 : entity lib_axi4_lite_7seg.axi4_lite_7segs
    generic map (
      G_AXI4_LITE_ADDR_WIDTH => G_AXI_ADDR_WIDTH,
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
      G_AXI4_LITE_ADDR_WIDTH => G_AXI_ADDR_WIDTH,
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


  -- Outputs
  ledr     <= ledr_int;
  o_lcd_on <= lcd_on_int;
  ledg(8)  <= lcd_on_int;

end architecture rtl;




