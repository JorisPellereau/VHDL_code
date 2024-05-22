-------------------------------------------------------------------------------
-- Title      : Watch on 24 hours
-- Project    : 
-------------------------------------------------------------------------------
-- File       : watch_24h.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-05-12
-- Last update: 2024-05-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
-- Limitation : start shall be a pulse of one clk_sys clock period
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-05-12  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity watch_24h is
  port (
    clk_sys   : in std_logic;           -- Clock System
    rst_n_sys : in std_logic;           -- Reset in clock_sys clock domain

    -- Pulse for the compuation
    start : in std_logic;               -- Compute Next Update

    -- PRELOAD
    preload               : in  std_logic;                     -- Preload Pulse
    pre_hours_tens_digit  : out std_logic_vector(1 downto 0);  -- Hour tens digit
    pre_hours_unity_digit : out std_logic_vector(2 downto 0);  -- Hour unity digit
    pre_mins_tens_digit   : out std_logic_vector(2 downto 0);  -- Minutes tens digit
    pre_mins_unity_digit  : out std_logic_vector(3 downto 0);  -- Minutes unity digit

    -- Next hours computed
    hours_tens_digit  : out std_logic_vector(1 downto 0);  -- Hour tens digit
    hours_unity_digit : out std_logic_vector(2 downto 0);  -- Hour unity digit
    mins_tens_digit   : out std_logic_vector(2 downto 0);  -- Minutes tens digit
    mins_unity_digit  : out std_logic_vector(3 downto 0);  -- Minutes unity digit

    -- Done
    done : out std_logic                -- Update Done
    );
end entity watch_24h;


architecture rtl of watch_24h is

  -- == INTERNAL Signals ==
  signal cnt_secs_unity : unsigned(3 downto 0);  -- Counter of second unity
  signal cnt_secs_tens  : unsigned(2 downto 0);  -- Counter for tens digit of the second

  signal update_mins    : std_logic;             -- Update Minutes comb.
  signal cnt_mins_unity : unsigned(3 downto 0);  -- Counter of minuts unity
  signal cnt_mins_tens  : unsigned(2 downto 0);  -- Counter of tens digit of the minutes

  signal update_hours    : std_logic;             -- Update Hour comb.
  signal cnt_hours_unity : unsigned(2 downto 0);  -- Counter of hours's unity
  signal cnt_hours_tens  : unsigned(1 downto 0);  -- Counter of hours's tens digit

begin  -- architecture rtl


  -- purpose: Counter for secons unity
  p_cnt_secs_unity : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_secs_unity
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cnt_secs_unity <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- On start -> Update counters
      if(start = '1') then

        -- If max reach -> return to 0
        if(cnt_secs_unity = x"9") then
          cnt_secs_unity <= (others => '0');

        -- Otherwise inc. by one
        else
          cnt_secs_unity <= cnt_secs_unity + 1;  -- Inc by one
        end if;
      end if;

    end if;
  end process p_cnt_secs_unity;

  -- purpose: Counter of tens digit of seconds 
  p_cnt_secs_tens : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_secs_tens
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cnt_secs_tens <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- On start and cnt_secs_unity at max value compute tens second digit
      if(start = '1' and cnt_secs_unity = x"9") then

        -- If max reach -> reset it to 0
        if(cnt_secs_tens = "101") then
          cnt_secs_tens <= (others => '0');

        -- Otherwise inc by one the counter
        else
          cnt_secs_tens <= cnt_secs_tens + 1;
        end if;

      end if;

    end if;
  end process p_cnt_secs_tens;


  -- Set the flag to '1' when 59 is reach on seconds
  update_mins <= '1' when cnt_secs_tens = "101" and cnt_secs_unity = x"9" else
                 '0';

  -- purpose: Counter of the unity of the minutes
  p_cnt_mins_unity : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_mins_unity
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cnt_mins_unity <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Update Minutes unity
      if(start = '1' and update_mins = '1') then

        -- Counter of unity for the minutes
        -- Reset it if x"9" is reach
        if(cnt_mins_unity = x"9") then
          cnt_mins_unity <= (others => '0');

        -- Otherwise inc the counter
        else
          cnt_mins_unity <= cnt_mins_unity + 1;
        end if;

      end if;

    end if;
  end process p_cnt_mins_unity;


  -- Counter for the tens digit of the minutes
  p_cnt_mins_tens : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_mins_tens
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cnt_mins_tens <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Update of the start and update_mins
      if(start = '1' and update_mins = '1' and cnt_mins_unity = x"9") then

        -- If the counter of tens digit of minutes, reset the counter
        if(cnt_mins_tens = "101") then
          cnt_mins_tens <= (others => '0');
        -- Otherwise inc the counter
        else
          cnt_mins_tens <= cnt_mins_tens + 1;
        end if;

      end if;

    end if;
  end process p_cnt_mins_tens;


  -- Update hours
  update_hours <= '1' when cnt_mins_tens = "101" and cnt_mins_unity = x"9"  and update_mins = '1' else
                  '0';


  -- purpose: Counter of unity for hours
  p_cnt_hours_unity : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_hours_unity
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cnt_hours_unity <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Update hours's unity on start and if 59 minutes is reach
      if(start = '1' and update_hours = '1') then

        -- If max is reach -> reset the counter
        if(cnt_hours_unity = "100") then
          cnt_hours_unity <= (others => '0');

        -- Inc the counter
        else
          cnt_hours_unity <= cnt_hours_unity + 1;
        end if;

      end if;
    end if;
  end process p_cnt_hours_unity;

  -- purpose: Counter of hours's tens digit
  p_cnt_hours_tens : process (clk_sys, rst_n_sys) is
  begin  -- process p_cnt_hours_tens
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      cnt_hours_tens <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- On start Pulse
      if(start = '1' and update_hours = '1' and cnt_hours_unity = "100") then

        -- If max reach reset the counter
        if(cnt_hours_tens = "10") then
          cnt_hours_tens <= (others => '0');

        -- Otherwise inc. the counter
        else
          cnt_hours_tens <= cnt_hours_tens + 1;
        end if;

      end if;
    end if;
  end process p_cnt_hours_tens;


  -- purpose: Done management
  p_done : process (clk_sys, rst_n_sys) is
  begin  -- process p_done
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      done <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge
      done <= start;
    end if;
  end process p_done;


  -- == Outputs Affecation ==
  hours_tens_digit  <= std_logic_vector(cnt_hours_tens);
  hours_unity_digit <= std_logic_vector(cnt_hours_unity);
  mins_tens_digit   <= std_logic_vector(cnt_mins_tens);
  mins_unity_digit  <= std_logic_vector(cnt_mins_unity);

end architecture rtl;
