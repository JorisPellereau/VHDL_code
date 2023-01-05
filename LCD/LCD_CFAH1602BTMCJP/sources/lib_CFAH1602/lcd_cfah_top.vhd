-------------------------------------------------------------------------------
-- Title      : LCD CFAH Management TOP
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd_cfah_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2022-12-03
-- Last update: 2023-01-05
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

    -- LCD LINES BUFFER I/F
    i_char_wdata     : in std_logic_vector(7 downto 0);  -- Data character
    i_char_wdata_val : in std_logic;                     -- Data valid
    i_char_position  : in std_logic_vector(3 downto 0);  -- Character number
    i_line_sel       : in std_logic;                     -- Line Selection

    -- LCD CGRAM BUFFER I/F
    i_cgram_addr      : in std_logic_vector(6 downto 0);  -- CGRAM Addr
    i_cgram_wdata     : in std_logic_vector(4 downto 0);  -- CGRAM Data
    i_cgram_wdata_val : in std_logic;                     -- CGRAM Data valid

    -- LCD Config Bus
    i_dl_n_f : in std_logic_vector(2 downto 0);  -- Function SET bis control
    i_dcb    : in std_logic_vector(2 downto 0);  -- Display ON/OFF Control bits

    -- LCD Commands and Controls
    i_lcd_on            : in std_logic;  -- LCD On control
    i_start_init        : in std_logic;  -- Start Initialization command
    i_display_ctrl_cmd  : in std_logic;  -- Display Control Command
    i_clear_display_cmd : in std_logic;  -- Clear Display Command

    i_update_lcd        : in std_logic;  -- Update LCD
    i_lcd_all_char      : in std_logic;  -- One Char or all Lcd update selection
    i_lcd_line_sel      : in std_logic;
    i_lcd_char_position : in std_logic_vector(3 downto 0);  -- Character number

    i_update_cgram        : in std_logic;  -- Update CGRAM Command
    i_cgram_all_char      : in std_logic;  -- All Char or One char selection  
    i_cgram_char_position : in std_logic_vector(2 downto 0);  -- Character position selection

    o_control_done : out std_logic;     -- Command done

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

  signal s_init_ongoing     : std_logic;
  signal s_init_done        : std_logic;
  signal s_init_done_p      : std_logic;  -- s_init_done pipe one time
  signal s_init_done_r_edge : std_logic;  -- rising edge of s_init_done

  signal s_cmd_bus         : std_logic_vector(10 downto 0);
  signal s_lcd_rdy         : std_logic;  -- LCD Ready
  signal s_start_poll      : std_logic;  -- Start polling busy
  signal s_done_cmd_buffer : std_logic;

  signal s_cmd_req                 : std_logic;
  signal s_return_home             : std_logic;
  signal s_entry_mode_set          : std_logic;
  signal s_id_sh                   : std_logic_vector(1 downto 0);
  signal s_id_sh_cmd_buffer        : std_logic_vector(1 downto 0);
  signal s_id_sh_to_cmd_generator  : std_logic_vector(1 downto 0);
  signal s_display_ctrl            : std_logic;
  signal s_dcb                     : std_logic_vector(2 downto 0);
  signal s_dcb_cmd_buffer          : std_logic_vector(2 downto 0);
  signal s_dcb_to_cmd_generator    : std_logic_vector(2 downto 0);
  signal s_cursor_display_shift    : std_logic;
  signal s_sc_rl                   : std_logic_vector(1 downto 0);
  signal s_sc_rl_cmd_buffer        : std_logic_vector(1 downto 0);
  signal s_function_set            : std_logic;
  signal s_dl_n_f                  : std_logic_vector(2 downto 0);
  signal s_set_gcram_addr          : std_logic;
  signal s_set_ddram_addr          : std_logic;
  signal s_read_busy_flag          : std_logic;
  signal s_wr_data_cmd_buffer      : std_logic;
  signal s_wr_data_ddram           : std_logic;
  signal s_rd_data                 : std_logic;
  signal s_data_bus                : std_logic_vector(7 downto 0);
  signal s_data_bus_cmd_buffer     : std_logic_vector(7 downto 0);
  signal s_lcd_rdata_cmd_generator : std_logic_vector(7 downto 0);
  signal s_done_cmd_generator      : std_logic;

  signal s_display_ctrl_to_cmd_buffer : std_logic;
  signal s_lcd_wdata                  : std_logic_vector(7 downto 0);

  signal s_rw           : std_logic;
  signal s_rs           : std_logic;
  signal s_start        : std_logic;
  signal s_lcd_rdata    : std_logic_vector(7 downto 0);  -- LCD RDATA
  signal s_lcd_itf_done : std_logic;

  signal s_lcd_rdata_cmd_buffer : std_logic_vector(7 downto 0);  -- LCD RDATA from cmd buffer block

  signal s_char_rd_busy          : std_logic;
  signal s_char_read_req         : std_logic;
  signal s_char_rd_char_position : std_logic_vector(3 downto 0);
  signal s_char_rd_line_sel      : std_logic;
  signal s_char_rdata            : std_logic_vector(7 downto 0);
  signal s_char_rdata_val        : std_logic;
  signal s_ddram_data_or_addr    : std_logic_vector(7 downto 0);
  signal s_lcd_update_ongoing    : std_logic;
  signal s_lcd_update_done       : std_logic;

  signal s_poll_ongoing                : std_logic;
  signal s_clear_display_from_init     : std_logic;
  signal s_clear_display_to_cmd_buffer : std_logic;

  signal s_cmd_done_to_update_display : std_logic;
  signal s_done_cmd_to_init           : std_logic;
  signal s_power_on_init_ongoing      : std_logic;
  signal s_init_ongoing_to_cmd_buffer : std_logic;

  signal s_rd_req_cgram             : std_logic;
  signal s_rd_cgram_addr            : std_logic_vector(6 downto 0);
  signal s_cgram_rdata              : std_logic_vector(4 downto 0);
  signal s_cgram_rdata_val          : std_logic;
  signal s_cgram_rd_busy            : std_logic;
  signal s_wr_data_cgram            : std_logic;
  signal s_cgram_data_or_addr       : std_logic_vector(7 downto 0);
  signal s_cgram_update_ongoing     : std_logic;
  signal s_cgram_update_done        : std_logic;
  signal s_cmd_done_to_update_cgram : std_logic;

  signal s_display_ctrl_cmd : std_logic;


begin  -- architecture rtl

  -- purpose: Pipe Inputs
  p_pipe_inputs : process (clk, rst_n) is
  begin  -- process p_pipe_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_lcd_on           <= '0';
      s_display_ctrl_cmd <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_lcd_on           <= i_lcd_on;
      s_display_ctrl_cmd <= i_display_ctrl_cmd;
    end if;
  end process p_pipe_inputs;

  -- Rising Edge detection
  s_lcd_on_r_edge <= i_lcd_on and not s_lcd_on;



  -- purpose: Pipes internal signals
  p_pipe_signals : process (clk, rst_n) is
  begin  -- process p_pipe_signals
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_init_done_p <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_init_done_p <= s_init_done;
    end if;
  end process p_pipe_signals;

  -- Rising edge detection
  s_init_done_r_edge <= s_init_done and not s_init_done_p;


  -- purpose: Latch Config Bits on command
  p_latch_config_bits : process (clk, rst_n) is
  begin  -- process p_latch_config_bits
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_dl_n_f <= (others => '0');
      s_dcb    <= (others => '0');
      s_id_sh  <= (others => '0');

    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Update Function Set Command configuration bits
      if(i_lcd_on = '1' or i_start_init = '1') then
        s_dl_n_f <= i_dl_n_f;
      end if;

      -- Update on command
      if(i_display_ctrl_cmd = '1') then
        s_dcb <= i_dcb;
      end if;
      
      s_id_sh <= "01";  -- shift to right (I/D == 0) and S == 1 (display
      
    end if;
  end process p_latch_config_bits;

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

  -- Direct cmd_done from cmd_buffer block when power on initialization
  -- else during regular init and when not polling is ongoing get done from
  -- cmd_biffer block
  s_done_cmd_to_init <= s_done_cmd_buffer when s_power_on_init_ongoing = '1' else
                        s_done_cmd_buffer when (s_power_on_init_ongoing = '0' and s_poll_ongoing = '0') else
                        '0';

  -- LCD INIT Block
  i_lcd_cfah_init_0 : lcd_cfah_init
    generic map (
      G_CLK_PERIOD => G_CLK_PERIOD_NS
      )
    port map (
      clk                     => clk,
      rst_n                   => rst_n,
      i_lcd_on                => s_o_lcd_on,
      i_start_init            => i_start_init,
      i_cmd_done              => s_done_cmd_to_init,
      o_function_set_cmd      => s_function_set,
      o_display_ctrl          => s_display_ctrl,
      o_entry_mode_set        => s_entry_mode_set,
      o_clear_display         => s_clear_display_from_init,
      o_init_ongoing          => s_init_ongoing,
      o_power_on_init_ongoing => s_power_on_init_ongoing,
      o_init_done             => s_init_done
      );

  -- BUSY Polling
  i_lcd_cfah_polling_busy_0 : lcd_cfah_polling_busy
    port map (
      clk              => clk,
      rst_n            => rst_n,
      i_new_cmd_req    => s_cmd_req,
      i_start_poll     => s_start_poll,
      i_done           => s_done_cmd_buffer,
      i_lcd_busy_flag  => s_lcd_rdata_cmd_buffer(7),  -- TBD
      o_read_busy_flag => s_read_busy_flag,
      o_poll_ongoing   => s_poll_ongoing,
      o_lcd_rdy        => s_lcd_rdy
      );


  -- Command done return only when polling is done
  s_cmd_done_to_update_display <= s_done_cmd_buffer and not s_poll_ongoing;
  s_cmd_done_to_update_cgram   <= s_done_cmd_buffer and not s_poll_ongoing;

  -- UPDATE DISPLAY Management block
  i_lcd_cfah_update_display_0 : lcd_cfah_update_display
    port map (
      clk                  => clk,
      rst_n                => rst_n,
      i_update_lcd         => i_update_lcd,
      i_lcd_all_char       => i_lcd_all_char,
      i_lcd_line_sel       => i_lcd_line_sel,
      i_lcd_char_position  => i_lcd_char_position,
      i_cmd_done           => s_cmd_done_to_update_display,
      o_set_ddram_addr     => s_set_ddram_addr,
      o_wr_data            => s_wr_data_ddram,
      o_ddram_data_or_addr => s_ddram_data_or_addr,
      i_rdata              => s_char_rdata,
      i_rdata_val          => s_char_rdata_val,
      o_rd_req             => s_char_read_req,
      o_rd_char_pos        => s_char_rd_char_position,
      o_rd_line_sel        => s_char_rd_line_sel,
      o_update_ongoing     => s_lcd_update_ongoing,
      o_update_done        => s_lcd_update_done
      );

  -- Line Buffer
  i_lcd_cfah_lines_buffer_0 : lcd_cfah_lines_buffer
    port map (
      clk                => clk,
      rst_n              => rst_n,
      i_wdata            => i_char_wdata,
      i_wdata_val        => i_char_wdata_val,
      i_char_position    => i_char_position,
      i_line_sel         => i_line_sel,
      i_rd_req           => s_char_read_req,
      i_rd_char_position => s_char_rd_char_position,
      i_rd_line_sel      => s_char_rd_line_sel,
      o_rdata            => s_char_rdata,
      o_rdata_val        => s_char_rdata_val,
      o_read_busy        => s_char_rd_busy
      );


  -- CGRAM Custom Character Buffer
  i_lcd_cfah_cgram_buffer_0 : lcd_cfah_cgram_buffer
    port map (
      clk               => clk,
      rst_n             => rst_n,
      i_cgram_wdata     => i_cgram_wdata,
      i_cgram_wdata_val => i_cgram_wdata_val,
      i_cgram_addr      => i_cgram_addr,
      i_rd_req          => s_rd_req_cgram,
      i_rd_cgram_addr   => s_rd_cgram_addr,
      o_cgram_rdata     => s_cgram_rdata,
      o_cgram_rdata_val => s_cgram_rdata_val,
      o_read_busy       => s_cgram_rd_busy
      );


  i_lcd_cfah_update_cgram_0 : lcd_cfah_update_cgram
    port map (
      clk                   => clk,
      rst_n                 => rst_n,
      i_font_type           => s_dl_n_f(0),  -- Font type of function set command
      i_update_cgram        => i_update_cgram,
      i_cgram_all_char      => i_cgram_all_char,
      i_cgram_char_position => i_cgram_char_position,
      i_cmd_done            => s_cmd_done_to_update_cgram,
      o_set_cgram_addr      => s_set_gcram_addr,
      o_wr_data             => s_wr_data_cgram,
      o_cgram_data_or_addr  => s_cgram_data_or_addr,
      i_cgram_rdata         => s_cgram_rdata,
      i_cgram_rdata_val     => s_cgram_rdata_val,
      o_rd_req              => s_rd_req_cgram,
      o_cgram_addr          => s_rd_cgram_addr,
      o_update_ongoing      => s_cgram_update_ongoing,
      o_update_done         => s_cgram_update_done
      );


  s_dcb_cmd_buffer   <= s_dcb when s_init_ongoing = '0' else "000";  -- Enable
                                                                     -- display
                                                                     -- by default
  s_id_sh_cmd_buffer <= s_id_sh;
  -- shift

  -- Current not used cmd
  s_return_home          <= '0';
  s_cursor_display_shift <= '0';

  s_rd_data          <= '0';
  s_sc_rl_cmd_buffer <= (others => '0');

  -- MUX DATA BUS to CMD BUFFER
  s_data_bus_cmd_buffer <= s_ddram_data_or_addr when s_lcd_update_ongoing = '1' else
                           s_cgram_data_or_addr when s_cgram_update_ongoing = '1' else
                           (others => '0');

  -- MUX WR DATA Command to CMD BUFFER
  s_wr_data_cmd_buffer <= s_wr_data_ddram when s_lcd_update_ongoing = '1' else
                          s_wr_data_cgram when s_cgram_update_ongoing = '1' else
                          '0';

  -- From init block or from outside
  s_display_ctrl_to_cmd_buffer  <= s_display_ctrl or s_display_ctrl_cmd;
  s_clear_display_to_cmd_buffer <= s_clear_display_from_init or i_clear_display_cmd;


  -- During POWER On init -> Enable this signal in order to bypass polling busy
  -- during power on init
  s_init_ongoing_to_cmd_buffer <= s_init_ongoing and s_power_on_init_ongoing;

  -- LCD Command buffer
  i_lcd_cfah_cmd_buffer_0 : lcd_cfah_cmd_buffer
    generic map(
      G_NB_CMD => 11
      )
    port map (
      clk   => clk,
      rst_n => rst_n,

      i_init_ongoing => s_init_ongoing_to_cmd_buffer,

      -- Commands from specific block
      i_clear_display        => s_clear_display_to_cmd_buffer,
      i_return_home          => s_return_home,
      i_entry_mode_set       => s_entry_mode_set,
      i_id_sh                => s_id_sh_cmd_buffer,
      i_display_ctrl         => s_display_ctrl_to_cmd_buffer,
      i_dcb                  => s_dcb_cmd_buffer,
      i_cursor_display_shift => s_cursor_display_shift,
      i_sc_rl                => s_sc_rl_cmd_buffer,
      i_function_set         => s_function_set,
      i_set_gcram_addr       => s_set_gcram_addr,
      i_set_ddram_addr       => s_set_ddram_addr,
      i_read_busy_flag       => s_read_busy_flag,
      i_wr_data              => s_wr_data_cmd_buffer,
      i_rd_data              => s_rd_data,
      i_data_bus             => s_data_bus_cmd_buffer,
      i_cmd_done             => s_done_cmd_generator,
      o_cmd_done             => s_done_cmd_buffer,

      i_lcd_rdata => s_lcd_rdata_cmd_generator,
      o_lcd_rdata => s_lcd_rdata_cmd_buffer,

      -- Outputs to Commands Generator
      o_cmd_req  => s_cmd_req,
      o_cmd      => s_cmd_bus,
      o_id_sh    => s_id_sh_to_cmd_generator,
      o_dcb      => s_dcb_to_cmd_generator,
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
      i_id_sh                => s_id_sh_to_cmd_generator,
      i_display_ctrl         => s_cmd_bus(3),
      i_dcb                  => s_dcb_to_cmd_generator,
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
      i_lcd_data => i_lcd_data,
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

  -- Done from Block or from s_done_cmd_buffer if a single command is generated
  o_control_done <= s_lcd_update_done or s_init_done_r_edge or s_cgram_update_done or (s_done_cmd_buffer and not s_lcd_update_ongoing and not s_init_ongoing and not s_poll_ongoing and not s_cgram_update_ongoing);

end architecture rtl;
