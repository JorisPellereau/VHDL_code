-------------------------------------------------------------------------------
-- Title      : TEST for TOP blocks
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_top_max7219.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-12
-- Last update: 2020-04-13
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-12  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity test_top_max7219 is

end entity test_top_max7219;

architecture behv of test_top_max7219 is

  -- COMPONENTS
  component top_init_max7219 is
    generic(
      G_MAX_CNT         : std_logic_vector(31 downto 0) := x"02FAF080";
      G_MAX_HALF_PERIOD : integer                       := 50;
      G_LOAD_DURATION   : integer                       := 4);
    port (
      clk            : in  std_logic;
      rst_n          : in  std_logic;
      o_cnt          : out std_logic;
      o_max7219_load : out std_logic;
      o_max7219_clk  : out std_logic;
      o_max7219_data : out std_logic);

  end component top_init_max7219;


  -- INTERNAL SIGNALS
  signal clk   : std_logic := '0';
  signal rst_n : std_logic := '1';

  signal s_start        : std_logic;
  signal s_max7219_load : std_logic;
  signal s_max7219_clk  : std_logic;
  signal s_max7219_data : std_logic;

begin  -- architecture behv


  -- purpose: this process generate the input clock
  -- 50MHz : 20 ns
  p_clk_gen : process is
  begin  -- process p_clk_gen
    clk <= not clk;
    wait for 10 ns;
  end process p_clk_gen;

  p_stimuli : process is
  begin  -- process p_stimuli
    s_start <= '0';
    wait for 1 us;
    rst_n   <= '0';
    wait for 1 us;
    rst_n   <= '1';

    wait for 20 us;
    s_start <= '1', '0' after 1 us;

    wait;

  end process p_stimuli;

  -- TOP INIT INST
  top_init_max7219_inst : top_init_max7219
    generic map (
      G_MAX_CNT         => x"000009C4",
      G_MAX_HALF_PERIOD => 50,
      G_LOAD_DURATION   => 4
      )
    port map(
      clk            => clk,
      rst_n          => rst_n,
      o_cnt          => open,
      o_max7219_load => s_max7219_load,
      o_max7219_clk  => s_max7219_clk,
      o_max7219_data => s_max7219_data);

end architecture behv;
