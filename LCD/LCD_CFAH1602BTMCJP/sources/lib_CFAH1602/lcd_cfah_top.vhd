-------------------------------------------------------------------------------
-- Title      : LCD CFAH Management TOP
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd_cfah_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2022-12-03
-- Last update: 2022-12-04
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: LCD CFAH Management TOP
-------------------------------------------------------------------------------
-- Copyright (c) 2022 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2022-12-03  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_CFAH1602;
use lib_CFAH1602.pkg_lcd_cfah.all;


entity lcd_cfah_top is
  generic (
    G_CLK_PERIOD_NS      : integer   := 20;  -- Clock Period in ns
    G_BIDIR_SEL_POLARITY : std_logic := '0'  -- BIDIR SEL Polarity
    );
  port (
    clk   : in std_logic;                    -- Clock
    rst_n : in std_logic;                    -- Asynchronous Reset

    i_lcd_on : in std_logic;                     -- LCD On control
    i_dl_n_f : in std_logic_vector(2 downto 0);  -- Function SET bis control
    i_dcb    : in std_logic_vector(2 downto 0);  -- Display ON/OFF Control bits

    -- LCD I/F
    i_lcd_data  : in  std_logic_vector(7 downto 0);  -- Data from LCD
    o_lcd_wdata : out std_logic_vector(7 downto 0);  -- LCD WData    
    o_lcd_rw    : out std_logic;                     -- R/W command
    o_lcd_en    : out std_logic;                     -- LCD Enable
    o_lcd_rs    : out std_logic;                     -- LCD RS
    o_lcd_on    : out std_logic;                     -- LCD ON Management
    o_bidir_sel : out std_logic                      -- Bidir Selector

    );


end entity lcd_cfah_top;



architecture rtl of lcd_cfah_top is

  -- INTERNAL Signals
  signal s_lcd_on        : std_logic;   -- LCD On Management
  signal s_lcd_on_r_edge : std_logic;   -- LCD ON Rising edge
  signal s_o_lcd_on      : std_logic;   -- Output LCD ON

  signal s_init_ongoing    : std_logic;
  signal s_init_done       : std_logic;
  signal s_start_init      : std_logic;
  signal s_cmd_bus         : std_logic_vector(10 downto 0);
  signal s_lcd_rdy         : std_logic;  -- LCD Ready
  signal s_start_poll      : std_logic;  -- Start polling busy
  signal s_done_cmd_buffer : std_logic;

  signal s_cmd_req                 : std_logic;
  signal s_clear_display           : std_logic;
  signal s_return_home             : std_logic;
  signal s_entry_mode_set          : std_logic;
  signal s_id_sh                   : std_logic_vector(1 downto 0);
  signal s_id_sh_cmd_buffer        : std_logic_vector(1 downto 0);
  signal s_display_ctrl            : std_logic;
  signal s_dcb                     : std_logic_vector(2 downto 0);
  signal s_dcb_cmd_buffer          : std_logic_vector(2 downto 0);
  signal s_cursor_display_shift    : std_logic;
  signal s_sc_rl                   : std_logic_vector(1 downto 0);
  signal s_sc_rl_cmd_buffer        : std_logic_vector(1 downto 0);
  signal s_function_set            : std_logic;
  signal s_dl_n_f                  : std_logic_vector(2 downto 0);
  signal s_set_gcram_addr          : std_logic;
  signal s_set_ddram_addr          : std_logic;
  signal s_read_busy_flag          : std_logic;
  signal s_wr_data                 : std_logic;
  signal s_rd_data                 : std_logic;
  signal s_data_bus                : std_logic_vector(7 downto 0);
  signal s_data_bus_cmd_buffer     : std_logic_vector(7 downto 0);
  signal s_lcd_rdata_cmd_generator : std_logic_vector(7 downto 0);
  signal s_done_cmd_generator      : std_logic;

  signal s_lcd_wdata : std_logic_vector(7 downto 0);

  signal s_rw           : std_logic;
  signal s_rs           : std_logic;
  signal s_lcd_data     : std_logic_vector(7 downto 0);
  signal s_start        : std_logic;
  signal s_lcd_rdata    : std_logic_vector(7 downto 0);  -- LCD RDATA
  signal s_lcd_itf_done : std_logic;

  signal s_lcd_rdata_cmd_buffer : std_logic_vector(7 downto 0);  -- LCD RDATA from cmd buffer block

begin  -- architecture rtl

  -- purpose: Pipe Inputs
  p_pipe_inputs : process (clk, rst_n) is
  begin  -- process p_pipe_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_lcd_on <= '0';
      s_dl_n_f <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_lcd_on <= i_lcd_on;
      s_dl_n_f <= i_dl_n_f;             -- Static
    end if;
  end process p_pipe_inputs;

  -- Rising Edge detection
  s_lcd_on_r_edge <= i_lcd_on and not s_lcd_on;


  -- purpose: LCD On Management
  p_lcd_on_mngt : process (clk, rst_n) is
  begin  -- process p_lcd_on_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_o_lcd_on <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_lcd_on_r_edge = '1') then
        s_o_lcd_on <= not s_o_lcd_on;
      end if;

    end if;
  end process p_lcd_on_mngt;


  -- LCD INIT Block
  i_lcd_cfah_init_0 : lcd_cfah_init
    generic map (
      G_CLK_PERIOD => G_CLK_PERIOD_NS
      )
    port map (
      clk                => clk,
      rst_n              => rst_n,
      i_lcd_on           => s_o_lcd_on,
      i_start_init       => s_start_init,
      i_cmd_done         => s_done_cmd_buffer,
      o_function_set_cmd => s_function_set,
      o_display_ctrl     => s_display_ctrl,
      o_entry_mode_set   => s_entry_mode_set,
      o_clear_display    => s_clear_display,
      o_init_ongoing     => s_init_ongoing,
      o_init_done        => s_init_done
      );

  -- BUSY Polling
  i_lcd_cfah_polling_busy_0 : lcd_cfah_polling_busy
    port map (
      clk              => clk,
      rst_n            => rst_n,
      i_new_cmd_req    => s_cmd_req,
      i_start_poll     => s_start_poll,
      i_done           => s_done_cmd_buffer,
      i_lcd_busy_flag  => '0',          -- TBD
      o_read_busy_flag => s_read_busy_flag,
      o_lcd_rdy        => s_lcd_rdy
      );


  s_dcb_cmd_buffer   <= i_dcb when s_init_ongoing = '0' else (others => '0');
  s_id_sh_cmd_buffer <= "00";

  -- Current not used cmd
  s_return_home          <= '0';
  s_cursor_display_shift <= '0';
  s_set_gcram_addr       <= '0';
  s_set_ddram_addr       <= '0';
  s_wr_data              <= '0';
  s_rd_data              <= '0';
  s_data_bus_cmd_buffer  <= (others => '0');

  -- LCD Command buffer
  i_lcd_cfah_cmd_buffer_0 : lcd_cfah_cmd_buffer
    generic map(
      G_NB_CMD => 11
      )
    port map (
      clk   => clk,
      rst_n => rst_n,

      i_init_ongoing => s_init_ongoing,

      -- Commands from specific block
      i_clear_display        => s_clear_display,
      i_return_home          => s_return_home,
      i_entry_mode_set       => s_entry_mode_set,
      i_id_sh                => s_id_sh_cmd_buffer,
      i_display_ctrl         => s_display_ctrl,
      i_dcb                  => s_dcb_cmd_buffer,
      i_cursor_display_shift => s_cursor_display_shift,
      i_sc_rl                => s_sc_rl_cmd_buffer,
      i_function_set         => s_function_set,
      i_set_gcram_addr       => s_set_gcram_addr,
      i_set_ddram_addr       => s_set_ddram_addr,
      i_read_busy_flag       => s_read_busy_flag,
      i_wr_data              => s_wr_data,
      i_rd_data              => s_rd_data,
      i_data_bus             => s_data_bus_cmd_buffer,
      i_cmd_done             => s_done_cmd_generator,
      o_cmd_done             => s_done_cmd_buffer,

      i_lcd_rdata => s_lcd_rdata_cmd_generator,
      o_lcd_rdata => s_lcd_rdata_cmd_buffer,

      -- Outputs to Commands Generator
      o_cmd_req  => s_cmd_req,
      o_cmd      => s_cmd_bus,
      o_id_sh    => s_id_sh,
      o_dcb      => s_dcb,
      o_sc_rl    => s_sc_rl,
      o_data_bus => s_data_bus,

      -- BUSY SCROLLER I/F
      i_lcd_rdy    => s_lcd_rdy,
      o_start_poll => s_start_poll

      );


  -- LCD Command generator
  i_lcd_cfah_cmd_generator_0 : lcd_cfah_cmd_generator
    port map(
      clk   => clk,
      rst_n => rst_n,

      i_cmd_req              => s_cmd_req,
      i_clear_display        => s_cmd_bus(0),
      i_return_home          => s_cmd_bus(1),
      i_entry_mode_set       => s_cmd_bus(2),
      i_id_sh                => s_id_sh,
      i_display_ctrl         => s_cmd_bus(3),
      i_dcb                  => s_dcb,
      i_cursor_display_shift => s_cmd_bus(4),
      i_sc_rl                => s_sc_rl,
      i_function_set         => s_cmd_bus(5),
      i_dl_n_f               => s_dl_n_f,
      i_set_gcram_addr       => s_cmd_bus(6),
      i_set_ddram_addr       => s_cmd_bus(7),
      i_read_busy_flag       => s_cmd_bus(10),
      i_wr_data              => s_cmd_bus(8),
      i_rd_data              => s_cmd_bus(9),
      i_data_bus             => s_data_bus,
      o_lcd_rdata            => s_lcd_rdata_cmd_generator,
      o_done                 => s_done_cmd_generator,

      -- LCD ITF
      i_lcd_rdata    => s_lcd_rdata,
      i_lcd_itf_done => s_lcd_itf_done,
      o_rs           => s_rs,
      o_rw           => s_rw,
      o_lcd_wdata    => s_lcd_wdata,
      o_start        => s_start
      );


  -- LCD Physical Interface
  i_lcd_cfah_itf_0 : lcd_cfah_itf
    generic map (
      G_CLK_PERIOD_NS      => G_CLK_PERIOD_NS,
      G_BIDIR_SEL_POLARITY => G_BIDIR_SEL_POLARITY
      )
    port map (
      clk        => clk,
      rst_n      => rst_n,
      i_wdata    => s_lcd_wdata,
      i_lcd_data => s_lcd_data,
      i_rs       => s_rs,
      i_rw       => s_rw,
      i_start    => s_start,

      o_lcd_wdata => o_lcd_wdata,
      o_lcd_rdata => s_lcd_rdata,
      o_lcd_rw    => o_lcd_rw,
      o_lcd_en    => o_lcd_en,
      o_lcd_rs    => o_lcd_rs,
      o_bidir_sel => o_bidir_sel,
      o_done      => s_lcd_itf_done
      );


  -- Output Affectation
  o_lcd_on <= s_o_lcd_on;

end architecture rtl;
