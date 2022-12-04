library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_CFAH1602;
use lib_CFAH1602.pkg_lcd_cfah.all;

entity lcd_cfah_polling_busy is

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    i_new_cmd_req    : in  std_logic;   -- New Command req
    i_start_poll     : in  std_logic;   -- Start Polling
    i_done           : in  std_logic;   -- Command done
    i_lcd_busy_flag  : in  std_logic;   -- Read data bit 7
    o_read_busy_flag : out std_logic;   -- Read Busy Flag command
    o_lcd_rdy        : out std_logic    -- LCD Ready when rise
    );

end entity lcd_cfah_polling_busy;

architecture rtl of lcd_cfah_polling_busy is

  -- Internal SIGNALS
  signal s_poll_ongoing : std_logic;    -- Polling ongoing

begin  -- architecture rtl

  -- purpose: Busy Management
  p_busy_mngt : process (clk, rst_n) is
  begin  -- process p_busy_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_poll_ongoing <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(i_start_poll = '1') then
        s_poll_ongoing <= '1';

      elsif(i_done = '1' and i_lcd_busy_flag = '0' and s_poll_ongoing = '1') then
        s_poll_ongoing <= '0';
      end if;
    end if;
  end process p_busy_mngt;

  -- purpose: Command Management
  p_cmd_mngt : process (clk, rst_n) is
  begin  -- process p_cmd_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_read_busy_flag <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- 1st Access
      if(i_start_poll = '1') then
        o_read_busy_flag <= '1';

      -- Next access if always busy
      elsif(i_done = '1' and i_lcd_busy_flag = '0' and s_poll_ongoing = '1') then
        o_read_busy_flag <= '1';

      else
        o_read_busy_flag <= '0';
      end if;

    end if;
  end process p_cmd_mngt;


  -- purpose: LCD Ready Management
  p_lcd_rdy_mngt : process (clk, rst_n) is
  begin  -- process p_lcd_rdy_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_lcd_rdy <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Reset Start Poll on i_start
      if(i_new_cmd_req = '1') then
        o_lcd_rdy <= '0';
      elsif(i_done = '1' and i_lcd_busy_flag = '0' and s_poll_ongoing = '1') then
        o_lcd_rdy <= '1';
      end if;
    end if;
  end process p_lcd_rdy_mngt;

end architecture rtl;
