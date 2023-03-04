-------------------------------------------------------------------------------
-- Title      : AXI4 Lite Slave Refisters Interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_slave_reg_itf.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-03-04
-- Last update: 2023-03-04
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: AXI4 Lite Slave Refisters Interface
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-03-04  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axi4_lite_slave_reg_itf is

  generic (
    G_AXI4_LITE_ADDR_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite ADDR WIDTH
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32);  -- AXI4 Lite DATA WIDTH

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
    wstrb  : in  std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);
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

    -- Slave Registers Interface
    slv_reg_wren    : out std_logic;    -- Slave Reg. Write Enable
    slv_reg_waddr   : out std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Slave Write Addr
    slv_reg_wdata   : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave WDATA
    slv_reg_awready : in  std_logic;    -- Slave AWREADY
    slv_reg_wready  : in  std_logic;    -- Slave WREADY
    slv_reg_bresp   : in  std_logic_vector(1 downto 0);  -- Slave BRESP

    slv_reg_rden    : out std_logic;    -- Slave Reg. Read Enable
    slv_reg_raddr   : out std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Slave Read Addr
    slv_reg_rdata   : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave RDATA
    slv_reg_arready : in  std_logic;    -- Slave ARREADY
    slv_reg_rresp   : in  std_logic_vector(1 downto 0)
    );

end entity axi4_lite_slave_reg_itf;

architecture rtl of axi4_lite_slave_reg_itf is

begin  -- architecture rtl



end architecture rtl;
