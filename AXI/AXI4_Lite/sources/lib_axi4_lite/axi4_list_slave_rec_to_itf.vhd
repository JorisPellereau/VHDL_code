-------------------------------------------------------------------------------
-- Title      : AXi4 List Slave Record to AXI4-Lite Interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_list_slave_rec_to_itf.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-03-04
-- Last update: 2023-03-04
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
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

library lib_axi4_lite;
use lib_axi4_lite.pkg_axi4_lite_inst.all;

entity axi4_list_slave_rec_to_itf is

  generic (
    G_AXI4_LITE_ADDR_WIDTH : integer range 32 to 64 := 32;   -- AXI4 ADDR WIDTH
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32);  -- AXI4 DATA WIDTH
                      
  port(
    axi4_lite_slave_in  : in  t_axi4_lite_slave_in;
    axi4_lite_slave_out : out t_axi4_lite_slave_out;

    -- Write Address Channel signals
    awvalid : out std_logic;            -- Address Write Valid
    awaddr  : out std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Address Write
    awprot  : out std_logic_vector(2 downto 0);  -- Adress Write Prot
    awready : in  std_logic;            -- Address Write Ready

    -- Write Data Channel
    wvalid : out std_logic;             -- Write Data Valid
    wdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Write Data
    wstrb  : out std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);
    wready : in  std_logic;             -- Write data Ready

    -- Write Response Channel
    bready : out std_logic;                     -- Write Channel Response
    bvalid : in  std_logic;                     -- Write Response Channel Valid
    bresp  : in  std_logic_vector(1 downto 0);  -- Write Response Channel resp

    -- Read Address Channel
    arvalid : out std_logic;            -- Read Channel Valid
    araddr  : out std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
    arprot  : out std_logic_vector(2 downto 0);  --  Read Address channel Ready Prot
    arready : in  std_logic;            -- Read Address Channel Ready

    -- Read Data Channel
    rready : out std_logic;             -- Read Data Channel Ready
    rvalid : in  std_logic;             -- Read Data Channel Valid
    rdata  : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
    rresp  : in  std_logic_vector(1 downto 0)  -- Read Data Channel Response

    );

end entity axi4_list_slave_rec_to_itf;


architecture rtl of axi4_list_slave_rec_to_itf is

begin  -- architecture rtl

  -- AXI4-Lite Inputs Record to Outputs
  awvalid <= axi4_lite_slave_in.awvalid;
  awaddr  <= axi4_lite_slave_in.awaddr;
  awprot  <= axi4_lite_slave_in.awprot;
  wvalid  <= axi4_lite_slave_in.wvalid;
  wdata   <= axi4_lite_slave_in.wdata;
  wstrb   <= axi4_lite_slave_in.wstrb;
  bready  <= axi4_lite_slave_in.bready;
  arvalid <= axi4_lite_slave_in.arvalid;
  araddr  <= axi4_lite_slave_in.araddr;
  arprot  <= axi4_lite_slave_in.arprot;
  rready  <= axi4_lite_slave_in.rready;

  -- AXI4-Lite Outputs Record to Inputs
  axi4_lite_slave_out.awready <= awready;
  axi4_lite_slave_out.wready  <= wready;
  axi4_lite_slave_out.bvalid  <= bvalid;
  axi4_lite_slave_out.bresp   <= bresp;
  axi4_lite_slave_out.rvalid  <= rvalid;
  axi4_lite_slave_out.rdata   <= rdata;
  axi4_lite_slave_out.rresp   <= rresp;

end architecture rtl;
