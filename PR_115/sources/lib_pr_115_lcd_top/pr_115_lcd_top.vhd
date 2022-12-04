-------------------------------------------------------------------------------
-- Title      : PR 115 LCD TOP
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pr_115_lcd_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2022-12-04
-- Last update: 2022-12-04
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: PR 115 LCD Top
-------------------------------------------------------------------------------
-- Copyright (c) 2022 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2022-12-04  1.0      linux-jp        Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_CFAH1602;
use lib_CFAH1602.pkg_lcd_cfah.all;

entity pr_115_lcd_top is

  port (
    clk   : in std_logic;               -- Clock 50MHz
    rst_n : in std_logic;               -- Asynchronous Reset

    -- LCD Control from Button of PR-115 Board
    i_lcd_on : in std_logic;
    i_dl_n_f : in std_logic_vector(2 downto 0);  -- Function SET bis control
    i_dcb    : in std_logic_vector(2 downto 0);  -- Display ON/OFF Control bits


    -- LCD I/F
    io_lcd_data : inout std_logic_vector(7 downto 0);  -- LCD R/W Data
    o_lcd_rw    : out   std_logic;                     -- R/W command
    o_lcd_en    : out   std_logic;                     -- LCD Enable
    o_lcd_rs    : out   std_logic;                     -- LCD RS
    o_lcd_on    : out   std_logic                      -- LCD ON Management
    );

end entity pr_115_lcd_top;


architecture rtl of pr_115_lcd_top is

  -- INTERNAL Signals
  signal s_lcd_on    : std_logic;
  signal s_lcd_on_p1 : std_logic;
  signal s_lcd_on_p2 : std_logic;

  signal s_dl_nf_f    : std_logic_vector(2 downto 0);
  signal s_dl_nf_f_p1 : std_logic_vector(2 downto 0);
  signal s_dl_nf_f_p2 : std_logic_vector(2 downto 0);

  signal s_dcb    : std_logic_vector(2 downto 0);
  signal s_dcb_p1 : std_logic_vector(2 downto 0);
  signal s_dcb_p2 : std_logic_vector(2 downto 0);

  signal s_lcd_wdata : std_logic_vector(7 downto 0);
  signal s_lcd_rdata : std_logic_vector(7 downto 0);

begin  -- architecture rtl

  -- Resynchronization on asynchronous inputs (Button)
  p_resynch_inputs_mngt : process (clk, rst_n) is
  begin  -- process p_resynch_inputs_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_lcd_on    <= '0';
      s_lcd_on_p1 <= '0';
      s_lcd_on_p2 <= '0';

      s_dl_nf_f    <= (others => '0');
      s_dl_nf_f_p1 <= (others => '0');
      s_dl_nf_f_p2 <= (others => '0');

      s_dcb    <= (others => '0');
      s_dcb_p1 <= (others => '0');
      s_dcb_p2 <= (others => '0');

    elsif clk'event and clk = '1' then  -- rising clock edge

      s_lcd_on    <= i_lcd_on;
      s_lcd_on_p1 <= s_lcd_on;
      s_lcd_on_p2 <= s_lcd_on_p1;

      s_dl_nf_f    <= i_dl_n_f;
      s_dl_nf_f_p1 <= s_dl_nf_f;
      s_dl_nf_f_p2 <= s_dl_nf_f_p1;

      s_dcb    <= i_dcb;
      s_dcb_p1 <= s_dcb;
      s_dcb_p2 <= s_dcb_p1;

    end if;
  end process p_resynch_inputs_mngt;

  -- LCD CFAH TOP Instanciation
  i_lcd_cfah_top_0 : lcd_cfah_top
    generic map(
      G_CLK_PERIOD_NS      => 20,
      G_BIDIR_SEL_POLARITY => '0'
      )
    port map (
      clk   => clk,
      rst_n => rst_n,

      -- Input control
      i_lcd_on => s_lcd_on_p2,
      i_dl_n_f => s_dl_nf_f_p2,
      i_dcb    => s_dcb_p2,

      i_lcd_data  => s_lcd_rdata,
      o_lcd_wdata => s_lcd_wdata,
      o_lcd_rw    => o_lcd_rw,
      o_lcd_en    => o_lcd_en,
      o_lcd_rs    => o_lcd_rs,
      o_lcd_on    => o_lcd_on,
      o_bidir_sel => s_bidir_sel
      );

  -- BIDIR Management
  io_lcd_data = s_lcd_wdata when s_bidir_sel = '1' else 'z';
  s_lcd_rdata = io_lcd_data;



end architecture rtl;
