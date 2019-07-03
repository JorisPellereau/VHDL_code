-------------------------------------------------------------------------------
-- Title      : Test synch clock
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_clock_synch.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-07-03
-- Last update: 2019-07-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: test synch clock
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-07-03  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity test_clock_synch is
  generic (G_T_2_CLOCK_A : time := 25 ns;
           G_T_2_CLOCK_B : time := 10 ns);
end entity test_clock_synch;


architecture arch_test_clock_synch of test_clock_synch is

  component clock_synch
    port (
      reset_n    : in  std_logic;       -- REset
      clock_b    : in  std_logic;       -- clock b
      in_a       : in  std_logic;       -- input clocked on clock a
      synch_in_a : out std_logic);      -- Input clocked on clock b
  end component;

  component pulse_synch
    port (
      reset_n : in  std_logic;          -- Reset
      clock_a : in  std_logic;          -- Clock A
      clock_b : in  std_logic;          -- Clock B
      in_a    : in  std_logic;          -- Pulse from clock A
      out_b   : out std_logic);         -- Pulse from A clocked on clock A
  end component;


  -- SIGNALS
  signal reset_n    : std_logic;        -- Asynchronous reset
  signal clock_b    : std_logic := '0';
  signal clock_a    : std_logic := '1';
  signal in_a       : std_logic;
  signal synch_in_a : std_logic;


  signal pulse_in_a  : std_logic;
  signal pulse_out_b : std_logic;

  signal cnt_100 : integer range 0 to 100;

begin  -- architecture arch_test_clock_synch

  --  clock A
  p_clock_a : process
  begin  -- process p_clock_a
    clock_a <= not clock_a;
    wait for G_T_2_CLOCK_A;
  end process p_clock_a;

  -- clock B
  p_clock_b : process
  begin  -- process p_clock_b
    clock_b <= not clock_b;
    wait for G_T_2_CLOCK_B;
  end process p_clock_b;

  -- Generate a wave on in_a
  -- Generate a pulse on pulse_in_a
  p_in_a_mng : process (clock_a, reset_n)
  begin  -- process p_in_a_mng
    if reset_n = '0' then               -- asynchronous reset (active low)
      in_a       <= '0';
      pulse_in_a <= '0';
    elsif clock_a'event and clock_a = '1' then  -- rising clock edge
      if(cnt_100 < 100 - 1) then
        cnt_100    <= cnt_100 + 1;
        pulse_in_a <= '0';
      else
        cnt_100    <= 0;
        pulse_in_a <= '1';
      end if;

      if(cnt_100 < 44) then
        in_a <= '1';
      else
        in_a <= '0';
      end if;

    end if;
  end process p_in_a_mng;


  p_stimuli_mng : process
  begin  -- process p_stimuli_mng
    reset_n <= '1';
    wait for 200 ns;
    reset_n <= '0';
    wait for 100 ns;
    reset_n <= '1';
    wait for 100 us;

    report "end of test";
    wait;
  end process p_stimuli_mng;

  -- clock synch Inst
  clock_synch_inst : clock_synch
    port map(
      reset_n    => reset_n,
      clock_b    => clock_b,
      in_a       => in_a,
      synch_in_a => synch_in_a);

  -- pulse synch inst
  pulse_synch_inst : pulse_synch
    port map(
      reset_n => reset_n,
      clock_a => clock_a,
      clock_b => clock_b,
      in_a    => pulse_in_a,
      out_b   => pulse_out_b);


end architecture arch_test_clock_synch;
