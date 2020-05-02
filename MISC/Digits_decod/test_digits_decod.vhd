-------------------------------------------------------------------------------
-- Title      : Test of DIGITS DECOD
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_digits_decod.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-18
-- Last update: 2020-04-19
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Test of the Digit Decod Block
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

entity test_digits_decod is

end entity test_digits_decod;

architecture behv of test_digits_decod is

  -- COMPONENT
  component digits_decod is

    generic (
      G_DIGITS_NB  : integer range 2 to 8 := 8;    -- DIGITS Number to decod
      G_DATA_WIDTH : integer              := 32);  -- DATA WIDTH

    port (
      clk          : in  std_logic;     -- Clock
      rst_n        : in  std_logic;     -- Asynchronous Reset
      i_data2decod : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Data to decod
      i_val        : in  std_logic;     -- Input valid
      o_decod      : out std_logic_vector(G_DIGITS_NB*G_DATA_WIDTH - 1 downto 0);  -- Decod output
      o_done       : out std_logic);    -- Decod Done

  end component digits_decod;

  -- TB CONSTANTS
  constant C_CLK_HALF_PERIOD : time := 10 ns;   -- HALF PERIOD of clk
  constant C_WAIT_TIME       : time := 100 ns;  -- WAIT TIME
  constant C_TIMEOUT         : time := 1 ms;    -- TIMEOUT

  -- INST CONSTANTS
  constant C_DIGITS_NB  : integer range 2 to 8 := 8;
  constant C_DATA_WIDTH : integer              := 32;


  -- TB INTERNAL SIGNALS
  signal clk   : std_logic := '0';      -- Clock
  signal rst_n : std_logic := '1';      -- Asynchronous reset

  -- INTERNAL SIGNALS
  signal s_data2decod : std_logic_vector(C_DATA_WIDTH - 1 downto 0);
  signal s_val        : std_logic;

  -- INST_0
  signal s_decod : std_logic_vector(C_DIGITS_NB*4 - 1 downto 0);
  signal s_done  : std_logic;

  -- INST_1
  signal s_decod_1 : std_logic_vector(2*4 - 1 downto 0);
  signal s_done_1  : std_logic;

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
    s_data2decod <= (others => '0');
    s_val        <= '0';

    wait for C_WAIT_TIME;
    rst_n <= '0';
    wait for C_WAIT_TIME;
    rst_n <= '1';
    wait for C_WAIT_TIME;

    s_data2decod <= x"05F5E100";        -- Set at 100.000.000
    wait until falling_edge(clk);
    s_val        <= '1';
    wait until falling_edge(clk);
    s_val        <= '0';

    wait until rising_edge(s_done) for C_TIMEOUT;


    s_data2decod <= x"00BC614E";        -- Set at 12.345.678
    wait until falling_edge(clk);
    s_val        <= '1';
    wait until falling_edge(clk);
    s_val        <= '0';

    wait until rising_edge(s_done) for C_TIMEOUT;


    report "end of Simulation !!!";
    wait;
  end process p_stimulis;


  -- DIGITS DECOD INST
  digits_decod_inst_0 : digits_decod
    generic map (
      G_DIGITS_NB  => C_DIGITS_NB,
      G_DATA_WIDTH => C_DATA_WIDTH)

    port map (
      clk          => clk,
      rst_n        => rst_n,
      i_data2decod => s_data2decod,
      i_val        => s_val,
      o_decod      => s_decod,
      o_done       => s_done);


  -- DIGITS DECOD INST
  digits_decod_inst_1 : digits_decod
    generic map (
      G_DIGITS_NB  => 2,
      G_DATA_WIDTH => C_DATA_WIDTH)

    port map (
      clk          => clk,
      rst_n        => rst_n,
      i_data2decod => s_data2decod,
      i_val        => s_val,
      o_decod      => s_decod_1,
      o_done       => s_done_1);




end architecture behv;
