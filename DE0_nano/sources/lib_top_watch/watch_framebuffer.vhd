-------------------------------------------------------------------------------
-- Title      : WATCH Frame Buffer
-- Project    : 
-------------------------------------------------------------------------------
-- File       : watch_framebuffer.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2024-05-12
-- Last update: 2024-05-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2024 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-05-12  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_top_watch;
use lib_top_watch.watch_pkg.all;


entity watch_framebuffer is
  port (
    clk_sys   : in std_logic;           -- Clock System
    rst_n_sys : in std_logic;           -- Reset of clk_sys clock domain

    -- Input data to organized
    char_data_0_array : in t_char_data_array;  -- Array of Char DATA 0
    char_data_1_array : in t_char_data_array;  -- Array of Char DATA 1
    char_data_2_array : in t_char_data_array;  -- Array of Char DATA 2
    char_data_3_array : in t_char_data_array;  -- Array of Char DATA 3
    char_data_4_array : in t_char_data_array;  -- Array of Char DATA 4

    -- Output Frame Buffer Array
    framebuffer : out t_framebuffer_array  -- Output Frame Buffer Array
    );
end entity watch_framebuffer;

architecture rtl of watch_framebuffer is

begin  -- architecture rtl

  p_framebuffer : process (clk_sys, rst_n_sys) is
  begin  -- process p_framebuffer
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      framebuffer <= (others => (others => '0'));
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Update Digit 7
      framebuffer(0) <= x"08" & x"00";                  -- M3(D7)
      framebuffer(1) <= x"008" & char_data_1_array(3);  -- M2(D7)
      framebuffer(2) <= x"08" & x"00";                  -- M1(D7)
      framebuffer(3) <= x"008" & char_data_1_array(1);  -- M0(D7)

      -- Update Digit 6
      framebuffer(4) <= x"07" & x"00";                  -- M3(D6)
      framebuffer(5) <= x"007" & char_data_0_array(3);  -- M2(D6)
      framebuffer(6) <= x"07" & x"00";                  -- M1(D6)
      framebuffer(7) <= x"007" & char_data_0_array(1);  -- M0(D6)

      -- Update Digit 5
      framebuffer(8)  <= x"06" & x"00";  -- M3(D5)
      framebuffer(9)  <= x"06" & x"00";  -- M2(D5)
      framebuffer(10) <= x"06" & x"28";  -- M1(D5)
      framebuffer(11) <= x"06" & x"00";  -- M0(D5)

      -- Update Digit 4
      framebuffer(12) <= x"05" & x"00";                  -- M3(D4)
      framebuffer(13) <= x"005" & char_data_4_array(2);  -- M2(D4)
      framebuffer(14) <= x"05" & x"00";                  -- M1(D4)
      framebuffer(15) <= x"005" & char_data_4_array(0);  -- M0(D4)

      -- Update Digit 3
      framebuffer(16) <= x"04" & x"00";                  -- M3(D3)
      framebuffer(17) <= x"004" & char_data_3_array(2);  -- M2(D3)
      framebuffer(18) <= x"04" & x"00";                  -- M1(D3)
      framebuffer(19) <= x"004" & char_data_3_array(0);  -- M0(D3)

      -- Update Digit 2
      framebuffer(20) <= x"003" & char_data_4_array(3);  -- M3(D2)
      framebuffer(21) <= x"003" & char_data_2_array(2);  -- M2(D2)
      framebuffer(22) <= x"003" & char_data_4_array(1);  -- M1(D2)
      framebuffer(23) <= x"003" & char_data_2_array(0);  -- M0(D2)

      -- Update Digit 1
      framebuffer(24) <= x"002" & char_data_3_array(3);  -- M3(D1)
      framebuffer(25) <= x"002" & char_data_1_array(2);  -- M2(D1)
      framebuffer(26) <= x"002" & char_data_3_array(1);  -- M1(D1)
      framebuffer(27) <= x"002" & char_data_1_array(0);  -- M0(D1)

      -- Update Digit 0
      framebuffer(28) <= x"001" & char_data_2_array(3);  -- M3(D0)
      framebuffer(29) <= x"001" & char_data_0_array(2);  -- M2(D0)
      framebuffer(30) <= x"001" & char_data_2_array(1);  -- M1(D0)
      framebuffer(31) <= x"001" & char_data_0_array(0);  -- M0(D0)

    end if;
  end process p_framebuffer;


end architecture rtl;

