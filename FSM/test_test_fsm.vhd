-------------------------------------------------------------------------------
-- Title      : Test du test FSM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_test_fsm.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-27
-- Last update: 2019-07-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-27  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity test_test_fsm is

end entity test_test_fsm;

architecture arch of test_test_fsm is


  component test1_fsm
    port (
      clock   : in  std_logic;                      -- System clock 50MHz
      reset_n : in  std_logic;                      -- Asynchronous_reset
      bp1     : in  std_logic;                      -- bp1
      bp2     : in  std_logic;                      -- bp2
      leds    : out std_logic_vector(7 downto 0));  -- leds
  end component;

  component test2_fsm
    port (
      clock   : in  std_logic;                      -- System clock 50MHz
      reset_n : in  std_logic;                      -- Asynchronous_reset
      bp1     : in  std_logic;                      -- bp1
      bp2     : in  std_logic;                      -- bp2
      leds    : out std_logic_vector(7 downto 0));  -- leds
  end component;

  component test3_fsm
    port (
      clock   : in  std_logic;                      -- System clock 50MHz
      reset_n : in  std_logic;                      -- Asynchronous_reset
      bp1     : in  std_logic;                      -- bp1
      bp2     : in  std_logic;                      -- bp2
      leds    : out std_logic_vector(7 downto 0));  -- leds
  end component;

  component test4_fsm
    port (
      clock   : in  std_logic;                      -- System clock 50MHz
      reset_n : in  std_logic;                      -- Asynchronous_reset
      bp1     : in  std_logic;                      -- bp1
      bp2     : in  std_logic;                      -- bp2
      leds    : out std_logic_vector(7 downto 0));  -- leds
  end component;

  signal clock   : std_logic := '0';
  signal reset_n : std_logic := '1';
  signal bp1     : std_logic;
  signal bp2     : std_logic;
  signal leds1   : std_logic_vector(7 downto 0);
  signal leds2   : std_logic_vector(7 downto 0);
  signal leds3   : std_logic_vector(7 downto 0);
  signal leds4   : std_logic_vector(7 downto 0);

begin  -- architecture arch

  p_clk : process is
  begin  -- process p_clk
    clock <= not clock;
    wait for 10 ns;
  end process p_clk;

  p_stimuli : process is
  begin  -- process p_stimuli

    bp1 <= '0';
    bp2 <= '0';

    reset_n <= '0';
    wait for 50 ns;
    reset_n <= '1';
    wait for 100 ns;

    bp1 <= '1';

    wait for 100 ns;
    bp1 <= '0';
    wait for 100 ns;

    bp2 <= '1';

    wait for 210 ns;
    bp1 <= '1';

    wait for 100 ns;

    report "end of test !!!";
    wait;
  end process p_stimuli;

  test1_fsm_inst : test1_fsm
    port map(
      clock   => clock,
      reset_n => reset_n,
      bp1     => bp1,
      bp2     => bp2,
      leds    => leds1
      );

  test2_fsm_inst : test2_fsm
    port map(
      clock   => clock,
      reset_n => reset_n,
      bp1     => bp1,
      bp2     => bp2,
      leds    => leds2
      );

  test3_fsm_inst : test3_fsm
    port map(
      clock   => clock,
      reset_n => reset_n,
      bp1     => bp1,
      bp2     => bp2,
      leds    => leds3
      );

  test4_fsm_inst : test4_fsm
    port map(
      clock   => clock,
      reset_n => reset_n,
      bp1     => bp1,
      bp2     => bp2,
      leds    => leds4
      );

end architecture arch;
