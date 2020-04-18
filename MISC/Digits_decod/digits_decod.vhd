-------------------------------------------------------------------------------
-- Title      : Digits Decoder
-- Project    : 
-------------------------------------------------------------------------------
-- File       : digits_decod.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-18
-- Last update: 2020-04-18
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Digits Decoder
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-18  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity digits_decod is

  generic (
    G_DIGITS_NB  : integer range 2 to 8 := 8;    -- DIGITS Number to decod
    G_DATA_WIDTH : integer              := 32);  -- DATA WIDTH

  port (
    clk          : in  std_logic;       -- Clock
    rst_n        : in  std_logic;       -- Asynchronous Reset
    i_data2decod : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Data to decod
    i_val        : in  std_logic;       -- Input valid
    o_decod      : out std_logic_vector(G_DIGITS_NB*G_DATA_WIDTH - 1 downto 0);  -- Decod output
    o_done       : out std_logic);      -- Decod Done

end entity digits_decod;

architecture behv of digits_decod is

  -- COMPONENT
  component uint_division is

    generic (
      G_WIDTH : integer := 4);          -- Input Width

    port (
      clk     : in  std_logic;          -- Clock
      rst_n   : in  std_logic;          -- Asynchronous Reset
      i_start : in  std_logic;          -- Start the division    
      i_q     : in  std_logic_vector(G_WIDTH - 1 downto 0);  -- Dividend
      i_m     : in  std_logic_vector(G_WIDTH - 1 downto 0);  -- Divisor
      i_n     : in  std_logic_vector(G_WIDTH - 1 downto 0);  -- Number of useful bits in the dividend
      o_q     : out std_logic_vector(G_WIDTH - 1 downto 0);  -- Result
      o_r     : out std_logic_vector(G_WIDTH - 1 downto 0);  -- Remainder
      o_done  : out std_logic);         -- Result Available

  end component uint_division;

  -- CONSTANTS
  constant C_DIVISOR_10000000 : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := x"00989680";
  constant C_DIVISOR_1000000  : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := x"000F4240";
  constant C_DIVISOR_100000   : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := x"000186A0";
  constant C_DIVISOR_10000    : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := x"00002710";
  constant C_DIVISOR_1000     : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := x"000003E8";
  constant C_DIVISOR_100      : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := x"00000064";
  constant C_DIVISOR_10       : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := x"0000000A";

--  constant C_N : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := conv_std_logic_vector(G_DATA_WIDTH, C_N'length);

  -- INTERNAL SIGNALS
  signal s_n    : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
  signal s_done : std_logic_vector(G_DIGITS_NB - 1 downto 0);  -- DONE
  signal s_q    : std_logic_vector(G_DIGITS_NB*G_DATA_WIDTH - 1 downto 0);
  signal s_r    : std_logic_vector(G_DIGITS_NB*G_DATA_WIDTH - 1 downto 0);
  signal s_m    : std_logic_vector(G_DIGITS_NB*G_DATA_WIDTH - 1 downto 0);

  signal s_data2decod_sat : std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Data to Decod Saturate
  signal s_val            : std_logic;  -- S val
begin  -- architecture behv

  s_n <= conv_std_logic_vector(G_DATA_WIDTH, s_n'length);

  -- INPUTS SATURATION
  p_data2decod_saturation : process (clk, rst_n) is
  begin  -- process p_data2decod_saturation
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_data2decod_sat <= (others => '0');
      s_val            <= '0';
      s_m              <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge      
      if(i_val = '1') then
        s_val <= '1';
        case G_DIGITS_NB is
          when 8 =>
            if(i_data2decod > x"05F5E0FF") then
              s_data2decod_sat                                             <= x"05F5E0FF";
              s_m(G_DATA_WIDTH - 1 downto 0)                               <= C_DIVISOR_10000000;
              s_m(1*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto 1*G_DATA_WIDTH) <= C_DIVISOR_1000000;
              s_m(2*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto 2*G_DATA_WIDTH) <= C_DIVISOR_100000;
              s_m(3*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto 3*G_DATA_WIDTH) <= C_DIVISOR_10000;
              s_m(4*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto 4*G_DATA_WIDTH) <= C_DIVISOR_1000;
              s_m(5*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto 5*G_DATA_WIDTH) <= C_DIVISOR_100;
              s_m(6*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto 6*G_DATA_WIDTH) <= C_DIVISOR_10;
            end if;

          when others => null;
        end case;
      else
        s_val <= '0';
      end if;
    end if;
  end process p_data2decod_saturation;




  g_uint_division_0 : for i in 0 to G_DIGITS_NB - 2 generate
    -- end generate g_uint_division_0;

    gen_if_0 : if i = 0 generate

      uint_division_inst_0 : uint_division
        generic map (
          G_WIDTH => G_DATA_WIDTH
          )
        port map(
          clk     => clk,
          rst_n   => rst_n,
          i_start => s_val,
          i_q     => s_data2decod_sat,
          i_m     => s_m(G_DATA_WIDTH - 1 downto 0),
          i_n     => s_n,
          o_q     => s_q(G_DATA_WIDTH - 1 downto 0),
          o_r     => s_r(G_DATA_WIDTH - 1 downto 0),
          o_done  => s_done(i)
          );

    end generate gen_if_0;

    gen_if_1 : if i > 0 generate

      uint_division_inst_0 : uint_division
        generic map (
          G_WIDTH => G_DATA_WIDTH
          )
        port map(
          clk     => clk,
          rst_n   => rst_n,
          i_start => s_done(i),
          i_q     => s_s(i*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto i*G_DATA_WIDTH),
          i_m     => s_m(i*G_DATA_WIDTH + G_DATA_WIDTH - 1 downto i*G_DATA_WIDTH),
          i_n     => s_n,
          o_q     => o_q(G_DATA_WIDTH - 1 downto 0),
          o_r     => s_r(G_DATA_WIDTH - 1 downto 0),
          o_done  => s_done(i)
          );

    end generate gen_if_1;


  end generate g_uint_division_0;


end architecture behv;
