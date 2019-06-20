-------------------------------------------------------------------------------
-- Title      : Top led controller on DE Nano board
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top_led_ctrl.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-20
-- Last update: 2019-06-20
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the top level file for the led controller
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-20  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_pwm;
use lib_pwm.pkg_pwm.all;

entity top_led_ctrl is

  port (
    clock   : in  std_logic;            -- 50 MHz clock
    reset_n : in  std_logic;            -- Active low asynchronous reset
    leds_o  : out std_logic_vector(7 downto 0));

end entity top_led_ctrl;

architecture arch_top_led_ctrl of top_led_ctrl is

  -- COMPONENTS
  component NIOS_II_debug is
    port (
      clk_clk                                  : in std_logic                    := 'X';  -- clk
      reset_reset_n                            : in std_logic                    := 'X';  -- reset_n
      pio_uart_data_external_connection_export : in std_logic_vector(7 downto 0) := (others => 'X')  -- export
      );
  end component NIOS_II_debug;


  -- TYPES
  type t_int_array is array (0 to 7) of integer range 0 to C_MAX_DUTY_CYCLE;  -- Array of integer

  -- SIGNALS
  signal leds_o_s : std_logic_vector(7 downto 0);  -- To leds outputs

  signal duty_cycle_array_s : t_int_array;  -- Array o integer

  -- COUNTERS
  signal cnt_1ms_s      : integer range 0 to 50000;  -- Counter for 1 ms
  signal done_1ms_s     : std_logic;                 -- Counter reach
  signal cnt_mode_sel_s : std_logic;                 -- Count up or count down

  signal cnt_duty_cycle_s : integer range 0 to C_MAX_DUTY_CYCLE;  -- Generates the duty cycle


begin

  -- purpose: This process manages the duty cycle
  p_duty_gen : process (clock, reset_n)
  begin  -- process p_duty_gen
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_1ms_s        <= 0;
      done_1ms_s       <= '0';
      cnt_duty_cycle_s <= 0;
      cnt_mode_sel_s   <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge

      if(cnt_1ms_s < 10000 - 1) then
        cnt_1ms_s  <= cnt_1ms_s + 1;
        done_1ms_s <= '0';
      else
        done_1ms_s <= '1';
        cnt_1ms_s  <= 0;
      end if;

      if(done_1ms_s = '1') then

        if(cnt_mode_sel_s = '0') then
          if(cnt_duty_cycle_s < C_MAX_DUTY_CYCLE - 1) then
            cnt_duty_cycle_s <= cnt_duty_cycle_s + 1;
          else
            -- cnt_duty_cycle_s <= 0;
            cnt_mode_sel_s <= '1';
          end if;
        else
          if(cnt_duty_cycle_s > 0) then
            cnt_duty_cycle_s <= cnt_duty_cycle_s - 1;
          else
            cnt_duty_cycle_s <= 0;
            cnt_mode_sel_s   <= '0';
          end if;
        end if;

      end if;

    end if;
  end process p_duty_gen;


  leds_o <= leds_o_s;

  duty_cycle_array_s(0) <= cnt_duty_cycle_s / 8;
  duty_cycle_array_s(1) <= cnt_duty_cycle_s / 4;
  duty_cycle_array_s(2) <= cnt_duty_cycle_s / 2;
  duty_cycle_array_s(3) <= cnt_duty_cycle_s;
  duty_cycle_array_s(4) <= cnt_duty_cycle_s;
  duty_cycle_array_s(5) <= cnt_duty_cycle_s / 2;
  duty_cycle_array_s(6) <= cnt_duty_cycle_s / 4;
  duty_cycle_array_s(7) <= cnt_duty_cycle_s / 8;

  -- Leds instanciation
  G_leds : for i in 0 to 7 generate
    ledi_cmd_inst : pwm
      port map(
        clock_i      => clock,
        reset_n_i    => reset_n,
        duty_cycle_i => duty_cycle_array_s(i),
        en_pwm_i     => '1',
        pwm_o        => leds_o_s(i));
  end generate G_leds;




  -- ADD NIOS to TOP

  NIOS_isnt : component NIOS_II_debug
    port map (
      clk_clk                                  => clock,
      reset_reset_n                            => reset_n,
      pio_uart_data_external_connection_export => x"DE");

end architecture arch_top_led_ctrl;
