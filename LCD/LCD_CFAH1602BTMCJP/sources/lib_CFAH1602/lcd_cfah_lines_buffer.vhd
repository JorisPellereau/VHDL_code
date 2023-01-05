-------------------------------------------------------------------------------
-- Title      : LCD Lines Buffer
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd_cfah_lines_buffer.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2022-12-10
-- Last update: 2023-01-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: LCD Lines BUFFER
-------------------------------------------------------------------------------
-- Copyright (c) 2022 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2022-12-10  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_CFAH1602;
use lib_CFAH1602.pkg_lcd_cfah_types_and_func.all;

library lib_CFAH1602;
use lib_CFAH1602.pkg_lcd_cfah.all;


entity lcd_cfah_lines_buffer is

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous reset

    i_wdata         : in std_logic_vector(7 downto 0);  -- Data character
    i_wdata_val     : in std_logic;                     -- Data valid
    i_char_position : in std_logic_vector(3 downto 0);  -- Character number
    i_line_sel      : in std_logic;                     -- Line Selection

    i_rd_req           : in  std_logic;  -- Read Request
    i_rd_char_position : in  std_logic_vector(3 downto 0);  -- Character number
    i_rd_line_sel      : in  std_logic;  -- Line selection for Read port
    o_rdata            : out std_logic_vector(7 downto 0);  -- Rdata
    o_rdata_val        : out std_logic;  -- Rdata valid

    o_read_busy : out std_logic         -- Busy

    );

end entity lcd_cfah_lines_buffer;

architecture rtl of lcd_cfah_lines_buffer is

  -- INTERNAL Signals
  signal s_lines_array : t_lines_array;  -- Lines Array
  signal s_read_busy   : std_logic;      -- Read Busy Flag
  signal s_rd_req_p    : std_logic;      -- Pipe Read Request

begin  -- architecture rtl


  -- purpose: Lines Array Management
  p_lines_array_mngt : process (clk, rst_n) is
  begin  -- process p_lines_array_mngt
    if rst_n = '0' then                     -- asynchronous reset (active low)
      s_lines_array <= C_LINES_ARRAY_INIT;  -- Init with a specific Pattern
      o_rdata       <= (others => '0');
      o_rdata_val   <= '0';
    elsif clk'event and clk = '1' then      -- rising clock edge


      -- No Read busy -> write possible
      if(i_wdata_val = '1' and s_read_busy = '0') then

        -- 2nd Line selection
        if(i_line_sel = '1') then
          s_lines_array(conv_integer(unsigned(i_char_position)) + 16) <= i_wdata;

        -- 1st Line selection
        else
          s_lines_array(conv_integer(unsigned(i_char_position))) <= i_wdata;
        end if;

      -- Read access
      else

        if(i_rd_req = '1') then

          if(i_rd_line_sel = '1') then
            o_rdata <= s_lines_array(conv_integer(unsigned(i_rd_char_position)) + 16);
          else
            o_rdata <= s_lines_array(conv_integer(unsigned(i_rd_char_position)));
          end if;

          o_rdata_val <= '1';
        else
          o_rdata     <= (others => '0');
          o_rdata_val <= '0';
        end if;

      end if;
    end if;
  end process p_lines_array_mngt;


-- purpose: Read busy Flag management
  p_read_busy_flag_mngt : process (clk, rst_n) is
  begin  -- process p_read_busy_flag_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_read_busy <= '0';
      s_rd_req_p  <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_rd_req_p <= i_rd_req;           -- Pipe Input

      if(i_rd_req = '1') then
        s_read_busy <= '1';

      elsif(s_rd_req_p = '0') then
        s_read_busy <= '0';
      end if;

    end if;

  end process p_read_busy_flag_mngt;

  -- Output affectation
  o_read_busy <= s_read_busy;

end architecture rtl;
