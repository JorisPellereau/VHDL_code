library ieee;
use ieee.std_logic_1164.all;


package pkg_lcd_cfah_types_and_func is

  -- TYPES
  type t_lines_array is array (0 to 31) of std_logic_vector(7 downto 0);  -- Line Array
  type t_cgram_array is array(0 to 63) of std_logic_vector(4 downto 0);  -- CGRAM buffer

  type t_cgram_pattern_5x8_array is array(0 to 7) of std_logic_vector(4 downto 0);
  type t_cgram_pattern_5x10_array is array(0 to 9) of std_logic_vector(4 downto 0);
  type t_cgram_array_2 is array(0 to 7) of t_cgram_pattern_5x8_array;

  -- == FUNCTIONS ==
  -- Convert a clock period in [ns] to a number of period
  function clk_period_to_max(i_clk_period : integer; i_duration : integer)
    return integer;

  -- Convert 8  t_cgram_pattern_5x8_array type to t_cgram_array type
  function create_cgram_init(i_cgram_pattern_5x8_0 : t_cgram_pattern_5x8_array; i_cgram_pattern_5x8_1 : t_cgram_pattern_5x8_array;
                             i_cgram_pattern_5x8_2 : t_cgram_pattern_5x8_array; i_cgram_pattern_5x8_3 : t_cgram_pattern_5x8_array;
                             i_cgram_pattern_5x8_4 : t_cgram_pattern_5x8_array; i_cgram_pattern_5x8_5 : t_cgram_pattern_5x8_array;
                             i_cgram_pattern_5x8_6 : t_cgram_pattern_5x8_array; i_cgram_pattern_5x8_7 : t_cgram_pattern_5x8_array)
    return t_cgram_array;


end package pkg_lcd_cfah_types_and_func;

package body pkg_lcd_cfah_types_and_func is

  -- Convert a clock period in [ns] to a number of period
  function clk_period_to_max(i_clk_period : integer; i_duration : integer)
    return integer is

    -- Internal Variables
    variable v_results : integer := 0;
  begin
    v_results := i_duration / i_clk_period;
    if(v_results = 0) then
      v_results := 1;                   -- One TCLK minimum
    end if;
    return v_results;
  end function clk_period_to_max;


  -- Convert 8  t_cgram_pattern_5x8_array type to t_cgram_array type
  function create_cgram_init(i_cgram_pattern_5x8_0 : t_cgram_pattern_5x8_array; i_cgram_pattern_5x8_1 : t_cgram_pattern_5x8_array;
                             i_cgram_pattern_5x8_2 : t_cgram_pattern_5x8_array; i_cgram_pattern_5x8_3 : t_cgram_pattern_5x8_array;
                             i_cgram_pattern_5x8_4 : t_cgram_pattern_5x8_array; i_cgram_pattern_5x8_5 : t_cgram_pattern_5x8_array;
                             i_cgram_pattern_5x8_6 : t_cgram_pattern_5x8_array; i_cgram_pattern_5x8_7 : t_cgram_pattern_5x8_array)
    return t_cgram_array is

    -- Internal variables
    variable v_cgram_array : t_cgram_array;

  begin

    -- Assign each pattern to the correct position of cgram_buffer
    v_cgram_array(0 to 7) := (i_cgram_pattern_5x8_0(0), i_cgram_pattern_5x8_0(1), i_cgram_pattern_5x8_0(2), i_cgram_pattern_5x8_0(3),
                              i_cgram_pattern_5x8_0(4), i_cgram_pattern_5x8_0(5), i_cgram_pattern_5x8_0(7), i_cgram_pattern_5x8_0(7));

    v_cgram_array(8 to 15) := (i_cgram_pattern_5x8_1(0), i_cgram_pattern_5x8_1(1), i_cgram_pattern_5x8_1(2), i_cgram_pattern_5x8_1(3),
                               i_cgram_pattern_5x8_1(4), i_cgram_pattern_5x8_1(5), i_cgram_pattern_5x8_1(7), i_cgram_pattern_5x8_1(7));

    v_cgram_array(16 to 23) := (i_cgram_pattern_5x8_2(0), i_cgram_pattern_5x8_2(1), i_cgram_pattern_5x8_2(2), i_cgram_pattern_5x8_2(3),
                                i_cgram_pattern_5x8_2(4), i_cgram_pattern_5x8_2(5), i_cgram_pattern_5x8_2(7), i_cgram_pattern_5x8_2(7));

    v_cgram_array(24 to 31) := (i_cgram_pattern_5x8_3(0), i_cgram_pattern_5x8_3(1), i_cgram_pattern_5x8_3(2), i_cgram_pattern_5x8_3(3),
                                i_cgram_pattern_5x8_3(4), i_cgram_pattern_5x8_3(5), i_cgram_pattern_5x8_3(7), i_cgram_pattern_5x8_3(7));

    v_cgram_array(32 to 39) := (i_cgram_pattern_5x8_4(0), i_cgram_pattern_5x8_4(1), i_cgram_pattern_5x8_4(2), i_cgram_pattern_5x8_4(3),
                                i_cgram_pattern_5x8_4(4), i_cgram_pattern_5x8_4(5), i_cgram_pattern_5x8_4(7), i_cgram_pattern_5x8_4(7));

    v_cgram_array(40 to 47) := (i_cgram_pattern_5x8_5(0), i_cgram_pattern_5x8_5(1), i_cgram_pattern_5x8_5(2), i_cgram_pattern_5x8_5(3),
                                i_cgram_pattern_5x8_5(4), i_cgram_pattern_5x8_5(5), i_cgram_pattern_5x8_5(7), i_cgram_pattern_5x8_5(7));

    v_cgram_array(48 to 55) := (i_cgram_pattern_5x8_6(0), i_cgram_pattern_5x8_6(1), i_cgram_pattern_5x8_6(2), i_cgram_pattern_5x8_6(3),
                                i_cgram_pattern_5x8_6(4), i_cgram_pattern_5x8_6(5), i_cgram_pattern_5x8_6(7), i_cgram_pattern_5x8_6(7));

    v_cgram_array(56 to 63) := (i_cgram_pattern_5x8_7(0), i_cgram_pattern_5x8_7(1), i_cgram_pattern_5x8_7(2), i_cgram_pattern_5x8_7(3),
                                i_cgram_pattern_5x8_7(4), i_cgram_pattern_5x8_7(5), i_cgram_pattern_5x8_7(7), i_cgram_pattern_5x8_7(7));


    return v_cgram_array;

  end function create_cgram_init;



end package body pkg_lcd_cfah_types_and_func;
