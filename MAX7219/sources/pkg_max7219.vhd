-------------------------------------------------------------------------------
-- Title      : MAX7219 package
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_max7219.vhd
-- Author     :   <pellereau@D-R81A4E3>
-- Company    : 
-- Created    : 2019-07-19
-- Last update: 2020-09-26
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the package for the Max7219 component
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-07-19  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package pkg_max7219 is

  -- SYSTEM clock : 50MHz : 20 ns
  -- CLK frequency : 5MHz (10MHz max)

  -- == MAX7219_interface CONSTANTS ==
  constant C_T_CLK    : integer := 10;      -- 50MHz/5MHz = 10
  constant C_T_2_sclk : integer := 10 / 2;  -- Half Period of CLK
  -- =================================

  -- == MAX7219_controller TYPES & CONSTANTS ==
  constant C_CFG_NB          : integer := 3;  -- Number of configuration
  constant C_DIGIT_NB        : integer := 8;  -- Number of digits in a matrix
  constant C_MATRIX_NB       : integer := 8;  -- Number of 8x8 matrix
  constant C_MATRIX_SEL_SIZE : integer := integer(LOG2(real(C_MATRIX_NB)));  -- Size of the selector

  constant C_NO_OP_ADDR : std_logic_vector(7 downto 0) := x"00";  -- No operation addr register

  constant C_DIGIT_0_ADDR : std_logic_vector(7 downto 0) := x"01";  -- Digit 0 addr register
  constant C_DIGIT_1_ADDR : std_logic_vector(7 downto 0) := x"02";  -- Digit 1 addr register
  constant C_DIGIT_2_ADDR : std_logic_vector(7 downto 0) := x"03";  -- Digit 2 addr register
  constant C_DIGIT_3_ADDR : std_logic_vector(7 downto 0) := x"04";  -- Digit 3 addr register
  constant C_DIGIT_4_ADDR : std_logic_vector(7 downto 0) := x"05";  -- Digit 4 addr register
  constant C_DIGIT_5_ADDR : std_logic_vector(7 downto 0) := x"06";  -- Digit 5 addr register
  constant C_DIGIT_6_ADDR : std_logic_vector(7 downto 0) := x"07";  -- Digit 6 addr register
  constant C_DIGIT_7_ADDR : std_logic_vector(7 downto 0) := x"08";  -- Digit 7 addr register

  constant C_DECODE_MODE_ADDR  : std_logic_vector(7 downto 0) := x"09";  -- Decode mode address register
  constant C_INTENSITY_ADDR    : std_logic_vector(7 downto 0) := x"0A";  -- Inensity addr register
  constant C_SCAN_LIMIT_ADDR   : std_logic_vector(7 downto 0) := x"0B";  -- Scan limit addr register
  constant C_SHUTDOWN_ADDR     : std_logic_vector(7 downto 0) := x"0C";  -- Shutdown addr register
  constant C_DISPLAY_TEST_ADDR : std_logic_vector(7 downto 0) := x"0F";  -- Display test addr register

  type t_max7219_ctrl_fsm is (IDLE, SET_CFG, DISPLAY_ON, DISPLAY_OFF, TEST_DISPLAY_ON, TEST_DISPLAY_OFF, SET_DISPLAY, SEND_NOP);  -- States of the MAX7219 Controller
  -- ==================================


  -- == PATTERN_SELECTOR TYPES & CONSTANTS ==
  type t_matrix_8x8 is array (0 to 7) of std_logic_vector(7 downto 0);  -- Array of bytes for the matrix

  constant C_MATRIX_0 : t_matrix_8x8 := (0 => x"00", 1 => x"7E", 2 => x"C3", 3 => x"81", 4 => x"81", 5 => x"81", 6 => x"7E", 7 => x"00");  -- Display 0
  constant C_MATRIX_1 : t_matrix_8x8 := (0 => x"10", 1 => x"20", 2 => x"41", 3 => x"FF", 4 => x"01", 5 => x"01", 6 => x"00", 7 => x"00");  -- Display 1
  constant C_MATRIX_2 : t_matrix_8x8 := (0 => x"00", 1 => x"61", 2 => x"83", 3 => x"85", 4 => x"89", 5 => x"89", 6 => x"01", 7 => x"00");  -- Display 2
  constant C_MATRIX_3 : t_matrix_8x8 := (0 => x"00", 1 => x"42", 2 => x"81", 3 => x"81", 4 => x"89", 5 => x"89", 6 => x"6E", 7 => x"00");  -- Display 3
  constant C_MATRIX_4 : t_matrix_8x8 := (0 => x"00", 1 => x"1C", 2 => x"24", 3 => x"44", 4 => x"8F", 5 => x"8F", 6 => x"00", 7 => x"00");  -- Display 4
  constant C_MATRIX_5 : t_matrix_8x8 := (0 => x"00", 1 => x"F2", 2 => x"91", 3 => x"91", 4 => x"91", 5 => x"91", 6 => x"9E", 7 => x"00");  -- Display 5
  constant C_MATRIX_6 : t_matrix_8x8 := (0 => x"00", 1 => x"3E", 2 => x"51", 3 => x"91", 4 => x"91", 5 => x"91", 6 => x"0E", 7 => x"00");  -- Display 6
  constant C_MATRIX_7 : t_matrix_8x8 := (0 => x"00", 1 => x"80", 2 => x"8F", 3 => x"90", 4 => x"90", 5 => x"90", 6 => x"C0", 7 => x"00");  -- Display 7
  constant C_MATRIX_8 : t_matrix_8x8 := (0 => x"00", 1 => x"6E", 2 => x"91", 3 => x"91", 4 => x"91", 5 => x"91", 6 => x"6E", 7 => x"00");  -- Display 8
  constant C_MATRIX_9 : t_matrix_8x8 := (0 => x"00", 1 => x"62", 2 => x"91", 3 => x"91", 4 => x"91", 5 => x"91", 6 => x"7E", 7 => x"00");  -- Display 9
  -- =======================================

  type t_score_array is array (0 to 63) of std_logic_vector(15 downto 0);   --
  type t_msg_array is array (0 to 63) of std_logic_vector(15 downto 0);
  type t_config_array is array (0 to 31) of std_logic_vector(15 downto 0);  -- Config ARRAY


  type t_msg2scroll_array is array(integer range <>) of std_logic_vector(15 downto 0);


  -- COMPONENTS
  component max7219_interface
    port (
      clk            : in  std_logic;   -- System clock
      rst_n          : in  std_logic;   -- Asynchronous active low reset
      i_max7219_data : in  std_logic_vector(15 downto 0);  -- Data to send te the Max7219
      i_start        : in  std_logic;   -- Start the transaction
      i_en_load      : in  std_logic;   -- Enable the generation of o_load
      o_load_max7219 : out std_logic;   -- LOAD command
      o_data_max7219 : out std_logic;   -- DATA to send th
      o_clk_max7219  : out std_logic;   -- CLK
      o_max7219_done : out std_logic);  -- Frame done
  end component;

  component max7219_controller is
    port (
      clock_i   : in std_logic;         -- System clock
      reset_n_i : in std_logic;         -- Asynchonous Active Low

      -- From MAX7219 interface
      frame_done_i : in std_logic;  -- Frame done from the MAX7219 interface

      test_display_i      : in std_logic;  -- Test the display
      update_display_i    : in std_logic;  -- Update the display
      pattern_available_i : in std_logic;  -- Pattern available

      -- Matrix selector
      matrix_sel_i : in std_logic_vector(C_MATRIX_SEL_SIZE - 1 downto 0);

      -- Config inputs
      start_config_i     : in std_logic;  -- Start the config of the MAX7219
      decode_mode_i      : in std_logic_vector(1 downto 0);  -- Decode mode (0x0 - 0x1 - 0x2 - 0x3)
      intensity_format_i : in std_logic_vector(3 downto 0);  -- Intensity format
      scan_limit_i       : in std_logic_vector(2 downto 0);  -- Scan limit config

      -- Config Digits
      digit_0_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
      digit_1_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
      digit_2_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
      digit_3_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
      digit_4_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
      digit_5_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
      digit_6_i : in std_logic_vector(7 downto 0);  -- Digit 0 data
      digit_7_i : in std_logic_vector(7 downto 0);  -- Digit 0 data


      -- Flags
      config_done_o  : out std_logic;   -- Config is done
      display_on_o   : out std_logic;   -- State of the display 1 : on 0 : off
      display_test_o : out std_logic;   -- 1 : Display in test mode
      update_done_o  : out std_logic;   -- Display Update terminated

      -- To MAX7219 interface
      wdata_o       : out std_logic_vector(15 downto 0);  -- Data bus                                        
      start_frame_o : out std_logic;    -- Start a frame
      en_load_o     : out std_logic);   -- Enable the LOAD generation
  end component;

  component pattern_selector is
    port (
      clock_i             : in  std_logic;   -- System clock
      reset_n_i           : in  std_logic;   -- Active low asynchronous reset
      en_i                : in  std_logic;   -- Enable
      sel_i               : in  std_logic_vector(15 downto 0);  -- Selector
      digit_0_o           : out std_logic_vector(7 downto 0);  -- Digit 0 pattern
      digit_1_o           : out std_logic_vector(7 downto 0);  -- Digit 1 pattern
      digit_2_o           : out std_logic_vector(7 downto 0);  -- Digit 2 pattern
      digit_3_o           : out std_logic_vector(7 downto 0);  -- Digit 3 pattern
      digit_4_o           : out std_logic_vector(7 downto 0);  -- Digit 4 pattern
      digit_5_o           : out std_logic_vector(7 downto 0);  -- Digit 5 pattern
      digit_6_o           : out std_logic_vector(7 downto 0);  -- Digit 6 pattern
      digit_7_o           : out std_logic_vector(7 downto 0);  -- Digit 7 pattern
      pattern_available_o : out std_logic);  -- Pattern avaiable
  end component;



  -- == MAX7219 CMD DECODER COMPONENT ==

  component max7219_if is
    generic (
      G_MAX_HALF_PERIOD : integer := 4;  -- 4 => 6.25MHz with 50MHz input
      G_LOAD_DURATION   : integer := 4   -- LOAD DURATION in clk_in period
      );
    port (
      clk   : in std_logic;              -- System clock
      rst_n : in std_logic;              -- Asynchronous active low reset

      -- Input commands
      i_start   : in std_logic;         -- Start the transaction
      i_en_load : in std_logic;         -- Enable the generation of o_load
      i_data    : in std_logic_vector(15 downto 0);  -- Data to send te the Max7219

      -- MAX7219 I/F
      o_max7219_load : out std_logic;   -- LOAD command
      o_max7219_data : out std_logic;   -- DATA to send
      o_max7219_clk  : out std_logic;   -- CLK

      -- Transaction Done
      o_done : out std_logic);          -- Frame done
  end component;


  component max7219_ram_decod is
    generic (
      G_RAM_ADDR_WIDTH : integer                       := 8;  -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH : integer                       := 16;  -- RAM DATA WIDTH
      G_MAX_CNT_32B    : std_logic_vector(31 downto 0) := x"02FAF080");  -- MAX CNT

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous reset
      i_en  : in std_logic;             -- Enable the Function

      -- RAM I/F
      o_me    : out std_logic;          -- MEMORY ENABLE
      o_we    : out std_logic;          -- W/R COMMAND
      o_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
      i_rdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA

      -- RAM INFO.
      i_start_ptr    : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- ST ADDR
      i_last_ptr     : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- LAST ADDR
      i_ptr_val      : in  std_logic;   -- PTRS VALIDS
      i_loop         : in  std_logic;   -- LOOP CONFIG.
      o_ptr_equality : out std_logic;   -- ADDR = LAST PTR    

      -- MAX7219 I/F
      o_start   : out std_logic;                      -- MAX7219 START
      o_en_load : out std_logic;                      -- MAX7219 EN LOAD
      o_data    : out std_logic_vector(15 downto 0);  -- MAX7219 DATA
      i_done    : in  std_logic);                     -- MAX7219 DONE
  end component max7219_ram_decod;


  component max7219_cmd_decod is
    -- generic (
    --   G_RAM_ADDR_WIDTH             : integer                       := 8;  -- RAM ADDR WIDTH
    --   G_RAM_DATA_WIDTH             : integer                       := 16;  -- RAM DATA WIDTH
    --   G_DECOD_MAX_CNT_32B          : std_logic_vector(31 downto 0) := x"02FAF080";
    --   G_MAX7219_IF_MAX_HALF_PERIOD : integer                       := 50;  -- MAX HALF PERIOD for MAX729 CLK generation
    --   G_MAX7219_LOAD_DUR           : integer                       := 4);  -- MAX7219 LOAD duration in period of clk

    -- port (
    --   clk     : in  std_logic;          -- Clock
    --   rst_n   : in  std_logic;          -- Asynchronous reset
    --   i_en    : in  std_logic;          -- Enable the Function
    --   -- RAM I/F
    --   i_me    : in  std_logic;          -- Memory Enable
    --   i_we    : in  std_logic;          -- W/R command
    --   i_addr  : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
    --   i_wdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM WDATA
    --   o_rdata : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA

    --   -- RAM INFO.
    --   i_start_ptr    : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- ST PTR
    --   i_last_ptr     : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- LAST ADDR
    --   i_ptr_val      : in  std_logic;   -- PTRS VALIDS
    --   i_loop         : in  std_logic;   -- LOOP CONFIG.
    --   o_ptr_equality : out std_logic;   -- ADDR = LAST PTR

    --   -- MAX7219 I/F
    --   o_max7219_load : out std_logic;   -- MAX7219 LOAD
    --   o_max7219_data : out std_logic;   -- MAX7219 DATA
    --   o_max7219_clk  : out std_logic);  -- MAX7219 CLK




    generic (
    G_RAM_ADDR_WIDTH    : integer                       := 8;  -- RAM ADDR WIDTH
    G_RAM_DATA_WIDTH    : integer                       := 16;  -- RAM DATA WIDTH
    G_DECOD_MAX_CNT_32B : std_logic_vector(31 downto 0) := x"02FAF080");
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous reset
    i_en  : in std_logic;               -- Enable the Function

    -- RAM I/F
    i_me    : in  std_logic;            -- Memory Enable
    i_we    : in  std_logic;            -- W/R command
    i_addr  : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
    i_wdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM WDATA
    o_rdata : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA

    -- RAM INFO.
    i_start_ptr    : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- ST PTR
    i_last_ptr     : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- LAST ADDR
    i_ptr_val      : in  std_logic;     -- PTRS VALIDS
    i_loop         : in  std_logic;     -- LOOP CONFIG.
    o_ptr_equality : out std_logic;     -- ADDR = LAST PTR

    -- MAX7219 I/F
    i_max7219_if_done    : in  std_logic;  -- MAX7219 IF Done
    o_max7219_if_start   : out std_logic;
    o_max7219_if_en_load : out std_logic;
    o_max7219_if_data    : out std_logic_vector(15 downto 0));

    
  end component max7219_cmd_decod;

  -- ===============


  component max7219_digit2conf is

    port (
      clk     : in  std_logic;                      -- Clock
      rst_n   : in  std_logic;                      -- Asynchronous reset
      i_digit : in  std_logic_vector(3 downto 0);   -- DIGIT to DECOD
      i_val   : in  std_logic;
      o_seg_7 : out std_logic_vector(11 downto 0);  -- Config. Seg N7
      o_seg_6 : out std_logic_vector(11 downto 0);  -- Config. Seg N6
      o_seg_5 : out std_logic_vector(11 downto 0);  -- Config. Seg N5
      o_seg_4 : out std_logic_vector(11 downto 0);  -- Config. Seg N4
      o_seg_3 : out std_logic_vector(11 downto 0);  -- Config. Seg N3
      o_seg_2 : out std_logic_vector(11 downto 0);  -- Config. Seg N2
      o_seg_1 : out std_logic_vector(11 downto 0);  -- Config. Seg N1
      o_seg_0 : out std_logic_vector(11 downto 0);  -- Config. Seg N0
      o_done  : out std_logic                       -- Conf Available
      );
  end component max7219_digit2conf;




  component max7219_cmd_organizer is

    generic (
      G_RAM_DATA_WIDTH : integer              := 16;  -- RAM DATA SIZE
      G_DIGITS_NB      : integer range 2 to 8 := 8);  -- DIGITS Number on the DISPLAY

    port (
      clk               : in  std_logic;      -- Clock
      rst_n             : in  std_logic;      -- Asynchronous reset
      i_score_decod     : in  std_logic_vector(G_DIGITS_NB*4 - 1 downto 0);  -- SCORE DECODED
      i_score_decod_val : in  std_logic;      -- SCORE DECOD valid
      o_score_cmd       : out t_score_array;  -- ARRAY of SCORE
      o_score_val       : out std_logic
      );

  end component max7219_cmd_organizer;

  component max7219_ram_sequencer is
    generic (
      G_RAM_ADDR_WIDTH : integer              := 8;   -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH : integer              := 16;  -- RAM DATA WIDTH
      G_DIGITS_NB      : integer range 2 to 8 := 2  --DIGIR NB on THE MATRIX DISPLAY
      );
    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      -- CONFIG. MATRIX I/F
      i_config_array      : in  t_config_array;  -- CONFIG. Matrix
      i_config_val        : in  std_logic;       -- CONFIG. Matrix valid
      i_config_start_addr : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
      o_config_last_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
      o_config_done       : out std_logic;       -- CONFIG. IN RAM DONE

      -- SCORE I/F
      i_score_cmd        : in  t_score_array;  -- Score Command
      i_score_val        : in  std_logic;      -- Score Command Valid
      i_score_start_addr : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
      o_score_last_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
      o_score_done       : out std_logic;      -- SCORE IN RAM DONE

      -- MESSAGE I/F
      i_msg            : in  t_msg_array;  -- Message
      i_msg_val        : in  std_logic;    -- Message Valid
      i_msg_start_addr : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
      o_msg_last_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
      o_msg_done       : out std_logic;    -- SCORE IN RAM DONE

      -- RAM I/F
      o_me    : out std_logic;          -- Memory Enable
      o_we    : out std_logic;          -- W/R Memory Command
      o_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
      o_wdata : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM WDATA
      i_rdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0)  -- RAM RDATA
      );
  end component max7219_ram_sequencer;


  component max7219_config_matrix is

    generic (
      G_DIGITS_NB      : integer range 2 to 8 := 8;  -- DIGIT NB on THE MATRIX DISPLAY
      G_RAM_DATA_WIDTH : integer              := 16);         -- RAM DATA WIDTH
    port (
      clk                : in  std_logic;            -- Clock
      rst_n              : in  std_logic;            -- Asynchronous Reset
      i_decod_mode       : in  std_logic_vector(7 downto 0);  -- DECOD MODE
      i_intensity        : in  std_logic_vector(7 downto 0);  -- INTENSITY
      i_scan_limit       : in  std_logic_vector(7 downto 0);  -- SCAN LIMIT
      i_shutdown         : in  std_logic_vector(7 downto 0);  -- SHUTDOWN MODE
      i_config_val       : in  std_logic;            -- Config. Valid
      o_config_array     : out t_config_array;       -- CONFIG. ARRAY CMD
      o_config_array_val : out std_logic);           -- CONFIG ARRAY VAL

  end component max7219_config_matrix;

  component max7219_display_manager is
    generic (
      G_DIGITS_NB      : integer range 2 to 8 := 8;  -- DIGIT NB on the MATRIX DISPLAY
      G_RAM_ADDR_WIDTH : integer              := 8);  -- RAM ADDR WIDTH

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      -- NEW CONFIG.
      i_config_val        : in std_logic;  -- New Config Available
      i_config_start_addr : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
      i_config_last_addr  : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);

      i_score_val        : in std_logic;  -- New SCORE available
      i_score_start_addr : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
      i_score_last_addr  : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);

      i_msg_val        : in  std_logic;  -- New Message available
      i_msg_start_addr : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
      i_msg_last_addr  : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
      -- MAX7219 RAM DECOD I/F
      i_ptr_equality   : in  std_logic;  -- PTR EQUALITY
      o_start_ptr      : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- START PTR
      o_last_ptr       : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- LAST PTR
      o_ptr_val        : out std_logic;  -- PTR VALID
      o_loop           : out std_logic;  -- LOOP MODE
      o_en             : out std_logic  -- ENABLE CMD DECOD BLOCK
      );

  end component max7219_display_manager;





  component max7219_digit2letter is
    port (
      clk      : in  std_logic;                      -- Clock
      rst_n    : in  std_logic;                      -- Asynchronous reset
      i_letter : in  std_logic_vector(7 downto 0);   -- Letter to decod
      i_val    : in  std_logic;
      o_seg_7  : out std_logic_vector(11 downto 0);  -- Config. Seg N7
      o_seg_6  : out std_logic_vector(11 downto 0);  -- Config. Seg N6
      o_seg_5  : out std_logic_vector(11 downto 0);  -- Config. Seg N5
      o_seg_4  : out std_logic_vector(11 downto 0);  -- Config. Seg N4
      o_seg_3  : out std_logic_vector(11 downto 0);  -- Config. Seg N3
      o_seg_2  : out std_logic_vector(11 downto 0);  -- Config. Seg N2
      o_seg_1  : out std_logic_vector(11 downto 0);  -- Config. Seg N1
      o_seg_0  : out std_logic_vector(11 downto 0);  -- Config. Seg N0
      o_done   : out std_logic                       -- Conf Available
      );
  end component max7219_digit2letter;


  component max7219_msg_organizer is
    generic (
      G_RAM_DATA_WIDTH : integer              := 16;  -- RAM DATA SIZE
      G_DIGITS_NB      : integer range 2 to 8 := 8);  -- DIGITS Number on the DISPLAY

    port (
      clk           : in  std_logic;    -- Clock
      rst_n         : in  std_logic;    -- Asynchronous reset
      i_msg_cmd     : in  std_logic_vector(G_DIGITS_NB*8 - 1 downto 0);  -- Sel msg
      i_msg_cmd_val : in  std_logic;    -- SCORE DECOD valid
      o_msg         : out t_msg_array;  -- ARRAY of message
      o_msg_val     : out std_logic
      );
  end component max7219_msg_organizer;


  component max7219_msg_sel is

    generic (
      G_DIGITS_NB : integer range 2 to 8 := 8);          -- DIGIT NB
    port (
      clk           : in  std_logic;                     -- Clock
      rst_n         : in  std_logic;                     -- Asynchronous Reset
      i_msg_sel     : in  std_logic_vector(7 downto 0);  -- MSG SEL
      i_msg_sel_val : in  std_logic;                     -- MSG SEL VALID
      o_msg_cmd     : out std_logic_vector(G_DIGITS_NB*8 - 1 downto 0);
      o_msg_cmd_val : out std_logic);                    -- MSG CMD VAL

  end component max7219_msg_sel;


  component max7219_start_addr_mngt is
    generic (
      G_RAM_ADDR_WIDTH : integer              := 16;  -- RAM ADDR WIDTH
      G_DIGITS_NB      : integer range 2 to 8 := 8);  -- Digits Number on the Display
    port (
      clk                 : in  std_logic;
      rst_n               : in  std_logic;            -- Asynchronous reset
      o_config_start_addr : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
      o_score_start_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
      o_msg_start_addr    : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0)
      );
  end component max7219_start_addr_mngt;


  component max7219_scroller_rd_mem is

    generic (
      G_RAM_ADDR_WIDTH : integer := 8;   -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH : integer := 16;  -- RAM DATA_WIDTH
      G_DIGITS_NB      : integer := 8);  -- DIGITS NUMBER

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      i_start_scroll : in std_logic;    -- Start Scroll

      o_me    : out std_logic;          -- Memory Enable
      o_we    : out std_logic;          -- R/W enable
      o_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
      i_rdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM DATA

      o_msg2scroll_array : out t_msg2scroll_array(0 to 2**G_RAM_ADDR_WIDTH - 2);  -- Mesage to Scroll
      o_shift_nb         : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- Number of shift to perform
      o_start            : out std_logic);  -- Start

  end component max7219_scroller_rd_mem;


  component max7219_scroller is

    generic (
      G_RAM_ADDR_WIDTH : integer := 8;   -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH : integer := 16;  -- RAM DATA WIDTH
      G_DIGITS_NB      : integer := 8);  -- DIGIT NUMBER

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      -- COMMANDS
      i_start_scroll : in std_logic;    -- START SCROLL COMMAND

      -- MEMORY I/F
      o_me    : out std_logic;          -- Memory Enable
      o_we    : out std_logic;          -- R/W enable
      o_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- MEMORY ADDR
      i_rdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- MEMORY RDATA

      -- MAX7219 I/F
      o_start   : out std_logic;        -- MAX7219 I/F Start
      o_en_load : out std_logic;        -- MAX7219 I/F Enable Load
      o_data    : out std_logic_vector(15 downto 0);  -- MAX7219 I/F DATA
      i_done    : in  std_logic);       -- MAX7219 DONE

  end component max7219_scroller;

  component max7219_scroller_if is

    generic (
      G_MATRIX_NB : integer range 2 to 8 := 8);  -- MATRIX_NB

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      i_seg_data       : in  std_logic_vector(7 downto 0);   -- Segment Data
      i_seg_data_valid : in  std_logic;
      i_max_tempo_cnt  : in  std_logic_vector(31 downto 0);  -- Max Tempo Counter
      o_busy           : out std_logic;  -- Scroller I/F Busy

      -- MAX7219 I/F
      i_max7219_if_done    : in  std_logic;  -- MAX7219 I/F Done
      o_max7219_if_start   : out std_logic;  -- MAX7219 I/F Start
      o_max7219_if_en_load : out std_logic;  -- MAX7219 Enable Load
      o_max7219_if_data    : out std_logic_vector(15 downto 0));  -- MAX7219 I/F Data

  end component max7219_scroller_if;


  component max7219_ram2scroller_if is
    generic (
      G_MATRIX_NB      : integer range 2 to 8 := 8;   -- MATRIX NUMBER
      G_RAM_ADDR_WIDTH : integer              := 8;   -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH : integer              := 8);  -- RAM DATA WIDTH

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      -- EXTERNAL I/F
      i_start         : in std_logic;   -- START SCROLL
      i_msg_length    : in std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);
      i_ram_start_ptr : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);

      -- RAM I/F
      i_rdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA
      o_me    : out std_logic;          -- Memory Enable
      o_we    : out std_logic;          -- W/R command
      o_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR

      -- RAM SCROLLER I/F
      o_seg_data       : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- SEG DATA
      o_seg_data_valid : out std_logic;  -- SEG DATA VAL

      i_scroller_if_busy : in  std_logic;
      o_busy             : out std_logic);  -- Scroller Controller Busy
  end component max7219_ram2scroller_if;

  component max7219_scroller_ctrl is

    generic (
      G_MATRIX_NB      : integer range 2 to 8 := 8;   -- MATRIX NUMBER
      G_RAM_ADDR_WIDTH : integer              := 8;   -- RAM ADDR WITH
      G_RAM_DATA_WIDTH : integer              := 8);  -- RAM DATA WIDTH

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      -- RAM I/F
      i_me    : in  std_logic;          -- Memory Enable
      i_we    : in  std_logic;          -- W/R command
      i_addr  : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
      i_wdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM DATA
      o_rdata : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM RDATA

      -- RAM Commands
      i_ram_start_ptr : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM START PTR
      i_msg_length    : in std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- Message Length
      i_start_scroll  : in std_logic;   -- Valid - Start Scroller
      i_max_tempo_cnt : in std_logic_vector(31 downto 0);  -- Scroller Tempo

      -- MAX7219 I/F
      i_max7219_if_done    : in  std_logic;  -- MAX7219 I/F Done
      o_max7219_if_start   : out std_logic;  -- MAX7219 I/F Start
      o_max7219_if_en_load : out std_logic;  -- MAX7219 Enable Load
      o_max7219_if_data    : out std_logic_vector(15 downto 0);  -- MAX7219 I/F Data

      o_busy : out std_logic);          -- Scroller Controller Busy

  end component max7219_scroller_ctrl;

  component max7219_matrix_display is
    generic (
      G_DIGITS_NB                  : integer range 2 to 8          := 8;  -- DIGIT NB on THE MATRIX DISPLAY
      G_DATA_WIDTH                 : integer                       := 32;  -- INPUTS SCORE WIDTH
      G_RAM_ADDR_WIDTH             : integer                       := 8;  -- RAM ADDR WIDTH
      G_RAM_DATA_WIDTH             : integer                       := 16;  -- RAM DATA WIDTH
      G_DECOD_MAX_CNT_32B          : std_logic_vector(31 downto 0) := x"02FAF080";
      G_MAX7219_IF_MAX_HALF_PERIOD : integer                       := 50;  -- MAX HALF PERIOD for MAX729 CLK generation
      G_MAX7219_LOAD_DUR           : integer                       := 4);  -- MAX7219 LOAD duration in period of clk
    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      -- MATRIX CONFIG.
      i_decod_mode     : in std_logic_vector(7 downto 0);  -- DECOD MODE
      i_intensity      : in std_logic_vector(7 downto 0);  -- INTENSITY
      i_scan_limit     : in std_logic_vector(7 downto 0);  -- SCAN LIMIT
      i_shutdown       : in std_logic_vector(7 downto 0);  -- SHUTDOWN MODE
      i_new_config_val : in std_logic;                     -- CONFIG. VALID

      -- SCORE to DISPLAY
      i_score     : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Score to Display
      i_score_val : in std_logic;       -- Scare Valid

      -- MESSAGE to DISPLAY
      i_msg_sel     : in std_logic_vector(7 downto 0);  -- Message Selector
      i_msg_sel_val : in std_logic;     -- Message Selector Valid

      -- MAX7219 I/F
      o_max7219_load : out std_logic;   -- MAX7219 LOAD
      o_max7219_data : out std_logic;   -- MAX7219 DATA
      o_max7219_clk  : out std_logic    -- MAX729 CLK
      );
  end component max7219_matrix_display;

  component max7219_init_ram is
    generic (
      G_ADDR_WIDTH : integer                       := 8;   -- RAM ADDR WIDTH
      G_DATA_WIDTH : integer                       := 16;  -- RAM DATA WIDTH
      G_LAST_PTR   : std_logic_vector(31 downto 0) := x"0000000A");

    port (
      clk        : in  std_logic;       -- Clock
      rst_n      : in  std_logic;       -- Asynchronous reset
      o_me       : out std_logic;       -- Memory Enable
      o_we       : out std_logic;       -- Memory Command
      o_addr     : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
      o_wdata    : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- RAM WDATA
      o_en       : out std_logic;       -- Enable the MAX7219 CMD DECOD
      o_last_ptr : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0));  -- LAST ADDR PTR
  end component max7219_init_ram;












  -- TOP_MAX7219 CONSTANTS

  type t_ram_array is array (0 to 2**8 - 1) of std_logic_vector(15 downto 0);
  constant C_RAM_INIT_0 : t_ram_array := (
    0 => x"1A00",                       -- SET INT
    1 => x"1B07",                       -- SET SCNA
    2 => x"1900",                       -- SET DECOD
    3 => x"1C01",                       -- SET OP

    -- DISPLAY S
    4  => x"1146",                      -- SET DIG0
    5  => x"12C9",                      -- SET DIG1
    6  => x"1389",                      -- SET DIG2
    7  => x"1489",                      -- SET DIG3
    8  => x"1589",                      -- SET DIG4
    9  => x"1689",                      -- SET DIG5
    10 => x"1793",                      -- SET DIG6
    11 => x"1866",                      -- SET DIG7
    12 => x"4000",                      -- WAIT G_MAX_CNT_32B

    -- DISPLAY T
    13 => x"11C0",                      -- SET DIG0
    14 => x"12C0",                      -- SET DIG1
    15 => x"13C0",                      -- SET DIG2
    16 => x"14FF",                      -- SET DIG3
    17 => x"15FF",                      -- SET DIG4
    18 => x"16C0",                      -- SET DIG5
    19 => x"17C0",                      -- SET DIG6
    20 => x"18C0",                      -- SET DIG7
    21 => x"4000",                      -- WAIT G_MAX_CNT_32B

    -- DISPLAY A
    22 => x"113F",                      -- SET DIG0
    23 => x"127F",                      -- SET DIG1
    24 => x"13C8",                      -- SET DIG2
    25 => x"14C8",                      -- SET DIG3
    26 => x"15C8",                      -- SET DIG4
    27 => x"16C8",                      -- SET DIG5
    28 => x"177F",                      -- SET DIG6
    29 => x"183F",                      -- SET DIG7
    30 => x"4000",                      -- WAIT G_MAX_CNT_32B

    -- DISPLAY Y
    31 => x"11C0",                      -- SET DIG0
    32 => x"12E0",                      -- SET DIG1
    33 => x"1330",                      -- SET DIG2
    34 => x"141F",                      -- SET DIG3
    35 => x"151F",                      -- SET DIG4
    36 => x"1630",                      -- SET DIG5
    37 => x"17E0",                      -- SET DIG6
    38 => x"18C0",                      -- SET DIG7
    39 => x"4000",                      -- WAIT G_MAX_CNT_32B

    -- DISPLAY H
    40 => x"11FF",                      -- SET DIG0
    41 => x"12FF",                      -- SET DIG1
    42 => x"1318",                      -- SET DIG2
    43 => x"1418",                      -- SET DIG3
    44 => x"1518",                      -- SET DIG4
    45 => x"1618",                      -- SET DIG5
    46 => x"17FF",                      -- SET DIG6
    47 => x"18FF",                      -- SET DIG7    
    48 => x"4000",                      -- WAIT G_MAX_CNT_32B

    -- DISPLAY O
    49 => x"113C",                      -- SET DIG0
    50 => x"127E",                      -- SET DIG1
    51 => x"13C3",                      -- SET DIG2
    52 => x"14C3",                      -- SET DIG3
    53 => x"15C3",                      -- SET DIG4
    54 => x"16C3",                      -- SET DIG5
    55 => x"177E",                      -- SET DIG6
    56 => x"183C",                      -- SET DIG7    
    57 => x"4000",                      -- WAIT G_MAX_CNT_32B

    -- DISPLAY M
    58 => x"11FF",                      -- SET DIG0
    59 => x"127F",                      -- SET DIG1
    60 => x"1330",                      -- SET DIG2
    61 => x"1418",                      -- SET DIG3
    62 => x"1518",                      -- SET DIG4
    63 => x"1630",                      -- SET DIG5
    64 => x"177F",                      -- SET DIG6
    65 => x"18FF",                      -- SET DIG7    
    66 => x"4000",                      -- WAIT G_MAX_CNT_32B

    -- DISPLAY E
    67 => x"11C3",                      -- SET DIG0
    68 => x"12C3",                      -- SET DIG1
    69 => x"13DB",                      -- SET DIG2
    70 => x"14DB",                      -- SET DIG3
    71 => x"15DB",                      -- SET DIG4
    72 => x"16FF",                      -- SET DIG5
    73 => x"17FF",                      -- SET DIG6
    74 => x"18FF",                      -- SET DIG7    
    75 => x"4000",                      -- WAIT G_MAX_CNT_32B

    -- DISPLAY :)
    76 => x"11C4",                      -- SET DIG0
    77 => x"12A6",                      -- SET DIG1
    78 => x"1365",                      -- SET DIG2
    79 => x"1405",                      -- SET DIG3
    80 => x"1515",                      -- SET DIG4
    81 => x"16C5",                      -- SET DIG5
    82 => x"17A6",                      -- SET DIG6
    83 => x"1864",                      -- SET DIG7    
    84 => x"4000",                      -- WAIT G_MAX_CNT_32B

    others => (others => '0'));


  -- TEST with 2 MATRIX in DAISY chain
  constant C_RAM_INIT_1 : t_ram_array := (
    0 => x"0A00",                       -- SET INT - NO LOAD
    1 => x"1A00",                       -- SET INT - LOAD
    2 => x"0B07",                       -- SET SCAN - NO LOAD
    3 => x"1B07",                       -- SET SCAN - LOAD
    4 => x"0900",                       -- SET DECOD - NO LOAD
    5 => x"1900",                       -- SET DECOD - LOAD
    6 => x"0C01",                       -- SET OP - NO LOAD
    7 => x"1C01",                       -- SET OP - LOAD
    8 => x"0000",                       -- NOP - NO LOAD
    9 => x"1000",                       -- NOP - LOAD

    -- RAZ MATRIX

    10 => x"0100",                      -- SET DIG0
    11 => x"1100",                      -- SET DIG0    
    12 => x"0200",                      -- SET DIG1
    13 => x"1200",                      -- SET DIG1    
    14 => x"0300",                      -- SET DIG2
    15 => x"1300",                      -- SET DIG2
    16 => x"0400",                      -- SET DIG3
    17 => x"1400",                      -- SET DIG3
    18 => x"0500",                      -- SET DIG4
    19 => x"1500",                      -- SET DIG4
    20 => x"0600",                      -- SET DIG5
    21 => x"1600",                      -- SET DIG5
    22 => x"0700",                      -- SET DIG6
    23 => x"1700",                      -- SET DIG6
    24 => x"0800",                      -- SET DIG7
    25 => x"1800",                      -- SET DIG7
    26 => x"4000",                      -- WAIT G_MAX_CNT_32B


    -- :) on matrix 0 only
    -- 
    27 => x"0000",                      -- NOP - NO LOAD
    28 => x"11C4",                      -- SET DIG0 - LOAD
    29 => x"0000",                      -- NOP - NO LOAD
    30 => x"12A6",                      -- SET DIG1 - LOAD
    31 => x"0000",                      -- NOP - NO LOAD
    32 => x"1365",                      -- SET DIG2 - LOAD
    33 => x"0000",                      -- NOP - NO LOAD
    34 => x"1405",                      -- SET DIG3 - LOAD
    35 => x"0000",                      -- NOP - NO LOAD 
    36 => x"1515",                      -- SET DIG4 - LOAD
    37 => x"0000",                      -- NOP - NO LOAD
    38 => x"16C5",                      -- SET DIG5 - LOAD
    39 => x"0000",                      -- NOP - NO LOAD
    40 => x"17A6",                      -- SET DIG6 - LOAD
    41 => x"0000",                      -- NOP - NO LOAD
    42 => x"1864",                      -- SET DIG7 - LOAD
    43 => x"0000",                      -- NOP - NO LOAD
    44 => x"4000",                      -- WAIT G_MAX_CNT_32B

    -- SET Y on matrix 1 and keep MTRIX 0 as previously :)

    45 => x"01C0",                      -- SET DIG0 - NO LOAD
    46 => x"1000",                      -- NOP - LOAD
    47 => x"02E0",                      -- SET DIG1 - NO LOAD
    48 => x"1000",                      -- NOP - LOAD
    49 => x"0330",                      -- SET DIG2 - NO LOAD
    50 => x"1000",                      -- NOP - LOAD
    51 => x"041F",                      -- SET DIG3 - NO LOAD
    52 => x"1000",                      -- NOP - LOAD
    53 => x"051F",                      -- SET DIG4 - NO LOAD
    54 => x"1000",                      -- NOP - LOAD
    55 => x"0630",                      -- SET DIG5 - NO LOAD
    56 => x"1000",                      -- NOP - LOAD
    57 => x"07E0",                      -- SET DIG6 - NO LOAD
    58 => x"1000",                      -- NOP - LOAD
    59 => x"08C0",                      -- SET DIG7 - NO LOAD
    60 => x"1000",                      -- NOP - LOAD    
    61 => x"4000",                      -- WAIT G_MAX_CNT_32B

    --  SHUTDOWN DISPLAY
    62 => x"0C00",                      -- SET OP - NO LOAD
    63 => x"1C00",                      -- SET OP - LOAD
    64 => x"4000",                      -- WAIT G_MAX_CNT_32B

    -- ON DISPLAY
    65 => x"0C01",                      -- SET OP - NO LOAD
    66 => x"1C01",                      -- SET OP - LOAD
    67 => x"4000",                      -- WAIT G_MAX_CNT_32B

    -- DISPLAY TEST on
    68 => x"0F01",                      -- SET OP - NO LOAD
    69 => x"1F01",                      -- SET OP - LOAD
    70 => x"4000",                      -- WAIT G_MAX_CNT_32B

    -- DISPLAY TEST off
    71 => x"0F00",                      -- SET OP - NO LOAD
    72 => x"1F00",                      -- SET OP - LOAD
    73 => x"4000",                      -- WAIT G_MAX_CNT_32B


    others => (others => '0')
    );


end package pkg_max7219;
