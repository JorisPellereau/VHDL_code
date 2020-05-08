-------------------------------------------------------------------------------
-- Title      : MAX7219 COMMAND ORGANIZER
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_cmd_organizer.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-05-03
-- Last update: 2020-05-08
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 COMMAND ORGANIZER
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-05-03  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_cmd_organizer is

  generic (
    G_RAM_DATA_WIDTH : integer              := 16;  -- RAM DATA SIZE
    G_DIGITS_NB      : integer range 2 to 8 := 8);  -- DIGITS Number on the DISPLAY

  port (
    clk               : in  std_logic;  -- Clock
    rst_n             : in  std_logic;  -- Asynchronous reset
    i_score_decod     : in  std_logic_vector(G_DIGITS_NB*4 - 1 downto 0);  -- SCORE DECODED
    i_score_decod_val : in  std_logic;  -- SCORE DECOD valid
    o_score_cmd       : out t_score_array;  -- ARRAY of SCORE
    o_score_val       : out std_logic
    );

end entity max7219_cmd_organizer;

architecture behv of max7219_cmd_organizer is

  -- INTERNAL SIGNALS
  signal s_segs_7 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);
  signal s_segs_6 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);
  signal s_segs_5 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);
  signal s_segs_4 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);
  signal s_segs_3 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);
  signal s_segs_2 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);
  signal s_segs_1 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);
  signal s_segs_0 : std_logic_vector(G_DIGITS_NB*12 - 1 downto 0);

  signal s_digits2conf_done : std_logic_vector(G_DIGITS_NB - 1 downto 0);

  signal s_conf_done : std_logic;       -- Config. Done
  signal s_set_done  : std_logic;

begin  -- architecture behv

  g_digits2conf_inst_0 : for i in 0 to G_DIGITS_NB - 1 generate
    i_digits2conf_inst : max7219_digit2conf
      port map (
        clk     => clk,
        rst_n   => rst_n,
        i_digit => i_score_decod(i*4 + 3 downto i*4),
        i_val   => i_score_decod_val,
        o_seg_7 => s_segs_7((12*(G_DIGITS_NB -i)- 1) downto 12*(G_DIGITS_NB - 1 - i)),
        o_seg_6 => s_segs_6((12*(G_DIGITS_NB -i)- 1) downto 12*(G_DIGITS_NB - 1 - i)),
        o_seg_5 => s_segs_5((12*(G_DIGITS_NB -i)- 1) downto 12*(G_DIGITS_NB - 1 - i)),
        o_seg_4 => s_segs_4((12*(G_DIGITS_NB -i)- 1) downto 12*(G_DIGITS_NB - 1 - i)),
        o_seg_3 => s_segs_3((12*(G_DIGITS_NB -i)- 1) downto 12*(G_DIGITS_NB - 1 - i)),
        o_seg_2 => s_segs_2((12*(G_DIGITS_NB -i)- 1) downto 12*(G_DIGITS_NB - 1 - i)),
        o_seg_1 => s_segs_1((12*(G_DIGITS_NB -i)- 1) downto 12*(G_DIGITS_NB - 1 - i)),
        o_seg_0 => s_segs_0((12*(G_DIGITS_NB -i)- 1) downto 12*(G_DIGITS_NB - 1 - i)),
        o_done  => s_digits2conf_done(i)
        );
  end generate g_digits2conf_inst_0;

  --s_seg MATRIX0 on MSB

  -- o_seg_7 => s_segs_7(i*12 + 11 downto i*12),
  -- o_seg_6 => s_segs_6(i*12 + 11 downto i*12),
  -- o_seg_5 => s_segs_5(i*12 + 11 downto i*12),
  -- o_seg_4 => s_segs_4(i*12 + 11 downto i*12),
  -- o_seg_3 => s_segs_3(i*12 + 11 downto i*12),
  -- o_seg_2 => s_segs_2(i*12 + 11 downto i*12),
  -- o_seg_1 => s_segs_1(i*12 + 11 downto i*12),
  -- o_seg_0 => s_segs_0(i*12 + 11 downto i*12),

  s_conf_done <= s_digits2conf_done(0);


  -- SCORE_CMD MNGT
  p_score_cmd_mngt : process (clk, rst_n) is
  begin  -- process p_score_cmd_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_score_cmd <= (others => (others => '0'));
      s_set_done  <= '0';
      o_score_val <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_conf_done = '1') then
        for j in 0 to G_DIGITS_NB - 1 loop

          -- SET Command
          o_score_cmd(j)                 <= x"0" & s_segs_0((12*(G_DIGITS_NB -j)- 1) downto 12*(G_DIGITS_NB - 1 - j));
          o_score_cmd(j + 1*G_DIGITS_NB) <= x"0" & s_segs_1((12*(G_DIGITS_NB -j)- 1) downto 12*(G_DIGITS_NB - 1 - j));
          o_score_cmd(j + 2*G_DIGITS_NB) <= x"0" & s_segs_2((12*(G_DIGITS_NB -j)- 1) downto 12*(G_DIGITS_NB - 1 - j));
          o_score_cmd(j + 3*G_DIGITS_NB) <= x"0" & s_segs_3((12*(G_DIGITS_NB -j)- 1) downto 12*(G_DIGITS_NB - 1 - j));
          o_score_cmd(j + 4*G_DIGITS_NB) <= x"0" & s_segs_4((12*(G_DIGITS_NB -j)- 1) downto 12*(G_DIGITS_NB - 1 - j));
          o_score_cmd(j + 5*G_DIGITS_NB) <= x"0" & s_segs_5((12*(G_DIGITS_NB -j)- 1) downto 12*(G_DIGITS_NB - 1 - j));
          o_score_cmd(j + 6*G_DIGITS_NB) <= x"0" & s_segs_6((12*(G_DIGITS_NB -j)- 1) downto 12*(G_DIGITS_NB - 1 - j));
          o_score_cmd(j + 7*G_DIGITS_NB) <= x"0" & s_segs_7((12*(G_DIGITS_NB -j)- 1) downto 12*(G_DIGITS_NB - 1 - j));
        end loop;  -- j
        s_set_done <= '1';
      else
        s_set_done <= '0';
      end if;

      if(s_set_done = '1') then
        for k in 0 to 7 loop
          -- Set Load
          o_score_cmd(G_DIGITS_NB*(k + 1) - 1)(12) <= '1';
          o_score_val                              <= '1';
        end loop;
      else
        o_score_val <= '0';
      end if;
    end if;
  end process p_score_cmd_mngt;

end architecture behv;
