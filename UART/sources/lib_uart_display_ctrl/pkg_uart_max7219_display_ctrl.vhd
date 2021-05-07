-------------------------------------------------------------------------------
-- Title      : Package of UART MAX7219 DISPLAY CTRL
-- Project    : 
-------------------------------------------------------------------------------
-- File       : pkg_uart_max7219_display_ctrl.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-05-07
-- Last update: 2021-05-07
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

package pkg_uart_max7219_display_ctrl is

  -- == CONSTANTS ==
  constant C_NB_CMD     : integer              := 8;   -- Command Number
  constant C_CMD_LENGTH : integer              := 20;  -- Command Length
  constant C_DATA_WIDTH : integer range 5 to 9 := 8;   -- Data Width

  constant C_RESP_LENGTH : integer := 20;  -- Length of a TX Response in byte
  constant C_NB_RESP     : integer := 10;  -- Number of possible respons

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




  -- == CONSTANTS COMMANDS LIST ==
  constant C_CMD_LIST : t_cmd_list_array := (
    0 => C_CMD_00,
    1 => C_CMD_01,
    2 => C_CMD_02,
    3 => C_CMD_03,
    4 => C_CMD_04,
    5 => C_CMD_05,
    6 => C_CMD_06,
    7 => C_CMD_07

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
                                        10     => UNDSCR,
                                        11     => D,
                                        12     => O,
                                        13     => N,
                                        14     => E,
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

  constant C_RESP_LIST : t_resp_list_array := (
    0      => C_RESP_00,
    1      => C_RESP_01,
    2      => C_RESP_02,
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

      -- INIT Scroller RAM
      i_init_scroller_ram_done : in  std_logic;
      o_init_scroller_ram      : out std_logic;  -- Init Scroller RAM Command

      -- TX Uart commands
      i_tx_done       : in  std_logic;
      o_tx_uart_start : out std_logic;
      o_tx_data       : out std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0)

      );
  end component;


  component static_ram_mngr is
    generic (

      G_RAM_ADDR_WIDTH_STATIC : integer := 8;    -- RAM STATIC ADDR WIDTH
      G_RAM_DATA_WIDTH_STATIC : integer := 16);  -- RAM STATIC DATA WIDTH

    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous clock

      -- RAM STATIC I/F
      i_rdata_static : in  std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM RDATA
      o_me_static    : out std_logic;
      o_we_static    : out std_logic;   -- W/R command
      o_addr_static  : out std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0);  -- RAM ADDR
      o_wdata_static : out std_logic_vector(G_RAM_DATA_WIDTH_STATIC - 1 downto 0);  -- RAM DATA

      i_init_static_ram      : in  std_logic;
      o_init_static_ram_done : out std_logic

      );
  end component;

end package pkg_uart_max7219_display_ctrl;
