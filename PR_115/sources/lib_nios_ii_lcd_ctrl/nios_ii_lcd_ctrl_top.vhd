-------------------------------------------------------------------------------
-- Title      : NIOS II LCD Controller TOP
-- Project    : 
-------------------------------------------------------------------------------
-- File       : nios_ii_lcd_ctrl_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-01-28
-- Last update: 2023-02-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: NIOS II LCD Controller TOP
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-01-28  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_CFAH1602;
use lib_CFAH1602.pkg_lcd_cfah.all;

library altera_mf;
use altera_mf.altera_mf_components.all;


entity nios_ii_lcd_ctrl_top is
  generic(
    G_BIDIR_POLARITY_READ : std_logic := '0'  -- BIDIR SEL Polarity
    );
  port (
    clk   : in std_logic;                     -- Clock
    rst_n : in std_logic;                     -- Asynchronous Reset

    io_lcd_data : inout std_logic_vector(7 downto 0);  -- LCD Data
    o_lcd_on    : out   std_logic;                     -- LCD ON
    o_lcd_rs    : out   std_logic;                     -- LCD RS
    o_lcd_en    : out   std_logic;                     -- LCD EN
    o_lcd_rw    : out   std_logic                      -- LCD RW
    );

end entity nios_ii_lcd_ctrl_top;


architecture rtl of nios_ii_lcd_ctrl_top is

  component char_buffer is
    port
      (
        address : in  std_logic_vector (4 downto 0);
        clock   : in  std_logic := '1';
        data    : in  std_logic_vector (7 downto 0);
        wren    : in  std_logic;
        q       : out std_logic_vector (7 downto 0)
        );
  end component char_buffer;

  component NIOS_II_LCD_controller is
    port (
      clk_clk            : in  std_logic := 'X';              -- clk
      reset_reset_n      : in  std_logic := 'X';              -- reset_n
      pio_lcd_in_export  : in  std_logic := 'X';              -- export
      pio_lcd_out_export : out std_logic_vector(31 downto 0)  -- export
      );
  end component NIOS_II_LCD_controller;


  component reset_gen is

    port (
      clk     : in  std_logic;          -- Clock
      arst_n  : in  std_logic;          -- Synchronous Input Reset
      o_rst_n : out std_logic);         -- Output synchronous Reset

  end component reset_gen;

  -- INTERNAL Signals
  signal s_bidir_sel                   : std_logic;  -- Bidir Selection
  signal s_lcd_rdata                   : std_logic_vector(7 downto 0);  -- LCD RDATA
  signal s_lcd_wdata                   : std_logic_vector(7 downto 0);  -- LCD WDATA
  signal s_control_done                : std_logic;  -- Control Done
  signal s_char_wdata                  : std_logic_vector(7 downto 0);  -- WDATA on char
  signal s_char_wdata_val              : std_logic;  -- WDATA Valid
  signal s_char_position               : std_logic_vector(3 downto 0);  -- CHAR Position
  signal s_line_sel                    : std_logic;  -- Line selection
  signal s_char_position_nios          : std_logic_vector(3 downto 0);  -- CHAR Position
  signal s_line_sel_nios               : std_logic;  -- Line selection
  signal s_cgram_addr                  : std_logic_vector(6 downto 0);  -- CGRAM Addr
  signal s_cgram_wdata                 : std_logic_vector(4 downto 0);  -- CGRAM Data
  signal s_cgram_wdata_val             : std_logic;  -- CGRAM Valid
  signal s_lcd_on                      : std_logic;  -- LCD On Command
  signal s_dl_nf_f                     : std_logic_vector(2 downto 0);  -- DL N F Bit config
  signal s_dcb                         : std_logic_vector(2 downto 0);  -- DCB bits config
  signal s_start_init                  : std_logic;  -- Start LCD Initialization command
  signal s_display_ctrl_cmd            : std_logic;  -- Display Control Command
  signal s_clear_display_cmd           : std_logic;  -- Clear display Command
  signal s_update_cgram                : std_logic;  -- Update CGRAM Command  
  signal s_update_lcd                  : std_logic;  -- Update LCD command
  signal s_lcd_all_char                : std_logic;  -- LCD All Char command
  signal s_return_home_cmd             : std_logic;  -- Return Home Command
  signal s_cursor_or_display_shift_cmd : std_logic;  -- Cursor or Display shift
  signal s_sc_rl                       : std_logic_vector(1 downto 0);  -- SC RL bit config
  signal s_cgram_all_char              : std_logic;  -- CGRAM All Char
  signal s_cgram_char_position         : std_logic_vector(2 downto 0);  -- CGRAM Char position
  signal s_lcd_line_sel                : std_logic;  -- LCD Line Selection
  signal s_lcd_char_position           : std_logic_vector(3 downto 0);  -- LCD Char Position


  -- CHAR Buffer Signals
  signal s_char_buffer_addr  : std_logic_vector(4 downto 0);  -- Char buffer addr
  signal s_char_buffer_wdata : std_logic_vector(7 downto 0);  -- Char buffer data
  signal s_char_buffer_wren  : std_logic;  -- Char buffer WREN
  signal s_char_buffer_rdata : std_logic_vector(7 downto 0);  -- Char buffer rdata

  signal s_pio_in  : std_logic;
  signal s_pio_out : std_logic_vector(31 downto 0);

  -- commands from NIOS - LEVEL
  signal s_load_one_char_nios : std_logic;  -- Load 1 Char on CHAR Buffer
  signal s_load_all_char_nios : std_logic;  -- Load All char (1st and 2nd line) on CHAR BUFFER

  -- Piped Signals
  signal s_load_one_char_nios_p : std_logic;  -- Load 1 Char on CHAR Buffer
  signal s_load_all_char_nios_p : std_logic;  -- Load All char (1st and 2nd line) on CHAR BUFFER



  signal s_load_one_char : std_logic;   -- Load 1 Char on CHAR Buffer
  signal s_load_all_char : std_logic;  -- Load All char (1st and 2nd line) on CHAR BUFFER

  signal s_rst_n : std_logic;           -- Synchronous Reset

begin  -- architecture rtl


  --
  i_reset_gen_0 : reset_gen
    port map (
      clk     => clk,
      arst_n  => rst_n,
      o_rst_n => s_rst_n
      );

  i_NIOS_II_LCD_controller_0 : NIOS_II_LCD_controller
    port map (
      clk_clk            => clk,
      pio_lcd_in_export  => s_pio_in,
      pio_lcd_out_export => s_pio_out,
      reset_reset_n      => s_rst_n
      );

  s_pio_in <= s_control_done;           -- Get control Done


  -- Command from NIOS
  s_char_position_nios <= s_pio_out(29 downto 26);
  s_line_sel_nios      <= s_pio_out(30);
  s_load_one_char_nios <= s_pio_out(31);
  s_load_all_char_nios <= s_pio_out(32);



  s_lcd_on                      <= s_pio_out(0);
  s_dl_nf_f                     <= s_pio_out(3 downto 1);
  s_dcb                         <= s_pio_out(6 downto 4);
  s_start_init                  <= s_pio_out(7);
  s_display_ctrl_cmd            <= s_pio_out(8);
  s_clear_display_cmd           <= s_pio_out(9);
  s_return_home_cmd             <= s_pio_out(10);
  s_cursor_or_display_shift_cmd <= s_pio_out(11);
  s_sc_rl                       <= s_pio_out(13 downto 12);
  s_update_cgram                <= s_pio_out(14);
  s_cgram_all_char              <= s_pio_out(15);
  s_cgram_char_position         <= s_pio_out(18 downto 16);
  s_update_lcd                  <= s_pio_out(19);
  s_lcd_all_char                <= s_pio_out(20);
  s_lcd_line_sel                <= s_pio_out(21);
  s_lcd_char_position           <= s_pio_out(25 downto 22);


  --s_char_buffer_addr <= s_pio_out(35 downto 31);


  -- purpose: pipe internals signals
  p_pipe_signals : process (clk, rst_n) is
  begin  -- process p_pipe_signals
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_load_one_char_nios_p <= '0';
      s_load_all_char_nios_p <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_load_one_char_nios_p <= s_load_one_char_nios;
      s_load_all_char_nios_p <= s_load_all_char_nios;
    end if;
  end process p_pipe_signals;

  -- purpose: Load Char Management
  p_load_char_mngt : process (clk, rst_n) is
  begin  -- process p_load_char_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_char_wdata        <= (others => '0');
      s_char_wdata_val    <= '0';
      s_char_buffer_addr  <= (others => '0');
      s_char_position     <= (others => '0');
      s_char_buffer_wdata <= (others => '0');
      s_char_buffer_wren  <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Pulse detection of load one CHAR
      if(s_load_one_char_nios = '1' and s_load_one_char_nios_p = '0') then

        -- Set Buffer Addr for a Read access
        s_char_buffer_addr <= unsigned(s_char_position_nios, s_char_buffer_addr'length) + unsigned(16*conv_integer(unsigned(s_line_sel_nios)), s_char_buffer_addr'length);
      elsif(s_load_all_char = '1') then

      else

      end if;

    end if;
  end process p_load_char_mngt;

  -- This buffer will be initialized by JTAG
  -- It will only be read on command
  -- Addr 0    -> 0xF  == 1st line
  -- Addr 0x10 -> 0x1F == 2nd line
  i_char_buffer_0 : char_buffer
    port map
    (
      address => s_char_buffer_addr,
      clock   => clk,
      data    => s_char_buffer_wdata,
      wren    => s_char_buffer_wren,
      q       => s_char_buffer_rdata
      );


  -- LCD CFAH TOP Instanciation
  i_lcd_cfah_top_0 : lcd_cfah_top
    generic map(
      G_CLK_PERIOD_NS       => 20,
      G_BIDIR_POLARITY_READ => G_BIDIR_POLARITY_READ
      )
    port map (
      clk   => clk,
      rst_n => s_rst_n,

      -- LCD LINES BUFFER I/F
      i_char_wdata     => s_char_wdata,
      i_char_wdata_val => s_char_wdata_val,
      i_char_position  => s_char_position,
      i_line_sel       => s_line_sel,

      -- LCD CGRAM BUFFER I/F
      i_cgram_addr      => s_cgram_addr,
      i_cgram_wdata     => s_cgram_wdata,
      i_cgram_wdata_val => s_cgram_wdata_val,

      -- Input control
      i_lcd_on => s_lcd_on,
      i_dl_n_f => s_dl_nf_f,
      i_dcb    => s_dcb,

      -- LCD Commands and Controls     
      i_start_init        => s_start_init,
      i_display_ctrl_cmd  => s_display_ctrl_cmd,
      i_clear_display_cmd => s_clear_display_cmd,

      i_return_home_cmd => s_return_home_cmd,

      i_cursor_or_display_shift_cmd => s_cursor_or_display_shift_cmd,
      i_sc_rl                       => s_sc_rl,

      -- LCD CGRAM Update
      i_update_cgram        => s_update_cgram,
      i_cgram_all_char      => s_cgram_all_char,
      i_cgram_char_position => s_cgram_char_position,

      -- LCD Display Update
      i_update_lcd        => s_update_lcd,
      i_lcd_all_char      => s_lcd_all_char,
      i_lcd_line_sel      => s_lcd_line_sel,
      i_lcd_char_position => s_lcd_char_position,

      o_control_done => s_control_done,

      i_lcd_data  => s_lcd_rdata,
      o_lcd_wdata => s_lcd_wdata,
      o_lcd_rw    => o_lcd_rw,
      o_lcd_en    => o_lcd_en,
      o_lcd_rs    => o_lcd_rs,
      o_lcd_on    => o_lcd_on,
      o_bidir_sel => s_bidir_sel

      );

  -- BIDIR Management -- Write access when not G_POL
  io_lcd_data <= s_lcd_wdata when s_bidir_sel = not G_BIDIR_POLARITY_READ else (others => 'Z');
  s_lcd_rdata <= io_lcd_data;


end architecture rtl;
