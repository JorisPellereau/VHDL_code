-------------------------------------------------------------------------------
-- Title      : WS2812 Reset management
-- Project    : 
-------------------------------------------------------------------------------
-- File       : ws2812_rst_mng.vhd
-- Author     : root  <pellerj@localhost.localdomain>
-- Company    : 
-- Last update: 2019/09/04
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: This module manages the reset generation of the WS2812 module
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019/09/03  1.0      pellerj Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;

entity ws2812_rst_mng is

  port (
    clock_i       : in  std_logic;      -- System clock
    reset_n       : in  std_logic;      -- Asychronous active low reset
    en_start_i    : in  std_logic;      -- Enable the frame generation
    reset_gen_i   : in  std_logic;      -- Command for the reset genration
    config_done_i : in  std_logic;      -- Config done from the WS2812_mngt
    start_leds_o  : out std_logic);     -- Start config, to the WS2812 MNGT

end ws2812_rst_mng;

architecture arch_ws2812_rst_mng of ws2812_rst_mng is


  -- CONSTANTS

  -- RESET deration
  constant C_MAX_RESET : std_logic_vector(15 downto 0) := x"000F";


  -- INTERNAL SIGNALS
  signal config_done_s      : std_logic;  -- Old config done
  signal config_done_r_edge : std_logic;  -- REdge of config done

  signal cnt_rst_s   : unsigned(15 downto 0);  -- Counter for the reset generation  
  signal start_cnt_s : std_logic;       -- Start the counter
  signal rst_done_s  : std_logic;       -- Reset done

  signal en_start_i_s  : std_logic;     -- Old en_start_i
  signal en_start_i_ss : std_logic;     -- Old en_start_i_s

  signal reset_gen_i_s  : std_logic;    -- Old en_start_i
  signal reset_gen_i_ss : std_logic;    -- Old reset_gen_i_s

  signal start_leds_o_s : std_logic;    -- To the output start_leds_o

begin  -- arch_ws2812_rst_mng

  -- purpose: This process manages the R_edge of the inputs 
  p_r_edge_mng : process (clock_i, reset_n)
  begin  -- process p_r_edge_mng
    if reset_n = '0' then               -- asynchronous reset (active low)
      config_done_s <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      config_done_s <= config_done_i;
    end if;
  end process p_r_edge_mng;

  -- Rising edge from the WS2812_mngt module
  config_done_r_edge <= config_done_i and not config_done_s;


  -- purpose: This process latches inputs
  p_latch_intputs : process (clock_i, reset_n)
  begin  -- process p_latch_intputs
    if reset_n = '0' then               -- asynchronous reset (active low)
      en_start_i_s   <= '0';
      en_start_i_ss  <= '0';
      reset_gen_i_s  <= '0';
      reset_gen_i_ss <= '0';

    elsif clock_i'event and clock_i = '1' then  -- rising clock edge
      en_start_i_s   <= en_start_i;
      en_start_i_ss  <= en_start_i_s;
      reset_gen_i_s  <= reset_gen_i;
      reset_gen_i_ss <= reset_gen_i_s;

    end if;
  end process p_latch_intputs;

  -- purpose: This process manages the start_leds output
  p_start_leds_mng : process (clock_i, reset_n)
  begin  -- process p_start_leds_mng
    if reset_n = '0' then               -- asynchronous reset (active low)
      start_leds_o_s <= '0';
      start_cnt_s    <= '0';
      cnt_rst_s      <= (others => '0');
      rst_done_s     <= '0';
    elsif clock_i'event and clock_i = '1' then  -- rising clock edge


      if(en_start_i_ss = '0') then
        start_leds_o_s <= '0';
        start_cnt_s    <= '0';
        cnt_rst_s      <= (others => '0');
        rst_done_s     <= '0';

        -- En = 1 => start
      elsif(en_start_i_ss = '1' and reset_gen_i_ss = '0') then

        start_leds_o_s   <= '1';
        -- On the REdge of config_done
        if(config_done_r_edge = '1') then
          start_leds_o_s <= '0';
        end if;

      elsif(en_start_i_ss = '1' and reset_gen_i_ss = '1') then
        if(config_done_r_edge = '1') then
          start_cnt_s <= '1';
        end if;

        if(start_cnt_s = '1') then
          if(cnt_rst_s < unsigned(C_MAX_RESET) - 1) then
            cnt_rst_s      <= cnt_rst_s + 1;
          else
            cnt_rst_s      <= (others => '0');
            rst_done_s     <= '1';
            start_cnt_s    <= '0';
            start_leds_o_s <= '1';
          end if;
        end if;

        if(rst_done_s = '1') then
          start_leds_o_s <= '0';
          rst_done_s     <= '0';
        end if;

      end if;





    end if;
  end process p_start_leds_mng;

  -- OUTPUT affectation
  start_leds_o <= start_leds_o_s;


end arch_ws2812_rst_mng;
