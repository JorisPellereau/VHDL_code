-------------------------------------------------------------------------------
-- Title      : Matrix config Manager
-- Project    : 
-------------------------------------------------------------------------------
-- File       : matrix_config_mngr.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-05-09
-- Last update: 2021-05-30
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-05-09  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_uart;
use lib_uart.pkg_uart.all;

library lib_uart_display_ctrl;
use lib_uart_display_ctrl.pkg_uart_max7219_display_ctrl.all;


entity matrix_config_mngr is

  generic (
    G_UART_DATA_WIDTH : integer range 5 to 9 := 8  -- UART RAM Data WIDTH
    );
  port (
    clk   : in std_logic;                          -- Clock
    rst_n : in std_logic;                          -- Asunchronous Reset

    i_config_done : in std_logic;       -- Config. Done from MAX7219 - TBD

    i_load_config      : in  std_logic;  -- Load Config. Command
    o_load_config_done : out std_logic;  --Load Config. Command done

    i_update_config      : in  std_logic;  -- New config Command    
    o_update_config_done : out std_logic;  -- Config. Done

    o_display_test : out std_logic;     -- Display test config.
    o_decod_mode   : out std_logic_vector(7 downto 0);
    o_intensity    : out std_logic_vector(7 downto 0);
    o_scan_limit   : out std_logic_vector(7 downto 0);
    o_shutdown     : out std_logic_vector(7 downto 0);

    -- RX UART I/F
    i_rx_data : in std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0);
    i_rx_done : in std_logic
    );

end entity matrix_config_mngr;

architecture behv of matrix_config_mngr is

  -- INTERNAL SIGNALS
  signal s_load_config_ongoing   : std_logic;
  signal s_update_config_ongoing : std_logic;
  signal s_update_config_done    : std_logic;

  signal s_cnt_5            : integer range 0 to 5;  -- Counter of receved data
  signal s_load_config_done : std_logic;

  signal s_display_test : std_logic;
  signal s_decod_mode   : std_logic_vector(7 downto 0);
  signal s_intensity    : std_logic_vector(7 downto 0);
  signal s_scan_limit   : std_logic_vector(7 downto 0);
  signal s_shutdown     : std_logic_vector(7 downto 0);

begin  -- architecture behv



  p_config_mngt : process (clk, rst_n) is
  begin  -- process p_config_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_load_config_ongoing   <= '0';
      s_update_config_ongoing <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(i_load_config = '1') then
        s_load_config_ongoing <= '1';

      elsif(s_load_config_done = '1') then
        s_load_config_ongoing <= '0';

      elsif(i_update_config = '1') then
        s_update_config_ongoing <= '1';

      elsif(s_update_config_done = '1') then
        s_update_config_ongoing <= '0';
      end if;

    end if;
  end process p_config_mngt;



  p_rx_data_mngt : process (clk, rst_n) is
  begin  -- process p_rx_data_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)

      s_cnt_5            <= 0;
      s_display_test     <= '0';
      s_decod_mode       <= (others => '0');
      s_intensity        <= (others => '0');
      s_scan_limit       <= x"07";--(others => '0');
      s_shutdown         <= x"01";--(others => '0');
      s_load_config_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_load_config_ongoing = '1' and s_load_config_done = '0') then

        if(i_rx_done = '1') then

          if(s_cnt_5 < 5) then
            if(s_cnt_5 = 0) then
              s_display_test <= i_rx_data(0);  -- TBD first_bit

            elsif(s_cnt_5 = 1) then
              s_decod_mode <= i_rx_data;

            elsif(s_cnt_5 = 2) then
              s_intensity <= i_rx_data;

            elsif(s_cnt_5 = 3) then
              s_scan_limit <= i_rx_data;

            elsif(s_cnt_5 = 4) then
              s_shutdown         <= i_rx_data;
              s_load_config_done <= '1';
            end if;

            s_cnt_5 <= s_cnt_5 + 1;     -- Inc
          --else
          --   s_load_config_done <= '1';
          end if;
        end if;
      else
        s_cnt_5            <= 0;
        s_load_config_done <= '0';
      end if;

    end if;
  end process p_rx_data_mngt;


  p_update_config_mngt : process (clk, rst_n) is
  begin  -- process p_update_config_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)

      s_update_config_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_update_config_ongoing = '1') then
        s_update_config_done <= '1';
      else
        s_update_config_done <= '0';
      end if;
    end if;
  end process p_update_config_mngt;


  -- Outputs Affectation
  o_display_test       <= s_display_test;
  o_decod_mode         <= s_decod_mode;
  o_intensity          <= s_intensity;
  o_scan_limit         <= s_scan_limit;
  o_shutdown           <= s_shutdown;
  o_load_config_done   <= s_load_config_done;
  o_update_config_done <= s_update_config_done;

end architecture behv;
