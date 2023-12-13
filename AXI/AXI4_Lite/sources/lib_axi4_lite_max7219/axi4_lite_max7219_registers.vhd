-------------------------------------------------------------------------------
-- Title      : AXI 4 Lite MAX7219 Registers
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_max7219_registers.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-08-29
-- Last update: 2023-12-13
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: MAX7219 REGISTERS - 32 bits access
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

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_axi4_lite_max7219;
use lib_axi4_lite_max7219.axi4_lite_max7219_pkg.all;

entity axi4_lite_max7219_registers is
  generic (
    G_ADDR_WIDTH : integer range 4 to 16  := 4;   -- USEFULL ADDR WIDTH
    G_DATA_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite DATA WIDTH
    G_MATRIX_NB  : integer range 1 to 8   := 4    -- Matrix Number
    );
  port (
    clk   : in std_logic;                         -- Clock
    rst_n : in std_logic;                         -- Asynchronous Reset

    -- Slave Registers Interface
    slv_start  : in std_logic;                                          -- Start the access
    slv_rw     : in std_logic;                                          -- Read or write access
    slv_addr   : in std_logic_vector(G_ADDR_WIDTH - 1 downto 0);        -- Slave Addr
    slv_wdata  : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);        -- Slave Write Data
    slv_strobe : in std_logic_vector((G_DATA_WIDTH / 8) - 1 downto 0);  -- Write strobe

    slv_done   : out std_logic;                                    -- Slave access done
    slv_rdata  : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Slave RDATA
    slv_status : out std_logic_vector(1 downto 0);                 -- Slave status

    -- Registers Interface
    cmd_start   : out std_logic;                                        -- Command Start
    cmd         : out std_logic_vector(13 downto 0);                    -- Possible Commands
    cmd_data    : out std_logic_vector(7 downto 0);                     -- Data Command
    matrix_idx  : out std_logic_vector(log2(G_MATRIX_NB) -1 downto 0);  -- Number of Matrix
    ctrl_done   : in  std_logic;                                        -- Write access done
    ctrl_status : in  std_logic;                                        -- Controller Status 0 : No Error - 1 : Error
    fifo_full   : in  std_logic;                                        -- FIFO Full
    fifo_empty  : in  std_logic                                         -- FIFO Empty Status
    );

end entity axi4_lite_max7219_registers;

architecture rtl of axi4_lite_max7219_registers is

  -- == INTERNAL Signals ==
  signal reg_wr_sel       : std_logic_vector(C_NB_REG - 1 downto 0);  -- Write register selection
  signal reg_wr_sel_error : std_logic;                                -- Reg Write Selection error

  -- Internal Registers
  signal ctrl_register       : std_logic_vector(C_CTRL_WIDTH - 1 downto 0);  -- CTRL Register
  signal cmd_register        : std_logic_vector(C_CMD_WIDTH - 1 downto 0);   -- Command Register
  signal status_register     : std_logic_vector(C_STATUS_WIDTH - 1 downto 0);
  signal slv_wr_access_error : std_logic;                                    -- Slave Write Access Error

begin  -- architecture rtl


  -- == Register Decoding ==
  -- Register decoding for Write Access or Read Access
  -- 
  g_register_sel : for i in 0 to C_NB_REG - 1 generate

    -- Register selection from slv_addr
    -- Check registers addr until G_REG_NB
    p_register_sel : process (slv_addr) is
    begin  -- process p_register_sel

      -- Set the corresponding bit to '1' if the address correspond to an
      -- exsisting address from the number of possible address
      -- check addr modulo 4 (0-4-8-C)
      if(unsigned(slv_addr(C_USEFUL_LSBITS - 1 downto 0)) = to_unsigned((i*G_DATA_WIDTH)/8, C_USEFUL_LSBITS)) then

        -- If different from REG2 ADDR -> Write access is authorized
        -- otherwise it is forbidden ('0')
        if(unsigned(slv_addr(C_USEFUL_LSBITS - 1 downto 0)) /= unsigned(C_REG2_ADDR)) then  --, slv_addr'length)) then
          reg_wr_sel(i) <= '1';
        else
          reg_wr_sel(i) <= '0';
        end if;

      else
        reg_wr_sel(i) <= '0';
      end if;

    end process p_register_sel;

  end generate;
  -- ==========================

  -- == SELECTION ERROR Management ==
  -- reg_wr_sel_error generation if reg_wr_sel is set to (others => '0')
  reg_wr_sel_error <= '1' when reg_wr_sel = std_logic_vector(to_unsigned(0, reg_wr_sel'length)) else '0';
  -- ================================


  -- == Register Write Access ==
  -- purpose: Write Management of the REG0 Register
  -- Write in :
  -- CTRL
  -- ENTRY_MODE_SET_CONFIG
  -- DISP_ON_OFF_CONFIG
  -- CURSOR_DISP_CONFIG
  -- Register in function of the strobe
  p_reg0_wr_mngt : process (clk, rst_n) is
  begin  -- process p_reg0_wr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      ctrl_register <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Write in CTRL Register
      if(reg_wr_sel(C_REG0_IDX) = '1' and slv_start = '1' and slv_rw = '0') then
        ctrl_register <= slv_wdata(C_CTRL_WIDTH - 1 downto 0);
      end if;

    end if;
  end process p_reg0_wr_mngt;


  -- purpose: REG1 Write Management
  -- Write in register :
  -- command register
  p_reg1_wr_mngt : process (clk, rst_n) is
  begin  -- process p_reg1_wr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      cmd_register <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Write in FUNC_SET_CONFIG Register
      if(reg_wr_sel(C_REG1_IDX) = '1' and slv_start = '1' and slv_rw = '0') then
        cmd_register <= slv_wdata(C_CMD_WIDTH - 1 downto 0);
      end if;

    end if;
  end process p_reg1_wr_mngt;

  -- ===========================



  -- Slave WRite Access error :
  -- Wrong Write selection
  slv_wr_access_error <= reg_wr_sel_error;


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
        slv_status <= slv_wr_access_error & '0';

      -- Ack for a read access into a regular register
      -- Generates an error if the addr is greater than the last accessible addr C_REG2_ADDR
      elsif(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) > C_REG2_ADDR) then
        slv_status <= "10";

      -- No Error generated
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

      -- RDATA for Regular registers
      -- Set RDATA when reading REG0
      if(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) = C_REG0_ADDR) then
        slv_rdata <= x"0000000" & x"0" & "000" & ctrl_register;

      -- Set RDATA when reading REG1
      elsif(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) = C_REG1_ADDR) then
        slv_rdata <= x"0" & cmd_register;

      -- Set RDATA when reading REG2
      elsif(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) = C_REG2_ADDR) then
        slv_rdata <= std_logic_vector(to_unsigned(0, G_DATA_WIDTH - C_STATUS_WIDTH)) & status_register;

      -- Otherwise REturn (others => '0');
      else
        slv_rdata <= (others => '0');
      end if;

    end if;
  end process p_slv_rdata_mngt;

  -- ==========================

  -- Inputs
  status_register <= fifo_full & fifo_empty;
  -- == OUTPUTS Affectation ==
  cmd_start       <= '0';               -- Command Start
  cmd             <= cmd_register(13 downto 0);
  cmd_data        <= cmd_register(23 downto 16);
  matrix_idx      <= cmd_register(25 downto 24);


end architecture rtl;
