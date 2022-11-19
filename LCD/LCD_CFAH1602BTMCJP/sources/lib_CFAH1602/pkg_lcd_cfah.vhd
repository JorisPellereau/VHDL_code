library ieee;
use ieee.std_logic_1164.all;


package pkg_lcd_cfah is

  -- == LCD CFAH Timing Duration ==
  constant C_tAS_DURATION    : integer := 40;   -- 40 ns
  constant C_PWeh_DURATION   : integer := 230;  -- 230 ns
  constant C_tAH_DURATION    : integer := 10;   -- 10 ns
  constant C_tcycE_DURATION  : integer := 500;  -- 500 ns
  constant C_tH_tAH_DURATION : integer := 10;   -- 10 ns
  constant C_tDDR_DURATION   : integer := 160;  -- 160 ns

  -- Convert a clock period in [ns] to a number of period
  function clk_period_to_max(i_clk_period : integer; i_duration : integer)
    return integer;

end package pkg_lcd_cfah;

package body pkg_lcd_cfah is

  -- Convert a clock period in [ns] to a number of period
  function clk_period_to_max(i_clk_period : integer; i_duration : integer)
    return integer is

    -- Internal Variables
    variable v_results : integer := 0;
  begin
    v_results := C_tAS_DURATION / i_clk_period;
    if(v_results = 0) then
      v_results := 1;                   -- One TCLK minimum
    end if;
    return v_results;
  end function clk_period_to_max;


end package body pkg_lcd_cfah;