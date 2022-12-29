-------------------------------------------------------------------------------
-- Title      : PR 115 LCD TOP
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pr_115_lcd_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2022-12-04
-- Last update: 2022-12-29
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

    -- i_clear_display_cmd : in std_logic;  -- Clear display
    i_display_ctrl_cmd : in std_logic;  -- Display Control Command
    -- i_start_init        : in std_logic;  -- Start init cmd

    i_update_lcd        : in std_logic;  -- Update LCD command
    i_lcd_all_char      : in std_logic;  -- LCD All char sel
    i_lcd_line_sel      : in std_logic;  -- LCD Line sel
    i_lcd_char_position : in std_logic_vector(3 downto 0);  -- LCD Char position

    -- GREEN LEDS
    o_green_leds : out std_logic_vector(8 downto 0);  -- GREEN LEDS controls

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
  signal s_bidir_sel : std_logic;

  signal s_char_wdata     : std_logic_vector(7 downto 0);
  signal s_char_wdata_val : std_logic;
  signal s_char_position  : std_logic_vector(3 downto 0);
  signal s_line_sel       : std_logic;

  signal s_start_init    : std_logic;
  signal s_start_init_p1 : std_logic;
  signal s_start_init_p2 : std_logic;

  signal s_display_ctrl_cmd    : std_logic;
  signal s_display_ctrl_cmd_p1 : std_logic;
  signal s_display_ctrl_cmd_p2 : std_logic;

  signal s_clear_display_cmd    : std_logic;
  signal s_clear_display_cmd_p1 : std_logic;
  signal s_clear_display_cmd_p2 : std_logic;

  signal s_update_lcd    : std_logic;
  signal s_update_lcd_p1 : std_logic;
  signal s_update_lcd_p2 : std_logic;

  signal s_lcd_all_char    : std_logic;
  signal s_lcd_all_char_p1 : std_logic;
  signal s_lcd_all_char_p2 : std_logic;

  signal s_lcd_line_sel    : std_logic;
  signal s_lcd_line_sel_p1 : std_logic;
  signal s_lcd_line_sel_p2 : std_logic;

  signal s_lcd_char_position    : std_logic_vector(3 downto 0);
  signal s_lcd_char_position_p1 : std_logic_vector(3 downto 0);
  signal s_lcd_char_position_p2 : std_logic_vector(3 downto 0);

  signal s_control_done   : std_logic;
  signal s_control_done_p : std_logic;
  signal s_o_lcd_on       : std_logic;

  signal s_update_lcd_p2_p      : std_logic;
  signal s_update_lcd_p2_r_edge : std_logic;

  signal s_display_ctrl_cmd_p2_p      : std_logic;
  signal s_display_ctrl_cmd_p2_r_edge : std_logic;
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

      s_start_init    <= '0';
      s_start_init_p1 <= '0';
      s_start_init_p2 <= '0';

      s_display_ctrl_cmd    <= '0';
      s_display_ctrl_cmd_p1 <= '0';
      s_display_ctrl_cmd_p2 <= '0';

      s_clear_display_cmd    <= '0';
      s_clear_display_cmd_p1 <= '0';
      s_clear_display_cmd_p2 <= '0';

      s_update_lcd    <= '0';
      s_update_lcd_p1 <= '0';
      s_update_lcd_p2 <= '0';

      s_lcd_all_char    <= '0';
      s_lcd_all_char_p1 <= '0';
      s_lcd_all_char_p2 <= '0';

      s_lcd_line_sel    <= '0';
      s_lcd_line_sel_p1 <= '0';
      s_lcd_line_sel_p2 <= '0';

      s_lcd_char_position    <= (others => '0');
      s_lcd_char_position_p1 <= (others => '0');
      s_lcd_char_position_p2 <= (others => '0');

      s_update_lcd_p2_p       <= '0';
      s_display_ctrl_cmd_p2_p <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_lcd_on    <= not i_lcd_on;
      s_lcd_on_p1 <= s_lcd_on;
      s_lcd_on_p2 <= s_lcd_on_p1;

      s_dl_nf_f    <= i_dl_n_f;
      s_dl_nf_f_p1 <= s_dl_nf_f;
      s_dl_nf_f_p2 <= s_dl_nf_f_p1;

      s_dcb    <= i_dcb;
      s_dcb_p1 <= s_dcb;
      s_dcb_p2 <= s_dcb_p1;

      s_start_init    <= '0';           --i_start_init;
      s_start_init_p1 <= s_start_init;
      s_start_init_p2 <= s_start_init_p1;

      s_display_ctrl_cmd    <= i_display_ctrl_cmd;
      s_display_ctrl_cmd_p1 <= s_display_ctrl_cmd;
      s_display_ctrl_cmd_p2 <= s_display_ctrl_cmd_p1;

      s_clear_display_cmd    <= '0';    --i_clear_display_cmd;
      s_clear_display_cmd_p1 <= s_clear_display_cmd;
      s_clear_display_cmd_p2 <= s_clear_display_cmd_p1;

      s_update_lcd    <= not i_update_lcd;
      s_update_lcd_p1 <= s_update_lcd;
      s_update_lcd_p2 <= s_update_lcd_p1;

      s_lcd_all_char    <= i_lcd_all_char;
      s_lcd_all_char_p1 <= s_lcd_all_char;
      s_lcd_all_char_p2 <= s_lcd_all_char_p1;


      s_lcd_line_sel    <= i_lcd_line_sel;
      s_lcd_line_sel_p1 <= s_lcd_line_sel;
      s_lcd_line_sel_p2 <= s_lcd_line_sel_p1;

      s_lcd_char_position    <= i_lcd_char_position;
      s_lcd_char_position_p1 <= s_lcd_char_position;
      s_lcd_char_position_p2 <= s_lcd_char_position_p1;

      s_update_lcd_p2_p       <= s_update_lcd_p2;
      s_display_ctrl_cmd_p2_p <= s_display_ctrl_cmd_p2;
    end if;
  end process p_resynch_inputs_mngt;


  p_force_useless_inputs : process (clk, rst_n) is
  begin  -- process p_force_useless_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_char_wdata     <= (others => '0');
      s_char_wdata_val <= '0';
      s_char_position  <= (others => '0');
      s_line_sel       <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_char_wdata     <= (others => '0');
      s_char_wdata_val <= '0';
      s_char_position  <= (others => '0');
      s_line_sel       <= '0';

    end if;
  end process p_force_useless_inputs;


  s_update_lcd_p2_r_edge <= s_update_lcd_p2 and not s_update_lcd_p2_p;

  s_display_ctrl_cmd_p2_r_edge <= s_display_ctrl_cmd_p2 and not s_display_ctrl_cmd_p2_p;

  -- LCD CFAH TOP Instanciation
  i_lcd_cfah_top_0 : lcd_cfah_top
    generic map(
      G_CLK_PERIOD_NS      => 20,
      G_BIDIR_SEL_POLARITY => '0'
      )
    port map (
      clk   => clk,
      rst_n => rst_n,

      -- LCD LINES BUFFER I/F
      i_char_wdata     => s_char_wdata,
      i_char_wdata_val => s_char_wdata_val,
      i_char_position  => s_char_position,
      i_line_sel       => s_line_sel,

      -- LCD CGRAM BUFFER I/F
      -- i_cgram_addr : in std_logic_vector(2 downto 0);  -- CGRAM Addr
      -- i_cgram_data : in std_logic_vector(7 downto 0);  -- CGRAM Data
      -- i_cgram_val  : in std_logic;                     -- CGRAM Data valid

      -- Input control
      i_lcd_on => s_lcd_on_p2,
      i_dl_n_f => s_dl_nf_f_p2,
      i_dcb    => s_dcb_p2,

      -- LCD Commands and Controls     
      i_start_init        => s_start_init_p2,
      i_display_ctrl_cmd  => s_display_ctrl_cmd_p2_r_edge,
      i_clear_display_cmd => s_clear_display_cmd_p2,

      i_update_lcd        => s_update_lcd_p2_r_edge,
      i_lcd_all_char      => s_update_lcd_p2_r_edge,  --'1',       --s_lcd_all_char_p2,
      i_lcd_line_sel      => '0',       --s_lcd_line_sel_p2,
      i_lcd_char_position => "0000",    --s_lcd_char_position_p2,

      o_control_done => s_control_done,

      i_lcd_data  => s_lcd_rdata,
      o_lcd_wdata => s_lcd_wdata,
      o_lcd_rw    => o_lcd_rw,
      o_lcd_en    => o_lcd_en,
      o_lcd_rs    => o_lcd_rs,
      o_lcd_on    => s_o_lcd_on,
      o_bidir_sel => s_bidir_sel

      );

  -- Outputs Affectation
  o_lcd_on <= s_o_lcd_on;

  -- BIDIR Management -- Write access when not G_POL
  io_lcd_data <= s_lcd_wdata when s_bidir_sel = '1' else (others => 'Z');
  s_lcd_rdata <= io_lcd_data;

  o_green_leds(8)          <= '1';
  o_green_leds(7 downto 5) <= s_dcb_p2;
  o_green_leds(4 downto 2) <= s_dl_nf_f_p2;
  o_green_leds(1)          <= s_o_lcd_on;
  o_green_leds(0)          <= s_control_done_p;

  p_output_mngt : process (clk, rst_n) is
  begin  -- process p_output_mngt
    if rst_n = '0' then  -- asynchronous reset (active low)      

      s_control_done_p <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_control_done = '1') then
        s_control_done_p <= not s_control_done_p;
      end if;
    end if;
  end process p_output_mngt;


end architecture rtl;
