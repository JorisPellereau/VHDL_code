-------------------------------------------------------------------------------
-- Title      : LCD CFAH MAIN FSM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : lcd_cfah_main_fsm.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-12
-- Last update: 2023-09-13
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Main FSM of LCD CFAH
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-12  1.0      linux-jp        Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lcd_cfah_main_fsm is
  port (
    clk_sys   : in std_logic;           -- System Clock
    rst_n_sys : in std_logic;           -- Asynchronous reset

    i_lcd_on   : in  std_logic;         -- LCD ON Command
    start_init : out std_logic;         -- Start Init command

    init_ongoing : out std_logic;       -- Initialization ongoing
    init_done    : in  std_logic);      -- Initialization done
end entity lcd_cfah_main_fsm;

architecture rtl of lcd_cfah_main_fsm is

  -- == TYPES ==
  type t_fsm_state is (IDLE, WAIT_LCD_ON, LCD_INIT, OPE);  -- FSM States
  signal fsm_cs : t_fsm_state;                             -- Current State
  signal fsm_ns : t_fsm_state;                             -- Next state

  signal start_init_int : std_logic;    -- Internal Start init
  signal start_init_p : std_logic;    -- Internal Start init
  
begin  -- architecture rtl


  -- purpose: Update of the current state
  p_fsm_cs_update : process (clk_sys, rst_n_sys) is
  begin  -- process p_fsm_cs_update
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fsm_cs <= IDLE;
    elsif rising_edge(clk_sys) then     -- rising clock edge
      fsm_cs <= fsm_ns;
    end if;
  end process p_fsm_cs_update;


  -- purpose: Update the fsm_ns signal in function of the current state and inputs
  p_fsm_ns_update : process (fsm_cs, i_lcd_on, init_done) is
  begin  -- process p_fsm_ns_update

    case fsm_cs is

      -- In IDLE, when the reset is released, go to WAIT_LCD_ON state
      when IDLE =>

        init_ongoing   <= '0';          -- Init Ongoing flag
        start_init_int <= '0';          -- Start init internal
        fsm_ns         <= WAIT_LCD_ON;


      -- In WAIT_LCD_ON state, when the LCD_ON signal is set, go to LCD_INIT state
      when WAIT_LCD_ON =>

        init_ongoing   <= '0';          -- Init Ongoing flag
        start_init_int <= '0';          -- Start init internal
        if(i_lcd_on = '1') then
          fsm_ns         <= LCD_INIT;
          init_ongoing   <= '1';        -- Init Ongoing flag
        else
          fsm_ns         <= WAIT_LCD_ON;
          start_init_int <= '0';        -- Start init internal
        end if;


      -- In LCD INIT state, when the initialization is done, go to OPE state
      when LCD_INIT =>
        init_ongoing   <= '1';          -- Init Ongoing flag
        start_init_int <= '1';          -- Start init internal
        if(init_done = '1') then
          fsm_ns       <= OPE;
        else
          fsm_ns <= LCD_INIT;
        end if;

      -- In OPE state, wait in this state until the LCD_ON is set to '0'
      when OPE =>
        init_ongoing   <= '0';          -- Init Ongoing flag
        start_init_int <= '0';          -- Start init internal
        if(i_lcd_on = '0') then
          fsm_ns <= IDLE;
        else
          fsm_ns <= OPE;
        end if;

      when others =>
        fsm_ns         <= IDLE;
        init_ongoing   <= '0';          -- Init Ongoing flag
        start_init_int <= '0';          -- Start init internal
    end case;

  end process p_fsm_ns_update;

  -- purpose: Generation of a pulse of start init
  p_start_init_mngt: process (clk_sys, rst_n_sys) is
  begin  -- process p_start_init_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      start_init_p <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      start_init_p <= start_init_int;
    end if;
  end process p_start_init_mngt;

  start_init <= start_init_int and not start_init_p;

end architecture rtl;
