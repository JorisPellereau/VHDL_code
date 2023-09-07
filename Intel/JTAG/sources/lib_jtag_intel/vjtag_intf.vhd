-------------------------------------------------------------------------------
-- Title      : Interface With Virtual JTAG from INTEL
-- Project    : 
-------------------------------------------------------------------------------
-- File       : vjtag_intf.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-08-28
-- Last update: 2023-09-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-08-28  1.0      linux-jp        Created
-------------------------------------------------------------------------------

-- IR : 0 -> BYPASS
-- IR : 1 -> Set ADDR
-- IR : 2 -> Set DATA
-- IR : 3 -> Set RNW (1 : Read - 0 : Write)
-- IR : 4 -> Start Access
-- IR : 5 -> Read Data IN

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vjtag_intf is

  generic (
    G_DATA_WIDTH : integer range 1 to 32 := 32;  -- DAta Width
    G_ADDR_WIDTH : integer range 8 to 32 := 32;
    G_IR_WIDTH   : integer range 6 to 24 := 6);  -- VJTAG IR Width
  port (
    clk_jtag   : in std_logic;                   -- JTAG Clock
    rst_n_jtag : in std_logic;                   -- Asynchronous Reset

    tdi   : in  std_logic;              -- TDI Data from Virtual JTAG
    tdo   : out std_logic;              -- TDO Data to Virtual JTAG
    ir_in : in  std_logic_vector(G_IR_WIDTH - 1 downto 0);  -- IR IN Vector
    sdr   : in  std_logic;              -- SDR state from Virtual JTAG
    udr   : in  std_logic;              -- UDR state from Virtual JTAG
    cdr   : in  std_logic;              -- CDR statue from Virtual JTAG

    addr        : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Addr
    data_out    : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Data out
    data_in     : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- DATA IN to read
    data_in_val : in  std_logic;        -- Data in Valid
    rnw         : out std_logic;        -- Read not Write signal
    start       : out std_logic);       -- Start Read or Write Access

end entity vjtag_intf;

architecture rtl of vjtag_intf is

  -- == CONSTANTS ==
  constant C_BYPASS_REG : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := (others => '1');  -- Bypass value

  constant C_DATA_IN_RST_VALUE : std_logic_vector(G_DATA_WIDTH - 1 downto 0) := (0 => '0', others => '1');

  -- == Internal Signals ==
  signal select_DR0 : std_logic;        -- DR 0 - Bypass
  signal select_DR1 : std_logic;        -- DR 1 
  signal select_DR2 : std_logic;        -- DR 2 
  signal select_DR3 : std_logic;        -- DR 3 
  signal select_DR4 : std_logic;        -- DR 4 
  signal select_DR5 : std_logic;        -- DR 5

  signal addr_int     : std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Addr int
  signal data_out_int : std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Data Out int
  signal rnw_int      : std_logic;      -- Read Not write internal
  signal data_in_int  : std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Data in latch

  signal shift_data : std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Shift regiser
  signal start_int  : std_logic;        -- Start internal

begin  -- architecture rtl

  -- Decoder : Selection of DR1 in function of IR_in
  select_DR0 <= '1' when ir_in = std_logic_vector(to_unsigned(0, ir_in'length)) else '0';
  select_DR1 <= '1' when ir_in = std_logic_vector(to_unsigned(1, ir_in'length)) else '0';
  select_DR2 <= '1' when ir_in = std_logic_vector(to_unsigned(2, ir_in'length)) else '0';
  select_DR3 <= '1' when ir_in = std_logic_vector(to_unsigned(3, ir_in'length)) else '0';
  select_DR4 <= '1' when ir_in = std_logic_vector(to_unsigned(4, ir_in'length)) else '0';
  select_DR5 <= '1' when ir_in = std_logic_vector(to_unsigned(5, ir_in'length)) else '0';




  -- purpose: Management of the ADDR
  p_addr_mngt : process (clk_jtag, rst_n_jtag) is
  begin  -- process p_addr_mngt
    if rst_n_jtag = '0' then            -- asynchronous reset (active low)
      addr_int <= (others => '0');
      addr     <= (others => '0');
    elsif rising_edge(clk_jtag) then    -- rising clock edge

      -- Perform Shift only when DR1 is selected and in sdr state
      -- Get data from TDI
      if(sdr = '1' and select_DR1 = '1') then
        addr_int <= tdi & addr_int(G_ADDR_WIDTH-1 downto 1);

      -- Reset the addr_int on UDR pulse
      elsif(udr = '1') then
        addr_int <= (others => '0');
      end if;

      -- Update ADDR on UDR pulse
      if(udr = '1' and select_DR1 = '1') then
        addr <= addr_int;
      end if;

    end if;
  end process p_addr_mngt;

  -- purpose: Management of the DATA_OUT
  p_data_out_mngt : process (clk_jtag, rst_n_jtag) is
  begin  -- process p_data_out_mngt
    if rst_n_jtag = '0' then            -- asynchronous reset (active low)
      data_out_int <= (others => '0');
      data_out     <= (others => '0');
    elsif rising_edge(clk_jtag) then    -- rising clock edge

      -- Perform Shift only when DR2 is selected and in sdr state
      -- Get data from TDI - The LSBIT is send first
      if(sdr = '1' and select_DR2 = '1') then
        data_out_int <= tdi & data_out_int(G_DATA_WIDTH-1 downto 1);

      elsif(udr = '1') then
        data_out_int <= (others => '0');
      end if;

      -- Update data_out on UDR pulse and when the DR2 register is selected
      if(udr = '1'and select_DR2 = '1') then
        data_out <= data_out_int;
      end if;
    end if;
  end process p_data_out_mngt;

  -- purpose: RNW signal management
  -- When select_DR3 is selected set the value on rnw
  p_rnw_mngt : process (clk_jtag, rst_n_jtag) is
  begin  -- process p_rnw_mngt
    if rst_n_jtag = '0' then            -- asynchronous reset (active low)
      rnw_int <= '0';
      rnw     <= '0';
    elsif rising_edge(clk_jtag) then    -- rising clock edge

      -- Update rnw during SDR state
      if(sdr = '1' and select_DR3 = '1') then
        rnw_int <= tdi;
      end if;

      -- Update rnw on UDR pulse
      if(udr = '1' and select_DR3 = '1') then
        rnw <= rnw_int;
      end if;

    end if;
  end process p_rnw_mngt;

  -- purpose: Start Management
  p_start_mngt : process (clk_jtag, rst_n_jtag) is
  begin  -- process p_start_mngt
    if rst_n_jtag = '0' then            -- asynchronous reset (active low)
      start_int <= '0';
      start     <= '0';
    elsif rising_edge(clk_jtag) then    -- rising clock edge

      if(sdr = '1' and select_DR4 = '1') then
        start_int <= tdi;
      end if;

      -- Update Start on UDR pulse
      if(udr = '1' and select_DR4 = '1') then
        start <= start_int;
      -- Reset it otherwise in order to generate a pulse start
      else
        start <= '0';
      end if;

    end if;
  end process p_start_mngt;

  -- purpose: On data_in_val latch data_in_int
  p_data_in_latch : process (clk_jtag, rst_n_jtag) is
  begin  -- process p_data_in_latch
    if rst_n_jtag = '0' then               -- asynchronous reset (active low)
      data_in_int <= C_DATA_IN_RST_VALUE;  --(others => '0');
    elsif rising_edge(clk_jtag) then       -- rising clock edge

      -- Latch vector on CDR signal
      if(cdr = '1') then
        data_in_int <= data_in;
      end if;

      -- Shift Data on SDR and when select_DR5 is selected
      -- Shift MSBit to LSBit
      if(sdr = '1' and select_DR5 = '1') then
        data_in_int <= '0' & data_in_int(G_DATA_WIDTH -1 downto 1);

      -- Reset the value of the register
      elsif(udr = '1' and select_DR5 = '1') then
        data_in_int <= C_DATA_IN_RST_VALUE;
      end if;

    end if;
  end process p_data_in_latch;



  -- TDO Continuity
  -- LSBits is shifted first
  tdo <= data_in_int(0) when select_DR5 = '1' else '0';

end architecture rtl;
