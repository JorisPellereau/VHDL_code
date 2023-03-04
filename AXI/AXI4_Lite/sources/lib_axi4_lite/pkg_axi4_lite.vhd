-------------------------------------------------------------------------------
-- Title      : Package for AXI4 Lite
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_axi4_lite.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-02-26
-- Last update: 2023-03-04
-- Platform   : 
-- Standard   : VHDL 2008
-------------------------------------------------------------------------------
-- Description: Package for AXI4 Lite
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-02-26  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pkg_axi4_lite is
  generic(
    G_AXI4_LITE_ADDR_WIDTH : integer range 32 to 64 := 32;  -- AXI4 ADDR Width
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32   -- AXI4 DATA Width
    );

  -- == TYPES ==

  -- Slave AXI4 Lite Inputs
  type t_axi4_lite_slave_in is record
    awvalid : std_logic;                -- Address Write Valid
    awaddr  : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Address Write
    awprot  : std_logic_vector(2 downto 0);  -- Adress Write Prot
    wvalid  : std_logic;                -- Write Data Valid
    wdata   : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Write Data
    wstrb   : std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);
    bready  : std_logic;                -- Write Channel Response
    arvalid : std_logic;                -- Read Channel Valid
    araddr  : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
    arprot  : std_logic_vector(2 downto 0);  --  Read Address channel Ready Prot
    rready  : std_logic;                -- Read Data Channel Ready
  end record t_axi4_lite_slave_in;

  -- Slave AXI4 Lite Outputs
  type t_axi4_lite_slave_out is record
    awready : std_logic;                -- Address Write Ready
    wready  : std_logic;                -- Write data Ready
    bvalid  : std_logic;                -- Write Response Channel Valid
    bresp   : std_logic_vector(1 downto 0);  -- Write Response Channel resp
    arready : std_logic;                -- Read Address Channel Ready
    rvalid  : std_logic;                -- Read Data Channel Valid
    rdata   : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
    rresp   : std_logic_vector(1 downto 0);  -- Read Data Channel Resp
  end record t_axi4_lite_slave_out;

  -- Master AXI4 Lite Outputs
  type t_axi4_lite_master_out is record
    awvalid : std_logic;                -- Address Write Valid
    awaddr  : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Address Write
    awprot  : std_logic_vector(2 downto 0);  -- Adress Write Prot
    wvalid  : std_logic;                -- Write Data Valid
    wdata   : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Write Data
    wstrb   : std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);
    bready  : std_logic;                -- Write Channel Response
    arvalid : std_logic;                -- Read Channel Valid
    araddr  : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
    arprot  : std_logic_vector(2 downto 0);  --  Read Address channel Ready Prot
    rready  : std_logic;                -- Read Data Channel Ready

  end record t_axi4_lite_master_out;

  -- Master AXI4 Lite Inputs
  type t_axi4_lite_master_in is record
    awready : std_logic;                -- Address Write Ready
    wready  : std_logic;                -- Write data Ready
    bvalid  : std_logic;                -- Write Response Channel Valid
    bresp   : std_logic_vector(1 downto 0);  -- Write Response Channel resp
    arready : std_logic;                -- Read Address Channel Ready
    rvalid  : std_logic;                -- Read Data Channel Valid
    rdata   : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
    rresp   : std_logic_vector(1 downto 0);  -- Read Data Channel Resp
  end record t_axi4_lite_master_in;

end package pkg_axi4_lite;
