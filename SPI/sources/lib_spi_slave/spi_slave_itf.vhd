-------------------------------------------------------------------------------
-- Title      : SPI Slave Interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : spi_slave_itf.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-09
-- Last update: 2024-01-21
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: SPI Slave Interface
-- Input data : spi_di is not resynchronized : the data is considered stable of the edge sampling due to SPI protocol
-- clk_sys clock domain is faster than spi_clk clock_domain
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-09  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity spi_slave_itf is
  generic (
    G_SPI_SIZE        : integer range 1 to 4  := 4;     -- SPI Size
    G_DATA_WIDTH      : integer               := 8;     -- Data Width
    G_FIFO_DATA_WIDTH : integer range 8 to 32 := 8;     -- FIFO DATA WIDTH
    G_FIFO_DEPTH      : integer               := 1024;  -- FIFO DEPTH
    G_CPHA            : std_logic;                      -- CPHA HARD Configuration
    G_CPOL            : std_logic                       -- CPOL HARD Configuration
    );
  port (
    clk_sys   : in std_logic;                           -- Clock System
    rst_n_sys : in std_logic;                           -- Asynchronous Reset

    -- FIFO TX Interface
    fifo_tx_rd_en : out std_logic;                                    -- FIFO TX Read Enable
    fifo_tx_data  : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- FIFO TX DATA

    -- FIFO RX Interface
    fifo_rx_wr_en : out std_logic;                                    -- FIFO RX Write Enable
    fifo_rx_data  : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- FIFO RX DATA

    -- SPI Control
    spi_clk      : in  std_logic;                                  -- MASTER SPI Clock
    spi_cs_n     : in  std_logic;                                  -- MASTER SPI Chip Select - Actif at '0'
    spi_do       : out std_logic_vector(G_SPI_SIZE - 1 downto 0);  -- SPI Data Out
    spi_di       : in  std_logic_vector(G_SPI_SIZE - 1 downto 0);  -- SPI Data In
    spi_busy     : out std_logic;                                  -- SPI Is busy
    spi_slave_it : out std_logic                                   -- SPI DONE
    );
end entity spi_slave_itf;

architecture rtl of spi_slave_itf is

  -- == TYPES ==
  type t_fsm_state is (ST_IDLE, ST_RD, ST_IT);  -- FSM STATES

  -- == INTERNAL Signals ==
  signal spi_cs_n_p      : std_logic;    -- SPI CS piped one time
  signal spi_cs_n_r_edge : std_logic;    -- Rising edge of SPI_CS_N
  signal spi_cs_n_f_edge : std_logic;    -- Falling edge of SPI_CS_N
  signal fsm_ns          : t_fsm_state;  -- FSM Next state
  signal fsm_cs          : t_fsm_state;  -- FSM Current state

  signal cnt_bit_done_p0     : std_logic;  -- counter bit done in clk_sys clock domain
  signal cnt_bit_done_p1     : std_logic;  -- counter bit done in clk_sys clock domain
  signal cnt_bit_done_p2     : std_logic;  -- counter bit done in clk_sys clock domain
  signal cnt_bit_done_r_edge : std_logic;  -- rising edge of counter bit done in clk_sys clock domain
  signal en_it               : std_logic;  -- Enable Interruption

  -- == spi_clk clock domain ==
  signal cnt_bit_spi_clk      : unsigned(log2(G_DATA_WIDTH) - 1 downto 0);    -- Bit Counter
  signal cnt_bit_done_spi_clk : std_logic;                                    -- Counter of bit done
  signal rdata_sr_spi_clk     : std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Read Data shift register
  signal spi_clk_rst          : std_logic;                                    -- SPI reset clock domain
  -- ==========================

begin  -- architecture rtl


  -- purpose: Piped input signals
  p_piped_signals : process (clk_sys, rst_n_sys) is
  begin  -- process p_piped_signals
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      spi_cs_n_p <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      spi_cs_n_p <= spi_cs_n;
    end if;
  end process p_piped_signals;

  spi_cs_n_r_edge <= spi_cs_n and not spi_cs_n_p;  -- Rising Edge detection
  spi_cs_n_f_edge <= not spi_cs_n and spi_cs_n_p;  -- Falling edge detection

  -- purpose: FSM CS Update
  p_fsm_ns_update : process (clk_sys, rst_n_sys) is
  begin  -- process p_fsm_ns_update
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fsm_cs <= ST_IDLE;
    elsif rising_edge(clk_sys) then     -- rising clock edge
      fsm_cs <= fsm_ns;
    end if;
  end process p_fsm_ns_update;


  -- purpose: FSM NS update
  p_fsm_ns : process (fsm_cs, spi_cs_n_r_edge, spi_cs_n_f_edge) is
  begin  -- process p_fsm_ns

    case fsm_cs is

      -- Stay in IDLE state until the detection of a falling edge of SPI CS
      when ST_IDLE =>
        en_it <= '0';                   -- Enable IT

        -- Go to Read State if a falling edge is detected
        if(spi_cs_n_f_edge = '1') then
          fsm_ns <= ST_RD;
        else
          fsm_ns <= ST_IDLE;
        end if;


      -- Stay in this state until the reception of a rising edge of spi cs
      when ST_RD =>
        en_it <= '0';                   -- Enable IT
        if(spi_cs_n_r_edge = '1') then
          fsm_ns <= ST_IT;
        else
          fsm_ns <= ST_RD;
        end if;

      when ST_IT =>
        en_it  <= '1';                  -- Enable IT
        fsm_ns <= ST_IDLE;

      when others =>
        en_it  <= '0';                  -- Enable IT
        fsm_ns <= ST_IDLE;

    end case;

  end process p_fsm_ns;


  -- == spi_clk to clk_sys clock domain ==
  -- purpose: Double resynchronization in order to pass bits in spi_clk clock domain to clk_sys clock domain
  p_double_resynch : process (clk_sys, rst_n_sys) is
  begin  -- process p_double_resynch
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cnt_bit_done_p0 <= '0';
      cnt_bit_done_p1 <= '0';
      cnt_bit_done_p2 <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      cnt_bit_done_p0 <= cnt_bit_done_spi_clk;
      cnt_bit_done_p1 <= cnt_bit_done_p0;
      cnt_bit_done_p2 <= cnt_bit_done_p1;
    end if;
  end process p_double_resynch;

  cnt_bit_done_r_edge <= cnt_bit_done_p1 and not cnt_bit_done_p2;  -- Rising Edge detection

  -- purpose: Interruption generation
  p_it_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_it_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      spi_slave_it <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      spi_slave_it <= en_it;
    end if;
  end process p_it_mngt;

  -- purpose: Busy management
  p_busy_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_busy_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      spi_busy <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      spi_busy <= not spi_cs_n;
    end if;
  end process p_busy_mngt;

  -- Outputs affectation
  fifo_rx_wr_en <= cnt_bit_done_r_edge;
  fifo_rx_data  <= rdata_sr_spi_clk;    -- Data is considered as stable on the fifo_rx_wr_en pulse
  -- =====================================



  -- == Shift register in spi_clk clock domain ==

  spi_clk_rst <= '0' when spi_cs_n = '0' else '1';  -- TBD a chier

  g_sr_on_r_edge : if((G_CPOL = '0' and G_CPHA = '0') or (G_CPOL = '1' and G_CPHA = '1')) generate

    -- Shift data on rising edge of cpi_clk. It depends on cpol and cpha
    p_rdata_sr : process (spi_clk) is
    begin

      if(rising_edge(spi_clk)) then
        rdata_sr_spi_clk <= spi_di & rdata_sr_spi_clk(G_DATA_WIDTH - 1 downto G_SPI_SIZE);
      end if;

    end process p_rdata_sr;


    -- purpose: Counter of Bit on each edge
    p_cnt_bit : process (spi_clk, spi_clk_rst) is
    begin  -- process p_cnt_bit
      if spi_clk_rst = '0' then         -- asynchronous reset (active low)
        cnt_bit_spi_clk <= (others => '0');
      elsif rising_edge(spi_clk) then   -- rising clock edge

        if(cnt_bit_done_spi_clk = '1') then
          cnt_bit_spi_clk <= to_unsigned(1, cnt_bit_spi_clk'length);  -- Reinit at one because there is only G_DATA_WIDTH clock edge per data
        else
          cnt_bit_spi_clk <= cnt_bit_spi_clk + 1;                     -- Inc the Counter
        end if;

      end if;
    end process p_cnt_bit;

  end generate g_sr_on_r_edge;


  g_sr_on_f_edge : if((G_CPOL = '1' and G_CPHA = '0') or (G_CPOL = '0' and G_CPHA = '1')) generate
    p_rdata_sr : process(spi_clk) is
    begin

      if(falling_edge(spi_clk)) then
        rdata_sr_spi_clk <= spi_di & rdata_sr_spi_clk(G_DATA_WIDTH - 1 downto G_SPI_SIZE);
      end if;

    end process p_rdata_sr;

    -- purpose: Counter of Bit on each edge
    p_cnt_bit : process (spi_clk, spi_clk_rst) is
    begin  -- process p_cnt_bit
      if spi_clk_rst = '0' then         -- asynchronous reset (active low)
        cnt_bit_spi_clk <= (others => '0');
      elsif falling_edge(spi_clk) then  -- rising clock edge

        if(cnt_bit_done_spi_clk = '1') then
          cnt_bit_spi_clk <= to_unsigned(1, cnt_bit_spi_clk'length);  -- Reinit at one because there is only G_DATA_WIDTH clock edge per data
        else
          cnt_bit_spi_clk <= cnt_bit_spi_clk + 1;                     -- Inc the Counter
        end if;

      end if;
    end process p_cnt_bit;

  end generate g_sr_on_f_edge;


  -- This Flag is set to '1' when the counter is reach
  cnt_bit_done_spi_clk <= '1' when cnt_bit_spi_clk = to_unsigned(G_DATA_WIDTH / G_SPI_SIZE, cnt_bit_spi_clk'length) else '0';

  -- ============================================

end architecture rtl;
