-------------------------------------------------------------------------------
-- Title      : TB Template
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_type.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-18
-- Last update: 2020-04-18
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

entity tb_template is

end entity tb_template;

architecture behv of tb_template is

  -- TB CONSTANTS
  constant C_CLK_HALF_PERIOD : time := 10 ns;  -- HALF PERIOD of clk

  -- TB INTERNAL SIGNALS
  signal clk   : std_logic := '0';      -- Clock
  signal rst_n : std_logic := '1';      -- Asynchronous reset

  -- INTERNAL SIGNALS

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


    report "end of Simulation !!!";
    wait;
  end process p_stimulis;

  -- INST

end architecture behv;
