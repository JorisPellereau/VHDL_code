library ieee;
use ieee.std_logic_1164.all;


-- Import Types and Fucntions
library lib_CFAH1602;
use lib_CFAH1602.pkg_lcd_cfah_types_and_func.all;


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


  -- == CHARACTER ROM ADDR ==
  constant C_A_CHAR_ADDR : std_logic_vector(7 downto 0) := x"41";  -- A
  constant C_B_CHAR_ADDR : std_logic_vector(7 downto 0) := x"42";  -- B
  constant C_C_CHAR_ADDR : std_logic_vector(7 downto 0) := x"43";  -- C
  constant C_D_CHAR_ADDR : std_logic_vector(7 downto 0) := x"44";  -- D
  constant C_E_CHAR_ADDR : std_logic_vector(7 downto 0) := x"45";  -- E
  constant C_F_CHAR_ADDR : std_logic_vector(7 downto 0) := x"46";  -- F
  constant C_G_CHAR_ADDR : std_logic_vector(7 downto 0) := x"47";  -- G
  constant C_H_CHAR_ADDR : std_logic_vector(7 downto 0) := x"48";  -- H
  constant C_I_CHAR_ADDR : std_logic_vector(7 downto 0) := x"49";  -- I
  constant C_J_CHAR_ADDR : std_logic_vector(7 downto 0) := x"4A";  -- J
  constant C_K_CHAR_ADDR : std_logic_vector(7 downto 0) := x"4B";  -- K
  constant C_L_CHAR_ADDR : std_logic_vector(7 downto 0) := x"4C";  -- L
  constant C_M_CHAR_ADDR : std_logic_vector(7 downto 0) := x"4D";  -- M
  constant C_N_CHAR_ADDR : std_logic_vector(7 downto 0) := x"4E";  -- N
  constant C_O_CHAR_ADDR : std_logic_vector(7 downto 0) := x"4F";  -- O
  constant C_P_CHAR_ADDR : std_logic_vector(7 downto 0) := x"50";  -- P
  constant C_Q_CHAR_ADDR : std_logic_vector(7 downto 0) := x"51";  -- Q
  constant C_R_CHAR_ADDR : std_logic_vector(7 downto 0) := x"52";  -- R
  constant C_S_CHAR_ADDR : std_logic_vector(7 downto 0) := x"53";  -- S
  constant C_T_CHAR_ADDR : std_logic_vector(7 downto 0) := x"54";  -- T
  constant C_U_CHAR_ADDR : std_logic_vector(7 downto 0) := x"55";  -- U
  constant C_V_CHAR_ADDR : std_logic_vector(7 downto 0) := x"56";  -- V
  constant C_W_CHAR_ADDR : std_logic_vector(7 downto 0) := x"57";  -- W
  constant C_X_CHAR_ADDR : std_logic_vector(7 downto 0) := x"58";  -- X
  constant C_Y_CHAR_ADDR : std_logic_vector(7 downto 0) := x"59";  -- Y
  constant C_Z_CHAR_ADDR : std_logic_vector(7 downto 0) := x"5A";  -- Z

  constant C_UNDSCR_CHAR_ADDR       : std_logic_vector(7 downto 0) := x"5F";  -- _
  constant C_SINGLE_QUOTE_CHAR_ADDR : std_logic_vector(7 downto 0) := x"27";  -- '
  constant C_SPACE_CHAR_ADDR        : std_logic_vector(7 downto 0) := x"20";

  -- Lines Buffer Constants
  constant C_LINES_ARRAY_INIT : t_lines_array := (0 => C_B_CHAR_ADDR,  -- Position 0_0 :
                                                  1 => C_O_CHAR_ADDR,
                                                  2 => C_N_CHAR_ADDR,
                                                  3 => C_J_CHAR_ADDR,
                                                  4 => C_O_CHAR_ADDR,
                                                  5 => C_U_CHAR_ADDR,
                                                  6 => C_R_CHAR_ADDR,

                                                  7 => C_SPACE_CHAR_ADDR,

                                                  8 => C_J_CHAR_ADDR,
                                                  9 => C_E_CHAR_ADDR,

                                                  10 => C_SPACE_CHAR_ADDR,

                                                  11 => C_C_CHAR_ADDR,
                                                  12 => C_R_CHAR_ADDR,
                                                  13 => C_O_CHAR_ADDR,
                                                  14 => C_I_CHAR_ADDR,
                                                  15 => C_S_CHAR_ADDR,

                                                  16 => C_Q_CHAR_ADDR,
                                                  17 => C_U_CHAR_ADDR,
                                                  18 => C_E_CHAR_ADDR,

                                                  19 => C_SPACE_CHAR_ADDR,

                                                  20 => C_C_CHAR_ADDR,
                                                  21 => C_SINGLE_QUOTE_CHAR_ADDR,
                                                  22 => C_E_CHAR_ADDR,
                                                  23 => C_S_CHAR_ADDR,
                                                  24 => C_T_CHAR_ADDR,

                                                  25 => C_SPACE_CHAR_ADDR,

                                                  26     => C_B_CHAR_ADDR,
                                                  27     => C_O_CHAR_ADDR,
                                                  28     => C_N_CHAR_ADDR,
                                                  29     => x"7E",
                                                  30     => x"EF",
                                                  31     => x"7F",
                                                  others => C_SPACE_CHAR_ADDR
                                                  );


  -- CGRAM Character patterns
  constant C_CGRAM_5x8_PATTERN_HEART_EMPTY_0 : t_cgram_pattern_5x8_array := (0 => "0" & x"0",
                                                                             1 => "0" & x"A",
                                                                             2 => "1" & x"5",
                                                                             3 => "1" & x"1",
                                                                             4 => "0" & x"A",
                                                                             5 => "0" & x"4",
                                                                             6 => "0" & x"0",
                                                                             7 => "0" & x"0");

  constant C_CGRAM_5x8_PATTERN_HEART_EMPTY_1 : t_cgram_pattern_5x8_array := (0 => "0" & x"0",
                                                                             1 => "0" & x"A",
                                                                             2 => "1" & x"5",
                                                                             3 => "1" & x"1",
                                                                             4 => "1" & x"1",
                                                                             5 => "0" & x"A",
                                                                             6 => "0" & x"4",
                                                                             7 => "0" & x"0");

  constant C_CGRAM_5x8_PATTERN_HEART_EMPTY_2 : t_cgram_pattern_5x8_array := (0 => "0" & x"0",
                                                                             1 => "0" & x"A",
                                                                             2 => "1" & x"F",
                                                                             3 => "1" & x"B",
                                                                             4 => "0" & x"E",
                                                                             5 => "0" & x"4",
                                                                             6 => "0" & x"0",
                                                                             7 => "0" & x"0");

  constant C_CGRAM_5x8_PATTERN_HEART_FULL_0 : t_cgram_pattern_5x8_array := (0 => "0" & x"0",
                                                                            1 => "0" & x"A",
                                                                            2 => "1" & x"F",
                                                                            3 => "1" & x"F",
                                                                            4 => "0" & x"E",
                                                                            5 => "0" & x"4",
                                                                            6 => "0" & x"0",
                                                                            7 => "0" & x"0");

  constant C_CGRAM_5x8_PATTERN_ET_0 : t_cgram_pattern_5x8_array := (0 => "0" & x"E",
                                                                    1 => "0" & x"A",
                                                                    2 => "0" & x"E",
                                                                    3 => "0" & x"4",
                                                                    4 => "1" & x"F",
                                                                    5 => "0" & x"4",
                                                                    6 => "0" & x"A",
                                                                    7 => "1" & x"B");


  constant C_CGRAM_5x8_PATTERN_ET_1 : t_cgram_pattern_5x8_array := (0 => "0" & x"4",
                                                                    1 => "0" & x"E",
                                                                    2 => "1" & x"F",
                                                                    3 => "0" & x"4",
                                                                    4 => "0" & x"4",
                                                                    5 => "0" & x"E",
                                                                    6 => "0" & x"A",
                                                                    7 => "1" & x"B");


  constant C_CGRAM_5x8_PATTERN_ET_2 : t_cgram_pattern_5x8_array := (0 => "1" & x"5",
                                                                    1 => "0" & x"A",
                                                                    2 => "0" & x"A",
                                                                    3 => "0" & x"E",
                                                                    4 => "0" & x"E",
                                                                    5 => "0" & x"A",
                                                                    6 => "0" & x"A",
                                                                    7 => "1" & x"5");


  constant C_CGRAM_5x8_PATTERN_ET_3 : t_cgram_pattern_5x8_array := (0 => "0" & x"E",
                                                                    1 => "1" & x"1",
                                                                    2 => "0" & x"E",
                                                                    3 => "0" & x"4",
                                                                    4 => "1" & x"5",
                                                                    5 => "0" & x"E",
                                                                    6 => "0" & x"A",
                                                                    7 => "1" & x"1");

  constant C_CGRAM_INIT : t_cgram_array := create_cgram_init(C_CGRAM_5x8_PATTERN_ET_3,
                                                             C_CGRAM_5x8_PATTERN_ET_3,
                                                             C_CGRAM_5x8_PATTERN_ET_3,
                                                             C_CGRAM_5x8_PATTERN_ET_3,
                                                             C_CGRAM_5x8_PATTERN_ET_3,
                                                             C_CGRAM_5x8_PATTERN_ET_3,
                                                             C_CGRAM_5x8_PATTERN_ET_3,
                                                             C_CGRAM_5x8_PATTERN_ET_3);

  constant C_CGRAM_INIT_2 : t_cgram_array_2 := (0 => C_CGRAM_5x8_PATTERN_ET_3,
                                                1 => C_CGRAM_5x8_PATTERN_ET_3,
                                                2 => C_CGRAM_5x8_PATTERN_ET_3,
                                                3 => C_CGRAM_5x8_PATTERN_ET_3,
                                                4 => C_CGRAM_5x8_PATTERN_ET_3,
                                                5 => C_CGRAM_5x8_PATTERN_ET_3,
                                                6 => C_CGRAM_5x8_PATTERN_ET_3,
                                                7 => C_CGRAM_5x8_PATTERN_ET_3);




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

      i_cmd_done              : in  std_logic;  -- Command done
      o_function_set_cmd      : out std_logic;  -- Function Set command
      o_display_ctrl          : out std_logic;  -- Display Control Command
      o_entry_mode_set        : out std_logic;  -- Entry Mode set command
      o_clear_display         : out std_logic;  -- Clear Display
      o_init_ongoing          : out std_logic;  -- Init. ongoing
      o_power_on_init_ongoing : out std_logic;  -- Power On init ongoing
      o_init_done             : out std_logic   -- Initialization Done
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
      o_poll_ongoing   : out std_logic;  -- Polling ongoing
      o_lcd_rdy        : out std_logic   -- LCD Ready when rise
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

      o_control_done : out std_logic;   -- Command done

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

  component lcd_cfah_update_display is

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      i_update_lcd        : in std_logic;  -- Update LCD Command
      i_lcd_all_char      : in std_logic;  -- All Char or One char selection
      i_lcd_line_sel      : in std_logic;  -- Line 0 or 1 selection
      i_lcd_char_position : in std_logic_vector(3 downto 0);  -- Character position selection

      -- Command Done
      i_cmd_done : in std_logic;        -- Command done from Command buffer

      -- LCD Commands
      o_set_ddram_addr     : out std_logic;  -- SET DDRAM ADDR Command
      o_wr_data            : out std_logic;  -- Write data to RAM command
      o_ddram_data_or_addr : out std_logic_vector(7 downto 0);  -- Data or Addr bus

      -- LINE BUFFER I/F
      i_rdata       : in  std_logic_vector(7 downto 0);  -- Line RDATA
      i_rdata_val   : in  std_logic;                     -- Line RDATA Valid
      o_rd_req      : out std_logic;                     -- Read Request
      o_rd_char_pos : out std_logic_vector(3 downto 0);  -- Char Position
      o_rd_line_sel : out std_logic;                     -- Line selection

      o_update_ongoing : out std_logic;  -- Update ongoing flag

      -- LCD Update done flag
      o_update_done : out std_logic     -- LCD Update Done

      );

  end component lcd_cfah_update_display;


  component lcd_cfah_lines_buffer is

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous reset

      i_wdata         : in std_logic_vector(7 downto 0);  -- Data character
      i_wdata_val     : in std_logic;                     -- Data valid
      i_char_position : in std_logic_vector(3 downto 0);  -- Character number
      i_line_sel      : in std_logic;                     -- Line Selection

      i_rd_req           : in  std_logic;  -- Read Request
      i_rd_char_position : in  std_logic_vector(3 downto 0);  -- Character number
      i_rd_line_sel      : in  std_logic;  -- Line selection for Read port
      o_rdata            : out std_logic_vector(7 downto 0);  -- Rdata
      o_rdata_val        : out std_logic;  -- Rdata valid

      o_read_busy : out std_logic       -- Busy

      );

  end component lcd_cfah_lines_buffer;


  component lcd_cfah_cgram_buffer is

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous reset

      i_cgram_wdata     : in std_logic_vector(4 downto 0);  -- Data character
      i_cgram_wdata_val : in std_logic;                     -- Data valid   
      i_cgram_addr      : in std_logic_vector(6 downto 0);  --CGRAM ADDR

      i_rd_req        : in std_logic;                     -- Read Request
      i_rd_cgram_addr : in std_logic_vector(6 downto 0);  -- Character Address

      o_cgram_rdata     : out std_logic_vector(4 downto 0);  -- Rdata
      o_cgram_rdata_val : out std_logic;                     -- Rdata valid

      o_read_busy : out std_logic       -- Busy
      );

  end component lcd_cfah_cgram_buffer;


  component lcd_cfah_update_cgram is

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      i_font_type : in std_logic;  -- Font type Configuration (5*8 or 5*10)

      i_update_cgram        : in std_logic;  -- Update CGRAM Command
      i_cgram_all_char      : in std_logic;  -- All Char or One char selection  
      i_cgram_char_position : in std_logic_vector(2 downto 0);  -- Character position selection

      -- Command Done
      i_cmd_done : in std_logic;        -- Command done from Command buffer

      -- LCD Commands
      o_set_cgram_addr     : out std_logic;  -- SET CGRAM ADDR Command
      o_wr_data            : out std_logic;  -- Write data to RAM command
      o_cgram_data_or_addr : out std_logic_vector(7 downto 0);  -- Data or Addr bus

      -- LINE BUFFER I/F
      i_cgram_rdata     : in  std_logic_vector(4 downto 0);  -- CGRAM one line RDATA
      i_cgram_rdata_val : in  std_logic;  -- CGRAM one Line RDATA Valid
      o_rd_req          : out std_logic;  -- Read Request
      o_cgram_addr      : out std_logic_vector(6 downto 0);  -- Char Position

      o_update_ongoing : out std_logic;  -- CGRAM Update ongoing flag

      -- CGRAM Update done flag
      o_update_done : out std_logic     -- CGRAM Update Done

      );

  end component lcd_cfah_update_cgram;


  -- == END COMPONENTS ==

end package pkg_lcd_cfah;

package body pkg_lcd_cfah is




end package body pkg_lcd_cfah;
