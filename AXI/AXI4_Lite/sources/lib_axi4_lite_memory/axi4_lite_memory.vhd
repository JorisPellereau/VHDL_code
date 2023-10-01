-------------------------------------------------------------------------------
-- Title      : AXI4 Lite Memory
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_lcd.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-17
-- Last update: 2023-10-01
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: AXI4 Lite Memory
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-17  1.0      linux-jp        Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library lib_axi4_lite;
library lib_axi4_lite_memory;
library lib_rom_intel;
use lib_rom_intel.pkg_sp_rom.all;


entity axi4_lite_memory is
  generic (
    G_AXI4_LITE_ADDR_WIDTH : integer range 10 to 64 := 32;  -- AXI4 Lite ADDR WIDTH
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite DATA WIDTH
    G_ROM_ADDR_WIDTH       : integer                := 8;   -- ROM Addr Width - Shall have the size : G_AXI4_LITE_ADDR_WIDTH / 4
    G_ROM_INIT             : t_rom_32bits                   -- Rom Initialization
    );
  port (
    clk_sys   : in std_logic;                               -- System Clock
    rst_n_sys : in std_logic;                               -- Asynchronous Reset

    -- Write Address Channel signals
    awvalid : in  std_logic;                                              -- Address Write Valid
    awaddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Address Write
    awprot  : in  std_logic_vector(2 downto 0);                           -- Adress Write Prot
    awready : out std_logic;                                              -- Address Write Ready

    -- Write Data Channel
    wvalid : in  std_logic;                                                    -- Write Data Valid
    wdata  : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);        -- Write Data
    wstrb  : in  std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
    wready : out std_logic;                                                    -- Write data Ready

    -- Write Response Channel
    bready : in  std_logic;                     -- Write Channel Response
    bvalid : out std_logic;                     -- Write Response Channel Valid
    bresp  : out std_logic_vector(1 downto 0);  -- Write Response Channel resp

    -- Read Address Channel
    arvalid : in  std_logic;                                              -- Read Channel Valid
    araddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
    arprot  : in  std_logic_vector(2 downto 0);                           --  Read Address channel Ready Prot
    arready : out std_logic;                                              -- Read Address Channel Ready

    -- Read Data Channel
    rready : in  std_logic;                                              -- Read Data Channel Ready
    rvalid : out std_logic;                                              -- Read Data Channel Valid
    rdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
    rresp  : out std_logic_vector(1 downto 0)                            -- Read Data Channel Response
    );

end entity axi4_lite_memory;

architecture rtl of axi4_lite_memory is

  -- == INTERNAL Signals ==
  signal slv_start  : std_logic;                                                  -- Start the access
  signal slv_rw     : std_logic;                                                  -- Read or Write Access
  signal slv_addr   : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);      -- ADDR to reach
  signal slv_wdata  : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);      -- Write Data
  signal slv_strobe : std_logic_vector((G_AXI4_LITE_DATA_WIDTH/8) - 1 downto 0);  -- Write Strobe
  signal slv_done   : std_logic;                                                  -- Access done
  signal slv_rdata  : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);      -- Slave read data
  signal slv_status : std_logic_vector(1 downto 0);                               -- Slave status

  signal addr_rom : std_logic_vector(G_ROM_ADDR_WIDTH - 1 downto 0);        -- ADDR ROM
  signal data_rom : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- DATA ROM

begin  -- architecture rtl

  -- Instanciation of AXI4 Lite Slave interface
  i_axi4_lite_slave_itf_0 : entity lib_axi4_lite.axi4_lite_slave_itf

    generic map (
      G_AXI4_LITE_ADDR_WIDTH => G_AXI4_LITE_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI4_LITE_DATA_WIDTH
      )
    port map(
      clk   => clk_sys,
      rst_n => rst_n_sys,

      -- Write Address Channel signals
      awvalid => awvalid,
      awaddr  => awaddr,
      awprot  => awprot,
      awready => awready,

      -- Write Data Channel
      wvalid => wvalid,
      wdata  => wdata,
      wstrb  => wstrb,
      wready => wready,

      -- Write Response Channel
      bready => bready,
      bvalid => bvalid,
      bresp  => bresp,

      -- Read Address Channel
      arvalid => arvalid,
      araddr  => araddr,
      arprot  => arprot,
      arready => arready,

      -- Read Data Channel
      rready => rready,
      rvalid => rvalid,
      rdata  => rdata,
      rresp  => rresp,

      -- Slave Registers Interface
      slv_start  => slv_start,
      slv_rw     => slv_rw,
      slv_addr   => slv_addr,
      slv_wdata  => slv_wdata,
      slv_strobe => slv_strobe,

      slv_done   => slv_done,
      slv_rdata  => slv_rdata,
      slv_status => slv_status
      );


  -- Instanciation of the MEMORY Controler
  i_axi4_lite_rom_ctrl_0 : entity lib_axi4_lite_memory.axi4_lite_rom_ctrl

    generic map(
      G_AXI4_LITE_ADDR_WIDTH => G_AXI4_LITE_ADDR_WIDTH,
      G_AXI4_LITE_DATA_WIDTH => G_AXI4_LITE_DATA_WIDTH,
      G_ROM_ADDR_WIDTH       => G_ROM_ADDR_WIDTH
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- Slave Interface
      slv_start => slv_start,
      slv_rw    => slv_rw,
      slv_addr  => slv_addr,
      done      => slv_done,
      rdata     => slv_rdata,
      status    => slv_status,

      -- Rom Interface
      addr_rom  => addr_rom,
      rom_rdata => data_rom
      );

  -- Instanciation of the SP ROM
  -- Le nombre de case memoire de la ROM est / 4
  i_sp_rom_0 : entity lib_rom_intel.sp_rom
    generic map(
      G_ADDR_WIDTH => G_ROM_ADDR_WIDTH,
      G_DATA_WIDTH => G_AXI4_LITE_DATA_WIDTH,
      G_ROM_INIT   => G_ROM_INIT
      )
    port map (
      clk    => clk_sys,
      addr_a => addr_rom,
      q_a    => data_rom
      );

end architecture rtl;
