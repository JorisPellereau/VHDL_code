-------------------------------------------------------------------------------
-- Title      : Top for I2C test
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top_i2c_eemprom_de_nano.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-06-28
-- Last update: 2019-07-10
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-28  1.0      JorisPC Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_i2c;
use lib_i2c.pkg_i2c.all;


entity top_i2c_eemprom_de_nano is

  port (
    clock   : in std_logic;
    reset_n : in std_logic;

    bp1 : in std_logic;

    -- I2C interface
    scl : inout std_logic;
    sda : inout std_logic;

    leds : out std_logic_vector(7 downto 0);

    -- I2C debug
    scl_debug         : out std_logic;
    sda_debug         : out std_logic;
    clock_20mhz_debug : out std_logic;
    rdata             : out std_logic_vector(7 downto 0)
    );

end entity top_i2c_eemprom_de_nano;


architecture arch_top_i2c_eemprom_de_nano of top_i2c_eemprom_de_nano is


  component pll_20meg is
    port
      (
        areset : in  std_logic := '0';
        inclk0 : in  std_logic := '0';
        c0     : out std_logic;
        locked : out std_logic
        );
  end component;



  -- EEPROM CTRL SIGNALS
  signal en_s         : std_logic;
  signal start_s      : std_logic;
  signal byte_wr_s    : std_logic;
  signal page_wr_s    : std_logic;
  signal byte_rd_s    : std_logic;
  signal chip_addr_s  : std_logic_vector(6 downto 0);
  signal word_addr_s  : std_logic_vector(7 downto 0);
  -- signal wdata_s      : t_byte_array;
  -- signal rdata_s      : t_byte_array;
  signal sack_error_s : std_logic;
  signal i2c_busy_s   : std_logic;

  -- I2C MASTER SIGNALS
  signal wdata_s        : std_logic_vector(7 downto 0);
  signal rdata_s        : std_logic_vector(7 downto 0);
  signal rdata_valid_s  : std_logic;
  signal wdata_change_s : std_logic;
  signal rw_s           : std_logic;
  signal i2c_done_s     : std_logic;
  signal nb_data_s      : integer range 1 to C_MAX_DATA;


  -- Internal counter
  signal cnt_500ms  : integer range 0 to 25000000;
  signal cnt_done_s : std_logic;

  signal pll_locked_s : std_logic;
  signal pll_rst_s    : std_logic;

  signal sel_rw_s : std_logic;

  -- Reset mng
  signal reset_n_s       : std_logic;   -- Latch input reset
  signal reset_n_synch_s : std_logic;   -- Synch reset


  signal clock_20mhz : std_logic;       -- Clock 20MHz from PLL

  signal i2c_done_ss   : std_logic;
  signal i2c_done_re_s : std_logic;

  signal wdata_change_re_s : std_logic;
  signal wdata_change_ss   : std_logic;

  signal cnt_255 : integer range 0 to 255;

begin  -- architecture arch_top_i2c_eemprom_de_nano


  -- p_wdata_mng : process (clock_20mhz, reset_n_synch_s) is
  -- begin  -- process p_wdata_mng
  --   if reset_n_synch_s = '0' then  -- asynchronous reset (active low)
  --     wdata_s <= x"00";
  --     cnt_255 <= 0;
  --   elsif clock_20mhz'event and clock_20mhz = '1' then  -- rising clock edge
  --     if(
  --       end if;
  --       end process p_wdata_mng;


  wdata_s <= x"BE";



  -- MASTER I2C INST
  master_i2c_inst : i2c_master
    generic map(
      scl_frequency   => f400k,
      clock_frequency => 20000000)
    port map(
      reset_n      => reset_n_synch_s,
      clock        => clock_20mhz,
      start_i2c    => start_s,
      rw           => rw_s,
      chip_addr    => chip_addr_s,
      nb_data      => nb_data_s,
      wdata        => wdata_s,
      i2c_done     => i2c_done_s,
      sack_error   => sack_error_s,
      rdata        => rdata_s,
      rdata_valid  => rdata_valid_s,
      wdata_change => wdata_change_s,
      scl          => scl,
      sda          => sda);


  chip_addr_s <= "1010000";

  scl_debug         <= scl;
  sda_debug         <= sda;
  clock_20mhz_debug <= clock_20mhz;


  leds(0) <= sack_error_s;
  leds(1) <= pll_locked_s;
  leds(2) <= rdata_valid_s;
  leds(3) <= wdata_change_s;
  leds(4) <= start_s;
  leds(5) <= cnt_done_s;
  leds(6) <= '0';
  leds(7) <= i2c_done_s;

  rdata <= rdata_s;
  -- nb_data_s <= 2;


  p_i2c_done_re : process (clock_20mhz, reset_n_synch_s) is
  begin  -- process p_i2c_done_re
    if reset_n_synch_s = '0' then       -- asynchronous reset (active low)
      i2c_done_ss <= '0';
    elsif clock_20mhz'event and clock_20mhz = '1' then  -- rising clock edge
      i2c_done_ss <= i2c_done_s;
    end if;
  end process p_i2c_done_re;
  i2c_done_re_s <= i2c_done_s and not i2c_done_ss;


  p_cnt_500ms : process (clock_20mhz, reset_n_synch_s) is
  begin  -- process p_cnt_500ms
    if reset_n_synch_s = '0' then       -- asynchronous reset (active low)
      cnt_500ms  <= 0;
      start_s    <= '0';
      rw_s       <= '0';
      nb_data_s  <= 1;
      cnt_done_s <= '0';
      sel_rw_s   <= '0';
    elsif clock_20mhz'event and clock_20mhz = '1' then  -- rising clock edge

      if(pll_locked_s = '1') then

        if(cnt_500ms < 25000000 - 1 and cnt_done_s = '0') then
          cnt_500ms <= cnt_500ms + 1;
        else
          cnt_500ms  <= 0;
          cnt_done_s <= '1';
        end if;

        -- if(i2c_done_re_s = '1') then
        --   rw_s <= not rw_s;
        -- end if;

        if(cnt_done_s = '1') then

          if(i2c_done_s = '1' and sel_rw_s = '0') then
            rw_s      <= '0';
            start_s   <= '1';
            nb_data_s <= 4;
          --   sel_rw_s  <= '1';
          -- elsif(i2c_done_s = '1' and sel_rw_s = '1') then
          --   rw_s      <= '1';
          --   nb_data_s <= 1;
          --   start_s   <= '1';
          --   sel_rw_s  <= '0';               
          end if;


        end if;

        if(i2c_done_re_s = '1') then
          cnt_done_s <= '0';
          start_s    <= '0';
        end if;


      end if;
    end if;
  end process p_cnt_500ms;




  pll_rst_s <= not reset_n_synch_s;


  pll_20meg_inst : pll_20meg port map (
    areset => pll_rst_s,
    inclk0 => clock,
    c0     => clock_20mhz,
    locked => pll_locked_s
    );


  p_rst_synch : process (clock, reset_n) is
  begin  -- process p_rst_synch
    if reset_n = '0' then                   -- asynchronous reset (active low)
      reset_n_s       <= '0';
      reset_n_synch_s <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      reset_n_s       <= '1';
      reset_n_synch_s <= reset_n_s;
    end if;
  end process p_rst_synch;

end architecture arch_top_i2c_eemprom_de_nano;
