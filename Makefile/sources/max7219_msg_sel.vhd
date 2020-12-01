-------------------------------------------------------------------------------
-- Title      : MAX7219 MESSAGE SELECTOR
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_msg_sel.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2020-07-19
-- Last update: 2020-07-19
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 MESSAGE SELECTOR
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-07-19  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_msg_sel is

  generic (
    G_DIGITS_NB : integer range 2 to 8 := 8);          -- DIGIT NB
  port (
    clk           : in  std_logic;                     -- Clock
    rst_n         : in  std_logic;                     -- Asynchronous Reset
    i_msg_sel     : in  std_logic_vector(7 downto 0);  -- MSG SEL
    i_msg_sel_val : in  std_logic;                     -- MSG SEL VALID
    o_msg_cmd     : out std_logic_vector(G_DIGITS_NB*8 - 1 downto 0);
    o_msg_cmd_val : out std_logic);                    -- MSG CMD VAL

end entity max7219_msg_sel;


architecture behv of max7219_msg_sel is

begin  -- architecture behv

  p_msg_cmd_mngt : process (clk, rst_n) is
  begin  -- process p_msg_cmd_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_msg_cmd_val <= '0';
      o_msg_cmd     <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(i_msg_sel_val = '1') then

        case i_msg_sel is

          -- HELLO !!
          when x"00" =>
            o_msg_cmd <= x"07040B0B0E1A1B1B";

          -- PLAYER  
          when x"01" =>
            o_msg_cmd <= x"0F0B001804111A1A";

          -- >>> ONE !
          when x"02" =>
            o_msg_cmd <= x"1C1C1C1A0E0D041B";

          when others =>
            o_msg_cmd <= x"1B1B1B1B1B1B1B1B";
        end case;
        o_msg_cmd_val <= '1';
      else
        o_msg_cmd_val <= '0';
      end if;

    end if;
  end process p_msg_cmd_mngt;

end architecture behv;
