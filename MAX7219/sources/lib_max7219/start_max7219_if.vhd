-------------------------------------------------------------------------------
-- Title      : Start MAX7212 IF
-- Project    : 
-------------------------------------------------------------------------------
-- File       : start_max7219_if.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-12-06
-- Last update: 2023-12-21
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This block manages the start of a new transfert of data to MAX7219
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-12-06  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity start_max7219_if is
  port (
    clk_sys    : in  std_logic;         -- Clock System
    rst_n_sys  : in  std_logic;         -- Asynchronous Reset
    fifo_empty : in  std_logic;         -- Fifo Empty info
    enable     : in  std_logic;         -- Enable signal
    rd_en      : out std_logic;         -- FIFO Read Enable
    done       : in  std_logic          -- MAX7219 Access Done
    );
end entity start_max7219_if;

architecture rtl of start_max7219_if is

  -- == TYPES ==
  type t_fsm_state is (IDLE, RD_FIFO, WAIT_DONE);  -- FSM States

  -- == Signals ==
  signal fsm_cs : t_fsm_state;          -- Current State
  signal fsm_ns : t_fsm_state;          -- Next state

begin  -- architecture rtl

  -- purpose: Update of the current state in function of the next state
  p_cs_update : process (clk_sys, rst_n_sys) is
  begin  -- process p_cs_update
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fsm_cs <= IDLE;
    elsif rising_edge(clk_sys) then     -- rising clock edge
      fsm_cs <= fsm_ns;
    end if;
  end process p_cs_update;

  -- purpose: FSM Next State management
  p_ns_update : process (fsm_cs, fifo_empty, done) is
  begin  -- process p_ns_update

    case fsm_cs is

      -- IDLE State : Go to RUN State if the fifo is not empty
      when IDLE =>
        rd_en <= '0';                   -- Read Enable

        if(fifo_empty = '0' and enable = '1') then
          fsm_ns <= RD_FIFO;
        else
          fsm_ns <= IDLE;
        end if;

      -- RD_FIFO State : Generate a read access to the FIFO
      when RD_FIFO =>
        rd_en  <= '1';                  -- Read Enable
        fsm_ns <= WAIT_DONE;

      -- WAIT_DONE State : wait for the DONE signal of MX7219
      when WAIT_DONE =>

        rd_en <= '0';                   -- Read Enable

        -- FIFO Not Empty -> Go to RD_FIFO
        if(done = '1' and fifo_empty = '0' and enable = '1') then
          fsm_ns <= RD_FIFO;

        -- FIFO is Empty -> Go to IDLE state
        elsif(done = '1' and fifo_empty = '1' and enable = '1') then
          fsm_ns <= IDLE;

        -- After the done, if the block is not enable anymore -> Go to IDLE state
        elsif(done = '1' and enable = '0') then
          fsm_ns <= IDLE;

        else
          fsm_ns <= WAIT_DONE;
        end if;

      when others =>
        rd_en <= '0';                   -- Read Enable;
        
    end case;
    
  end process p_ns_update;

end architecture rtl;
