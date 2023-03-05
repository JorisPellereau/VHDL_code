-------------------------------------------------------------------------------
-- Title      : AXI4 Lite Slave Refisters Interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_slave_reg_itf.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-03-04
-- Last update: 2023-03-05
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
    slv_reg_bvalid  : in  std_logic;    -- Slave BVALID
    master_bready   : out std_logic;    -- Master BREADY

    slv_reg_rden    : out std_logic;    -- Slave Reg. Read Enable
    slv_reg_raddr   : out std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Slave Read Addr
    slv_reg_rdata   : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave RDATA
    slv_reg_arready : in  std_logic;    -- Slave ARREADY
    slv_reg_rresp   : in  std_logic_vector(1 downto 0)
    );

end entity axi4_lite_slave_reg_itf;

architecture rtl of axi4_lite_slave_reg_itf is

  -- == INTERNAL Signals ==
  signal s_awvalid : std_logic;         -- Internal awvalid
  signal s_wvalid  : std_logic;         -- Internal wvalid
  --signal s_awready : std_logic;         -- Internal awready

  signal s_awaddr : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Latch AWADDR
  signal s_wdata  : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Latch WDATA
begin  -- architecture rtl

  -- purpose: AWVALID Management
  p_awvalid_mngt : process (clk, rst_n) is
  begin  -- process p_awvalid_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_awvalid <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(awvalid = '1' and s_awvalid = '0') then  -- and slv_reg_awready = '0') then
        s_awvalid <= '1';
      elsif(slv_reg_awready = '1') then
        s_awvalid <= '0';
      end if;

    end if;
  end process p_awvalid_mngt;


  -- purpose: AWADDR Latch
  p_awaddr_latch : process (clk, rst_n) is
  begin  -- process p_awaddr_latch
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_awaddr <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(awvalid = '1' and s_awvalid = '0') then  -- and slv_reg_awready = '0') then
        s_awaddr <= awaddr;
      end if;
    end if;
  end process p_awaddr_latch;


  -- purpose: wvalid Management
  p_wvalid_mngt : process (clk, rst_n) is
  begin  -- process p_wvalid_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_wvalid <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(wvalid = '1' and s_wvalid = '0') then  -- and slv_reg_wready = '0') then
        s_wvalid <= '1';
      elsif(slv_reg_wready = '1') then
        s_wvalid <= '0';
      end if;

    end if;
  end process p_wvalid_mngt;


  -- purpose: WDATA Latch
  p_wdata_latch : process (clk, rst_n) is
  begin  -- process p_wdata_latch
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_wdata <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(wvalid = '1' and s_wvalid = '0') then  -- and slv_reg_wready = '0') then
        s_wdata <= wdata;
      end if;

    end if;
  end process p_wdata_latch;

  -- purpose: Slave Reg Write Enable Management
  p_slv_reg_wren_mngt : process (clk, rst_n) is
  begin  -- process p_slv_reg_wren_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_reg_wren <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(wvalid = '1' and s_wvalid = '0') then  -- and slv_reg_wready = '0') then
        slv_reg_wren <= '1';
      else
        slv_reg_wren <= '0';
      end if;

    end if;
  end process p_slv_reg_wren_mngt;

  -- OUTPUTS Affectation
  awready       <= slv_reg_awready;
  wready        <= slv_reg_wready;
  bvalid        <= slv_reg_bvalid;
  slv_reg_waddr <= s_awaddr;
  slv_reg_wdata <= s_wdata;
  master_bready <= bready;

end architecture rtl;
