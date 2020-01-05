-------------------------------------------------------------------------------
-- Title      : MAX7219 Command Interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_cmd_if.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-01-05
-- Last update: 2020-01-05
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the Command interface with the MAX7219_interface module
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-01-05  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.Std_Logic_Arith.all;

entity max7219_cmd_if is
  generic(G_MATRIX_NB : integer := 8)
    port (
      clk               : in  std_logic;  -- System Closk
      rst_n             : in  std_logic;  -- Asynchronous reset
      i_send_cmd        : in  std_logic;  -- Send a command to WS7219_interface
      i_max7219_done    : in  std_logic;  -- Frame done
      i_matrix_sel      : in  std_logic_vector(3 downto 0);  -- Matrix selection
      i_ws7219_reg_addr : in  std_logic_vector(7 downto 0);  -- REG Addr
      i_ws7219_wdata    : in  std_logic_vector(7 downto 0);  -- Data to write in the register
      o_max7219_data    : out std_logic_vector(15 downto 0);  -- Data to send
      o_en_load         : out std_logic;  -- Load the register
      o_start           : out std_logic;  -- Start the frame
      o_cmd_done        : out std_logic);                    -- Command send

end entity max7219_cmd_if;

architecture behv of max7219_cmd_if is

  -- Internal signals
  signal s_send_cmd        : std_logic;  -- Latch i_send_cmd
  signal s_send_cmd_r_edge : std_logic;  -- R_Edge of i_send_cmd

  signal s_matrix_sel      : std_logic_vector(3 downto 0);  -- Latch matrix selection
  signal s_ws7219_reg_addr : std_logic_vector(7 downto 0);  -- Latch reg addr
  signal s_ws7219_wdata    : std_logic_vector(7 downto 0);  -- Latch WDATA

  signal s_cur_reg_addr : std_logic_vector(7 downto 0);  -- Latch reg addr
  signal s_cur_wdata    : std_logic_vector(7 downto 0);  -- Latch WDATA

  signal s_start_cmd : std_logic;       -- Start sending command

  signal s_cnt_matrix : unsigned(3 downto 0);  -- Counter for the number of matrix

begin  -- architecture behv

  -- purpose: This process latches inputs
  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_send_cmd  <= '0';
      s_start_cmd <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_send_cmd  <= i_send_cmd;
      s_start_cmd <= '0';
      if(s_send_cmd_r_edge = '1') then
        s_matrix_sel      <= i_matrix_sel;
        s_ws7219_reg_addr <= i_ws7219_reg_addr;
        s_ws7219_wdata    <= i_ws7219_wdata;
        s_start_cmd       <= '1';
      end if;
    end if;
  end process p_latch_inputs;

  s_send_cmd_r_edge <= i_send_cmd and not s_send_cmd;


  -- purpose: This process generates the command for the WS7219 I/F 
  p_cmd_mngt : process (clk, rst_n) is
  begin  -- process p_cmd_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cur_reg_addr <= (others => '0');
      s_cur_wdata    <= (others => '0');
      o_en_load      <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_start_cmd = '1' or i_max7219_done = '1') then

        -- Case in 1 Matrix sel at a time
        if(s_matrix_sel < conv_unsigned(G_MATRIX_NB, s_matrix_sel'length)) then

          if(s_cnt_matrix < unsigned(s_matrix_sel)) then
            s_cnt_matrix <= s_cnt_matrix + 1;
          else

          end if;

        -- Case All Matrix are selected
        else
          o_en_load <= '1';
          if(s_cnt_matrix < unsigned(s_matrix_sel)) then

          else

          end if;
        end if;

      end if;
    end if;
  end process p_cmd_mngt;

  o_max7219_data <= s_cur_reg_addr & s_cur_wdata;

end architecture behv;
