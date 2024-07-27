-------------------------------------------------------------------------------
-- Title      : AXI4 Write Channel interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_wr_chan_itf.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-06-09
-- Last update: 2024-06-19
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: AXI4 Write Channel interface
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-06-09  1.0      linux-jp        Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axi4_wr_chan_itf is

  generic (
    G_AXI4_DATA_WIDTH : integer := 32;  -- AXI4 data width
    G_AXI4_ADDR_WIDTH : integer := 32;  -- AXI4 addr width
    G_AXI4_ID_WIDTH   : integer := 1;   -- AXI4 ID width
    G_AXI4_USER_WIDTH : integer := 1);  -- AXI4 User width
  port(
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
    s_axi_wvalid : in  std_logic;                                               -- W VALID
    s_axi_wready : out std_logic;                                               -- W READY

    -- B Channel
    s_axi_bid    : out std_logic_vector(G_AXI4_ID_WIDTH - 1 downto 0);  -- B ID
    s_axi_bresp  : out std_logic_vector(1 downto 0);                    -- B RESP
    s_axi_bvalid : out std_logic;                                       -- B VALID
    s_axi_bready : in  std_logic;                                       -- B READY

    -- Registers interface
    o_we    : out std_logic;                                            -- Write Enable
    o_waddr : out std_logic_vector(G_AXI4_ADDR_WIDTH - 1 downto 0);     -- Write Address
    o_wdata : out std_logic_vector(G_AXI4_DATA_WIDTH - 1 downto 0);     -- Write Data
    o_wstrb : out std_logic_vector((G_AXI4_DATA_WIDTH/8) - 1 downto 0)  -- Write Strobe
    );

end entity axi4_wr_chan_itf;

architecture rtl of axi4_wr_chan_itf is

  -- == INTERNAL signals ==

  -- - Skidbuffer signals
  signal skidbuffer_i_data : std_logic_vector(G_AXI4_ADDR_WIDTH + 2 + 3 + 1 + 8 + G_AXI4_ID_WIDTH - 1 downto 0);  -- Input data of the skidbuffer
  signal skidbuffer_o_data : std_logic_vector(skidbuffer_i_data'length - 1 downto 0);  -- Output data of the skidbuffer
  signal m_awvalid         : std_logic;                                                -- AWVALID at the output of the skidbuffer
  signal m_awready         : std_logic;                                                -- AWREADY at the input of the skidbuffer
  signal m_awaddr          : std_logic_vector(G_AXI4_ADDR_WIDTH - 1 downto 0);
  signal m_awburst         : std_logic_vector(1 downto 0);
  signal m_awsize          : std_logic_vector(2 downto 0);
  signal m_awlock          : std_logic;
  signal m_awlen           : std_logic_vector(7 downto 0);
  signal m_awid            : std_logic_vector(G_AXI4_ID_WIDTH - 1 downto 0);


  -- - AXI
  signal axi_awready      : std_logic;
  signal axi_wready       : std_logic;
  signal s_axi_wready_int : std_logic;
  signal s_axi_bvalid_int : std_logic;

  signal r_bvalid   : std_logic;
  signal r_bid      : std_logic_vector(G_AXI4_ID_WIDTH - 1 downto 0);
  signal axi_bid    : std_logic_vector(G_AXI4_ID_WIDTH - 1 downto 0);
  signal axi_bvalid : std_logic;

  signal waddr        : std_logic_vector(G_AXI4_ADDR_WIDTH - 1 downto 0);
  signal wburst       : std_logic_vector(1 downto 0);
  signal wsize        : std_logic_vector(2 downto 0);
  signal wlen         : std_logic_vector(7 downto 0);
  signal next_wr_addr : std_logic_vector(G_AXI4_ADDR_WIDTH - 1 downto 0);

begin  -- architecture rtl


  -- Skidbuffer input data affectation
  skidbuffer_i_data <= s_axi_awaddr & s_axi_awburst & s_axi_awsize & s_axi_awlock & s_axi_awlen & s_axi_awid;

  -- Instanciation of AW Skidbuffer
  i_skidbuffer_0 : entity work.skidbuffer
    generic map (
      G_DATA_WIDTH => skidbuffer_i_data'length
      )
    port map (
      clk_sys   => aclk,
      rst_n_sys => arstn,
      i_valid   => s_axi_awvalid,
      i_data    => skidbuffer_i_data,
      o_ready   => s_axi_awready,
      o_valid   => m_awvalid,
      i_ready   => m_awready,
      o_data    => skidbuffer_o_data
      );

  -- Skidbuffer output data affectation
  m_awaddr  <= skidbuffer_o_data(G_AXI4_ADDR_WIDTH + 2 + 3 + 1 + 8 + G_AXI4_ID_WIDTH - 1 downto 2 + 3 + 1 + 8 + G_AXI4_ID_WIDTH);
  m_awburst <= skidbuffer_o_data(2 + 3 + 1 + 8 + G_AXI4_ID_WIDTH - 1 downto 3 + 1 + 8 + G_AXI4_ID_WIDTH);
  m_awsize  <= skidbuffer_o_data(3 + 1 + 8 + G_AXI4_ID_WIDTH - 1 downto 1 + 8 + G_AXI4_ID_WIDTH);
  m_awlock  <= skidbuffer_o_data(8 + G_AXI4_ID_WIDTH);
  m_awlen   <= skidbuffer_o_data(8 + G_AXI4_ID_WIDTH - 1 downto G_AXI4_ID_WIDTH);
  m_awid    <= skidbuffer_o_data (G_AXI4_ID_WIDTH - 1 downto 0);


  -- AXI awready flag management
  p_axi_awready : process (aclk, arstn) is
  begin  -- process p_axi_awready
    if arstn = '0' then                 -- asynchronous reset (active low)
      axi_awready <= '1';
    elsif rising_edge(aclk) then        -- rising clock edge

      -- Acknowledgment
      if(m_awvalid = '1' and m_awready = '1') then
        axi_awready <= '0';

      elsif(s_axi_wvalid = '1' and s_axi_wready_int = '1') then
        axi_awready <= s_axi_wlast and (not s_axi_bvalid_int or s_axi_bready);
      else
        if(s_axi_wready_int = '1' or (r_bvalid = '1' and s_axi_bready = '0')) then
          axi_awready <= '0';
        else axi_awready <= '1';
        end if;
      end if;
    end if;
  end process p_axi_awready;


  -- AXI Wready flag management
  p_axi_wready : process (aclk, arstn) is
  begin  -- process p_axi_wready
    if arstn = '0' then                 -- asynchronous reset (active low)
      axi_wready <= '0';
    elsif rising_edge(aclk) then        -- rising clock edge
      if(m_awvalid = '1' and m_awready = '1') then
        axi_wready <= '1';

      elsif(s_axi_wvalid = '1' and s_axi_wready_int = '1') then
        axi_wready <= not s_axi_wlast;
      end if;
    end if;
  end process p_axi_wready;

  -- Exclusif write managenet


  -- Next write address calculation
  p_next_wr_addr : process (aclk, arstn) is
  begin  -- process p_next_wr_addr
    if arstn = '0' then                 -- asynchronous reset (active low)
      waddr  <= (others => '0');
      wburst <= (others => '0');
      wsize  <= (others => '0');
      wlen   <= (others => '0');
    elsif rising_edge(aclk) then        -- rising clock edge
      if(m_awready = '1') then
        waddr  <= m_awaddr;
        wburst <= m_awburst;
        wsize  <= m_awsize;
        wlen   <= m_awlen;

      elsif(s_axi_wvalid = '1') then
        waddr <= next_wr_addr;
      end if;
    end if;
  end process p_next_wr_addr;


  -- Instanciation of Next Write Addr computation
  i_axi_addr_0 : entity work.axi_addr
    generic map (
      G_ADDR_WIDTH => G_AXI4_ADDR_WIDTH,
      G_DATA_WIDTH => G_AXI4_DATA_WIDTH
      )
    port map (
      last_addr => waddr,
      size      => wsize,
      burst     => wburst,
      len       => wlen,
      next_addr => next_wr_addr
      );


  -- R_bvalid management
  p_r_valid_mngt : process (aclk, arstn) is
  begin  -- process p_r_valid_mngt
    if arstn = '0' then                 -- asynchronous reset (active low)
      r_bvalid <= '0';
    elsif rising_edge(aclk) then        -- rising clock edge

      if(s_axi_wvalid = '1' and s_axi_wready_int = '1' and s_axi_wlast = '1' and s_axi_bvalid_int = '1' and s_axi_bready = '0') then
        r_bvalid <= '1';
      elsif(s_axi_bready = '1') then
        r_bvalid <= '0';
      end if;

    end if;
  end process p_r_valid_mngt;

  p_r_bid_mngt : process (aclk, arstn) is
  begin  -- process p_r_bid_mngt
    if arstn = '0' then                 -- asynchronous reset (active low)
      r_bid <= (others => '0');
    elsif rising_edge(aclk) then        -- rising clock edge

      if(m_awready = '1' and m_awvalid = '1') then
        r_bid <= m_awid;
      end if;

    end if;
  end process p_r_bid_mngt;

  -- AXI BID management
  p_axi_bid_mngt : process (aclk, arstn) is
  begin  -- process p_axi_bid_mngt
    if arstn = '0' then                 -- asynchronous reset (active low)
      axi_bid <= (others => '0');
    elsif rising_edge(aclk) then        -- rising clock edge

      if(s_axi_bvalid_int = '0' or s_axi_bready = '1') then
        axi_bid <= r_bid;
      end if;

    end if;
  end process p_axi_bid_mngt;


  p_axi_bvalid_mngt : process (aclk, arstn) is
  begin  -- process p_axi_bvalid_mngt
    if arstn = '0' then                 -- asynchronous reset (active low)
      axi_bvalid <= '0';
    elsif rising_edge(aclk) then        -- rising clock edge

      if(s_axi_wvalid = '1' and s_axi_wready_int = '1' and s_axi_wlast = '1') then
        axi_bvalid <= '1';

      elsif(s_axi_bready = '1') then
        axi_bvalid <= r_bvalid;
      end if;

    end if;
  end process p_axi_bvalid_mngt;

  m_awready <= '1' when s_axi_wvalid = '1' and s_axi_wready_int = '1' and s_axi_wlast = '1' and (s_axi_bvalid_int = '0' or s_axi_bready = '1') else
               axi_awready;

  -- Registers Interface
  p_reg_wr_mngt : process (aclk, arstn) is
  begin  -- process p_reg_wr_mngt
    if arstn = '0' then                 -- asynchronous reset (active low)
      o_we    <= '0';
      o_waddr <= (others => '0');
      o_wstrb <= (others => '0');
      o_wdata <= (others => '0');
    elsif rising_edge(aclk) then        -- rising clock edge

      o_we    <= s_axi_wvalid and s_axi_wready_int;
      o_waddr <= waddr;
      o_wdata <= s_axi_wdata;
      o_wstrb <= s_axi_wstrb;
    end if;
  end process p_reg_wr_mngt;


  s_axi_wready <= s_axi_wready_int;
  s_axi_bvalid <= s_axi_bvalid_int;
  s_axi_bid    <= axi_bid;
  s_axi_bresp  <= (others => '0');      -- No Error generated yet
end architecture rtl;
