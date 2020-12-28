-------------------------------------------------------------------------------
-- Title      : Load Ram Injector
-- Project    : 
-------------------------------------------------------------------------------
-- File       : load_ram_injector.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-12-27
-- Last update: 2020-12-28
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Load RAM Injector
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-27  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity load_ram_injector is

  generic (
    G_RAM_ADDR_WIDTH : integer := 8;
    G_RAM_DATA_WIDTH : integer := 8;
    G_SEL_WIDTH      : integer := 8);

  port (
    clk   : in std_logic;
    rst_n : in std_logic;

    i_ram_start_addr : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
    i_ram_stop_addr  : in std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
    i_sel            : in std_logic_vector(G_SEL_WIDTH - 1 downto 0);
    i_start          : in std_logic;

    o_me    : out std_logic;
    o_we    : out std_logic;
    o_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
    o_wdata : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);
    i_rdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);

    o_done : out std_logic);

end entity load_ram_injector;

architecture behv of load_ram_injector is

  -- TYPES
  type t_cst_array is array (0 to 63) of std_logic_vector(7 downto 0);
  type t_cst_array_256 is array(0 to 255) of std_logic_vector(7 downto 0);

  -- CONSTANTS
  constant C_PATTERN_0 : t_cst_array := (
    0  => x"00",
    1  => x"3c",
    2  => x"7e",
    3  => x"7e",
    4  => x"7e",
    5  => x"7e",
    6  => x"3c",
    7  => x"00",
    8  => x"00",
    9  => x"00",
    10 => x"02",
    11 => x"03",
    12 => x"01",
    13 => x"03",
    14 => x"06",
    15 => x"0c",
    16 => x"18",
    17 => x"30",
    18 => x"60",
    19 => x"c0",
    20 => x"80",
    21 => x"80",
    22 => x"c0",
    23 => x"60",
    24 => x"30",
    25 => x"18",
    26 => x"0c",
    27 => x"06",
    28 => x"03",
    29 => x"01",
    30 => x"03",
    31 => x"06",
    32 => x"0c",
    33 => x"18",
    34 => x"30",
    35 => x"60",
    36 => x"c0",
    37 => x"80",
    38 => x"80",
    39 => x"c0",
    40 => x"60",
    41 => x"30",
    42 => x"18",
    43 => x"0c",
    44 => x"06",
    45 => x"03",
    46 => x"01",
    47 => x"03",
    48 => x"06",
    49 => x"0c",
    50 => x"18",
    51 => x"30",
    52 => x"60",
    53 => x"c0",
    54 => x"80",
    55 => x"00",
    56 => x"00",
    57 => x"3c",
    58 => x"7e",
    59 => x"7e",
    60 => x"7e",
    61 => x"7e",
    62 => x"3c",
    63 => x"00"
    );

  constant C_PATTERN_1 : t_cst_array := (
    0  => x"ff",
    1  => x"c3",
    2  => x"81",
    3  => x"81",
    4  => x"81",
    5  => x"81",
    6  => x"c3",
    7  => x"ff",
    8  => x"ff",
    9  => x"ff",
    10 => x"fd",
    11 => x"fc",
    12 => x"fe",
    13 => x"fc",
    14 => x"f9",
    15 => x"f3",
    16 => x"e7",
    17 => x"cf",
    18 => x"9f",
    19 => x"3f",
    20 => x"7f",
    21 => x"7f",
    22 => x"3f",
    23 => x"9f",
    24 => x"cf",
    25 => x"e7",
    26 => x"f3",
    27 => x"f9",
    28 => x"fc",
    29 => x"fe",
    30 => x"fc",
    31 => x"f9",
    32 => x"f3",
    33 => x"e7",
    34 => x"cf",
    35 => x"9f",
    36 => x"3f",
    37 => x"7f",
    38 => x"7f",
    39 => x"3f",
    40 => x"9f",
    41 => x"cf",
    42 => x"e7",
    43 => x"f3",
    44 => x"f9",
    45 => x"fc",
    46 => x"fe",
    47 => x"fc",
    48 => x"f9",
    49 => x"f3",
    50 => x"e7",
    51 => x"cf",
    52 => x"9f",
    53 => x"3f",
    54 => x"7f",
    55 => x"ff",
    56 => x"ff",
    57 => x"c3",
    58 => x"81",
    59 => x"81",
    60 => x"81",
    61 => x"81",
    62 => x"c3",
    63 => x"ff"
    );


  constant C_PATTERN_2 : t_cst_array_256 := (
    0      => x"00",
    1      => x"3c",
    2      => x"7e",
    3      => x"7e",
    4      => x"7e",
    5      => x"7e",
    6      => x"3c",
    7      => x"00",
    8      => x"00",
    9      => x"00",
    10     => x"02",
    11     => x"03",
    12     => x"01",
    13     => x"03",
    14     => x"06",
    15     => x"0c",
    16     => x"18",
    17     => x"30",
    18     => x"60",
    19     => x"c0",
    20     => x"80",
    21     => x"80",
    22     => x"c0",
    23     => x"60",
    24     => x"30",
    25     => x"18",
    26     => x"0c",
    27     => x"06",
    28     => x"03",
    29     => x"01",
    30     => x"03",
    31     => x"06",
    32     => x"0c",
    33     => x"18",
    34     => x"30",
    35     => x"60",
    36     => x"c0",
    37     => x"80",
    38     => x"80",
    39     => x"c0",
    40     => x"60",
    41     => x"30",
    42     => x"18",
    43     => x"0c",
    44     => x"06",
    45     => x"03",
    46     => x"01",
    47     => x"03",
    48     => x"06",
    49     => x"0c",
    50     => x"18",
    51     => x"30",
    52     => x"60",
    53     => x"c0",
    54     => x"80",
    55     => x"00",
    56     => x"00",
    57     => x"3c",
    58     => x"7e",
    59     => x"7e",
    60     => x"7e",
    61     => x"7e",
    62     => x"3c",
    63     => x"00",
    others => x"AA"
    );

  -- INTERNAL Signals
  signal s_start        : std_logic;    -- Latch i_start
  signal s_start_r_edge : std_logic;    -- i_start Rising Edge detected
  signal s_en_access    : std_logic;

  signal s_ram_start_addr : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_ram_stop_addr  : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_sel            : std_logic_vector(G_SEL_WIDTH - 1 downto 0);

  signal s_addr_cnt       : integer range 0 to 2**G_SEL_WIDTH;
  signal s_addr_cnt_reach : std_logic;
  signal s_addr_reach     : std_logic;

  signal s_me    : std_logic;
  signal s_we    : std_logic;
  signal s_addr  : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_wdata : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);


begin  -- architecture behv


  -- purpose: Latch Inputs 
  p_latch_in : process (clk, rst_n) is
  begin  -- process p_latch_in
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_start <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_start <= i_start;
    end if;
  end process p_latch_in;

  -- Rising Edge detection
  s_start_r_edge <= i_start and not s_start;


  p_latch_in_on_r_edge : process (clk, rst_n) is
  begin  -- process p_latch_in_on_r_edge
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_ram_start_addr <= (others => '0');
      s_ram_stop_addr  <= (others => '0');
      s_sel            <= (others => '0');
      s_en_access      <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_start_r_edge = '1') then
        s_ram_start_addr <= i_ram_start_addr;
        s_ram_stop_addr  <= i_ram_stop_addr;
        s_sel            <= i_sel;
        s_en_access      <= '1';
      elsif(s_addr_cnt_reach = '1') then
        s_en_access <= '0';
      end if;
    end if;
  end process p_latch_in_on_r_edge;


  p_gen_ram_access : process (clk, rst_n) is
  begin  -- process p_gen_ram_access
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_me             <= '0';
      s_we             <= '0';
      s_addr           <= (others => '0');
      s_wdata          <= (others => '0');
      s_addr_reach     <= '0';
      s_addr_cnt       <= 0;
      s_addr_cnt_reach <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_en_access = '1' and s_addr_cnt_reach = '0') then
        s_me   <= '1';
        s_we   <= '1';
        s_addr <= s_ram_start_addr;
      else
        s_me <= '0';
        s_we <= '0';
      end if;

      s_addr_reach <= '0';
      if(s_me = '1')then
        if(s_addr < s_ram_stop_addr) then
          s_addr <= unsigned(s_addr) + 1;
        else
          s_addr_reach <= '1';
        end if;
      end if;

      if(s_en_access = '1') then

        -- PATTERN Selector
        if(s_sel = x"00") then
          s_wdata <= C_PATTERN_0(s_addr_cnt);
        elsif(s_sel = x"01") then
          s_wdata <= C_PATTERN_1(s_addr_cnt);
        elsif(s_sel = x"02") then
          s_wdata <= C_PATTERN_2(s_addr_cnt);
        end if;

        if(s_sel = x"00" or s_sel = x"01") then
          if(s_addr_cnt < C_PATTERN_0'length - 1) then
            s_addr_cnt <= s_addr_cnt + 1;
          else
            s_addr_cnt_reach <= '1';
          end if;
        elsif(s_sel = x"02") then
          if(s_addr_cnt < C_PATTERN_2'length - 1) then
            s_addr_cnt <= s_addr_cnt + 1;
          else
            s_addr_cnt_reach <= '1';
          end if;
        end if;

      else
        s_addr_cnt       <= 0;
        s_addr_cnt_reach <= '0';
      end if;

    end if;
  end process p_gen_ram_access;


  -- Outputs affectation
  o_me    <= s_me;
  o_we    <= s_we;
  o_addr  <= s_addr;
  o_wdata <= s_wdata;
  o_done  <= s_addr_cnt_reach;

end architecture behv;
