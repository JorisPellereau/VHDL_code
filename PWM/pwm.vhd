-------------------------------------------------------------------------------
-- Title      : PWM command
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pwm.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-19
-- Last update: 2019-06-19
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is a simple PWM command
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-19  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_pwm;
use lib_pwm.pkg_pwm.all;

entity pwm is

  port (
    clock_i      : in  std_logic;       -- Input system clock
    reset_n_i    : in  std_logic;       -- Active low asynchronous reset
    duty_cycle_i : in  integer range 0 to C_MAX_DUTY_CYCLE;  -- Duty cycle
    en_pwm_i     : in  std_logic;       -- Enable pwm
    pwm_o        : out std_logic);      -- PWM output

end entity pwm;

architecture arch_pwm of pwm is

  signal pwm_o_s : std_logic;           -- Pwm connection

  -- Counter
  signal cnt_pwm_s : integer range 0 to C_MAX_DUTY_CYCLE;  -- Counter of the PWM period
begin

  -- purpose: This process manages the pwm output
  p_pwm_mng : process (clock_i, reset_n_i)
  begin
    if reset_n_i = '0' then
      pwm_o_s   <= '0';
      cnt_pwm_s <= 0;
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge

      if(en_pwm_i = '1') then
        if(cnt_pwm_s < C_MAX_DUTY_CYCLE - 1) then
          cnt_pwm_s <= cnt_pwm_s + 1;
        else
          cnt_pwm_s <= 0;
        end if;

        if(cnt_pwm_s <= duty_cycle_i) then
          pwm_o_s <= '1';
        else
          pwm_o_s <= '0';
        end if;

      else
        pwm_o_s   <= '0';
        cnt_pwm_s <= 0;
      end if;

    end if;
  end process p_pwm_mng;

  pwm_o <= pwm_o_s;

end architecture arch_pwm;
