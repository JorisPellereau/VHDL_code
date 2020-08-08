-------------------------------------------------------------------------------
-- Title      : TB Template
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_type.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-18
-- Last update: 2020-08-08
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-18  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tb_test0 is

end entity tb_test0;

architecture behv of tb_test0 is

  component crc_test0 is

    port (
      clk          : in  std_logic;     -- Clock
      rst_n        : in  std_logic;     -- Asynchronous reset
      i_crc_en     : in  std_logic;     -- CRC enable
      i_crc        : in  std_logic;     -- CRC in
      o_crc_vector : out std_logic_vector(7 downto 0));

  end component crc_test0;

  -- TB CONSTANTS
  constant C_CLK_HALF_PERIOD : time := 10 ns;  -- HALF PERIOD of clk

  -- TB INTERNAL SIGNALS
  signal clk   : std_logic := '0';      -- Clock
  signal rst_n : std_logic := '1';      -- Asynchronous reset

  -- INTERNAL SIGNALS
  signal s_crc_en     : std_logic;
  signal s_crc_in     : std_logic_vector(7 downto 0);
  signal s_crc_vector : std_logic_vector(7 downto 0);

begin  -- architecture behv

  -- purpose: this process generate the input clock
  p_clk_gen : process is
  begin  -- process p_clk_gen
    clk <= not clk;
    wait for C_CLK_HALF_PERIOD;
  end process p_clk_gen;

  -- STIMULIS
  p_stimulis : process is
  begin  -- process p_stimuli

    -- SIGNALS INIT
    s_crc_in <= (others => '0');
    s_crc_en <= '0';

    wait for 10*C_CLK_HALF_PERIOD;

    s_crc_in <= x"57";

    


    report "end of Simulation !!!";
    wait;
  end process p_stimulis;

  -- INST

  i_crc_test0 : crc_test0
    port map (
      clk          => clk,
      rst_n        => rst_n,
      i_crc_en     => s_crc_en,
      i_crc        => s_crc_in(7),
      o_crc_vector => s_crc_vector
      );

end architecture behv;
