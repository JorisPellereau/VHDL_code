-------------------------------------------------------------------------------
-- Title      : AXI4 Lite MAX7219 Controller
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_max7219.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-17
-- Last update: 2023-12-07
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: AXI4 Lite MAX7219 Controller
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
library lib_axi4_lite_max7219;
library lib_max7219;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

entity axi4_lite_max7219 is
  generic (
    G_AXI4_LITE_ADDR_WIDTH : integer range 10 to 64 := 10;  -- AXI4 Lite ADDR WIDTH
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite DATA WIDTH
    G_MATRIX_NB            : integer range 1 to 8   := 4    -- Matrix Number
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
    rresp  : out std_logic_vector(1 downto 0);                           -- Read Data Channel Response

    -- MAX7219 I/F
    o_max7219_load : out std_logic;     -- LOAD command
    o_max7219_data : out std_logic;     -- DATA to send
    o_max7219_clk  : out std_logic      -- CLK
    );

end entity axi4_lite_max7219;

architecture rtl of axi4_lite_max7219 is

  -- == INTERNAL Signals ==
  signal slv_start   : std_logic;                                                  -- Start the access
  signal slv_rw      : std_logic;                                                  -- Read or Write Access
  signal slv_addr    : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);      -- ADDR to reach
  signal slv_wdata   : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);      -- Write Data
  signal slv_strobe  : std_logic_vector((G_AXI4_LITE_DATA_WIDTH/8) - 1 downto 0);  -- Write Strobe
  signal slv_done    : std_logic;                                                  -- Access done
  signal slv_rdata   : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);      -- Slave read data
  signal slv_status  : std_logic_vector(1 downto 0);                               -- Slave status
  signal cmd_start   : std_logic;                                                  -- Command Start
  signal cmd         : std_logic_vector(13 downto 0);                              -- Command
  signal cmd_data    : std_logic_vector(7 downto 0);                               -- Command Data
  signal matrix_idx  : std_logic_vector(log2(G_MATRIX_NB) - 1 downto 0);           -- Matrix Index
  signal fifo_full   : std_logic;                                                  -- FIFO FULL
  signal fifo_empty  : std_logic;                                                  -- FIFO Empty
  signal ctrl_status : std_logic;                                                  -- Control Status
  signal ctrl_done   : std_logic;                                                  -- Control done

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


  -- Instanciation of LCD REGISTERS
  i_axi4_lite_max7219_registers_0 : entity lib_axi4_lite_max7219.axi4_lite_max7219_registers
    generic map (
      G_ADDR_WIDTH => G_AXI4_LITE_ADDR_WIDTH,
      G_DATA_WIDTH => G_AXI4_LITE_DATA_WIDTH,
      G_MATRIX_NB  => G_MATRIX_NB
      )
    port map (
      clk   => clk_sys,
      rst_n => rst_n_sys,

      -- Slave Registers Interface
      slv_start  => slv_start,
      slv_rw     => slv_rw,
      slv_addr   => slv_addr,
      slv_wdata  => slv_wdata,
      slv_strobe => slv_strobe,

      slv_done   => slv_done,
      slv_rdata  => slv_rdata,
      slv_status => slv_status,

      -- Registers Interface
      cmd_start   => cmd_start,
      cmd         => cmd,
      cmd_data    => cmd_data,
      matrix_idx  => matrix_idx,
      ctrl_done   => ctrl_done,
      ctrl_status => ctrl_status,
      fifo_full   => fifo_full,
      fifo_empty  => fifo_empty
      );


  -- Instanciation of MAX7219 Controller
  i_max7219_ctrli_0 : entity lib_max7219.max7219_ctrl
    generic map (
      G_MATRIX_NB => G_MATRIX_NB
      )
    port map(
      clk_sys   => clk_sys,
      rst_n_sys => rst_n_sys,

      -- Control Signals
      cmd_start  => cmd_start,
      cmd        => cmd,
      cmd_data   => cmd_data,
      matrix_idx => matrix_idx,

      ctrl_done   => ctrl_done,
      ctrl_status => ctrl_status,

      -- Status
      fifo_full  => fifo_full,
      fifo_empty => fifo_empty,

      -- MAX7219 I/F
      o_max7219_load => o_max7219_load,
      o_max7219_data => o_max7219_data,
      o_max7219_clk  => o_max7219_clk
      );


end architecture rtl;
