-------------------------------------------------------------------------------
-- Title      : Package of UART MAX7219 DISPLAY CTRL
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_uart_max7219_display_ctrl.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-05-07
-- Last update: 2021-06-13
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-05-07  1.0      jorisp  Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

library lib_uart;
use lib_uart.pkg_uart.all;

package pkg_uart_max7219_display_ctrl is

  -- == CONSTANTS ==
  constant C_NB_CMD     : integer              := 9;   -- Command Number
  constant C_CMD_LENGTH : integer              := 20;  -- Command Length
  constant C_DATA_WIDTH : integer range 5 to 9 := 8;   -- Data Width

  constant C_RESP_LENGTH : integer := 20;  -- Length of a TX Response in byte
  constant C_NB_RESP     : integer := 21;  -- Number of possible respons

  -- ASCII Character in hexdecimal
  constant A : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"41";
  constant C : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"43";
  constant D : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"44";
  constant E : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"45";
  constant F : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"46";
  constant G : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"47";
  constant I : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"49";
  constant L : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"4C";
  constant M : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"4D";
  constant N : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"4E";
  constant O : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"4F";
  constant P : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"50";
  constant R : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"52";
  constant S : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"53";
  constant T : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"54";
  constant U : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"55";
  constant X : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"58";
  constant Y : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"59";


  constant UNDSCR : std_logic_vector(C_DATA_WIDTH - 1 downto 0) := x"5F";

  -- == Types ==
  -- RX
  type t_cmd_array is array (0 to C_CMD_LENGTH - 1) of std_logic_vector(C_DATA_WIDTH - 1 downto 0);
  type t_cmd_list_array is array (0 to C_NB_CMD - 1) of t_cmd_array;

  -- TX
  type t_resp_array is array(0 to C_RESP_LENGTH - 1) of std_logic_vector(C_DATA_WIDTH - 1 downto 0);
  type t_resp_list_array is array(0 to C_NB_RESP - 1) of t_resp_array;

  -- == CONSTANTS COMMANDS ==
  -- INIT_RAM_STATIC : LOAD STATIC RAM With 0x00
  constant C_CMD_00 : t_cmd_array := (0      => I,
                                      1      => N,
                                      2      => I,
                                      3      => T,
                                      4      => UNDSCR,
                                      5      => R,
                                      6      => A,
                                      7      => M,
                                      8      => UNDSCR,
                                      9      => S,
                                      10     => T,
                                      11     => A,
                                      12     => T,
                                      13     => I,
                                      14     => C,
                                      others => x"00");

  -- INIT_RAM_SCROLLER : LOAD SCROLLER RAM with 0x00
  constant C_CMD_01 : t_cmd_array := (0      => I,
                                      1      => N,
                                      2      => I,
                                      3      => T,
                                      4      => UNDSCR,
                                      5      => R,
                                      6      => A,
                                      7      => M,
                                      8      => UNDSCR,
                                      9      => S,
                                      10     => C,
                                      11     => R,
                                      12     => O,
                                      13     => L,
                                      14     => L,
                                      15     => E,
                                      16     => R,
                                      others => x"00");



  -- UPDATE_MATRIX_CONFIG : Update static Config. of MATRIX
  constant C_CMD_02 : t_cmd_array := (0      => U,
                                      1      => P,
                                      2      => D,
                                      3      => A,
                                      4      => T,
                                      5      => E,
                                      6      => UNDSCR,
                                      7      => M,
                                      8      => A,
                                      9      => T,
                                      10     => R,
                                      11     => I,
                                      12     => X,
                                      13     => UNDSCR,
                                      14     => C,
                                      15     => O,
                                      16     => N,
                                      17     => F,
                                      18     => I,
                                      19     => G,
                                      others => x"00");

  -- LOAD_MATRIX_CONFIG : Load Matrix Config => Not a simple command
  constant C_CMD_03 : t_cmd_array := (0      => L,
                                      1      => O,
                                      2      => A,
                                      3      => D,
                                      4      => UNDSCR,
                                      5      => M,
                                      6      => A,
                                      7      => T,
                                      8      => R,
                                      9      => I,
                                      10     => X,
                                      11     => UNDSCR,
                                      12     => C,
                                      13     => O,
                                      14     => N,
                                      15     => F,
                                      16     => I,
                                      17     => G,
                                      others => x"00");

  -- LOAD_PATTERN_STATIC : Load PATTERN STATIC => Not a simple command
  constant C_CMD_04 : t_cmd_array := (0      => L,
                                      1      => O,
                                      2      => A,
                                      3      => D,
                                      4      => UNDSCR,
                                      5      => P,
                                      6      => A,
                                      7      => T,
                                      8      => T,
                                      9      => E,
                                      10     => R,
                                      11     => N,
                                      12     => UNDSCR,
                                      13     => S,
                                      14     => T,
                                      15     => A,
                                      16     => T,
                                      17     => I,
                                      18     => C,
                                      others => x"00");


  -- LOAD_PATTERN_SCROLL : Load PATTERN SCROLLER => Not a simple command
  constant C_CMD_05 : t_cmd_array := (0      => L,
                                      1      => O,
                                      2      => A,
                                      3      => D,
                                      4      => UNDSCR,
                                      5      => P,
                                      6      => A,
                                      7      => T,
                                      8      => T,
                                      9      => E,
                                      10     => R,
                                      11     => N,
                                      12     => UNDSCR,
                                      13     => S,
                                      14     => C,
                                      15     => R,
                                      16     => O,
                                      17     => L,
                                      18     => L,
                                      others => x"00");


  -- RUN_PATTERN_STATIC : Run PATTERN Static  => Not a simple command
  constant C_CMD_06 : t_cmd_array := (0      => R,
                                      1      => U,
                                      2      => N,
                                      3      => UNDSCR,
                                      4      => P,
                                      5      => A,
                                      6      => T,
                                      7      => T,
                                      8      => E,
                                      9      => R,
                                      10     => N,
                                      11     => UNDSCR,
                                      12     => S,
                                      13     => T,
                                      14     => A,
                                      15     => T,
                                      16     => I,
                                      17     => C,
                                      others => x"00");


  -- RUN_PATTERN_SCROLLER : Run PATTERN SCROLLER => Not a simple command
  constant C_CMD_07 : t_cmd_array := (0      => R,
                                      1      => U,
                                      2      => N,
                                      3      => UNDSCR,
                                      4      => P,
                                      5      => A,
                                      6      => T,
                                      7      => T,
                                      8      => E,
                                      9      => R,
                                      10     => N,
                                      11     => UNDSCR,
                                      12     => S,
                                      13     => C,
                                      14     => R,
                                      15     => O,
                                      16     => L,
                                      17     => L,
                                      18     => E,
                                      19     => R,
                                      others => x"00");
  -- LOAD_SCROLLER_TEMPO
  constant C_CMD_08 : t_cmd_array := (0      => L,
                                      1      => O,
                                      2      => A,
                                      3      => D,
                                      4      => UNDSCR,
                                      5      => S,
                                      6      => C,
                                      7      => R,
                                      8      => O,
                                      9      => L,
                                      10     => L,
                                      11     => E,
                                      12     => R,
                                      13     => UNDSCR,
                                      14     => T,
                                      15     => E,
                                      16     => M,
                                      17     => P,
                                      18     => O,
                                      others => x"00");




  -- == CONSTANTS COMMANDS LIST ==
  constant C_CMD_LIST : t_cmd_list_array := (
    0 => C_CMD_00,
    1 => C_CMD_01,
    2 => C_CMD_02,
    3 => C_CMD_03,
    4 => C_CMD_04,
    5 => C_CMD_05,
    6 => C_CMD_06,
    7 => C_CMD_07,
    8 => C_CMD_08
    );


  -- TX Response

  -- RAM_STATIC_DONE
  constant C_RESP_00 : t_resp_array := (0      => R,
                                        1      => A,
                                        2      => M,
                                        3      => UNDSCR,
                                        4      => S,
                                        5      => T,
                                        6      => A,
                                        7      => T,
                                        8      => I,
                                        9      => C,
                                        10     => UNDSCR,
                                        11     => D,
                                        12     => O,
                                        13     => N,
                                        14     => E,
                                        others => x"00");

  -- RAM_SCROLLER_DONE
  constant C_RESP_01 : t_resp_array := (0      => R,
                                        1      => A,
                                        2      => M,
                                        3      => UNDSCR,
                                        4      => S,
                                        5      => C,
                                        6      => R,
                                        7      => O,
                                        8      => L,
                                        9      => L,
                                        10     => E,
                                        11     => R,
                                        12     => UNDSCR,
                                        13     => D,
                                        14     => O,
                                        15     => N,
                                        16     => E,
                                        others => x"00");

  -- CMD_DISCARD
  constant C_RESP_02 : t_resp_array := (0      => C,
                                        1      => M,
                                        2      => D,
                                        3      => UNDSCR,
                                        4      => D,
                                        5      => I,
                                        6      => S,
                                        7      => C,
                                        8      => A,
                                        9      => R,
                                        10     => D,
                                        others => x"00");


  -- LOAD_STATIC_RDY
  constant C_RESP_03 : t_resp_array := (0      => L,
                                        1      => O,
                                        2      => A,
                                        3      => D,
                                        4      => UNDSCR,
                                        5      => S,
                                        6      => T,
                                        7      => A,
                                        8      => T,
                                        9      => I,
                                        10     => C,
                                        11     => UNDSCR,
                                        12     => R,
                                        13     => D,
                                        14     => Y,
                                        others => x"00");


  -- LOAD_STATIC_NOT_RDY
  constant C_RESP_04 : t_resp_array := (0      => L,
                                        1      => O,
                                        2      => A,
                                        3      => D,
                                        4      => UNDSCR,
                                        5      => S,
                                        6      => T,
                                        7      => A,
                                        8      => T,
                                        9      => I,
                                        10     => C,
                                        11     => UNDSCR,
                                        12     => N,
                                        13     => O,
                                        14     => T,
                                        15     => UNDSCR,
                                        16     => R,
                                        17     => D,
                                        18     => y,
                                        others => x"00");
  -- LOAD_STATIC_DONE
  constant C_RESP_05 : t_resp_array := (0      => L,
                                        1      => O,
                                        2      => A,
                                        3      => D,
                                        4      => UNDSCR,
                                        5      => S,
                                        6      => T,
                                        7      => A,
                                        8      => T,
                                        9      => I,
                                        10     => C,
                                        11     => UNDSCR,
                                        12     => D,
                                        13     => O,
                                        14     => N,
                                        15     => E,
                                        others => x"00");


  -- LOAD_SCROLL_RDY
  constant C_RESP_06 : t_resp_array := (0      => L,
                                        1      => O,
                                        2      => A,
                                        3      => D,
                                        4      => UNDSCR,
                                        5      => S,
                                        6      => C,
                                        7      => R,
                                        8      => O,
                                        9      => L,
                                        10     => L,
                                        11     => UNDSCR,
                                        12     => R,
                                        13     => D,
                                        14     => Y,
                                        others => x"00");


  -- LOAD_SCROLL_NOT_RDY
  constant C_RESP_07 : t_resp_array := (0      => L,
                                        1      => O,
                                        2      => A,
                                        3      => D,
                                        4      => UNDSCR,
                                        5      => S,
                                        6      => C,
                                        7      => R,
                                        8      => O,
                                        9      => L,
                                        10     => L,
                                        11     => UNDSCR,
                                        12     => N,
                                        13     => O,
                                        14     => T,
                                        15     => UNDSCR,
                                        16     => R,
                                        17     => D,
                                        18     => Y,
                                        others => x"00");


  -- LOAD_SCROLL_DONE
  constant C_RESP_08 : t_resp_array := (0      => L,
                                        1      => O,
                                        2      => A,
                                        3      => D,
                                        4      => UNDSCR,
                                        5      => S,
                                        6      => C,
                                        7      => R,
                                        8      => O,
                                        9      => L,
                                        10     => L,
                                        11     => UNDSCR,
                                        12     => D,
                                        13     => O,
                                        14     => N,
                                        15     => E,
                                        others => x"00");


  -- LOAD_MATRIX_RDY
  constant C_RESP_09 : t_resp_array := (0      => L,
                                        1      => O,
                                        2      => A,
                                        3      => D,
                                        4      => UNDSCR,
                                        5      => M,
                                        6      => A,
                                        7      => T,
                                        8      => R,
                                        9      => I,
                                        10     => X,
                                        11     => UNDSCR,
                                        12     => R,
                                        13     => D,
                                        14     => Y,
                                        others => x"00");


  -- LOAD_MATRIX_DONE
  constant C_RESP_10 : t_resp_array := (0      => L,
                                        1      => O,
                                        2      => A,
                                        3      => D,
                                        4      => UNDSCR,
                                        5      => M,
                                        6      => A,
                                        7      => T,
                                        8      => R,
                                        9      => I,
                                        10     => X,
                                        11     => UNDSCR,
                                        12     => D,
                                        13     => O,
                                        14     => N,
                                        15     => E,
                                        others => x"00");

  -- UPDATE_MATRIX_DONE
  constant C_RESP_11 : t_resp_array := (0      => U,
                                        1      => P,
                                        2      => D,
                                        3      => A,
                                        4      => T,
                                        5      => E,
                                        6      => UNDSCR,
                                        7      => M,
                                        8      => A,
                                        9      => T,
                                        10     => R,
                                        11     => I,
                                        12     => X,
                                        13     => UNDSCR,
                                        14     => D,
                                        15     => O,
                                        16     => N,
                                        17     => E,
                                        others => x"00");


  -- STATIC_PTRN_RDY
  constant C_RESP_12 : t_resp_array := (0      => S,
                                        1      => T,
                                        2      => A,
                                        3      => T,
                                        4      => I,
                                        5      => C,
                                        6      => UNDSCR,
                                        7      => P,
                                        8      => T,
                                        9      => R,
                                        10     => N,
                                        11     => UNDSCR,
                                        12     => R,
                                        13     => D,
                                        14     => Y,
                                        others => x"00");

  -- STATIC_PTRN_NOT_RDY
  constant C_RESP_13 : t_resp_array := (0      => S,
                                        1      => T,
                                        2      => A,
                                        3      => T,
                                        4      => I,
                                        5      => C,
                                        6      => UNDSCR,
                                        7      => P,
                                        8      => T,
                                        9      => R,
                                        10     => N,
                                        11     => UNDSCR,
                                        12     => N,
                                        13     => O,
                                        14     => T,
                                        15     => UNDSCR,
                                        16     => R,
                                        17     => D,
                                        18     => Y,
                                        others => x"00");


  -- STATIC_PTRN_DONE
  constant C_RESP_14 : t_resp_array := (0      => S,
                                        1      => T,
                                        2      => A,
                                        3      => T,
                                        4      => I,
                                        5      => C,
                                        6      => UNDSCR,
                                        7      => P,
                                        8      => T,
                                        9      => R,
                                        10     => N,
                                        11     => UNDSCR,
                                        12     => D,
                                        13     => O,
                                        14     => N,
                                        15     => E,
                                        others => x"00");


  -- SCROLL_PTRN_RDY
  constant C_RESP_15 : t_resp_array := (0      => S,
                                        1      => C,
                                        2      => R,
                                        3      => O,
                                        4      => L,
                                        5      => L,
                                        6      => UNDSCR,
                                        7      => P,
                                        8      => T,
                                        9      => R,
                                        10     => N,
                                        11     => UNDSCR,
                                        12     => R,
                                        13     => D,
                                        14     => Y,
                                        others => x"00");

  -- SCROLL_PTRN_NOT_RDY
  constant C_RESP_16 : t_resp_array := (0      => S,
                                        1      => C,
                                        2      => R,
                                        3      => O,
                                        4      => L,
                                        5      => L,
                                        6      => UNDSCR,
                                        7      => P,
                                        8      => T,
                                        9      => R,
                                        10     => N,
                                        11     => UNDSCR,
                                        12     => N,
                                        13     => O,
                                        14     => T,
                                        15     => UNDSCR,
                                        16     => R,
                                        17     => D,
                                        18     => Y,
                                        others => x"00");


  -- SCROLL_PTRN_DONE
  constant C_RESP_17 : t_resp_array := (0      => S,
                                        1      => C,
                                        2      => R,
                                        3      => O,
                                        4      => L,
                                        5      => L,
                                        6      => UNDSCR,
                                        7      => P,
                                        8      => T,
                                        9      => R,
                                        10     => N,
                                        11     => UNDSCR,
                                        12     => D,
                                        13     => O,
                                        14     => N,
                                        15     => E,
                                        others => x"00");

  -- LOAD_TEMPO_RDY
  constant C_RESP_18 : t_resp_array := (0      => L,
                                        1      => O,
                                        2      => A,
                                        3      => D,
                                        4      => UNDSCR,
                                        5      => T,
                                        6      => E,
                                        7      => M,
                                        8      => P,
                                        9      => O,
                                        10     => UNDSCR,
                                        11     => R,
                                        12     => D,
                                        13     => Y,
                                        others => x"00");

  -- LOAD_TEMPO_NOT_RDY
  constant C_RESP_19 : t_resp_array := (0      => L,
                                        1      => O,
                                        2      => A,
                                        3      => D,
                                        4      => UNDSCR,
                                        5      => T,
                                        6      => E,
                                        7      => M,
                                        8      => P,
                                        9      => O,
                                        10     => UNDSCR,
                                        11     => N,
                                        12     => O,
                                        13     => T,
                                        14     => UNDSCR,
                                        15     => R,
                                        16     => D,
                                        17     => Y,
                                        others => x"00");

  -- LOAD_TEMPO_DONE
  constant C_RESP_20 : t_resp_array := (0      => L,
                                        1      => O,
                                        2      => A,
                                        3      => D,
                                        4      => UNDSCR,
                                        5      => T,
                                        6      => E,
                                        7      => M,
                                        8      => P,
                                        9      => O,
                                        10     => UNDSCR,
                                        11     => D,
                                        12     => O,
                                        13     => N,
                                        14     => E,
                                        others => x"00");







  constant C_RESP_LIST : t_resp_list_array := (
    0      => C_RESP_00,
    1      => C_RESP_01,
    2      => C_RESP_02,
    3      => C_RESP_03,
    4      => C_RESP_04,
    5      => C_RESP_05,
    6      => C_RESP_06,
    7      => C_RESP_07,
    8      => C_RESP_08,
    9      => C_RESP_09,
    10     => C_RESP_10,
    11     => C_RESP_11,
    12     => C_RESP_12,
    13     => C_RESP_13,
    14     => C_RESP_14,
    15     => C_RESP_15,
    16     => C_RESP_16,
    17     => C_RESP_17,
    18     => C_RESP_18,
    19     => C_RESP_19,
    20     => C_RESP_20,
    others => (others => (others => '0'))
    );


  -- component
  component uart_cmd_decod is
    generic (
      G_NB_CMD     : integer              := 4;   -- Command Number
      G_CMD_LENGTH : integer              := 10;  -- Command length
      G_DATA_WIDTH : integer range 5 to 9 := 8);  -- Data width

    port (
      clk          : in  std_logic;     -- Clock
      rst_n        : in  std_logic;     -- Asynchronous reset
      i_data       : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Data Input
      i_data_valid : in  std_logic;     -- Data Valid
      o_commands   : out std_logic_vector(G_NB_CMD - 1 downto 0);  -- Output Commands pulses
      o_discard    : out std_logic);    -- Command discard
  end component;



  component sequencer_uart_cmd is
    generic (
      G_NB_CMD          : integer              := 4;  -- Command Number
      G_UART_DATA_WIDTH : integer range 5 to 9 := 8);

    port (
      clk           : in std_logic;
      rst_n         : in std_logic;
      i_cmd_pulses  : in std_logic_vector(G_NB_CMD - 1 downto 0);
      i_cmd_discard : in std_logic;

      o_rx_data_sel : out std_logic;    --RX Data from UART RX Mux selector

      -- INIT Static RAM
      i_init_static_ram_done : in  std_logic;
      o_init_static_ram      : out std_logic;  -- Init Static RAM Command

      o_load_pattern_static      : out std_logic;  -- Command Load Pattern Static
      --i_load_pattern_static_rdy     : in  std_logic;
      --i_load_pattern_static_discard : in  std_logic;  --Load Pattern Static Rejected
      i_load_pattern_static_done : in  std_logic;  -- Load Pattern Static Done

      -- INIT Scroller RAM
      i_init_scroller_ram_done : in  std_logic;
      o_init_scroller_ram      : out std_logic;  -- Init Scroller RAM Command

      -- LOAD Scroller RAM
      o_load_pattern_scroller      : out std_logic;  -- Command Load Pattern Scroller
      --i_load_pattern_scroller_rdy     : in  std_logic;
      --i_load_pattern_scroller_discard : in  std_logic;  -- Load Pattern Scroller Rejected
      i_load_pattern_scroller_done : in  std_logic;  -- Commands LOAD Scroller done

      -- LOAD_CONFIG
      o_load_config      : out std_logic;  -- Command Load Matrix Config
      i_load_config_done : in  std_logic;  -- Command done

      o_update_config      : out std_logic;  -- Command Update config
      i_update_config_done : in  std_logic;  -- Command done


      -- RUN_PATTERN_STATIC
      o_run_pattern_static         : out std_logic;
      i_run_pattern_static_rdy     : in  std_logic;
      i_run_pattern_static_done    : in  std_logic;
      i_run_pattern_static_discard : in  std_logic;

      -- RUN_PATTERN_SCROLLEr
      o_run_pattern_scroller         : out std_logic;
      i_run_pattern_scroller_rdy     : in  std_logic;
      i_run_pattern_scroller_done    : in  std_logic;
      i_run_pattern_scroller_discard : in  std_logic;


      i_load_tempo_scroller_done : in  std_logic;  -- Load Tempo done
      o_load_tempo_scroller      : out std_logic;  -- Load Tempo Scroller command

      -- TX Uart commands
      i_tx_done       : in  std_logic;
      o_tx_uart_start : out std_logic;
      o_tx_data       : out std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0)

      );
  end component;


  component static_ram_mngr is
    generic (

      G_RAM_ADDR_WIDTH_STATIC : integer              := 8;  -- RAM STATIC ADDR WIDTH
      G_RAM_DATA_WIDTH_STATIC : integer              := 16;  -- RAM STATIC DATA WIDTH
      G_UART_DATA_WIDTH       : integer range 5 to 9 := 8  -- UART RAM Data WIDTH
      );


    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous clock

      -- RAM STATIC I/F
      i_rdata_static : in  std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM RDATA
      o_me_static    : out std_logic;
      o_we_static    : out std_logic;   -- W/R command
      o_addr_static  : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- RAM ADDR
      o_wdata_static : out std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM DATA

      -- INIT Static Ram
      i_init_static_ram      : in  std_logic;
      o_init_static_ram_done : out std_logic;

      -- Load Static Ram
      i_load_static_ram      : in  std_logic;
      o_load_static_ram_done : out std_logic;

      i_rx_data : in std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0);
      i_rx_done : in std_logic

      );
  end component;


  component dyn_ram_mngr is

    generic (

      G_RAM_ADDR_WIDTH_DYN : integer              := 8;  -- RAM DYN ADDR WIDTH
      G_RAM_DATA_WIDTH_DYN : integer              := 8;  -- RAM DYN DATA WIDTH
      G_UART_DATA_WIDTH    : integer range 5 to 9 := 8   -- UART RAM Data WIDTH
      );

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous clock

      -- RAM STATIC I/F
      i_rdata_dyn : in  std_logic_vector(G_RAM_DATA_WIDTH_DYN - 1 downto 0);  -- RAM RDATA
      o_me_dyn    : out std_logic;
      o_we_dyn    : out std_logic;      -- W/R command
      o_addr_dyn  : out std_logic_vector(G_RAM_ADDR_WIDTH_DYN - 1 downto 0);  -- RAM ADDR
      o_wdata_dyn : out std_logic_vector(G_RAM_DATA_WIDTH_DYN - 1 downto 0);  -- RAM DATA

      -- INIT Dyn Ram
      i_init_dyn_ram      : in  std_logic;
      o_init_dyn_ram_done : out std_logic;

      -- Load Dyn Ram
      i_load_dyn_ram      : in  std_logic;
      o_load_dyn_ram_done : out std_logic;


      i_rx_data : in std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0);
      i_rx_done : in std_logic

      );

  end component;


  component matrix_config_mngr is
    generic (
      G_UART_DATA_WIDTH : integer range 5 to 9 := 8  -- UART RAM Data WIDTH
      );
    port (
      clk   : in std_logic;                          -- Clock
      rst_n : in std_logic;                          -- Asunchronous Reset

      i_config_done : in std_logic;     -- Config. Done from MAX7219 - TBD

      i_load_config      : in  std_logic;  -- Load Config. Command
      o_load_config_done : out std_logic;  --Load Config. Command done

      i_update_config      : in  std_logic;  -- New config Command    
      o_update_config_done : out std_logic;  -- Config. Done

      o_display_test : out std_logic;   -- Display test config.
      o_decod_mode   : out std_logic_vector(7 downto 0);
      o_intensity    : out std_logic_vector(7 downto 0);
      o_scan_limit   : out std_logic_vector(7 downto 0);
      o_shutdown     : out std_logic_vector(7 downto 0);

      -- RX UART I/F
      i_rx_data : in std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0);
      i_rx_done : in std_logic
      );

  end component;


  component run_pattern_mngt is

    generic (
      G_RAM_DATA_WIDTH_STATIC   : integer := 16;
      G_RAM_ADDR_WIDTH_STATIC   : integer := 8;
      G_RAM_DATA_WIDTH_SCROLLER : integer := 8;
      G_RAM_ADDR_WIDTH_SCROLLER : integer := 8;
      G_UART_DATA_WIDTH         : integer range 5 to 9
      );
    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      -- Commands from Sequencer
      i_run_static_pattern      : in  std_logic;
      o_run_static_pattern_done : out std_logic;
      o_run_static_pattern_rdy  : out std_logic;
      o_run_static_discard      : out std_logic;

      i_run_scroller_pattern      : in  std_logic;
      o_run_scroller_pattern_done : out std_logic;
      o_run_scroller_pattern_rdy  : out std_logic;
      o_run_scroller_discard      : out std_logic;

-- RX UART I/F
      i_rx_data : in std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0);
      i_rx_done : in std_logic;

      o_static_dyn  : out std_logic;    -- Static or Dynamic Pattern selection
      o_new_display : out std_logic;    -- Valid

      -- STATIC MNGT
      o_en_static           : out std_logic;  -- Enable Static Block
      i_ptr_equality_static : in  std_logic;  -- Static Ptr equality
      o_start_ptr_static    : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
      o_last_ptr_static     : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);
      i_static_busy         : in  std_logic;

      -- SCROLLER MNGT
      i_scroller_busy            : in  std_logic;
      o_ram_start_ptr_scroller   : out std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);  -- RAM START PTR
      o_msg_length_scroller      : out std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);  -- Message Length
      i_load_tempo_scroller      : in  std_logic;
      o_load_tempo_scroller_done : out std_logic;
      o_max_tempo_cnt_scroller   : out std_logic_vector(31 downto 0)  -- Scroller Tempo
      );


  end component;

  component uart_max7219_display_ctrl is

    generic (
      -- UART I/F Config.
      G_STOP_BIT_NUMBER : integer range 1 to 2 := 1;  -- Number of stop bit
      G_PARITY          : t_parity             := even;  -- Type of the parity
      G_BAUDRATE        : t_baudrate           := b115200;   -- Baudrate
      G_UART_DATA_SIZE  : integer range 5 to 9 := 8;  -- Size of the data to transmit
      G_POLARITY        : std_logic            := '1';  -- Polarity in idle state
      G_FIRST_BIT       : t_first_bit          := lsb_first;  -- LSB or MSB first
      G_CLOCK_FREQUENCY : integer              := 50000000;  -- Clock frequency [Hz]

      -- I/F Generics
      G_MATRIX_NB               : integer range 2 to 8 := 8;  -- Matrix Number
      G_RAM_ADDR_WIDTH_STATIC   : integer              := 8;  -- RAM STATIC ADDR WIDTH
      G_RAM_DATA_WIDTH_STATIC   : integer              := 16;  -- RAM STATIC DATA WIDTH
      G_RAM_ADDR_WIDTH_SCROLLER : integer              := 8;  -- RAM SCROLLER ADDR WIDTH
      G_RAM_DATA_WIDTH_SCROLLER : integer              := 8);  -- RAM SCROLLER DATA WIDTH

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous clock

      -- UART I/F
      i_rx : in  std_logic;             -- RX UART IN
      o_tx : out std_logic;             -- TX UART OUT

      -- Display Ctrl commands
      o_static_dyn  : out std_logic;    -- Statuc-Dyn selection
      o_new_display : out std_logic;    -- New Display

      -- Matrix Configuration
      i_config_done    : in  std_logic;
      o_display_test   : out std_logic;
      o_decod_mode     : out std_logic_vector(7 downto 0);
      o_intensity      : out std_logic_vector(7 downto 0);
      o_scan_limit     : out std_logic_vector(7 downto 0);
      o_shutdown       : out std_logic_vector(7 downto 0);
      o_new_config_val : out std_logic;


      -- STATIC I/O
      o_en_static : out std_logic;

      -- RAM STATIC I/F
      i_rdata_static : in  std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM RDATA
      o_me_static    : out std_logic;
      o_we_static    : out std_logic;   -- W/R command
      o_addr_static  : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- RAM ADDR
      o_wdata_static : out std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM DATA


      -- RAM INFO.
      o_start_ptr_static : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- ST PTR
      o_last_ptr_static  : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- LAST ADDR

      i_ptr_equality_static : in std_logic;  -- ADDR = LAST PTR
      i_static_busy         : in std_logic;  -- STATIC BUSY


      -- SCROLLER I/O
      -- RAM Commands
      i_scroller_busy          : in  std_logic;  -- SCROLLER BUSY
      o_ram_start_ptr_scroller : out std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);  -- RAM START PTR
      o_msg_length_scroller    : out std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);  -- Message Length
      o_max_tempo_cnt_scroller : out std_logic_vector(31 downto 0);  -- Scroller Tempo


      -- RAM SCROLLER I/F
      i_rdata_scroller : in  std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0);  -- RAM RDATA
      o_me_scroller    : out std_logic;  -- Memory Enable
      o_we_scroller    : out std_logic;  -- W/R command
      o_addr_scroller  : out std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0);  -- RAM ADDR
      o_wdata_scroller : out std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0)  -- RAM DATA

      );
  end component;


  component uart_max7219_display_ctrl_wrapper is

    generic (
      -- UART I/F Config.
      G_STOP_BIT_NUMBER : integer range 1 to 2 := 1;  -- Number of stop bit
      G_PARITY          : t_parity             := even;  -- Type of the parity
      G_BAUDRATE        : t_baudrate           := b115200;   -- Baudrate
      G_UART_DATA_SIZE  : integer range 5 to 9 := 8;  -- Size of the data to transmit
      G_POLARITY        : std_logic            := '1';  -- Polarity in idle state
      G_FIRST_BIT       : t_first_bit          := lsb_first;  -- LSB or MSB first
      G_CLOCK_FREQUENCY : integer              := 50000000;  -- Clock frequency [Hz]

      -- I/F Generics
      G_MATRIX_NB               : integer range 2 to 8 := 8;  -- Matrix Number
      G_RAM_ADDR_WIDTH_STATIC   : integer              := 8;  -- RAM STATIC ADDR WIDTH
      G_RAM_DATA_WIDTH_STATIC   : integer              := 16;  -- RAM STATIC DATA WIDTH
      G_RAM_ADDR_WIDTH_SCROLLER : integer              := 8;  -- RAM SCROLLER ADDR WIDTH
      G_RAM_DATA_WIDTH_SCROLLER : integer              := 8;  -- RAM SCROLLER DATA WIDTH

      -- MAX7219 I/F GENERICS
      G_MAX_HALF_PERIOD : integer := 4;  -- 4 => 6.25MHz with 50MHz input
      G_LOAD_DURATION   : integer := 4;  -- LOAD DURATION in clk_in period

      -- MAX7219 STATIC CTRL GENERICS
      G_DECOD_MAX_CNT_32B : std_logic_vector(31 downto 0) := x"02FAF080"

      );
    port (

      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous clock

      -- UART I/F
      i_rx : in  std_logic;             -- RX UART IN
      o_tx : out std_logic;             -- TX UART OUT

      -- MAX7219 I/F
      o_max7219_load : out std_logic;   -- MAX7219 Load
      o_max7219_data : out std_logic;   -- MAX7219 Data
      o_max7219_clk  : out std_logic    -- MAX7219 Clock

      );
  end component;

end package pkg_uart_max7219_display_ctrl;
