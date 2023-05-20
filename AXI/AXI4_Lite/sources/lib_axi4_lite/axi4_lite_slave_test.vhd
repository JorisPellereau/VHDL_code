-------------------------------------------------------------------------------
-- Title      : AXI4 Lite Slave Test
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_slave_test.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-05-20
-- Last update: 2023-05-20
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-05-20  1.0      linux-jp        Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_axi4_lite;
use lib_axi4_lite.pkg_reg.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity axi4_lite_slave_test is

  generic (
    G_AXI4_LITE_ADDR_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite ADDR WIDTH
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite DATA WIDTH
    G_REG_CONFIG           : t_reg_config_array;      -- Register Configuration
    G_REG_IN_NB            : integer range 1 to 4096;  -- Number of Inputs registers
    G_REG_OUT_NB           : integer range 1 to 4096  -- Number of Outputs registers
    );

  port(
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

    -- Registers Interface
    registers_in  : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH*G_REG_IN_NB - 1 downto 0);  -- Registers In
    registers_out : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH*G_REG_OUT_NB - 1 downto 0)  -- Registers out
    );

end entity axi4_lite_slave_test;

architecture rtl of axi4_lite_slave_test is

  -- == INTERNAL SIGNALS ==
  signal slv_start  : std_logic;        -- Slave start
  signal slv_rw     : std_logic;        -- Slave R/W access
  signal slv_addr   : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Slave ADDR
  signal slv_wdata  : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave WDATA
  signal slv_strobe : std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Slave Strobe
  signal slv_done   : std_logic;        -- Slave done
  signal slv_rdata  : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave RDATA
  signal slv_status : std_logic;        -- Slace status

begin  -- architecture rtl

  -- AXI4Lite Slave interface instanciation
  i_axi4_lite_slave_itf_0 : entity lib_axi4_lite.axi4_lite_slave_itf
    generic map (
      G_AXI4_LITE_ADDR_WIDTH => G_AXI4_LITE_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI4_LITE_DATA_WIDTH
      )
    port map (
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


  -- AXI4 Lite Slave register instanciation
  i_axi4_lite_slave_reg_0 : entity lib_axi4_lite.axi4_lite_slave_reg
    generic map (
      G_AXI4_LITE_ADDR_WIDTH => G_AXI4_LITE_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI4_LITE_DATA_WIDTH,
      G_REG_CONFIG           => G_REG_CONFIG,
      G_REG_IN_NB            => G_REG_IN_NB,
      G_REG_OUT_NB           => G_REG_OUT_NB
      )
    port map (
      clk   => clk,
      rst_n => rst_n,

      -- Slave Registers Interface
      slv_start  => slv_start,
      slv_rw     => slv_rw,
      slv_addr   => slv_addr,
      slv_wdata  => slv_wdata,
      slv_strobe => slv_strobe,

      slv_done   => slv_done,
      slv_rdata  => slv_rdata,
      slv_status => slv_status,

      -- Registers Interface
      registers_in  => registers_in,
      registers_out => registers_out
      );

end architecture rtl;
