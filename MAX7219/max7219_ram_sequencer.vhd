-------------------------------------------------------------------------------
-- Title      : MAX7219 RAM SEQUENCER
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_ram_sequencer.vhd
-- Author     :   <JorisP@DESKTOP-LO58CMN>
-- Company    : 
-- Created    : 2020-05-09
-- Last update: 2020-05-09
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 RAM SEQUENCER
-------------------------------------------------------------------------------
-- Copyright (c) 2020 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-05-09  1.0      JorisP  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_ram_sequencer is

  generic (
    G_RAM_ADDR_WIDTH : integer              := 8;   -- RAM ADDR WIDTH
    G_RAM_DATA_WIDTH : integer              := 16;  -- RAM DATA WIDTH
    G_DIGITS_NB      : integer range 2 to 8 := 2  --DIGIR NB on THE MATRIX DISPLAY
    );
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- CONFIG. MATRIX I/F
    i_config_array      : in  t_config_array;  -- CONFIG. Matrix
    i_config_val        : in  std_logic;       -- CONFIG. Matrix valid
    i_config_start_addr : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
    o_config_last_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
    o_config_done       : out std_logic;       -- CONFIG. IN RAM DONE

    -- SCORE I/F
    i_score_cmd        : in  t_score_array;  -- Score Command
    i_score_val        : in  std_logic;      -- Score Command Valid
    i_score_start_addr : in  std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
    o_score_last_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
    o_score_done       : out std_logic;      -- SCORE IN RAM DONE

    -- RAM I/F
    o_me    : out std_logic;            -- Memory Enable
    o_we    : out std_logic;            -- W/R Memory Command
    o_addr  : out std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);  -- RAM ADDR
    o_wdata : out std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);  -- RAM WDATA
    i_rdata : in  std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0)  -- RAM RDATA
    );

end entity max7219_ram_sequencer;

architecture behv of max7219_ram_sequencer is

  -- CONSTANTS
  constant C_MAX_SCORE_CNT  : integer := 8*G_DIGITS_NB;
  constant C_MAX_CONFIG_CNT : integer := 4*G_DIGITS_NB;

  -- TYPES
  type t_ram_seq_states is (IDLE, WR_CONFIG, WR_SCORE);  -- STATES

  -- INTERNAL SIGNALS
  signal s_curr_state : t_ram_seq_states;  -- Current state
  signal s_next_state : t_ram_seq_states;  -- Next State

  signal s_config_cnt  : integer range 0 to C_MAX_CONFIG_CNT;
  signal s_config_done : std_logic;
  signal s_config_en   : std_logic;

  signal s_score_cnt  : integer range 0 to C_MAX_SCORE_CNT;  -- Score Counter index
  signal s_score_done : std_logic;
  signal s_score_en   : std_logic;

  signal s_addr  : std_logic_vector(G_RAM_ADDR_WIDTH - 1 downto 0);
  signal s_me    : std_logic;
  signal s_we    : std_logic;
  signal s_wdata : std_logic_vector(G_RAM_DATA_WIDTH - 1 downto 0);

begin  -- architecture behv

  p_next_state_mngt : process (clk, rst_n) is
  begin  -- process p_next_state_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_curr_state <= IDLE;
      s_next_state <= IDLE;
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_curr_state <= s_next_state;

      case s_curr_state is
        when IDLE =>
          if(i_config_val = '1') then
            s_next_state <= WR_CONFIG;
          elsif(i_score_val = '1') then
            s_next_state <= WR_SCORE;
          end if;

        when WR_CONFIG =>
          if(s_config_done = '1') then
            s_next_state <= IDLE;
          end if;

        when WR_SCORE =>
          if(s_score_done = '1') then
            s_next_state <= IDLE;
          end if;

        when others => null;
      end case;

    end if;
  end process p_next_state_mngt;


  p_wr_ram_mngt : process (clk, rst_n) is
  begin  -- process p_wr_ram_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_addr        <= (others => '0');
      s_config_cnt  <= 0;
      s_config_done <= '0';
      s_score_cnt   <= 0;
      s_score_done  <= '0';
      s_me          <= '0';
      s_we          <= '0';
      s_wdata       <= (others => '0');
      s_score_en    <= '0';
      s_config_en   <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      case s_curr_state is

        when IDLE =>
          s_config_cnt  <= 0;
          s_config_done <= '0';
          s_score_cnt   <= 0;
          s_score_done  <= '0';
          s_score_en    <= '0';
          if(i_config_val = '1') then
            s_addr <= i_config_start_addr;
          elsif(i_score_val = '1') then
            s_addr <= i_score_start_addr;
          end if;

        when WR_CONFIG =>

          if(s_config_en = '0') then
            s_me         <= '1';
            s_we         <= '1';
            s_wdata      <= i_config_array(s_config_cnt);
            s_config_cnt <= s_config_cnt + 1;        -- INC cnt
            s_config_en  <= '1';
          else
            if(s_config_cnt < C_MAX_CONFIG_CNT) then
              s_me         <= '1';
              s_we         <= '1';
              s_wdata      <= i_config_array(s_config_cnt);
              s_addr       <= unsigned(s_addr) + 1;  -- INC addr
              s_config_cnt <= s_config_cnt + 1;      -- INC cnt
            else
              s_config_done <= '1';
              s_me          <= '0';
              s_we          <= '0';
            end if;
          end if;

        when WR_SCORE =>
          if(s_score_en = '0') then
            s_me        <= '1';
            s_we        <= '1';
            s_wdata     <= i_score_cmd(s_score_cnt);
            s_score_cnt <= s_score_cnt + 1;         -- INC cnt
            s_score_en  <= '1';
          else
            if(s_score_cnt < C_MAX_SCORE_CNT) then
              s_me        <= '1';
              s_we        <= '1';
              s_wdata     <= i_score_cmd(s_score_cnt);
              s_addr      <= unsigned(s_addr) + 1;  -- INC addr
              s_score_cnt <= s_score_cnt + 1;       -- INC cnt
            else
              s_score_done <= '1';
              s_me         <= '0';
              s_we         <= '0';
            end if;
          end if;

        when others => null;
      end case;
    end if;
  end process p_wr_ram_mngt;

  p_last_addr_mngt : process (clk, rst_n) is
  begin  -- process p_last_addr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_config_last_addr <= (others => '0');
      o_score_last_addr  <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge
      o_config_last_addr <= unsigned(i_config_start_addr) + unsigned(conv_std_logic_vector(C_MAX_CONFIG_CNT, o_config_last_addr'length));
      o_score_last_addr  <= unsigned(i_score_start_addr) + unsigned(conv_std_logic_vector(C_MAX_SCORE_CNT, o_score_last_addr'length));

    end if;
  end process p_last_addr_mngt;


  -- OUTPUTS AFFECTATIONS
  o_me          <= s_me;
  o_we          <= s_we;
  o_addr        <= s_addr;
  o_wdata       <= s_wdata;
  o_config_done <= s_config_done;
  o_score_done  <= s_score_done;
  
end architecture behv;
