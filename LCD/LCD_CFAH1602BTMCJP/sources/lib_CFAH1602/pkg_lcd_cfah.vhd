library ieee;
use ieee.std_logic_1164.all;


package pkg_lcd_cfah is

  -- == LCD CFAH Timing Duration ==
  constant C_tAS_DURATION    : integer := 40;   -- 40 ns
  constant C_PWeh_DURATION   : integer := 230;  -- 230 ns
  constant C_tAH_DURATION    : integer := 10;   -- 10 ns
  constant C_tcycE_DURATION  : integer := 500;  -- 500 ns
  constant C_tH_tAH_DURATION : integer := 10;   -- 10 ns
  constant C_tDDR_DURATION   : integer := 160;  -- 160 ns

  -- Initialization Constants
  constant C_LCD_WAIT_POWER_ON : integer := 15100000;  -- Wait more than 15ms after Power On

  -- More than 4.1ms
  constant C_INIT_WAIT_1 : integer := 4200000;  -- [ns] - Duration of First Wait for initialization
  constant C_INIT_WAIT_2 : integer := 100000;  -- [ns] - Duration of 2nd wait for initialization

  -- == FUNCTIONS ==
  -- Convert a clock period in [ns] to a number of period
  function clk_period_to_max(i_clk_period : integer; i_duration : integer)
    return integer;


  -- == COMPONENTS     ==
  component lcd_cfah_init is
    generic (
      G_CLK_PERIOD : integer := 20      -- Period of Input clock in [ns]
      );

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      i_lcd_on     : in std_logic;      -- LCD ON
      i_start_init : in std_logic;      -- Start Initialization

      i_cmd_done         : in  std_logic;  -- Command done
      o_function_set_cmd : out std_logic;  -- Function Set command
      o_display_ctrl     : out std_logic;  -- Display Control Command
      o_entry_mode_set   : out std_logic;  -- Entry Mode set command
      o_clear_display    : out std_logic;  -- Clear Display
      o_init_ongoing     : out std_logic;  -- Init. ongoing
      o_init_done        : out std_logic   -- Initialization Done
      );
  end component lcd_cfah_init;

  component lcd_cfah_itf is

    generic (
      G_CLK_PERIOD_NS      : integer   := 20;  -- Clock Period in ns
      G_BIDIR_SEL_POLARITY : std_logic := '0'  -- BIDIR SEL Polarity
      );
    port (
      clk   : in std_logic;                    -- Clock
      rst_n : in std_logic;                    -- Asynchronous Reset

      i_wdata    : in std_logic_vector(7 downto 0);  -- Data to write
      i_lcd_data : in std_logic_vector(7 downto 0);  -- Data from LCD
      i_rs       : in std_logic;                     -- Register Selection
      i_rw       : in std_logic;                     -- RW selection
      i_start    : in std_logic;                     -- Start tranfert

      o_lcd_wdata : out std_logic_vector(7 downto 0);  -- LCD WData
      o_lcd_rdata : out std_logic_vector(7 downto 0);  -- LCD RDATA
      o_lcd_rw    : out std_logic;                     -- R/W command
      o_lcd_en    : out std_logic;                     -- LCD Enable
      o_lcd_rs    : out std_logic;                     -- LCD RS
      o_bidir_sel : out std_logic;                     -- Bidir Selector
      o_done      : out std_logic);                    -- Done flag

  end component lcd_cfah_itf;


  component lcd_cfah_polling_busy is

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      i_new_cmd_req : in std_logic;     -- New Command req
      i_start_poll  : in std_logic;     -- Start Polling

      i_done          : in std_logic;   -- Command done
      i_lcd_busy_flag : in std_logic;   -- Read data bit 7


      o_read_busy_flag : out std_logic;  -- Read Busy Flag command

      o_lcd_rdy : out std_logic         -- LCD Ready when rise
      );

  end component lcd_cfah_polling_busy;

  component lcd_cfah_cmd_generator is

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      i_cmd_req : in std_logic;         -- Command Request

      i_clear_display : in std_logic;   -- Clear Display Cmd request
      i_return_home   : in std_logic;   -- Return Home Cmd Request

      i_entry_mode_set : in std_logic;  -- Entry Mode Set Cmd Request
      i_id_sh          : in std_logic_vector(1 downto 0);  -- Bits Control

      i_display_ctrl : in std_logic;    -- Display ON/OFF Ctrl Cmd Req
      i_dcb          : in std_logic_vector(2 downto 0);  -- Control bits

      i_cursor_display_shift : in std_logic;  -- Cursor Display Shift Cmd Req
      i_sc_rl                : in std_logic_vector(1 downto 0);  -- Cursor Display Bits control

      i_function_set : in std_logic;    -- Function Set cmd Req
      i_dl_n_f       : in std_logic_vector(2 downto 0);  -- Function SET bis control

      i_set_gcram_addr : in std_logic;  -- Set CGRAM Address Command Req
      i_set_ddram_addr : in std_logic;  -- Set DDRAM Address Command Req
      i_read_busy_flag : in std_logic;  -- Read Busy Flag and Addr command Req
      i_wr_data        : in std_logic;  -- Write Data to RAM Command Req
      i_rd_data        : in std_logic;  -- Read Data from RAM Command Req
      i_data_bus       : in std_logic_vector(7 downto 0);  -- Write data bus

      o_lcd_rdata : out std_logic_vector(7 downto 0);
      o_done      : out std_logic;      -- Done received

      -- LCD ITF
      i_lcd_rdata    : in  std_logic_vector(7 downto 0);
      i_lcd_itf_done : in  std_logic;
      o_rs           : out std_logic;
      o_rw           : out std_logic;
      o_lcd_wdata    : out std_logic_vector(7 downto 0);
      o_start        : out std_logic

      );

  end component lcd_cfah_cmd_generator;


  component lcd_cfah_cmd_buffer is

    generic (
      G_NB_CMD : integer := 11);        -- Number of possible Command

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      i_init_ongoing : in std_logic;

      -- Commands from specific block
      i_clear_display : in std_logic;   -- Clear Display Cmd request
      i_return_home   : in std_logic;   -- Return Home Cmd Request

      i_entry_mode_set : in std_logic;  -- Entry Mode Set Cmd Request
      i_id_sh          : in std_logic_vector(1 downto 0);  -- Bits Control

      i_display_ctrl : in std_logic;    -- Display ON/OFF Ctrl Cmd Req
      i_dcb          : in std_logic_vector(2 downto 0);  -- Control bits

      i_cursor_display_shift : in std_logic;  -- Cursor Display Shift Cmd Req
      i_sc_rl                : in std_logic_vector(1 downto 0);  -- Cursor Display Bits control

      i_function_set   : in std_logic;  -- Function Set cmd Req
      i_set_gcram_addr : in std_logic;  -- Set CGRAM Address Command Req
      i_set_ddram_addr : in std_logic;  -- Set DDRAM Address Command Req
      i_read_busy_flag : in std_logic;  -- Read Busy Flag and Addr command Req
      i_wr_data        : in std_logic;  -- Write Data to RAM Command Req
      i_rd_data        : in std_logic;  -- Read Data from RAM Command Req
      i_data_bus       : in std_logic_vector(7 downto 0);  -- Write data bus


      i_cmd_done : in  std_logic;       -- Command Done
      o_cmd_done : out std_logic;       -- Command Done

      i_lcd_rdata : in  std_logic_vector(7 downto 0);  -- LCD RDATA from cmd_generator
      o_lcd_rdata : out std_logic_vector(7 downto 0);  -- Re pipe rdata

      -- Outputs to Commands Generator
      o_cmd_req  : out std_logic;       -- Command Request
      o_cmd      : out std_logic_vector(G_NB_CMD - 1 downto 0);  -- Command bus
      o_id_sh    : out std_logic_vector(1 downto 0);  -- Bits Control
      o_dcb      : out std_logic_vector(2 downto 0);  -- Control bits
      o_sc_rl    : out std_logic_vector(1 downto 0);  -- Cursor Display Bits control 
      o_data_bus : out std_logic_vector(7 downto 0);  -- Write data bus

      -- BUSY SCROLLER I/F
      i_lcd_rdy    : in  std_logic;     -- LCD Ready
      o_start_poll : out std_logic      -- Start Polling command

      );

  end component lcd_cfah_cmd_buffer;


  component lcd_cfah_top is
    generic (
      G_CLK_PERIOD_NS      : integer   := 20;  -- Clock Period in ns
      G_BIDIR_SEL_POLARITY : std_logic := '0'  -- BIDIR SEL Polarity
      );
    port (
      clk   : in std_logic;                    -- Clock
      rst_n : in std_logic;                    -- Asynchronous Reset

      i_lcd_on : in std_logic;          -- LCD On control
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

  end component lcd_cfah_top;


  -- == END COMPONENTS ==

end package pkg_lcd_cfah;

package body pkg_lcd_cfah is

  -- Convert a clock period in [ns] to a number of period
  function clk_period_to_max(i_clk_period : integer; i_duration : integer)
    return integer is

    -- Internal Variables
    variable v_results : integer := 0;
  begin
    v_results := i_duration / i_clk_period;
    if(v_results = 0) then
      v_results := 1;                   -- One TCLK minimum
    end if;
    return v_results;
  end function clk_period_to_max;


end package body pkg_lcd_cfah;
