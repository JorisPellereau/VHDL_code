-------------------------------------------------------------------------------
-- Title      : APB wrapper
-- Project    : 
-------------------------------------------------------------------------------
-- File       : apb_wrapper.vhd
-- Author     :   <JorisPC@JORISP>
-- Company    : 
-- Created    : 2019-05-06
-- Last update: 2019-05-06
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: APB wrapper for slave module
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-05-06  1.0      JorisPC Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

library lib_apb;
use lib_apb.pkg_apb.all;

entity apb_wrapper is
  generic(base_addr : unsigned(add_width - 1 downto 0) := base_addr_slave1);
  port(
    -- == Interface APB3 ==
    -- INPUTS 
    presetn : in  std_logic;            -- reset
    pclk    : in  std_logic;            -- clock           
    paddr   : in  std_logic_vector(add_width - 1 downto 0);  -- slave address
    psel    : in  std_logic;            -- slave Select
    penable : in  std_logic;            -- enable
    pwrite  : in  std_logic;            -- W/R
    pwdata  : in  std_logic_vector(add_width - 1 downto 0);  -- data from controler
    -- OUTPUTS
    prdata  : out std_logic_vector(add_width - 1 downto 0);  -- data from slave to controler
    pready  : out std_logic;            -- slave ready
    pslverr : out std_logic;            -- slave error
    -- =====================

    -- Slaves commands
    sorties : out std_logic_vector(3 downto 0)
    );
end apb_wrapper;
-- ============

-- == ARCHITECHTURE ==
architecture arch_apb_wrapper of apb_wrapper is

  -- Sgnals
  signal sorties_s : std_logic_vector(3 downto 0);
  signal data_out  : std_logic_vector(add_width - 1 downto 0);
  signal data_in   : std_logic_vector(add_width - 1 downto 0);
begin



  -- This process manages the write operation
  p_write_apb_mng : process(presetn, pclk)
  begin

    if(presetn = '0') then
      sorties_s <= x"0";
      data_in   <= (others => '0');
    elsif(rising_edge(pclk)) then
      if(pwrite = '1' and psel = '1' and penable = '1') then

        if(paddr(add_width - 1 downto 0) = base_addr_slave1) then
          data_in <= PWDATA;
        elsif(paddr(add_width - 1 downto 0) = base_addr_slave1 + 4) then
        -- Do something
        end if;

        -- Do something with the input data
        case data_in is
          when x"00000000" => sorties_s <= x"0";
          when x"00000001" => sorties_s <= x"1";
          when x"00000002" => sorties_s <= x"3";
          when others      => sorties_s <= x"A";
        end case;

      end if;
    end if;
  end process p_write_apb_mng;


  -- This process manages the data to set on the bus (to be read by the master)
  prdata_mng : process(presetn, pclk)
  begin
    if(presetn = '0') then
      data_out <= (others => '0');
    elsif(pclk'event and pclk = '1') then
      if(pwrite = '0' and psel = '1' and penable = '1') then

        -- Example of data to send to the master
        if(paddr(7 downto 0) = x"20") then
          data_out <= x"FBFBF1F1";
        elsif(paddr(7 downto 0) = x"24") then
          data_out <= x"0000FFFA";
        elsif(paddr(7 downto 0) = x"28") then
          data_out <= x"12345678";
        elsif(paddr(7 downto 0) = x"2C") then
          data_out <= x"55556666";
        end if;
      else
        data_out <= (others => '0');
      end if;
    end if;

  end process prdata_mng;

  sorties <= sorties_s;
  prdata  <= data_out;
  pready  <= '1';
  pslverr <= '0';

end arch_apb_wrapper;
