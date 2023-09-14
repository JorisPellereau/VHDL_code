library ieee;
use ieee.std_logic_1164.all;


-- Import Types and Fucntions
library lib_CFAH1602_v2;
use lib_CFAH1602_v2.pkg_lcd_cfah_types_and_func.all;


package pkg_lcd_cfah is

  -- == LCD CFAH Timing Duration ==
  constant C_tAS_DURATION    : integer := 40;   -- 40 ns
  constant C_PWeh_DURATION   : integer := 230;  -- 230 ns
  constant C_tAH_DURATION    : integer := 10;   -- 10 ns
  constant C_tcycE_DURATION  : integer := 500;  -- 500 ns
  constant C_tH_tAH_DURATION : integer := 10;   -- 10 ns
  constant C_tDDR_DURATION   : integer := 160;  -- 160 ns

  -- Initialization Constants
  constant C_LCD_WAIT_POWER_ON : integer := 15100000;  -- Wait more than 15ms after Power On

  -- More than 4.1ms
  constant C_INIT_WAIT_1 : integer := 4200000;  -- [ns] - Duration of First Wait for initialization
  constant C_INIT_WAIT_2 : integer := 100000;  -- [ns] - Duration of 2nd wait for initialization

  -- == CONSTANTS ==
  constant C_CLEAR_DISPLAY        : integer := 0;
  constant C_RETURN_HOME          : integer := 1;
  constant C_ENTRY_MODE_SET       : integer := 2;
  constant C_DISP_ON_OFF_CTRL     : integer := 3;
  constant C_CURSOR_OR_DISP_SHIFT : integer := 4;
  constant C_FUNCTION_SET         : integer := 5;
  constant C_SET_CGRAM_ADDR       : integer := 6;
  constant C_SET_DDRAM_ADDR       : integer := 7;
  constant C_READ_BUSY_FLAG       : integer := 8;
  constant C_WRITE_DATA_TO_RAM    : integer := 9;
  constant C_READ_DATA_FROM_RAM   : integer := 10;

end package pkg_lcd_cfah;

package body pkg_lcd_cfah is

end package body pkg_lcd_cfah;
