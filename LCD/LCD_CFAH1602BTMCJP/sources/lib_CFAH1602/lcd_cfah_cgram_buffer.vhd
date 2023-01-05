-------------------------------------------------------------------------------
-- Title      : CGRAM Buffer Read/Write Access
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd_cfah_cgram_buffer.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-01-02
-- Last update: 2023-01-03
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: CGRAM Buffer Read/Write Access
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-01-02  1.0      linux-jp        Created
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


entity lcd_cfah_cgram_buffer is

  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous reset

    i_cgram_wdata     : in std_logic_vector(4 downto 0);  -- Data character
    i_cgram_wdata_val : in std_logic;                     -- Data valid   
    i_cgram_addr      : in std_logic_vector(6 downto 0);  --CGRAM ADDR

    i_rd_req        : in std_logic;                     -- Read Request
    i_rd_cgram_addr : in std_logic_vector(6 downto 0);  -- Character Address

    o_cgram_rdata     : out std_logic_vector(4 downto 0);  -- Rdata
    o_cgram_rdata_val : out std_logic;                     -- Rdata valid

    o_read_busy : out std_logic         -- Busy
    );

end entity lcd_cfah_cgram_buffer;

architecture rtl of lcd_cfah_cgram_buffer is

  -- INTERNAL Signald
  signal s_cgram_buffer : t_cgram_array;  -- CGRAM Buffer
  signal s_read_busy    : std_logic;      -- Read busy flag
  signal s_rd_req_p     : std_logic;      -- Pipe Read request

begin  -- architecture rtl

  p_cgram_buffer_rw_mngt : process (clk, rst_n) is
  begin  -- process p_cgram_buffer_rw_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cgram_buffer    <= C_CGRAM_INIT;
      o_cgram_rdata     <= (others => '0');
      o_cgram_rdata_val <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- No Read busy -> write possible
      if(i_cgram_wdata_val = '1' and s_read_busy = '0') then
        s_cgram_buffer(conv_integer(unsigned(i_cgram_addr))) <= i_cgram_wdata;

      else
        if(i_rd_req = '1') then
          o_cgram_rdata     <= s_cgram_buffer(conv_integer(unsigned(i_cgram_addr)));
          o_cgram_rdata_val <= '1';
        else
          o_cgram_rdata     <= (others => '0');
          o_cgram_rdata_val <= '0';
        end if;

      end if;
    end if;
  end process p_cgram_buffer_rw_mngt;


  -- purpose: Read Busy Flag management
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
