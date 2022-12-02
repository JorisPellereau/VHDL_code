-------------------------------------------------------------------------------
-- Title      : LCD CFAH Initialization
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lch_cfah_init.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2022-12-02
-- Last update: 2022-12-02
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: LCD CFAH Initialization Block
-------------------------------------------------------------------------------
-- Copyright (c) 2022 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2022-12-02  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_CFAH1602;
use lib_CFAH1602.pkg_lcd_cfah.all;

entity lcd_cfah_init is

  generic (
    G_CLK_PERIOD : integer := 20        -- Period of Input clock in [ns]
    );

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    i_init_en    : in std_logic;        -- Initialization Enable
    i_start_init : in std_logic;        -- Start Initialization

    i_cmd_done         : in  std_logic;  -- Command done
    o_function_set_cmd : out std_logic;  -- Function Set command
    o_display_ctrl     : out std_logic;  -- Display Control Command
    o_entry_mode_set   : out std_logic;  -- Entry Mode set command
    o_clear_display    : out std_logic;  -- Clear Display

    o_init_done : out std_logic         -- Initialization Done
    );

end entity lcd_cfah_init;


architecture rtl of lcd_cfah_init is

  -- Internal SIGNALS
  signal s_first_init_done    : std_logic;  -- First Initialization signal
  signal s_duration_cnt       : std_logic_vector(log2(C_INIT_WAIT_1) - 1 downto 0);  -- Duration for initialization sequence counter
  signal s_duration_max       : std_logic_vector(log2(C_INIT_WAIT_1) - 1 downto 0);  -- Max duration
  signal s_duration_cnt_reach : std_logic;

  signal s_cnt_function_set    : std_logic_vector(2 downto 0);  -- Function Set counter
  signal s_cnt_function_set_up : std_logic;                     -- Counter inc
begin  -- architecture rtl



  -- purpose: Function Set counter Management
  p_function_set_cnt_mngt : process (clk, rst_n) is
  begin  -- process p_function_set_cnt_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cnt_function_set    <= (others => '0');
      s_cnt_function_set_up <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(i_cmd_done = '1') then
        if(unsigned(s_cnt_function_set) < 4 - 1) then
          s_cnt_function_set    <= unsigned(s_cnt_function_set, s_cnt_function_set'length) + 1;
          s_cnt_function_set_up <= '1';
        else

        end if;

      else
        s_cnt_function_set_up <= '0';
      end if;

    end if;
  end process p_function_set_cnt_mngt;


  -- purpose: Duration Counter Management
  p_cnt_duration_mngt : process (clk, rst_n) is
  begin  -- process p_cnt_duration_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_duration_cnt       <= (others => '0');
      s_duration_cnt_reach <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge


    end if;
  end process p_cnt_duration_mngt;


  --
  --
  s_duration_max <=

end architecture rtl;
