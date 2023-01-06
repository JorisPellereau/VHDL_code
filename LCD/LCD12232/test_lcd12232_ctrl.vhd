-------------------------------------------------------------------------------
-- Title      : Test LCD12232 controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : test_lcd12232_ctrl.vhd
-- Author     :   <pellereau@D-R81A4E3>
-- Company    : 
-- Created    : 2019-06-10
-- Last update: 2019-06-12
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: this is the test of the LCD12232
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-06-10  1.0      pellereau       Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_lcd12232;
use lib_lcd12232.pkg_lcd12232.all;


entity test_lcd12232_ctrl is

end entity test_lcd12232_ctrl;

architecture arch_test_lcd12232_ctrl of test_lcd12232_ctrl is


  -- SIGNALS
  signal clock   : std_logic := '0';    -- System clock
  signal reset_n : std_logic := '1';    -- Reset active low

  -- LCd12232 signals
  signal reg_sel_o : std_logic;                     -- A0 sel
  signal en1_o     : std_logic;                     -- EN1
  signal en2_o     : std_logic;                     -- EN2
  signal rw_o      : std_logic;                     -- RW command
  signal rst_o     : std_logic;                     -- LCd reset
  signal data_io   : std_logic_vector(7 downto 0);  -- Data

begin

  p_clock_gen : process
  begin  -- process p_clock_gen
    clock <= not clock;
    wait for 10 ns;
  end process p_clock_gen;


  p_stimulis : process is
  begin  -- process p_stimulis

    -- INIT inputs
    reset_n <= '1';

    wait for 1 us;
    reset_n <= '0';
    wait for 1 us;
    reset_n <= '1';



    report "end of simu !!!";
    wait;
  end process p_stimulis;

  p_LCD_resp_simul : process
    variable v_cnt_data_io : integer range 0 to 10 := 0;  -- Counter
  begin

    wait until rising_edge(en1_o);
    if(rw_o = '1') then
      wait for 90 ns;
      if(v_cnt_data_io < 10) then
        data_io       <= x"ED";
        v_cnt_data_io := v_cnt_data_io + 1;
      else
        data_io       <= x"79";
        v_cnt_data_io := 0;
      end if;
      wait until falling_edge(en1_o);
      wait for 10 ns;
      data_io <= (others => 'Z');
    else
      data_io <= (others => 'Z');
    end if;
  end process p_LCD_resp_simul;


  lcd_inst : lcd12232_ctrl
    port map(clock_i   => clock,
             reset_n_i => reset_n,
             reg_sel_o => reg_sel_o,
             en1_o     => en1_o,
             en2_o     => en2_o,
             rw_o      => rw_o,
             rst_o     => rst_o,
             data_io   => data_io);


end architecture arch_test_lcd12232_ctrl;
