-------------------------------------------------------------------------------
-- Title      : AXI 4 Lite SPI SLAVE Registers
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_spi_slave_registers.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-08-29
-- Last update: 2024-02-21
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: SPI SLAVE REGISTERS - 32 bits access
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

library lib_axi4_lite_spi_slave;
use lib_axi4_lite_spi_slave.axi4_lite_spi_slave_pkg.all;

entity axi4_lite_spi_slave_registers is
  generic (
    G_ADDR_WIDTH      : integer range 4 to 16  := 5;   -- USEFULL ADDR WIDTH
    G_DATA_WIDTH      : integer range 32 to 64 := 32;  -- AXI4 Lite DATA WIDTH
    G_SPI_DATA_WIDTH  : integer                := 8;   -- SPI DATA WIDTH
    G_FIFO_DATA_WIDTH : integer range 8 to 32  := 8    -- FIFO DATA WIDTH

    );
  port (
    clk_sys   : in std_logic;           -- Clock
    rst_n_sys : in std_logic;           -- Asynchronous Reset

    -- Slave Registers Interface
    slv_start  : in std_logic;                                          -- Start the access
    slv_rw     : in std_logic;                                          -- Read or write access
    slv_addr   : in std_logic_vector(G_ADDR_WIDTH - 1 downto 0);        -- Slave Addr
    slv_wdata  : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);        -- Slave Write Data
    slv_strobe : in std_logic_vector((G_DATA_WIDTH / 8) - 1 downto 0);  -- Write strobe

    slv_done   : out std_logic;                                    -- Slave access done
    slv_rdata  : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Slave RDATA
    slv_status : out std_logic_vector(1 downto 0);                 -- Slave status

    -- FIFO RX FLAG
    fifo_rx_empty : in std_logic;       -- FIFO RX EMPTY FLAG
    fifo_rx_full  : in std_logic;       -- FIFO RX FULL FLAG

    -- FIFO TX FLAG
    fifo_tx_empty : in std_logic;       -- FIFO TX EMPTY FLAG
    fifo_tx_full  : in std_logic;       -- FIFO TX FULL FLAG

    -- Registers Interface
    rd_fifo_rx_en     : out std_logic;                                         -- Read Enable of FIFO RX
    rdata_fifo_rx     : in  std_logic_vector(G_FIFO_DATA_WIDTH - 1 downto 0);  -- Read Data FIFO RX
    rdata_fifo_rx_val : in  std_logic;                                         -- Read Data FIFO RX Valid
    spi_busy          : in  std_logic                                          -- SPI BUSY
    );

end entity axi4_lite_spi_slave_registers;

architecture rtl of axi4_lite_spi_slave_registers is

  -- == INTERNAL Signals ==
  signal reg_sel          : std_logic_vector(C_NB_REG - 1 downto 0);  -- Register selection
  signal reg_wr_sel_error : std_logic;                                -- Reg Write Selection error

  -- Internal Registers
  signal fifo_rx_register        : std_logic_vector(C_FIFO_RX_WIDTH - 1 downto 0);  -- FIFO RX Register
  signal fifo_rx_register_val    : std_logic;                                       -- FIFO RX Updated occurs
  signal status_register         : std_logic_vector(C_STATUS_WIDTH - 1 downto 0);   -- STATUS Register
  signal slv_wr_access_error     : std_logic;                                       -- Slave Write Access Error
  signal rd_fifo_rx_en_int       : std_logic;                                       -- Read FIFO RX
  signal regular_reg_sel         : std_logic;                                       -- Regular Register selected
  signal fifo_rx_rd_access_error : std_logic;                                       -- FIFO RX Read access Error FLAG

begin  -- architecture rtl


  -- == Register Decoding ==
  -- Register decoding for Write Access or Read Access 
  g_register_sel : for i in 0 to C_NB_REG - 1 generate

    -- Register selection from slv_addr
    -- Check registers addr until G_REG_NB
    p_register_sel : process (slv_addr) is
    begin  -- process p_register_sel

      -- Set the corresponding bit to '1' if the address correspond to an
      -- exsisting address from the number of possible address
      -- check addr modulo 4 (0-4-8-C)
      if(unsigned(slv_addr(C_USEFUL_LSBITS - 1 downto 0)) = to_unsigned((i*G_DATA_WIDTH)/8, C_USEFUL_LSBITS)) then

        -- If lower or equals than REG1 ADDR -> access is authorized
        -- otherwise it is forbidden ('0')
        if(unsigned(slv_addr(C_USEFUL_LSBITS - 1 downto 0)) <= unsigned(C_REG1_ADDR)) then
          reg_sel(i) <= '1';
        else
          reg_sel(i) <= '0';
        end if;

      else
        reg_sel(i) <= '0';
      end if;

    end process p_register_sel;

  end generate;
  -- ==========================

  -- == WRITE SELECTION ERROR Management ==
  reg_wr_sel_error <= '1';              -- Always at one because no register in WRITE access
  -- ======================================


  -- == Register Write Access ==
  -- REG0 is only updated from the data from the FIFO RX

  -- purpose: Register 0 - FIFO RX update 
  p_reg0_update : process (clk_sys, rst_n_sys) is
  begin  -- process p_reg0_update
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fifo_rx_register     <= (others => '0');
      fifo_rx_register_val <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- On the valid signal, update fifo_rx_register
      -- This signal is set to one only if rd_fifo_rx_en was set previously AND if the FIFO is not empty
      if(rdata_fifo_rx_val = '1') then
        fifo_rx_register     <= x"000000" & rdata_fifo_rx;  -- Update FIFO RX register
        fifo_rx_register_val <= '1';
      else
        fifo_rx_register_val <= '0';                        -- Reset the flag
      end if;

    end if;
  end process p_reg0_update;
  -- ===========================


  -- purpose: FIFO RX Read Enable bit management
  p_fifo_rx_en_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_fifo_rx_en_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      rd_fifo_rx_en_int <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Generates the enable bit only during a read_access (slv_rw = '1') and if the correct
      -- register (REG0) is selected. Otherwise no generatio of the bit
      -- Perform a read access only if the FIFO RX is not empty
      if(reg_sel(C_REG0_IDX) = '1' and slv_start = '1' and slv_rw = '1' and fifo_rx_empty = '0') then
        rd_fifo_rx_en_int <= '1';
      else
        rd_fifo_rx_en_int <= '0';
      end if;

    end if;
  end process p_fifo_rx_en_mngt;

  -- purpose: FIFO RX Read access error because of empty FIFO
  p_fifo_rx_read_access_error : process (clk_sys, rst_n_sys) is
  begin  -- process p_fifo_rx_read_access_error
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      fifo_rx_rd_access_error <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- If a read access if perform on the REG0 and if the fifo is EMPTY -> abort the access and generate an error flag
      if(reg_sel(C_REG0_IDX) = '1' and slv_start = '1' and slv_rw = '1' and fifo_rx_empty = '1') then
        fifo_rx_rd_access_error <= '1';
      else
        fifo_rx_rd_access_error <= '0';
      end if;

    end if;
  end process p_fifo_rx_read_access_error;

  -- Slave WRite Access error :
  -- Wrong Write selection
  slv_wr_access_error <= reg_wr_sel_error;


  -- Regular register is selected
  regular_reg_sel <= reg_sel(C_REG1_IDX);  -- REG1 (STATUS) is the only regular register

  -- == Slave ACK Management ==

  -- purpose: Slave Done Management
  p_slv_done_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_slv_done_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      slv_done <= '0';
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Ack for a write access into a regular register
      if(slv_start = '1' and slv_rw = '0') then
        slv_done <= '1';

      -- Ack for a read access into a regular register
      -- REGULAR REGISTER : REG1
      elsif(slv_start = '1' and slv_rw = '1' and regular_reg_sel = '1') then
        slv_done <= '1';

      -- Ack from a read FIFO RX access - Case an access to the FIFO RX was generated
      -- Or if an FIFO RX RD Access error is set
      elsif(fifo_rx_register_val = '1' or fifo_rx_rd_access_error = '1') then
        slv_done <= '1';

      else
        slv_done <= '0';
      end if;

    end if;
  end process p_slv_done_mngt;

  -- purpose: Slave Statue management
  p_slv_status_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_slv_status_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      slv_status <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- Ack for a write access into a regular register
      if(slv_start = '1' and slv_rw = '0') then
        slv_status <= slv_wr_access_error & '0';

      -- Ack for a read access into a regular register
      -- Generates an error if the addr is greater than the last accessible addr C_REG1_ADDR
      -- OR
      -- if a FIFO READ RX Read Access is generated
      elsif((slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) > C_REG1_ADDR)
            or
            fifo_rx_rd_access_error = '1'
            ) then
        slv_status <= "10";

      -- No Error generated
      else
        slv_status <= "00";
      end if;

    end if;
  end process p_slv_status_mngt;


  -- purpose: Slave RDATA management  
  p_slv_rdata_mngt : process (clk_sys, rst_n_sys) is
  begin  -- process p_slv_rdata_mngt
    if rst_n_sys = '0' then             -- asynchronous reset (active low)
      slv_rdata <= (others => '0');
    elsif rising_edge(clk_sys) then     -- rising clock edge

      -- RDATA for a FIFO registers
      -- Set RDATA when reading REG0
      if(fifo_rx_register_val = '1') then
        slv_rdata <= fifo_rx_register;

      -- Set RDATA when reading REG1
      elsif(slv_start = '1' and slv_rw = '1' and slv_addr(C_USEFUL_LSBITS - 1 downto 0) = C_REG1_ADDR) then
        slv_rdata <= x"000" & "000" & status_register;

      -- Otherwise REturn (others => '0');
      else
        slv_rdata <= (others => '0');
      end if;

    end if;
  end process p_slv_rdata_mngt;

  -- ==========================

  -- Inputs
  status_register <= spi_busy & x"0" & "00" & fifo_rx_full & fifo_rx_empty & x"0" & "00" & fifo_tx_full & fifo_tx_empty;  -- FIFO A ajouter

  -- == OUTPUTS Affectation ==
  rd_fifo_rx_en <= rd_fifo_rx_en_int;

end architecture rtl;
