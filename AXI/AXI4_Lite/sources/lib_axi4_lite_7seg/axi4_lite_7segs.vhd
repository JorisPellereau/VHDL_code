-------------------------------------------------------------------------------
-- Title      : AXI4 Lite 8*7Segments Controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_7segs.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-08-29
-- Last update: 2023-08-29
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-08-29  1.0      linux-jp        Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library lib_seg7;

library lib_axi4_lite;

entity axi4_lite_7segs is
  generic (
    G_AXI4_LITE_ADDR_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite ADDR WIDTH
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32  -- AXI4 Lite DATA WIDTH
    );
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- Write Address Channel signals
    awvalid : in  std_logic;            -- Address Write Valid
    awaddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Address Write
    awprot  : in  std_logic_vector(2 downto 0);  -- Adress Write Prot
    awready : out std_logic;            -- Address Write Ready

    -- Write Data Channel
    wvalid : in  std_logic;             -- Write Data Valid
    wdata  : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Write Data
    wstrb  : in  std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
    wready : out std_logic;             -- Write data Ready

    -- Write Response Channel
    bready : in  std_logic;                     -- Write Channel Response
    bvalid : out std_logic;                     -- Write Response Channel Valid
    bresp  : out std_logic_vector(1 downto 0);  -- Write Response Channel resp

    -- Read Address Channel
    arvalid : in  std_logic;            -- Read Channel Valid
    araddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
    arprot  : in  std_logic_vector(2 downto 0);  --  Read Address channel Ready Prot
    arready : out std_logic;            -- Read Address Channel Ready

    -- Read Data Channel
    rready : in  std_logic;             -- Read Data Channel Ready
    rvalid : out std_logic;             -- Read Data Channel Valid
    rdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
    rresp  : out std_logic_vector(1 downto 0);  -- Read Data Channel Response

    -- 7 Segments
    o_seg0 : out std_logic_vector(6 downto 0);  -- SEG 0
    o_seg1 : out std_logic_vector(6 downto 0);  -- SEG 1
    o_seg2 : out std_logic_vector(6 downto 0);  -- SEG 2
    o_seg3 : out std_logic_vector(6 downto 0);  -- SEG 3
    o_seg4 : out std_logic_vector(6 downto 0);  -- SEG 4
    o_seg5 : out std_logic_vector(6 downto 0);  -- SEG 5
    o_seg6 : out std_logic_vector(6 downto 0);  -- SEG 6
    o_seg7 : out std_logic_vector(6 downto 0)   -- SEG 7
    );

end entity axi4_lite_7segs;

architecture rtl of axi4_lite_7segs is

  -- == INTERNAL Signals ==
  signal digits_int : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Digits Value

  signal slv_start  : std_logic;        -- Start the access
  signal slv_rw     : std_logic;        -- Read or Write Access
  signal slv_addr   : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  --ADDR to reach
  signal slv_wdata  : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  --Write Data
  signal slv_strobe : std_logic_vector((G_AXI4_LITE_DATA_WIDTH/8) - 1 downto 0);  -- Write Strobe
  signal slv_done   : std_logic;        -- Access done
  signal slv_rdata  : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  --Slave read data
  signal slv_status : std_logic_vector(1 downto 0);  -- Slave status

begin  -- architecture rtl

  -- Instanciation of AXI4 Lite Slave interface
  i_axi4_lite_slave_itf_0 : axi4_lite_slave_itf

    generic map (
      G_AXI4_LITE_ADDR_WIDTH => G_AXI4_LITE_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI4_LITE_DATA_WIDTH
      )
    port map(
      clk   => clk,
      rst_n => rst_n,

      -- Write Address Channel signals
      awvalid => awvalid,
      awaddr  => awaddr,
      awprot  => awprot,
      awready => awready,

      -- Write Data Channel
      wvalid => wvalid,
      wdata  => wdata,
      wstrb  => wstrb,
      wready => wready,

      -- Write Response Channel
      bready => bready,
      bvalid => bvalid,
      bresp  => bresp,

      -- Read Address Channel
      arvalid => arvalid,
      araddr  => araddr,
      arprot  => arprot,
      arready => arready,

      -- Read Data Channel
      rready => rready,
      rvalid => rvalid,
      rdata  => rdata,
      rresp  => rresp,

      -- Slave Registers Interface
      slv_start  => slv_start,
      slv_rw     => slv_rw,
      slv_addr   => slv_addr,
      slv_wdata  => slv_wdata,
      slv_strobe => slv_strobe,

      slv_done   => slv_done,
      slv_rdata  => slv_rdata,
      slv_status => slv_status
      );

  -- Instanciation of 8*7Segments controller
i_axi4_lite_7segs_registers_0 : axi4_lite_7segs_registers

  generic map (
    G_AXI4_LITE_ADDR_WIDTH => G_AXI4_LITE_ADDR_WIDTH,
    G_AXI4_LITE_DATA_WIDTH => G_AXI4_LITE_DATA_WIDTH
    )
  port map (
    clk   => clk,
    rst_n=> rst_n,

    -- Slave Registers Interface
    slv_start => slv_start,
    slv_rw    => slv_rw,
    slv_addr  => slv_addr,
    slv_wdata => slv_wdata,
    slv_strobe=> slv_strobe,

    slv_done  => slv_done,
    slv_rdata => slv_rdata,
    slv_status => slv_status,

    -- Registers Interface
    digits => digits_int
    );

  i_seg7x8 : entity lib_seg7.seg7x8
    port map (
      i_digits => digits_int,
      o_seg0   => o_seg0,
      o_seg1   => o_seg1,
      o_seg2   => o_seg2,
      o_seg3   => o_seg3,
      o_seg4   => o_seg4,
      o_seg5   => o_seg5,
      o_seg6   => o_seg6,
      o_seg7   => o_seg7
      );

end architecture rtl;
