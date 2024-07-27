-------------------------------------------------------------------------------
-- Title      : AXI4 Slave ITF
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_slave_itf.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-06-09
-- Last update: 2024-06-19
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: AXI4 Slave Interface
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-06-09  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity axi4_slave_itf is

  generic (
    G_AXI4_DATA_WIDTH : integer := 32;  -- AXI4 data width
    G_AXI4_ADDR_WIDTH : integer := 32;  -- AXI4 addr width
    G_AXI4_ID_WIDTH   : integer := 1;   -- AXI4 ID width
    G_AXI4_USER_WIDTH : integer := 1);  -- AXI4 User width
  port (
    aclk  : in std_logic;               -- Clock
    arstn : in std_logic;               -- Reset

    -- AW Channel
    s_axi_awid    : in  std_logic_vector(G_AXI4_ID_WIDTH - 1 downto 0);    -- AW ID
    s_axi_awaddr  : in  std_logic_vector(G_AXI4_ADDR_WIDTH - 1 downto 0);  -- AW ADDR
    s_axi_awlen   : in  std_logic_vector(7 downto 0);                      -- AW LEN 
    s_axi_awsize  : in  std_logic_vector(2 downto 0);                      -- AW SIZE
    s_axi_awburst : in  std_logic_vector(1 downto 0);                      -- AW BURST
    s_axi_awlock  : in  std_logic;                                         -- AW LOCK
    s_axi_awcache : in  std_logic_vector(3 downto 0);                      -- AW CACHE
    s_axi_awprot  : in  std_logic_vector(2 downto 0);                      -- AW PROT
    s_axi_awqos   : in  std_logic_vector(3 downto 0);                      -- AW QOS
    s_axi_awvalid : in  std_logic;                                         -- AW VALID
    s_axi_awready : out std_logic;                                         -- AW READY

    -- W Channel
    s_axi_wdata  : in  std_logic_vector(G_AXI4_DATA_WIDTH - 1 downto 0);        -- W DATA
    s_axi_wstrb  : in  std_logic_vector((G_AXI4_DATA_WIDTH / 8) - 1 downto 0);  -- W STRB
    s_axi_wlast  : in  std_logic;                                               -- W LAST
    S_AXI_WVALID : in  std_logic;                                               -- W VALID
    s_axi_wready : out std_logic;                                               -- W READY

    -- B Channel
    s_axi_bid    : out std_logic_vector(G_AXI4_ID_WIDTH - 1 downto 0);  -- B ID
    s_axi_bresp  : out std_logic_vector(1 downto 0);                    -- B RESP
    s_axi_bvalid : out std_logic;                                       -- B VALID
    s_axi_bready : in  std_logic;                                       -- B READY

    -- AR Channel
    s_axi_arid    : in  std_logic_vector(G_AXI4_ID_WIDTH - 1 downto 0);    -- AR ID
    s_axi_araddr  : in  std_logic_vector(G_AXI4_ADDR_WIDTH - 1 downto 0);  -- AR ADDR
    s_axi_arlen   : in  std_logic_vector(7 downto 0);                      -- AR LEN 
    s_axi_arsize  : in  std_logic_vector(2 downto 0);                      -- AR SIZE
    s_axi_arburst : in  std_logic_vector(1 downto 0);                      -- AR BURST
    s_axi_arlock  : in  std_logic;                                         -- AR LOCK
    s_axi_arcache : in  std_logic_vector(3 downto 0);                      -- AR CACHE
    s_axi_arprot  : in  std_logic_vector(2 downto 0);                      -- AR PROT
    s_axi_arqos   : in  std_logic_vector(3 downto 0);                      -- AR QOS
    s_axi_arvalid : in  std_logic;                                         -- AR VALID
    s_axi_arready : out std_logic;                                         -- AR READY

    -- R Channel
    s_axi_rid    : out std_logic_vector(G_AXI4_ID_WIDTH - 1 downto 0);    -- R ID
    s_axi_rdata  : out std_logic_vector(G_AXI4_DATA_WIDTH - 1 downto 0);  -- R DATA
    s_axi_rresp  : out std_logic_vector(1 downto 0);                      -- R RESP
    s_axi_rlast  : out std_logic;                                         -- R LAST
    s_axi_rvalid : out std_logic;                                         -- R VALID
    s_axi_rready : in  std_logic;                                         -- R READY

    -- Registers interface
    o_we    : out std_logic;                                             -- Write Enable
    o_waddr : out std_logic_vector(G_AXI4_ADDR_WIDTH - 1 downto 0);      -- Write Address
    o_wdata : out std_logic_vector(G_AXI4_DATA_WIDTH - 1 downto 0);      -- Write Data
    o_wstrb : out std_logic_vector((G_AXI4_DATA_WIDTH/8) - 1 downto 0);  -- Write Strobe
    o_rd    : out std_logic;                                             -- Read Enable
    o_raddr : out std_logic_vector(G_AXI4_ADDR_WIDTH - 1 downto 0);      -- Read Addr
    i_rdata : in  std_logic_vector(G_AXI4_DATA_WIDTH - 1 downto 0)       -- Read Data
    );

end entity axi4_slave_itf;

architecture rtl of axi4_slave_itf is

begin  -- architecture rtl


  -- AXI4 Write Channel interface
  i_axi4_wr_chan_itf_0 : entity work.axi4_wr_chan_itf
    generic map (
      G_AXI4_DATA_WIDTH => G_AXI4_DATA_WIDTH,
      G_AXI4_ADDR_WIDTH => G_AXI4_ADDR_WIDTH,
      G_AXI4_ID_WIDTH   => G_AXI4_ID_WIDTH,
      G_AXI4_USER_WIDTH => G_AXI4_USER_WIDTH
      )
    port map (
      aclk  => aclk,
      arstn => arstn,

      -- AW Channel
      s_axi_awid    => s_axi_awid,
      s_axi_awaddr  => s_axi_awaddr,
      s_axi_awlen   => s_axi_awlen,
      s_axi_awsize  => s_axi_awsize,
      s_axi_awburst => s_axi_awburst,
      s_axi_awlock  => s_axi_awlock,
      s_axi_awcache => s_axi_awcache,
      s_axi_awprot  => s_axi_awprot,
      s_axi_awqos   => s_axi_awqos,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_awready => s_axi_awready,

      -- W Channel
      s_axi_wdata  => s_axi_wdata,
      s_axi_wstrb  => s_axi_wstrb,
      s_axi_wlast  => s_axi_wlast,
      s_axi_wvalid => s_axi_wvalid,
      s_axi_wready => s_axi_wready,

      -- B Channel
      s_axi_bid    => s_axi_bid,
      s_axi_bresp  => s_axi_bresp,
      s_axi_bvalid => s_axi_bvalid,
      s_axi_bready => s_axi_bready,

      -- Registers interface
      o_we    => o_we,
      o_waddr => o_waddr,
      o_wdata => o_wdata,
      o_wstrb => o_wstrb
      );

  -- AXI4 Read Channel interface


end architecture rtl;
