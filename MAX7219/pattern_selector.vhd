-------------------------------------------------------------------------------
-- Title      : Pattern selector for 8x8 matrix
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pattern_selector.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-07-23
-- Last update: 2019-07-23
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Pattern selector for 8x8 matrix
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-07-23  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity pattern_selector is

  port (
    clock_i             : in  std_logic;   -- System clock
    reset_n_i           : in  std_logic;   -- Active low asynchronous reset
    en_i                : in  std_logic;   -- Enable
    sel_i               : in  std_logic_vector(15 downto 0);  -- Selector
    digit_0_o           : out std_logic_vector(7 downto 0);  -- Digit 0 pattern
    digit_1_o           : out std_logic_vector(7 downto 0);  -- Digit 1 pattern
    digit_2_o           : out std_logic_vector(7 downto 0);  -- Digit 2 pattern
    digit_3_o           : out std_logic_vector(7 downto 0);  -- Digit 3 pattern
    digit_4_o           : out std_logic_vector(7 downto 0);  -- Digit 4 pattern
    digit_5_o           : out std_logic_vector(7 downto 0);  -- Digit 5 pattern
    digit_6_o           : out std_logic_vector(7 downto 0);  -- Digit 6 pattern
    digit_7_o           : out std_logic_vector(7 downto 0);  -- Digit 7 pattern
    pattern_available_o : out std_logic);  -- Pattern avaiable

end entity pattern_selector;

architecture arch_pattern_selector of pattern_selector is

  -- INTERNAL SIGNALS
  signal digit_0_s : std_logic_vector(7 downto 0);  -- Digit 0 output
  signal digit_1_s : std_logic_vector(7 downto 0);  -- Digit 1 output
  signal digit_2_s : std_logic_vector(7 downto 0);  -- Digit 2 output
  signal digit_3_s : std_logic_vector(7 downto 0);  -- Digit 3 output
  signal digit_4_s : std_logic_vector(7 downto 0);  -- Digit 4 output
  signal digit_5_s : std_logic_vector(7 downto 0);  -- Digit 5 output
  signal digit_6_s : std_logic_vector(7 downto 0);  -- Digit 6 output
  signal digit_7_s : std_logic_vector(7 downto 0);  -- Digit 7 output

  signal matrix_8x8_s        : t_matrix_8x8;  -- Matrix of the display
  signal pattern_available_s : std_logic;     -- Pattern available output

begin  -- architecture arch_pattern_selector

  -- This process select the pattern according to the input selector
  p_pattern_mng : process(sel_i, en_i)  -- (clock_i, reset_n_i) is
  begin  -- process p_pattern_mng
    -- if reset_n_i = '0' then             -- asynchronous reset (active low)
    --   pattern_available_s <= '0';
    --   matrix_8x8_s        <= (others => (others => '0'));
    -- elsif clock_i'event and clock_i = '1' then  -- rising clock edge
    if(en_i = '1') then

      pattern_available_s <= '1';
      case sel_i is
        when x"0000" =>
          matrix_8x8_s <= C_MATRIX_0;

        when x"0001" =>
          matrix_8x8_s <= C_MATRIX_1;

        when others =>
          pattern_available_s <= '0';
      end case;

    else
      pattern_available_s <= '0';
    end if;

  -- end if;
  end process p_pattern_mng;

  digit_0_s <= matrix_8x8_s(0)(7 downto 0);
  digit_1_s <= matrix_8x8_s(1)(7 downto 0);
  digit_2_s <= matrix_8x8_s(2)(7 downto 0);
  digit_3_s <= matrix_8x8_s(3)(7 downto 0);
  digit_4_s <= matrix_8x8_s(4)(7 downto 0);
  digit_5_s <= matrix_8x8_s(5)(7 downto 0);
  digit_6_s <= matrix_8x8_s(6)(7 downto 0);
  digit_7_s <= matrix_8x8_s(7)(7 downto 0);

  digit_0_o <= digit_0_s;
  digit_1_o <= digit_1_s;
  digit_2_o <= digit_2_s;
  digit_3_o <= digit_3_s;
  digit_4_o <= digit_4_s;
  digit_5_o <= digit_5_s;
  digit_6_o <= digit_6_s;
  digit_7_o <= digit_7_s;


  pattern_available_o <= pattern_available_s;

end architecture arch_pattern_selector;
