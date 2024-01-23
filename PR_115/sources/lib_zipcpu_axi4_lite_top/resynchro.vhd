-------------------------------------------------------------------------------
-- Title      : Resynchro
-- Project    : 
-------------------------------------------------------------------------------
-- File       : resynchro.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-01-04
-- Last update: 2024-01-23
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Resynchronization of asynchronous signal to clk_sys clock domain
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-01-04  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity resynchro is
  port (
    rst_n_clk_sys : in std_logic;       -- Reset synchronized in clk_sys clock domain
    clk_sys       : in std_logic;       -- clk_sys clock

    -- Push Buttons resynchronization
    key_1_a       : in  std_logic;      -- KEY 1 Asynchronous
    key_1_clk_sys : out std_logic;      -- KEY 2 Resynchronized in clk_sys clock domain
    key_2_a       : in  std_logic;      -- KEY 1 Asynchronous
    key_2_clk_sys : out std_logic;      -- KEY 2 Resynchronized in clk_sys clock domain
    key_3_a       : in  std_logic;      -- KEY 1 Asynchronous
    key_3_clk_sys : out std_logic;      -- KEY 2 Resynchronized in clk_sys clock domain

    -- RTS signals
    i_rts_n_a       : in  std_logic;    -- RTS asynchronous input
    o_rts_n_clk_sys : out std_logic;    -- RTS resynchronized in clk_sys clock domain

    -- SPI SLAVE CS N resynchronization
    spi_slave_cs_n         : in  std_logic;  -- SPI SLAVE Chip Select aynchronous
    spi_slave_cs_n_clk_sys : out std_logic   -- SPI SLAVE Chip select in clk_sys clock domain
    );
end entity resynchro;

architecture rtl of resynchro is

  -- == INTERNAL Signals ==
  signal rts_n_p1          : std_logic;  -- RTS N P1
  signal rts_n_p2          : std_logic;  -- RTS N P2
  signal spi_slave_cs_n_p1 : std_logic;  -- SPI SLAVE CS P1
  signal spi_slave_cs_n_p2 : std_logic;  -- SPI SLAVE CS P2
  signal key_1_p1          : std_logic;  -- KEY 1 P1
  signal key_1_p2          : std_logic;  -- KEY 1 P2
  signal key_2_p1          : std_logic;  -- KEY 2 P1
  signal key_2_p2          : std_logic;  -- KEY 2 P2
  signal key_3_p1          : std_logic;  -- KEY 3 P1
  signal key_3_p2          : std_logic;  -- KEY 3 P2

begin  -- architecture rtl

  p_resynch_rts_n : process (clk_sys, rst_n_clk_sys) is
  begin  -- process p_resynch_rts_n
    if rst_n_clk_sys = '0' then         -- asynchronous reset (active low)
      rts_n_p1 <= '0';
      rts_n_p2 <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      rts_n_p1 <= i_rts_n_a;
      rts_n_p2 <= rts_n_p1;
    end if;
  end process p_resynch_rts_n;

  o_rts_n_clk_sys <= rts_n_p2;          -- Connect the output

  p_resynch_spi_slave_cs_n : process (clk_sys, rst_n_clk_sys) is
  begin  -- process p_resynch_spi_slave_cs_n
    if rst_n_clk_sys = '0' then         -- asynchronous reset (active low)
      spi_slave_cs_n_p1 <= '0';
      spi_slave_cs_n_p2 <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      spi_slave_cs_n_p1 <= spi_slave_cs_n;
      spi_slave_cs_n_p2 <= spi_slave_cs_n_p1;
    end if;
  end process p_resynch_spi_slave_cs_n;

  spi_slave_cs_n_clk_sys <= spi_slave_cs_n_p2;  -- Connect to Output

  p_resynch_key_1 : process (clk_sys, rst_n_clk_sys) is
  begin  -- process p_resynch_key_1
    if rst_n_clk_sys = '0' then         -- asynchronous reset (active low)
      key_1_p1 <= '0';
      key_1_p2 <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      key_1_p1 <= key_1_a;
      key_1_p2 <= key_1_p1;
    end if;
  end process p_resynch_key_1;

  key_1_clk_sys <= key_1_p2;

  p_resynch_key_2 : process (clk_sys, rst_n_clk_sys) is
  begin  -- process p_resynch_key_2
    if rst_n_clk_sys = '0' then         -- asynchronous reset (active low)
      key_2_p1 <= '0';
      key_2_p2 <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      key_2_p1 <= key_2_a;
      key_2_p2 <= key_2_p1;
    end if;
  end process p_resynch_key_2;

  key_2_clk_sys <= key_2_p2;

  p_resynch_key_3 : process (clk_sys, rst_n_clk_sys) is
  begin  -- process p_resynch_key_3
    if rst_n_clk_sys = '0' then         -- asynchronous reset (active low)
      key_3_p1 <= '0';
      key_3_p2 <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      key_3_p1 <= key_3_a;
      key_3_p2 <= key_3_p1;
    end if;
  end process p_resynch_key_3;

  key_3_clk_sys <= key_3_p2;

end architecture rtl;
