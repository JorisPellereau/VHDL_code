-------------------------------------------------------------------------------
-- Title      : UART Command Decoder
-- Project    : 
-------------------------------------------------------------------------------
-- File       : uart_cmd_decod.vhd
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-04-16
-- Last update: 2021-05-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: A decoder of UART command
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-04-16  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_uart_display_ctrl;
use lib_uart_display_ctrl.pkg_uart_max7219_display_ctrl.all;

entity uart_cmd_decod is

  generic (
    G_NB_CMD     : integer              := 4;   -- Command Number
    G_CMD_LENGTH : integer              := 10;  -- Command length
    G_DATA_WIDTH : integer range 5 to 9 := 8);  -- Data width

  port (
    clk          : in  std_logic;       -- Clock
    rst_n        : in  std_logic;       -- Asynchronous reset
    i_data       : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Data Input
    i_data_valid : in  std_logic;       -- Data Valid
    o_commands   : out std_logic_vector(G_NB_CMD - 1 downto 0);  -- Output Commands pulses
    o_discard    : out std_logic);      -- Command discard

end entity uart_cmd_decod;


architecture behv of uart_cmd_decod is

  -- INTERNAL SIGNALS
  signal s_cmd_2_store   : t_cmd_array;                   -- Command to store
  signal s_cnt_data      : std_logic_vector(7 downto 0);  -- Data counter
  signal s_cnt_data_done : std_logic;                     -- Counter reach

  signal s_commands : std_logic_vector(G_NB_CMD - 1 downto 0);  -- Commands pulses
  signal s_discard  : std_logic;        -- Command discard


  signal s_cmd_check : std_logic;       -- Command exist flag
  signal s_raz_cnt   : std_logic;       -- RAZ Counter
begin  -- architecture behv


  -- purpose: Store input data
  p_store_data : process (clk, rst_n) is
  begin  -- process p_store_data
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cmd_2_store <= (others => (others => '0'));
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Store Data
      if(i_data_valid = '1') then
        s_cmd_2_store(G_CMD_LENGTH - 1)      <= i_data;
        s_cmd_2_store(0 to G_CMD_LENGTH - 2) <= s_cmd_2_store(1 to G_CMD_LENGTH - 1);
      end if;

      -- if(s_raz_cnt = '1') then
      --   s_cmd_2_store <= (others => (others => '0'));
      -- end if;

    end if;
  end process p_store_data;


  -- purpose: Count incomming data
  p_cnt_data : process (clk, rst_n) is
  begin  -- process p_cnt_data
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cnt_data      <= (others => '0');
      s_cnt_data_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(i_data_valid = '1') then
        if(s_cnt_data < conv_std_logic_vector(G_CMD_LENGTH - 1, s_cnt_data'length)) then
          s_cnt_data <= unsigned(s_cnt_data) + 1;  -- Inc
        else
          s_cnt_data_done <= '1';
          s_cnt_data      <= (others => '0');
        end if;
      else
        s_cnt_data_done <= '0';
      end if;

      -- RAZ Counter TBD
      -- if(s_raz_cnt = '1') then
      --   s_cnt_data <= (others => '0');
      -- end if;

    end if;
  end process p_cnt_data;


  -- purpose: Check command received and gen. outputs
  p_check_cmd : process (clk, rst_n) is
  begin  -- process p_check_cmd
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_commands  <= (others => '0');
      s_discard   <= '0';
      s_cmd_check <= '0';
      s_raz_cnt   <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- TBD a changer
      if(s_cnt_data_done = '1') then
        for i in 0 to G_NB_CMD - 1 loop

          -- Generate Pulse if exist
          if(s_cmd_2_store = C_CMD_LIST(i)) then
            s_commands(i) <= '1';
          else
            s_commands(i) <= '0';
          end if;

        end loop;  -- i
        s_cmd_check <= '1';
      else
        s_commands  <= (others => '0');
        s_discard   <= '0';
        s_cmd_check <= '0';
      end if;



      -- Check the command
      if(s_cmd_check = '1') then
        if(s_commands = conv_std_logic_vector(0, s_commands'length)) then
          s_discard <= '1';

        -- Case command exist
        else
          s_discard <= '0';
        end if;

        s_raz_cnt <= '1';
      else
        s_raz_cnt <= '0';
      end if;


    end if;
  end process p_check_cmd;


  -- Outputs affectation
  o_commands <= s_commands;
  o_discard  <= s_discard;


end architecture behv;
