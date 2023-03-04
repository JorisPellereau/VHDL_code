-------------------------------------------------------------------------------
-- Title      : Wrapper of the AXI4Lite Manager block of OSVVM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : osvvm_axi4lite_manager_wrapper.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-03-04
-- Last update: 2023-03-04
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-03-04  1.0      linux-jp        Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;
use ieee.math_real.all;

library osvvm_common;
use osvvm_common.AddressBusTransactionPkg.all;

library tb_lib_osvvm_axi4lite;
use tb_lib_osvvm_axi4lite.Axi4OptionsPkg.all;
use tb_lib_osvvm_axi4lite.Axi4ModelPkg.all;
use tb_lib_osvvm_axi4lite.Axi4InterfaceCommonPkg.all;
use tb_lib_osvvm_axi4lite.Axi4LiteInterfacePkg.all;
use tb_lib_osvvm_axi4lite.Axi4CommonPkg.all;

-- library osvvm;
--   context osvvm.OsvvmContext;
--   use osvvm.ScoreboardPkg_slv.all;

-- library osvvm_common;
-- context osvvm_common.OsvvmCommonContext;




entity osvvm_axi4lite_manager_wrapper is
  generic(
    MODEL_ID_NAME          : string                 := "MASTER_AXI4_Lite_";
    G_AXI4_LITE_ADDR_WIDTH : integer range 32 to 64 := 32;
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32;
    tperiod_Clk            : time                   := 10 ns;
    DEFAULT_DELAY          : time                   := 1 ns;
    tpd_Clk_AWAddr         : time                   := 1 ns;
    tpd_Clk_AWProt         : time                   := 1 ns;
    tpd_Clk_AWValid        : time                   := 1 ns;
    tpd_Clk_WValid         : time                   := 1 ns;
    tpd_Clk_WData          : time                   := 1 ns;
    tpd_Clk_WStrb          : time                   := 1 ns;
    tpd_Clk_BReady         : time                   := 1 ns;
    tpd_Clk_ARValid        : time                   := 1 ns;
    tpd_Clk_ARProt         : time                   := 1 ns;
    tpd_Clk_ARAddr         : time                   := 1 ns;
    tpd_Clk_RReady         : time                   := 1 ns
    );
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- Write Address Channel signals
    awvalid : out std_logic;            -- Address Write Valid
    awaddr  : out std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Address Write
    awprot  : out std_logic_vector(2 downto 0);  -- Adress Write Prot
    awready : in  std_logic;            -- Address Write Ready

    -- Write Data Channel
    wvalid : out std_logic;             -- Write Data Valid
    wdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Write Data
    wstrb  : out std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);
    wready : in  std_logic;             -- Write data Ready

    -- Write Response Channel
    bready : out std_logic;                     -- Write Channel Response
    bvalid : in  std_logic;                     -- Write Response Channel Valid
    bresp  : in  std_logic_vector(1 downto 0);  -- Write Response Channel resp

    -- Read Address Channel
    arvalid : out std_logic;            -- Read Channel Valid
    araddr  : out std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
    arprot  : out std_logic_vector(2 downto 0);  --  Read Address channel Ready Prot
    arready : in  std_logic;            -- Read Address Channel Ready

    -- Read Data Channel
    rready : out std_logic;             -- Read Data Channel Ready
    rvalid : in  std_logic;             -- Read Data Channel Valid
    rdata  : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
    rresp  : in  std_logic_vector(1 downto 0)  -- Read Data Channel Response

    );
end entity osvvm_axi4lite_manager_wrapper;

architecture rtl of osvvm_axi4lite_manager_wrapper is
--tb_lib_osvvm_axi4lite.Axi4LiteInterfacePkg.
  -- == INTERNALS Signals ==
  signal axibus : Axi4LiteRecType (
    WriteAddress(Addr (G_AXI4_LITE_ADDR_WIDTH-1 downto 0)),
    WriteData (Data (G_AXI4_LITE_DATA_WIDTH-1 downto 0),
               Strb((G_AXI4_LITE_DATA_WIDTH/8)-1 downto 0)),
    ReadAddress (Addr (G_AXI4_LITE_ADDR_WIDTH-1 downto 0)),
    ReadData (Data (G_AXI4_LITE_DATA_WIDTH-1 downto 0))
    );

  signal transrec : AddressBusRecType (
    Address (G_AXI4_LITE_ADDR_WIDTH-1 downto 0),
    DataToModel (G_AXI4_LITE_DATA_WIDTH-1 downto 0),
    DataFromModel(G_AXI4_LITE_DATA_WIDTH-1 downto 0)
    );


  -- Interface with Tesbench Module
  signal wr_req : std_logic;

begin  -- architecture rtl


  i_Axi4LiteManager_0 : entity tb_lib_osvvm_axi4lite.Axi4LiteManager
    generic map (
      MODEL_ID_NAME   => MODEL_ID_NAME,
      tperiod_Clk     => tperiod_Clk,
      DEFAULT_DELAY   => DEFAULT_DELAY,
      tpd_Clk_AWAddr  => tpd_Clk_AWAddr,
      tpd_Clk_AWProt  => tpd_Clk_AWProt,
      tpd_Clk_AWValid => tpd_Clk_AWValid,
      tpd_Clk_WValid  => tpd_Clk_WValid,
      tpd_Clk_WData   => tpd_Clk_WData,
      tpd_Clk_WStrb   => tpd_Clk_WStrb,
      tpd_Clk_BReady  => tpd_Clk_BReady,
      tpd_Clk_ARValid => tpd_Clk_ARValid,
      tpd_Clk_ARProt  => tpd_Clk_ARProt,
      tpd_Clk_ARAddr  => tpd_Clk_ARAddr,
      tpd_Clk_RReady  => tpd_Clk_RReady
      )
    port map (
      Clk    => clk,
      nReset => rst_n,

      -- AXI Manager Functional Interface
      AxiBus => Axibus,

      -- Testbench Transaction Interface
      TransRec => transrec
      );


  -- AXIBUS to AXI IN/OUT

  -- == AXI4Lite Procedure Control =

  p_axi4_write : process is
  begin  -- process p_axi4_write
    wait until rising_edge(wr_req);
--    if(wr_req = ) then
      Write(transrec, X"0002_0000", X"0002_0101");
  --  end if;

  end process p_axi4_write;


end architecture rtl;
