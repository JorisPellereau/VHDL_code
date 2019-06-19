-------------------------------------------------------------------------------
-- Title      : Simple test of the pwm
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_pwm.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-19
-- Last update: 2019-06-19
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Test of the pwm module
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-19  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_pwm;
use lib_pwm.pkg_pwm.all;

entity test_pwm is

end entity test_pwm;


architecture arch_test_pwm of test_pwm is


  -- SIGNALS
  signal clock      : std_logic                           := '0';  -- System clock
  signal reset_n    : std_logic                           := '1';  -- Reset
  signal duty_cycle : integer range 0 to C_MAX_DUTY_CYCLE := 0;  -- Duty cycle
  signal en_pwm     : std_logic                           := '0';  -- Enable of the PWM
  signal pwm_o      : std_logic;        -- PWM output


begin  -- architecture arch_test_pwm

  -- 50MHz => T = 20 ns
  p_clock_gen : process
  begin
    clock <= not clock;
    wait for 10 ns;
  end process p_clock_gen;

  -- Stimuli
  p_stimuli : process
  begin

    -- INIT signals
    reset_n    <= '1';
    duty_cycle <= 0;
    en_pwm     <= '0';

    wait for 10 us;

    -- Reset
    reset_n <= '0';
    wait for 10 us;
    reset_n <= '1';

    -- Start pwm
    duty_cycle <= C_MAX_DUTY_CYCLE / 2;
    en_pwm     <= '1';

    wait for 1 ms;

    -- Stop PWM
    en_pwm <= '0';
    wait for 100 us;

    -- END simu
    report "end of simulation";
    wait;



  end process p_stimuli;


  -- PWM inst
  pwm_inst : pwm
    port map(clock_i      => clock,
             reset_n_i    => reset_n,
             duty_cycle_i => duty_cycle,
             en_pwm_i     => en_pwm,
             pwm_o        => pwm_o);


end architecture arch_test_pwm;
