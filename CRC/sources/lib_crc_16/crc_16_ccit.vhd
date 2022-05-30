-------------------------------------------------------------------------------
-- Title      : CRC 16 CCIT
-- Project    : 
-------------------------------------------------------------------------------
-- File       : crc_16_ccit.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2022-05-25
-- Last update: 2022-05-27
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: CRC16 CCIT Implementation
-------------------------------------------------------------------------------
-- Copyright (c) 2022 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2022-05-25  1.0      linux-jp        Created
-------------------------------------------------------------------------------
-- Limitations : i_val have most priority than i_rst_crc. i_rst_crc must be
-- drived before new data is coming
--
library ieee;
use ieee.std_logic_1164.all;


entity crc_16_ccit is
  generic(
    G_CRC_INIT : std_logic_vector(15 downto 0) := x"FFFF"  -- INIT Value of CRC
    );
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    i_rst_crc : in  std_logic;                     -- Reset CRC
    i_val     : in  std_logic;                     -- Input Data Valid
    i_data    : in  std_logic_vector(7 downto 0);  -- Input Data
    o_crc     : out std_logic_vector(15 downto 0)  -- CRC computed on Data
    );

end entity crc_16_ccit;

architecture behv of crc_16_ccit is

  signal s_crc            : std_logic_vector(15 downto 0);
  signal s_rst_crc        : std_logic;
  signal s_rst_crc_r_edge : std_logic;

begin  -- architecture behv

  p_crc_computation : process (clk, rst_n) is
  begin  -- process p_crc_computation
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_crc <= G_CRC_INIT;              -- Init Current CRC
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(i_val = '1') then
        s_crc(0)  <= i_data(0) xor i_data(4) xor s_crc(8) xor s_crc(12);
        s_crc(1)  <= i_data(1) xor i_data(5) xor s_crc(9) xor s_crc(13);
        s_crc(2)  <= i_data(2) xor i_data(6) xor s_crc(10) xor s_crc(14);
        s_crc(3)  <= i_data(3) xor i_data(7) xor s_crc(11) xor s_crc(15);
        s_crc(4)  <= i_data(4) xor s_crc(12);
        s_crc(5)  <= i_data(0) xor i_data(4) xor i_data(5) xor s_crc(8) xor s_crc(12) xor s_crc(13);
        s_crc(6)  <= i_data(1) xor i_data(5) xor i_data(6) xor s_crc(9) xor s_crc(13) xor s_crc(14);
        s_crc(7)  <= i_data(2) xor i_data(6) xor i_data(7) xor s_crc(10) xor s_crc(14) xor s_crc(15);
        s_crc(8)  <= i_data(3) xor i_data(7) xor s_crc(0) xor s_crc(11) xor s_crc(15);
        s_crc(9)  <= i_data(4) xor s_crc(1) xor s_crc(12);
        s_crc(10) <= i_data(5) xor s_crc(2) xor s_crc(13);
        s_crc(11) <= i_data(6) xor s_crc(3) xor s_crc(14);
        s_crc(12) <= i_data(0) xor i_data(4) xor i_data(7) xor s_crc(4) xor s_crc(8) xor s_crc(12) xor s_crc(15);
        s_crc(13) <= i_data(1) xor i_data(5) xor s_crc(5) xor s_crc(9) xor s_crc(13);
        s_crc(14) <= i_data(2) xor i_data(6) xor s_crc(6) xor s_crc(10) xor s_crc(14);
        s_crc(15) <= i_data(3) xor i_data(7) xor s_crc(7) xor s_crc(11) xor s_crc(15);

      else
        s_crc <= G_CRC_INIT;
      end if;

    end if;
  end process p_crc_computation;

  p_pipe_signals : process (clk, rst_n) is
  begin  -- process p_pipe_signals
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_rst_crc <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_rst_crc <= i_rst_crc;
    end if;
  end process p_pipe_signals;

  -- Rising Edge detection
  s_rst_crc_r_edge <= i_rst_crc and not s_rst_crc;

  -- Output Affectation
  o_crc <= s_crc;

end architecture behv;
