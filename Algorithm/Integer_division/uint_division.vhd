-------------------------------------------------------------------------------
-- Title      : UINT DIVISION
-- Project    : 
-------------------------------------------------------------------------------
-- File       : uint_division.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-04-17
-- Last update: 2020-06-14
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Unsigned Integer Restoring Division
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-04-17  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity uint_division is

  generic (
    G_WIDTH : integer := 4);            -- Input Width

  port (
    clk     : in  std_logic;            -- Clock
    rst_n   : in  std_logic;            -- Asynchronous Reset
    i_start : in  std_logic;            -- Start the division    
    i_q     : in  std_logic_vector(G_WIDTH - 1 downto 0);  -- Dividend
    i_m     : in  std_logic_vector(G_WIDTH - 1 downto 0);  -- Divisor
    i_n     : in  std_logic_vector(G_WIDTH - 1 downto 0);  -- Number of useful bits in the dividend
    o_q     : out std_logic_vector(G_WIDTH - 1 downto 0);  -- Result
    o_r     : out std_logic_vector(G_WIDTH - 1 downto 0);  -- Remainder
    o_done  : out std_logic);           -- Result Available

end entity uint_division;

architecture behv of uint_division is

  -- TYPE
  type t_division_states is (IDLE, SHIFT_REG, SUB, CHECK_MSB, CHECK_CNT, DIV_DONE);  -- States

  -- INTERNAL SIGNALS
  signal s_current_state : t_division_states;  -- Current state
  signal s_next_state    : t_division_states;  -- Next State


  -- RESTORING & DIVIDEND computation
  signal s_reg : std_logic_vector(2*G_WIDTH - 1 downto 0);

  signal s_m   : std_logic_vector(G_WIDTH - 1 downto 0);  -- Latch Divisor
  signal s_cnt : std_logic_vector(G_WIDTH - 1 downto 0);  -- Counter

  signal s_cnt_done   : std_logic;      -- Down Count Done
  signal s_shift_done : std_logic;      -- Shift Done
  signal s_sub_done   : std_logic;      -- Sub Done

begin  -- architecture behv

  p_current_state_mngt : process (clk, rst_n) is
  begin  -- process p_current_state_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_current_state <= IDLE;
      s_next_state    <= IDLE;
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_current_state <= s_next_state;
      case s_current_state is
        when IDLE =>
          if(i_start = '1') then
            s_next_state <= SHIFT_REG;
          end if;

        when SHIFT_REG =>
          s_next_state <= SUB;

        when SUB =>
          s_next_state <= CHECK_MSB;

        when CHECK_MSB =>
          s_next_state <= CHECK_CNT;

        when CHECK_CNT =>
          if(conv_integer(unsigned(s_cnt)) > 0) then
            s_next_state <= SHIFT_REG;
          else
            s_next_state <= DIV_DONE;
          end if;

        when DIV_DONE =>
          s_next_state <= IDLE;

        when others => null;
      end case;

    end if;
  end process p_current_state_mngt;

  -- p_next_state_computation : process (clk, rst_n) is
  -- begin  -- process p_next_state_computation
  --   if rst_n = '0' then                 -- asynchronous reset (active low)
  --     s_next_state <= IDLE;
  --   elsif clk'event and clk = '1' then  -- rising clock edge
  --     case s_current_state is
  --       when IDLE =>
  --         if(i_start = '1') then
  --           s_next_state <= SHIFT_REG;
  --         end if;

  --       when SHIFT_REG =>
  --         s_next_state <= SUB;

  --       when SUB =>
  --         s_next_state <= CHECK_MSB;

  --       when CHECK_MSB =>
  --         s_next_state <= CHECK_CNT;

  --       when CHECK_CNT =>
  --         if(conv_integer(unsigned(s_cnt)) > 0) then
  --           s_next_state <= SHIFT_REG;
  --         else
  --           s_next_state <= DIV_DONE;
  --         end if;

  --       when DIV_DONE =>
  --         s_next_state <= IDLE;

  --       when others => null;
  --     end case;
  --   end if;
  -- end process p_next_state_computation;

  -- p_next_state_computation : process (s_current_state, i_start, s_cnt) is
  -- begin  -- process p_next_state_computation

  --   case s_current_state is
  --     when IDLE =>
  --       if(i_start = '1') then
  --         s_next_state <= SHIFT_REG;
  --       end if;

  --     when SHIFT_REG =>
  --       s_next_state <= SUB;

  --     when SUB =>
  --       s_next_state <= CHECK_MSB;

  --     when CHECK_MSB =>
  --       s_next_state <= CHECK_CNT;

  --     when CHECK_CNT =>
  --       if(conv_integer(unsigned(s_cnt)) > 0) then
  --         s_next_state <= SHIFT_REG;
  --       else
  --         s_next_state <= DIV_DONE;
  --       end if;

  --     when DIV_DONE =>
  --       s_next_state <= IDLE;

  --     when others => null;
  --   end case;

  -- end process p_next_state_computation;

  p_action_mngt : process (clk, rst_n) is
  begin  -- process p_action_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_reg        <= (others => '0');
      s_m          <= (others => '0');
      s_cnt        <= (others => '0');
      o_done       <= '0';
      o_q          <= (others => '0');
      o_r          <= (others => '0');
      s_cnt_done   <= '0';
      s_shift_done <= '0';
      s_sub_done   <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge


      o_done <= '0';                    -- PULSE
      case s_current_state is

        when IDLE =>
          s_cnt_done   <= '0';
          s_shift_done <= '0';
          s_sub_done   <= '0';
          if(i_start = '1') then
            s_reg(G_WIDTH - 1 downto 0)         <= i_q;  -- INIT REG
            s_reg(2*G_WIDTH - 1 downto G_WIDTH) <= (others => '0');  -- INIT Restor
            s_m                                 <= i_m;
            s_cnt                               <= i_n;
          end if;

        when SHIFT_REG =>
          if(s_shift_done = '0') then
            s_reg(2*G_WIDTH - 1 downto 1) <= s_reg(2*G_WIDTH - 2 downto 0);  -- SHIFT LEFT
            s_shift_done                  <= '1';
          end if;

        when SUB =>
          s_shift_done <= '0';
          if(s_sub_done = '0') then
            s_reg(2*G_WIDTH - 1 downto G_WIDTH) <= unsigned(s_reg(2*G_WIDTH - 1 downto G_WIDTH)) - unsigned(s_m);
            s_sub_done                          <= '1';
          end if;

        when CHECK_MSB =>
          s_sub_done <= '0';
          if(s_cnt_done = '0') then
            s_cnt      <= unsigned(s_cnt) - 1;  -- DOWN COUNT
            s_cnt_done <= '1';

            if(s_reg(2*G_WIDTH - 1) = '0') then
              s_reg(0) <= '1';
            else
              s_reg(0)                            <= '0';
              s_reg(2*G_WIDTH - 1 downto G_WIDTH) <= unsigned(s_reg(2*G_WIDTH - 1 downto G_WIDTH)) + unsigned(s_m);
            end if;
          end if;

        when CHECK_CNT =>
          s_cnt_done <= '0';

        when DIV_DONE =>
          o_done <= '1';
          o_q    <= s_reg(G_WIDTH - 1 downto 0);
          o_r    <= s_reg(2*G_WIDTH - 1 downto G_WIDTH);

        when others => null;
      end case;
    end if;
  end process p_action_mngt;

end architecture behv;
