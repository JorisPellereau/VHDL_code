-------------------------------------------------------------------------------
-- Title      : LCD CFAH Management TOP
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd_cfah_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2022-12-03
-- Last update: 2023-09-27
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

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_CFAH1602_v2;
use lib_CFAH1602_v2.pkg_lcd_cfah.all;


entity lcd_cfah_top is
  generic (
    G_CLK_PERIOD_NS       : integer   := 20;   -- Clock Period in ns
    G_BIDIR_POLARITY_READ : std_logic := '0';  -- BIDIR SEL Polarity
    G_DATA_WIDTH          : integer   := 8;    -- DATA Width
    G_FIFO_ADDR_WIDTH     : integer   := 10    -- FIFO ADDR WIDTH
    );
  port (
    clk   : in std_logic;                      -- Clock
    rst_n : in std_logic;                      -- Asynchronous Reset

    -- LCD DISPLAY CTRL
    i_func_set           : in std_logic;                     -- Function Set command
    i_cursor_disp_shift  : in std_logic;                     -- Cursor Or display shift
    i_disp_on_off_ctrl   : in std_logic;                     -- Displau ON/OFF Control command
    i_entry_mode_set     : in std_logic;                     -- Entry Mode Set command
    i_return_home        : in std_logic;                     -- Return Home Command
    i_clear_disp         : in std_logic;                     -- Clear Display Command
    i_update_all_lcd     : in std_logic;                     -- Update the entire LCD display command
    i_update_one_char    : in std_logic;                     -- Update one character command
    i_char_position      : in std_logic_vector(4 downto 0);  -- Character number
    i_wr_en_fifo_display : in std_logic;                     -- Write Enable the FIFO DATA DISPLAY
    i_wdata_fifo_display : in std_logic_vector(7 downto 0);  -- FIFO Write data

    -- LCD Config Bus
    i_dl_n_f : in std_logic_vector(2 downto 0);  -- Function SET bis control
    i_dcb    : in std_logic_vector(2 downto 0);  -- Display ON/OFF Control bits
    i_sc_rl  : in std_logic_vector(1 downto 0);  -- Cursor or Display Shift Control bits
    i_id_sh  : in std_logic_vector(1 downto 0);  -- ID SH Entry Mode set Control Bit

    -- LCD Commands and Controls
    i_lcd_on : in std_logic;            -- LCD On control

    -- STATUS
    fifo_full_display   : out std_logic;  -- FIFO FULL Display status
    fifo_empty_display  : out std_logic;  -- FIFO Empty Display status
    init_ongoing        : out std_logic;  -- Initialization of the LCD ongoing
    single_cmd_ongoing  : out std_logic;  -- Single Command ongoing
    update_disp_ongoing : out std_logic;  -- Update Display ongoing

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

  -- == INTERNAL Signals ==
  signal s_init_ongoing             : std_logic;
  signal s_init_done                : std_logic;
  signal s_cmd_bus_cmd_generator    : std_logic_vector(10 downto 0);  -- Command bus to command generator
  signal s_cmd_req_poll             : std_logic;                      -- Command request from polling block
  signal s_id_sh_to_cmd_generator   : std_logic_vector(1 downto 0);
  signal s_dcb_to_cmd_generator     : std_logic_vector(2 downto 0);
  signal s_sc_rl_cmd_generator      : std_logic_vector(1 downto 0);
  signal s_dl_n_f_cmd_generator     : std_logic_vector(2 downto 0);
  signal s_data_bus_cmd_generator   : std_logic_vector(7 downto 0);
  signal s_lcd_rdata_cmd_generator  : std_logic_vector(7 downto 0);
  signal s_done_cmd_generator       : std_logic;
  signal s_lcd_wdata                : std_logic_vector(7 downto 0);
  signal s_rw                       : std_logic;
  signal s_rs                       : std_logic;
  signal s_start                    : std_logic;
  signal s_start_polling            : std_logic;
  signal s_lcd_rdata                : std_logic_vector(7 downto 0);   -- LCD RDATA
  signal s_lcd_itf_done             : std_logic;
  signal start_init                 : std_logic;                      -- Start INIT signal
  signal s_cmds                     : std_logic_vector(10 downto 0);  -- Commands from
  signal s_cmd_bus_poll             : std_logic_vector(10 downto 0);
  signal s_done_cmd_init            : std_logic;                      -- Command done to INIT module
  signal s_function_set_init        : std_logic;                      -- FUNCTION SET from INIT
  signal s_display_ctrl_init        : std_logic;                      -- Display CTRL from INIT
  signal s_entry_mode_set_init      : std_logic;                      -- Entry Mode SET from INIT
  signal s_clear_display_init       : std_logic;                      -- Clear Display from INIT
  signal s_cmd_req_init             : std_logic;                      -- Command request from INIT Module
  signal s_cmd_req_cmd_generator    : std_logic;                      -- Command request to cmd generator
  signal s_done_cmd_poll            : std_logic;                      -- Command done to poll block
  signal dl_n_f_init                : std_logic_vector(2 downto 0);   -- DL N F Initialization value
  signal polling_done               : std_logic;                      -- Polling Ready Flag
  signal set_ddram_addr_display     : std_logic;                      -- SET DDRAM Command from DISPLAY UPDATE block
  signal wr_data_display            : std_logic;                      -- WR_DATA Command from DISPLAY UPDATE block
  signal ddram_data_or_addr_display : std_logic_vector(7 downto 0);   -- DDRAM DATA or ADDR from DISPLAY UPDATE block
  signal start_display              : std_logic;                      -- Start from DISPLAY UPDATE block
  signal update_display_done        : std_logic;                      -- Update Display ON

  signal s_func_set          : std_logic;                     -- function_set command
  signal s_cursor_disp_shift : std_logic;                     -- Cursor DISP Shift Command
  signal s_disp_on_off_ctrl  : std_logic;                     -- Disp On OFF Control Command
  signal s_entry_mode_set    : std_logic;                     -- Entry Mode Set Command
  signal s_return_home       : std_logic;                     -- Return Home Command
  signal s_clear_disp        : std_logic;                     -- Clear Display Command
  signal s_update_all_lcd    : std_logic;                     -- Update All LCD Command
  signal s_update_one_char   : std_logic;                     -- Update One Char Command
  signal start_cmd           : std_logic;                     -- Start Command Pulse
  signal mux_sel             : std_logic_vector(1 downto 0);  -- Mux selector

begin  -- architecture rtl

  -- Instanciation of the MAIN FSM of the LCD CFAH
  i_lcd_cfah_main_fsm_0 : entity lib_CFAH1602_v2.lcd_cfah_main_fsm
    port map (
      clk_sys   => clk,
      rst_n_sys => rst_n,

      i_lcd_on   => i_lcd_on,
      start_init => start_init,

      -- External LCD Commands
      i_func_set          => i_func_set,
      i_cursor_disp_shift => i_cursor_disp_shift,
      i_disp_on_off_ctrl  => i_disp_on_off_ctrl,
      i_entry_mode_set    => i_entry_mode_set,
      i_return_home       => i_return_home,
      i_clear_disp        => i_clear_disp,
      i_update_all_lcd    => i_update_all_lcd,
      i_update_one_char   => i_update_one_char,

      -- LCD Commands to send inside the function
      o_func_set          => s_func_set,
      o_cursor_disp_shift => s_cursor_disp_shift,
      o_disp_on_off_ctrl  => s_disp_on_off_ctrl,
      o_entry_mode_set    => s_entry_mode_set,
      o_return_home       => s_return_home,
      o_clear_disp        => s_clear_disp,
      o_start_cmd         => start_cmd,
      o_update_all_lcd    => s_update_all_lcd,
      o_update_one_char   => s_update_one_char,
      o_mux_sel           => mux_sel,

      polling_done        => polling_done,
      update_display_done => update_display_done,

      init_ongoing        => s_init_ongoing,
      init_done           => s_init_done,
      single_cmd_ongoing  => single_cmd_ongoing,
      update_disp_ongoing => update_disp_ongoing
      );

  -- Instanciation of LCD INITIALIZATION
  i_lcd_cfah_init_0 : entity lib_CFAH1602_v2.lcd_cfah_init
    generic map (
      G_CLK_PERIOD  => G_CLK_PERIOD_NS,
      G_DL_N_F_INIT => "111"
      )
    port map (
      clk_sys   => clk,
      rst_n_sys => rst_n,

      i_start_init => start_init,

      i_cmd_done => s_done_cmd_init,
      o_cmd_req  => s_cmd_req_init,

      o_function_set_cmd => s_function_set_init,
      o_dl_n_f           => dl_n_f_init,
      o_display_ctrl     => s_display_ctrl_init,
      o_entry_mode_set   => s_entry_mode_set_init,
      o_clear_display    => s_clear_display_init,

      o_init_done => s_init_done
      );

  -- Instanciation of LCD DISPLAY UPDATE
  i_lcd_cfah_update_display_0 : entity lib_CFAH1602_v2.lcd_cfah_update_display
    generic map (
      G_DATA_WIDTH => G_DATA_WIDTH,
      G_ADDR_WIDTH => G_FIFO_ADDR_WIDTH
      )
    port map (
      clk   => clk,
      rst_n => rst_n,

      -- Commands
      i_update_all_lcd  => s_update_all_lcd,
      i_update_one_char => s_update_one_char,
      i_char_position   => i_char_position,

      -- LCD Commands
      o_set_ddram_addr     => set_ddram_addr_display,
      o_wr_data            => wr_data_display,
      o_ddram_data_or_addr => ddram_data_or_addr_display,
      o_start              => start_display,

      -- Command Done
      i_poll_done => polling_done,

      -- FIFO CTRL 
      wr_en => i_wr_en_fifo_display,
      wdata => i_wdata_fifo_display,


      -- LCD Update done flag
      o_update_done => update_display_done,

      -- FIFO Status
      fifo_empty => fifo_empty_display,
      fifo_full  => fifo_full_display
      );


  -- Commands vector to POLLING BLOCK affectation
  s_cmds(C_CLEAR_DISPLAY)        <= s_clear_disp;
  s_cmds(C_RETURN_HOME)          <= s_return_home;
  s_cmds(C_ENTRY_MODE_SET)       <= s_entry_mode_set;
  s_cmds(C_DISP_ON_OFF_CTRL)     <= s_disp_on_off_ctrl;
  s_cmds(C_CURSOR_OR_DISP_SHIFT) <= s_cursor_disp_shift;
  s_cmds(C_FUNCTION_SET)         <= s_func_set;
  s_cmds(C_SET_CGRAM_ADDR)       <= '0';

  s_cmds(C_SET_DDRAM_ADDR)    <= set_ddram_addr_display;
  s_cmds(C_WRITE_DATA_TO_RAM) <= wr_data_display;

  s_cmds(C_READ_BUSY_FLAG)     <= '0';
  s_cmds(C_READ_DATA_FROM_RAM) <= '0';

  -- Selection of the Start polling command
  s_start_polling <= start_display when mux_sel = "10" else
                     start_cmd when mux_sel = "01" else
                     '0';


  -- Instanciation of LCD POLLING Block
  i_lcd_cfah_polling_0 : entity lib_CFAH1602_v2.lcd_cfah_polling
    port map(

      clk_sys   => clk,
      rst_n_sys => rst_n,
      i_start   => s_start_polling,     -- Start Commands
      i_cmds    => s_cmds,              -- Commands
      o_done    => polling_done,        -- Polling Done Flag

      -- Command generator ITF
      o_cmd_req   => s_cmd_req_poll,
      o_cmds      => s_cmd_bus_poll,
      i_lcd_rdata => s_lcd_rdata_cmd_generator,
      i_done      => s_done_cmd_poll
      );


  -- MUX :
  -- MUXs signals from INIT module to cmd generator when the MAIN FSM is in INIT
  -- state
  s_cmd_req_cmd_generator <= s_cmd_req_init when s_init_ongoing = '1' else s_cmd_req_poll;

  -- Commands shared with init module
  s_cmd_bus_cmd_generator(C_FUNCTION_SET)     <= s_function_set_init   when s_init_ongoing = '1' else s_cmd_bus_poll(C_FUNCTION_SET);
  s_cmd_bus_cmd_generator(C_DISP_ON_OFF_CTRL) <= s_display_ctrl_init   when s_init_ongoing = '1' else s_cmd_bus_poll(C_DISP_ON_OFF_CTRL);
  s_cmd_bus_cmd_generator(C_ENTRY_MODE_SET)   <= s_entry_mode_set_init when s_init_ongoing = '1' else s_cmd_bus_poll(C_ENTRY_MODE_SET);
  s_cmd_bus_cmd_generator(C_CLEAR_DISPLAY)    <= s_clear_display_init  when s_init_ongoing = '1' else s_cmd_bus_poll(C_CLEAR_DISPLAY);

  -- Command directly connects to polling block
  s_cmd_bus_cmd_generator(C_RETURN_HOME)          <= s_cmd_bus_poll(C_RETURN_HOME);
  s_cmd_bus_cmd_generator(C_CURSOR_OR_DISP_SHIFT) <= s_cmd_bus_poll(C_CURSOR_OR_DISP_SHIFT);
  s_cmd_bus_cmd_generator(C_SET_CGRAM_ADDR)       <= s_cmd_bus_poll(C_SET_CGRAM_ADDR);
  s_cmd_bus_cmd_generator(C_SET_DDRAM_ADDR)       <= s_cmd_bus_poll(C_SET_DDRAM_ADDR);
  s_cmd_bus_cmd_generator(C_READ_BUSY_FLAG)       <= s_cmd_bus_poll(C_READ_BUSY_FLAG);
  s_cmd_bus_cmd_generator(C_WRITE_DATA_TO_RAM)    <= s_cmd_bus_poll(C_WRITE_DATA_TO_RAM);
  s_cmd_bus_cmd_generator(C_READ_DATA_FROM_RAM)   <= s_cmd_bus_poll(C_READ_DATA_FROM_RAM);

  -- MUX INIT WDATA value
  -- Mux DL N F vector
  s_dl_n_f_cmd_generator <= dl_n_f_init when s_init_ongoing = '1' else
                            i_dl_n_f;

  -- MUX DONE Signal :
  -- Done poll is connected to cmd_generator done only when we are in OPE mode
  s_done_cmd_poll <= s_done_cmd_generator when s_init_ongoing = '0' else
                     '0';

  -- Donne cmd init is connected to  cmd_generator done only when we are in
  -- INIT mode
  s_done_cmd_init <= s_done_cmd_generator when s_init_ongoing = '1' else
                     '0';

  -- DAta Connexion - /!\ a muxer ! TBD
  s_data_bus_cmd_generator <= ddram_data_or_addr_display when mux_sel = "10" else
                              (others => '0');

  -- STATIC Configuration
  s_dcb_to_cmd_generator   <= i_dcb;
  s_sc_rl_cmd_generator    <= i_sc_rl;
  s_id_sh_to_cmd_generator <= i_id_sh;

  -- LCD Command generator
  i_lcd_cfah_cmd_generator_0 : entity lib_CFAH1602_v2.lcd_cfah_cmd_generator
    port map(
      clk   => clk,
      rst_n => rst_n,

      i_cmd_req              => s_cmd_req_cmd_generator,
      i_clear_display        => s_cmd_bus_cmd_generator(C_CLEAR_DISPLAY),
      i_return_home          => s_cmd_bus_cmd_generator(C_RETURN_HOME),
      i_entry_mode_set       => s_cmd_bus_cmd_generator(C_ENTRY_MODE_SET),
      i_id_sh                => s_id_sh_to_cmd_generator,
      i_display_ctrl         => s_cmd_bus_cmd_generator(C_DISP_ON_OFF_CTRL),
      i_dcb                  => s_dcb_to_cmd_generator,
      i_cursor_display_shift => s_cmd_bus_cmd_generator(C_CURSOR_OR_DISP_SHIFT),
      i_sc_rl                => s_sc_rl_cmd_generator,
      i_function_set         => s_cmd_bus_cmd_generator(C_FUNCTION_SET),
      i_dl_n_f               => s_dl_n_f_cmd_generator,
      i_set_gcram_addr       => s_cmd_bus_cmd_generator(C_SET_CGRAM_ADDR),
      i_set_ddram_addr       => s_cmd_bus_cmd_generator(C_SET_DDRAM_ADDR),
      i_read_busy_flag       => s_cmd_bus_cmd_generator(C_READ_BUSY_FLAG),
      i_wr_data              => s_cmd_bus_cmd_generator(C_WRITE_DATA_TO_RAM),
      i_rd_data              => s_cmd_bus_cmd_generator(C_READ_DATA_FROM_RAM),
      i_data_bus             => s_data_bus_cmd_generator,
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
  i_lcd_cfah_itf_0 : entity lib_CFAH1602_v2.lcd_cfah_itf
    generic map (
      G_CLK_PERIOD_NS       => G_CLK_PERIOD_NS,
      G_BIDIR_POLARITY_READ => G_BIDIR_POLARITY_READ
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


  -- purpose: LCD ON Management
  p_lcd_on_mngt : process (clk, rst_n) is
  begin  -- process p_lcd_on_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_lcd_on <= '0';
    elsif rising_edge(clk) then         -- rising clock edge
      o_lcd_on <= i_lcd_on;
    end if;
  end process p_lcd_on_mngt;

  init_ongoing <= s_init_ongoing;       -- Affectation of the init ongoing status

end architecture rtl;
