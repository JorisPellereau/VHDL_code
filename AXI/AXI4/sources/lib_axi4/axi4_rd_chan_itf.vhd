-------------------------------------------------------------------------------
-- Title      : AXI4 Read Channel interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_rd_chan_itf.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-06-19
-- Last update: 2024-06-20
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-06-19  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axi4_rd_chan_itf is
  generic (
    G_AXI4_DATA_WIDTH : integer := 32;  -- AXI4 data width
    G_AXI4_ADDR_WIDTH : integer := 32;  -- AXI4 addr width
    G_AXI4_ID_WIDTH   : integer := 1;   -- AXI4 ID width
    G_AXI4_USER_WIDTH : integer := 1);  -- AXI4 User width
  port(
    aclk  : in std_logic;               -- Clock
    arstn : in std_logic;               -- Reset

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
    o_rd    : out std_logic;                                         -- Read Enable
    o_raddr : out std_logic_vector(G_AXI4_ADDR_WIDTH - 1 downto 0);  -- Read Addr
    i_rdata : in  std_logic_vector(G_AXI4_DATA_WIDTH - 1 downto 0)   -- Read Data
    );
end entity axi4_rd_chan_itf;

architecture rtl of axi4_rd_chan_itf is

  -- == INTERNAL Signals ==
  signal axi_arready : std_logic;
  signal axi_rlen    : std_logic_vector(7 downto 0);

  signal s_axi_arready_int : std_logic;  -- AXI arready
  signal o_rd_int          : std_logic;

  signal raddr        : std_logic_vector(G_AXI4_ADDR_WIDTH - 1 downto 0);
  signal next_rd_addr : std_logic_vector(G_AXI4_ADDR_WIDTH - 1 downto 0);



  signal rburst : std_logic_vector(1 downto 0);
  signal rsize  : std_logic_vector(2 downto 0);
  signal rlen   : std_logic_vector(7 downto 0);
  signal rid    : std_logic_vector(G_AXI4_ID_WIDTH - 1 downto 0);
  signal rlock  : std_logic;

begin  -- architecture rtl

  p_axi_arready_mngt : process (aclk, arstn) is
  begin  -- process p_axi_arready_mngt
    if arstn = '0' then                 -- asynchronous reset (active low)
      axi_arready <= '1';
    elsif rising_edge(aclk) then        -- rising clock edge

      if(s_axi_arvalid = '1' and s_axi_arready_int = '1') then

        if(unsigned(s_axi_arlen) = to_unsigned(0, s_axi_arlen'length)) then
          axi_arready <= o_rd_int;

        else
          axi_arready <= '0';
        end if;

      elsif(o_rd_int = '1') then

        if(unsigned(axi_rlen) <= to_unsigned(1, axi_rlen'length)) then
          axi_arready <= '1';
        else
          axi_arready <= '0';
        end if;

      end if;

    end if;
  end process p_axi_arready_mngt;

  p_r_len_mngt : process (aclk, arstn) is
  begin  -- process p_r_len_mngt
    if arstn = '0' then                 -- asynchronous reset (active low)
      axi_rlen <= (others => '0');
    elsif rising_edge(aclk) then        -- rising clock edge

      if(s_axi_arvalid = '1' and s_axi_arready_int = '1') then

        if(o_rd_int = '1') then
          axi_rlen <= s_axi_arlen;
        else
          axi_rlen <= std_logic_vector(unsigned(s_axi_arlen) + to_unsigned(1, axi_rlen'length));
        end if;

      elsif(o_rd_int = '1') then

        axi_rlen <= std_logic_vector(unsigned(axi_rlen) - to_unsigned(1, axi_rlen'length));

      end if;
    end if;
  end process p_r_len_mngt;

  p_raddr_mngt : process (aclk, arstn) is
  begin  -- process p_raddr_mngt
    if arstn = '0' then                 -- asynchronous reset (active low)
      raddr <= (others => '0');
    elsif rising_edge(aclk) then        -- rising clock edge

      if(o_rd_int = '1') then
        raddr <= next_rd_addr;

      elsif(s_axi_arready_int = '1') then
        raddr <= s_axi_araddr;
      end if;

    end if;
  end process p_raddr_mngt;


  p_latch_mngt : process (aclk, arstn) is
  begin  -- process p_latch_mngt
    if arstn = '0' then                 -- asynchronous reset (active low)
      rburst <= (others => '0');
      rsize  <= (others => '0');
      rlen   <= (others => '0');
      rid    <= (others => '0');
      rlock  <= '0';
    elsif rising_edge(aclk) then        -- rising clock edge

      if(s_axi_arvalid = '0') then
        rburst <= (others => '0');
        rsize  <= (others => '0');
        rlen   <= (others => '0');
        rid    <= (others => '0');
        rlock  <= '0';
      else
        rburst <= s_axi_arburst;
        rsize  <= s_axi_arsize;
        rlen   <= s_axi_arlen;
        rid    <= s_axi_arid;
        rlock  <= s_axi_arlock and s_axi_arvalid;
      end if;

    end if;
  end process p_latch_mngt;


  -- Next AXI addr

  o_rd <= o_rd_int;

end architecture rtl;
