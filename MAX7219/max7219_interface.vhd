-------------------------------------------------------------------------------
-- Title      : MAX7219 interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : max7219_interface.vhd
-- Author     :   <pellereau@D-R81A4E3>
-- Company    : 
-- Created    : 2019-07-18
-- Last update: 2020-01-05
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: This is the interface controler for 8x8 matrix
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-07-18  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_max7219;
use lib_max7219.pkg_max7219.all;

entity max7219_interface is

  port (
    clk            : in  std_logic;     -- System clock
    rst_n          : in  std_logic;     -- Asynchronous active low reset
    i_max7219_data : in  std_logic_vector(15 downto 0);  -- Data to send te the Max7219
    i_start        : in  std_logic;     -- Start the transaction
    i_en_load      : in  std_logic;     -- Enable the generation of o_load
    o_load_max7219 : out std_logic;     -- LOAD command
    o_data_max7219 : out std_logic;     -- DATA to send th
    o_clk_max7219  : out std_logic;     -- CLK
    o_max7219_done : out std_logic);    -- Frame done

end entity max7219_interface;


architecture arch_max7219_interface of max7219_interface is

  -- Internal Constants
  constant C_MAX_CLK     : integer := 4;  -- Max CLK number, 5 => 5 MHz
  constant C_LOAD_LENGTH : integer := 3;  -- CLK length for LOAD Pulse

  -- Internal signals
  signal s_max7219_data       : std_logic_vector(15 downto 0);  -- Latch MAX7219 data
  signal s_clk_max7219        : std_logic;
  signal s_clk_max7219_d      : std_logic;
  signal s_clk_max7219_r_edge : std_logic;  -- R Edge of clk_max77219
  signal s_clk_max7219_f_edge : std_logic;  -- R Edge of clk_max7219
  signal s_cnt_clk            : integer range 0 to C_MAX_CLK;  -- Counter on clk

  signal s_en_load              : std_logic;
  signal s_cnt_clk_max7219      : integer range 0 to 15;  -- Clock MAX7219 cnt
  signal s_cnt_clk_max7219_done : std_logic;              -- Count done

  signal s_start        : std_logic;    -- Latch i_start
  signal s_start_r_edge : std_logic;    -- R Edge of i_start

  signal s_start_frame        : std_logic;
  signal s_start_frame_d      : std_logic;
  signal s_start_frame_r_edge : std_logic;

  signal s_load_max7219 : std_logic;
  signal s_gen_load     : std_logic;    -- Generate the load
  signal s_max7219_done : std_logic;    -- Frame done

  signal s_cnt_pulse_load : integer range 0 to C_LOAD_LENGTH;  -- LOAD Pulse cnt
begin  -- architecture arch_max7219_interface

  -- purpose: This process latch inputs in order to detects their R/F Edge 
  p_r_edge_mngt : process (clk, rst_n) is
  begin  -- process p_r_edge_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_start         <= '0';
      s_clk_max7219_d <= '0';
      s_start_frame_d <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_start         <= i_start;
      s_clk_max7219_d <= s_clk_max7219;
      s_start_frame_d <= s_start_frame;
    end if;
  end process p_r_edge_mngt;

  s_start_r_edge       <= i_start and not s_start;
  s_clk_max7219_r_edge <= s_clk_max7219 and not s_clk_max7219_d;
  s_start_frame_r_edge <= s_start_frame and not s_start_frame_d;
  s_clk_max7219_f_edge <= not s_clk_max7219 and s_clk_max7219_d;

  -- purpose: This process latches inputs when R Edge of i_start is detected
  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_max7219_data <= (others => '0');
      s_en_load      <= '0';
      s_start_frame  <= '0';
      s_gen_load     <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_start_r_edge = '1' and s_max7219_done = '0') then
        s_max7219_data <= i_max7219_data;
        s_en_load      <= i_en_load;
        s_start_frame  <= '1';          -- We can send the frame now
      elsif(s_cnt_clk_max7219_done = '1' and s_clk_max7219_f_edge = '1') then
        s_start_frame <= '0';           -- Stop CLK_MAX7219 and data generation
        s_gen_load    <= '1';           -- Generated the load
      elsif(s_max7219_done = '1') then
        s_max7219_data <= (others => '0');
        s_en_load      <= '0';
        s_start_frame  <= '0';
        s_gen_load     <= '0';
      end if;
    end if;
  end process p_latch_inputs;


  -- purpose: This process manages the clock generation for MAX7219 
  p_clk_max7219_mngt : process (clk, rst_n) is
  begin  -- process p_clk_max7219_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_clk_max7219 <= '0';
      s_cnt_clk     <= 0;
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_start_frame = '1') then
        if(s_cnt_clk < C_MAX_CLK - 1) then
          s_cnt_clk <= s_cnt_clk + 1;
        else
          s_clk_max7219 <= not s_clk_max7219;
          s_cnt_clk     <= 0;
        end if;
      else
        s_clk_max7219 <= '0';
        s_cnt_clk     <= 0;
      end if;
    end if;
  end process p_clk_max7219_mngt;

  -- purpose: This process counts the number of CLK_max7219 clock
  p_clk_max7219_cnt : process (clk, rst_n) is
  begin  -- process p_clk_max7219_cnt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cnt_clk_max7219      <= 0;
      s_cnt_clk_max7219_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(s_clk_max7219_r_edge = '1') then
        if(s_cnt_clk_max7219 < 15) then
          s_cnt_clk_max7219      <= s_cnt_clk_max7219 + 1;
          s_cnt_clk_max7219_done <= '0';
        else
          s_cnt_clk_max7219      <= 0;
          s_cnt_clk_max7219_done <= '1';
        end if;
      end if;
    end if;
  end process p_clk_max7219_cnt;

  -- Outputs affectation
  o_clk_max7219 <= s_clk_max7219;

  -- purpose: This process manages the MAX729 data output 
  p_max7219_data_mngt : process (clk, rst_n) is
  begin  -- process p_max7219_data_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_data_max7219 <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if(s_start_frame_r_edge = '1') then
        o_data_max7219 <= s_max7219_data(15);  -- Load 1st data

      elsif(s_clk_max7219_f_edge = '1') then
        if(s_cnt_clk_max7219_done = '0') then
          o_data_max7219 <= s_max7219_data(15 - s_cnt_clk_max7219);
        else
          o_data_max7219 <= '0';
        end if;
      end if;
    end if;
  end process p_max7219_data_mngt;

  -- purpose: This process manages the Load output: 
  p_max7219_load_mngt : process (clk, rst_n) is
  begin  -- process p_max7219_load_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_load_max7219 <= '0';
      s_max7219_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      s_max7219_done <= '0';
      s_load_max7219 <= '0';
      if(s_gen_load = '1' and s_max7219_done = '0') then
        if(s_en_load = '1') then
          if(s_cnt_pulse_load < C_LOAD_LENGTH) then
            s_cnt_pulse_load <= s_cnt_pulse_load + 1;
            s_load_max7219   <= '1';
          else
            s_load_max7219   <= '0';
            s_cnt_pulse_load <= 0;
            s_max7219_done   <= '1';
          end if;
        else
          s_load_max7219 <= '0';
          s_max7219_done <= '1';
        end if;
      elsif(s_max7219_done = '1') then
        s_load_max7219 <= '0';
        s_max7219_done <= '0';
      end if;
    end if;
  end process p_max7219_load_mngt;

  o_max7219_done <= s_max7219_done;
  o_load_max7219 <= s_load_max7219;
end architecture arch_max7219_interface;
