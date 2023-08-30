-------------------------------------------------------------------------------
-- Title      : AXI 4 Lite 8*7Segments Registers
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_7segs_registers.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-08-29
-- Last update: 2023-08-30
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-08-29  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib_axi4_lite_7seg;
use lib_axi4_lite_7seg.axi4_lite_7segs_pkg.all;
--
entity axi4_lite_7segs_registers is

  generic (
    G_AXI4_LITE_ADDR_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite ADDR WIDTH
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32  -- AXI4 Lite DATA WIDTH
    );
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- Slave Registers Interface
    slv_start  : in std_logic;          -- Start the access
    slv_rw     : in std_logic;          -- Read or write access
    slv_addr   : in std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Slave Addr
    slv_wdata  : in std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave Write Data
    slv_strobe : in std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Write strobe

    slv_done   : out std_logic;         -- Slave access done
    slv_rdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave RDATA
    slv_status : out std_logic_vector(1 downto 0);         -- Slave status

    -- Registers Interface
    digits : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0)  -- Digits Value
    );

end entity axi4_lite_7segs_registers;

architecture rtl of axi4_lite_7segs_registers is

  -- == INTERNAL Signals ==
  signal reg_wr_sel       : std_logic_vector(C_NB_REG - 1 downto 0);  -- Write register selection
  signal reg_wr_sel_error : std_logic;  -- Reg Write Selection error
  signal digits_int       : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- DIGITS register
begin  -- architecture rtl


  -- == Register Decoding ==
  g_register_sel : for i in 0 to C_NB_REG - 1 generate

    -- Register selection from slv_addr
    -- Check registers addr until G_REG_NB
    p_register_sel : process (slv_addr) is
    begin  -- process p_register_sel

      -- Set the corresponding bit to '1' if the address correspond to an
      -- exsisting address from the number of possible address      
      if(unsigned(slv_addr) = to_unsigned((i*G_AXI4_LITE_DATA_WIDTH)/8, slv_addr'length)) then
        reg_wr_sel(i) <= '1';
      else
        reg_wr_sel(i) <= '0';
      end if;

    end process p_register_sel;

  end generate;

  -- reg_wr_sel_error generation
  reg_wr_sel_error <= '1' when reg_wr_sel = std_logic_vector(to_unsigned(0, reg_wr_sel'length)) else '0';
  -- =======================


  -- == Register Write Access ==
  -- purpose: Write Management of the digits register
  p_digits_wr_mngt : process (clk, rst_n) is
  begin  -- process p_digits_wr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      digits_int <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      if(reg_wr_sel(C_DIGITS_IDX) = '1' and slv_start = '1' and slv_rw = '0') then
        digits_int <= slv_wdata; 
      end if;
    end if;
  end process p_digits_wr_mngt;

  -- ===========================

  -- == Register Read Access ==

  -- purpose: Rdata register selection
  --p_rdata_register : process (slv_start, slv_rw, reg_rd_sel) is
  --begin  -- process p_rdata_register

--  end process p_rdata_register;


  -- ==========================

  -- == Slave ACK Management ==

  -- purpose: Slave Done Management
  p_slv_done_mngt : process (clk, rst_n) is
  begin  -- process p_slv_done_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_done <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Ack for a write access into a regular register
      if(slv_start = '1' and slv_rw = '0') then
        slv_done <= '1';

      -- Ack for a read access into a regular register
      elsif(slv_start = '1' and slv_rw = '1') then
        slv_done <= '1';

      else
        slv_done <= '0';
      end if;

    end if;
  end process p_slv_done_mngt;

  -- purpose: Slave Statue management
  p_slv_status_mngt : process (clk, rst_n) is
  begin  -- process p_slv_status_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_status <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Ack for a write access into a regular register
      if(slv_start = '1' and slv_rw = '0') then
        slv_status <= reg_wr_sel_error & '0';

      -- Ack for a read access into a regular register
      elsif(slv_start = '1' and slv_rw = '1' and slv_addr(3 downto 0) /= "0000") then
        slv_status <= "10";

      else
        slv_status <= "00";
      end if;

    end if;
  end process p_slv_status_mngt;

  -- purpose: Slave RDATA management  
  p_slv_rdata_mngt : process (clk, rst_n) is
  begin  -- process p_slv_rdata_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_rdata <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Ack for a write access into a regular register
      if(slv_start = '1' and slv_rw = '1' and slv_addr(3 downto 0) = "0000") then
        slv_rdata <= digits_int;
      else
        slv_rdata <= (others => '0');
      end if;

    end if;
  end process p_slv_rdata_mngt;

  -- ==========================


  -- == OUTPUTS Affectation ==
  digits <= digits_int;


end architecture rtl;
