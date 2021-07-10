-------------------------------------------------------------------------------
-- Title      : I2C Master
-- Project    : 
-------------------------------------------------------------------------------
-- File       : i2c_master.vhd<lib_i2c>
-- Author     : JorisP  <jorisp@jorisp-VirtualBox>
-- Company    : 
-- Created    : 2021-06-27
-- Last update: 2021-07-10
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2021-06-27  1.0      jorisp  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_i2c;
use lib_i2c.pkg_i2c.all;

entity i2c_master is

  generic (
    G_SCL_FREQ   : t_i2c_frequency := f400k;      -- Frequency of SCL Clock
    G_CLOCK_FREQ : integer         := 50000000);  -- Input Clock Frequency

  port (    
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset
  
    -- Control Signals
    i_start     : in std_logic;         -- Start I2C Transaction
    i_rw        : in std_logic;         -- R/W acces
    i_chip_addr : in std_logic_vector(6 downto 0);  -- Chip addr to request
    i_nb_data   : in std_logic_vector(7 downto 0);  -- Number of Bytes to Read or Write
    i_wdata     : in std_logic_vector(7 downto 0);  -- Data to write

    -- Status and data
    o_rdata          : out std_logic_vector(7 downto 0);  -- Last read data
    o_rdata_valid    : out std_logic;                     -- Read Data valid
    o_next_wdata_rdy : out std_logic;                     -- Next Wdata ready
    o_sack_error     : out std_logic;                     -- Slave ACK Error

    -- I2C I/F
    scl : inout std_logic;              -- I2C Clock
    sda : inout std_logic);             -- I2C Data

end entity i2c_master;



architecture behv of i2c_master is

  -- CONSTANTS
  constant C_MAX_SCL_PERIOD  : integer := compute_scl_period(G_SCL_FREQ, G_CLOCK_FREQ);
  constant C_HALF_SCL_PERIOD : integer := C_MAX_SCL_PERIOD / 2;

  -- INTERNAL SIGNALS

  signal s_scl_cnt_en   : std_logic;                     -- Enable SCL Counter
  signal s_scl_cnt      : std_logic_vector(9 downto 0);  -- TBD taille bus
  signal s_scl_cnt_done : std_logic;

  signal s_current_state : t_i2c_master_fsm;
  signal s_next_state    : t_i2c_master_fsm;

  signal s_start        : std_logic;
  signal s_start_r_edge : std_logic;



  -- SDA/SCL I/O management
  signal s_scl_in  : std_logic;
  signal s_sda_in  : std_logic;
  signal s_scl_out : std_logic;
  signal s_sda_out : std_logic;
  signal s_en_scl  : std_logic;
  signal s_en_sda  : std_logic;

begin  -- architecture behv

  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_start <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_start <= i_start;
    end if;
  end process p_latch_inputs;

  s_start_r_edge <= i_start and not s_start;


  p_curr_state_mngt: process (clk, rst_n) is
  begin  -- process p_curr_state_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_current_state <= IDLE;
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_current_state <= s_next_state;
    end if;
  end process p_curr_state_mngt;


  p_next_state_mngt : process (clk, rst_n) is
  begin  -- process p_next_state_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_next_state    <= IDLE;
    elsif clk'event and clk = '1' then  -- rising clock edge

      case s_current_state is

        when IDLE =>
          if(s_start_r_edge = '1') then
            s_next_state <= START_GEN;
          end if;


        when START_GEN =>


        when others => null;
      end case;

    end if;
  end process p_next_state_mngt;


  p_scl_tick_mngt : process (clk, rst_n) is
  begin  -- process p_scl_tick_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_scl_cnt      <= (others => '0');
      s_scl_cnt_done <= '0';
      s_scl_cnt_en   <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Enable SCL Counter 
      if(s_current_state = IDLE) then
        if(s_start_r_edge = '1') then
          s_scl_cnt_en <= '1';
        end if;
      end if;

      -- Counter mngt
      if(s_scl_cnt_en = '1') then
        if(s_scl_cnt < conv_std_logic_vector(C_HALF_SCL_PERIOD, s_scl_cnt'length)) then
          s_scl_cnt_done <= '0';
          s_scl_cnt      <= unsigned(s_scl_cnt) + 1;
        else
          s_scl_cnt_done <= '1';
          s_scl_cnt      <= (others => '0');
        end if;
      else
        s_scl_cnt      <= (others => '0');
        s_scl_cnt_done <= '0';
      end if;

    end if;
  end process p_scl_tick_mngt;


  p_scl_mngt: process (clk, rst_n) is
  begin  -- process p_scl_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_scl_out <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      
    end if;
  end process p_scl_mngt;


  p_sda_mngt: process (clk, rst_n) is
  begin  -- process psda_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      
    elsif clk'event and clk = '1' then  -- rising clock edge
      
    end if;
  end process p_sda_mngt;

  -- Outputs Affectation
  scl <= s_scl_out when s_en_scl = '1' else 'Z';  -- Write on SCL output
  sda <= s_sda_out when s_en_sda = '1' else 'Z';  -- Write on SDA output

  s_scl_in <= scl;
  s_sda_in <= sda;

end architecture behv;
