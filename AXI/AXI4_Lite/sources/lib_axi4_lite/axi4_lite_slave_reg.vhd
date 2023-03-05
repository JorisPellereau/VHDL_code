-------------------------------------------------------------------------------
-- Title      : AXI4 Lite Slave Registers
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_slave_reg.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-03-05
-- Last update: 2023-03-05
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-03-05  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity axi4_lite_slave_reg is

  generic (
    G_AXI4_LITE_ADDR_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite ADDR WIDTH
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite DATA WIDTH
    G_AXI4_LITE_BASE_ADDR  : std_logic_vector       := x"00000000"
    );

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- Slave Registers Interface
    slv_reg_wren    : in  std_logic;    -- Slave Reg. Write Enable
    slv_reg_waddr   : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Slave Write Addr
    slv_reg_wdata   : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave WDATA
    slv_reg_awready : out std_logic;    -- Slave AWREADY
    slv_reg_wready  : out std_logic;    -- Slave WREADY
    slv_reg_bresp   : out std_logic_vector(1 downto 0);  -- Slave BRESP
    slv_reg_bvalid  : out std_logic;    -- Slave Bvalid
    master_bready   : in  std_logic;    -- Master BREADY

    slv_reg_rden    : in  std_logic;    -- Slave Reg. Read Enable
    slv_reg_raddr   : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Slave Read Addr
    slv_reg_rdata   : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave RDATA
    slv_reg_arready : out std_logic;    -- Slave ARREADY
    slv_reg_rresp   : out std_logic_vector(1 downto 0)

    );

end entity axi4_lite_slave_reg;

architecture rtl of axi4_lite_slave_reg is

  signal reg_0    : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);
  signal waddr_ok : std_logic;          -- waddr OK Flag
  signal raddr_ok : std_logic;          -- raddr OK Flag

begin  -- architecture rtl

  slv_reg_awready <= '1';               -- Always ready


  p_reg_0_write_mngt : process (clk, rst_n) is
  begin  -- process p_reg_0_write_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      reg_0 <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- On the Write Request
      if(slv_reg_wren = '1' and waddr_ok = '1') then
        reg_0 <= slv_reg_wdata;
      elsif(slv_reg_wren = '1' and waddr_ok = '0') then

      end if;
    end if;
  end process p_reg_0_write_mngt;

  p_bresp_mngt : process (clk, rst_n) is
  begin  -- process p_bresp_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_reg_bresp <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(slv_reg_wren = '1' and waddr_ok = '1') then
        slv_reg_bresp <= (others => '0');  -- No Error
      elsif(slv_reg_wren = '1' and waddr_ok = '0') then
        slv_reg_bresp <= "10";             -- SLVERR
      else
        slv_reg_bresp <= (others => '0');
      end if;

    end if;
  end process p_bresp_mngt;


  -- purpose: BVALID Management
  p_bvalid_mngt : process (clk, rst_n) is
  begin  -- process p_bvalid_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_reg_bvalid <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(slv_reg_wren = '1') then
        slv_reg_bvalid <= '1';
      elsif(master_bready = '1') then
        slv_reg_bvalid <= '0';
      end if;

    end if;
  end process p_bvalid_mngt;



  p_wready_mngt : process (clk, rst_n) is
  begin  -- process p_wready_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_reg_wready <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(slv_reg_wren = '1') then
        slv_reg_wready <= '1';
      else
        slv_reg_wready <= '0';

      end if;
    end if;
  end process p_wready_mngt;

  waddr_ok <= '1' when ((unsigned(slv_reg_waddr) >= unsigned(G_AXI4_LITE_BASE_ADDR)) and (unsigned(slv_reg_waddr) < (unsigned(G_AXI4_LITE_BASE_ADDR) + x"FFF"))) else '0';

--  (unsigned(slv_reg_waddr) < (unsigned(G_AXI4_LITE_BASE_ADDR) + x"FFFF"))

  raddr_ok <= '1' when unsigned(slv_reg_raddr) < x"00000FFF" else '0';

end architecture rtl;
