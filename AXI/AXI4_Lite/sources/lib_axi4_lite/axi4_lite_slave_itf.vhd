-------------------------------------------------------------------------------
-- Title      : AXI4 Lite Slave Interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_slave_itf.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-03-04
-- Last update: 2023-05-19
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: AXI4 Lite Slave Refisters Interface
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

entity axi4_lite_slave_itf is

  generic (
    G_AXI4_LITE_ADDR_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite ADDR WIDTH
    G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32  -- AXI4 Lite DATA WIDTH
    );
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    -- Write Address Channel signals
    awvalid : in  std_logic;            -- Address Write Valid
    awaddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Address Write
    awprot  : in  std_logic_vector(2 downto 0);  -- Adress Write Prot
    awready : out std_logic;            -- Address Write Ready

    -- Write Data Channel
    wvalid : in  std_logic;             -- Write Data Valid
    wdata  : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Write Data
    wstrb  : in  std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
    wready : out std_logic;             -- Write data Ready

    -- Write Response Channel
    bready : in  std_logic;                     -- Write Channel Response
    bvalid : out std_logic;                     -- Write Response Channel Valid
    bresp  : out std_logic_vector(1 downto 0);  -- Write Response Channel resp

    -- Read Address Channel
    arvalid : in  std_logic;            -- Read Channel Valid
    araddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
    arprot  : in  std_logic_vector(2 downto 0);  --  Read Address channel Ready Prot
    arready : out std_logic;            -- Read Address Channel Ready

    -- Read Data Channel
    rready : in  std_logic;             -- Read Data Channel Ready
    rvalid : out std_logic;             -- Read Data Channel Valid
    rdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
    rresp  : out std_logic_vector(1 downto 0);  -- Read Data Channel Response

    -- Slave Registers Interface
    slv_start  : out std_logic;         -- Start the access
    slv_rw     : out std_logic;         -- Read or write access
    slv_addr   : out std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Slave Addr
    slv_wdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave Write Data
    slv_strobe : out std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Write strobe

    slv_done   : in std_logic;          -- Slave access done
    slv_rdata  : in std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave RDATA
    slv_status : in std_logic           -- Slave status        
    );

end entity axi4_lite_slave_itf;

architecture rtl of axi4_lite_slave_itf is

  -- == INTERNAL Signals ==
  signal s_arvalid : std_logic;         -- Latch arvalid
  signal s_araddr  : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Latch araddr
  signal s_arready : std_logic;         -- Arready

  signal s_rvalid : std_logic;          -- Read Valid signal

  signal s_rd_ongoing : std_logic;      -- Read Access ongoing
  signal s_wr_ongoing : std_logic;      -- Write Access ongoing

  signal s_awvalid : std_logic;         -- Internal awvalid
  signal s_awaddr  : std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Latch AWADDR
  signal s_awready : std_logic;         -- Internal awready

  signal s_wvalid : std_logic;          -- Internal wvalid
  signal s_wready : std_logic;          -- Internal wready
  signal s_wdata  : std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Latch WDATA
  signal s_wstrb  : std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Write strobe

begin  -- architecture rtl

  -- == READ CHANNEL MNGT ==

  -- purpose: ARValid Management
  p_arvalid_mngt : process (clk, rst_n) is
  begin  -- process p_arvalid_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_arvalid <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Reset s_arvalid on ack.
      if(arvalid = '1' and s_arready = '1') then
        s_arvalid <= '0';

      -- Set s_arvalid (Rising edge detection)
      elsif(arvalid = '1' and s_arvalid = '0') then
        s_arvalid <= '1';
      end if;
    end if;
  end process p_arvalid_mngt;


  -- purpose: Management of araddr
  p_araddr_mngt : process (clk, rst_n) is
  begin  -- process p_araddr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_araddr <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Latch araddr
      if(arvalid = '1' and s_arvalid = '0') then
        s_araddr <= araddr;
      end if;

    end if;
  end process p_araddr_mngt;


-- purpose: Arready Management
  p_arready_mngt : process (clk, rst_n) is
  begin  -- process p_arready_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_arready <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Reset arready on ack
      if(arvalid = '1' and s_arready = '1') then
        s_arready <= '0';

      -- Generate arready
      elsif(arvalid = '1' and s_arvalid = '0') then
        s_arready <= '1';
      end if;

    end if;
  end process p_arready_mngt;


  -- purpose: Rvalid Management
  p_rvalid_mngt : process (clk, rst_n) is
  begin  -- process p_rvalid_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_rvalid <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Reset s_rvalid on ack
      if(rready = '1' and s_rvalid = '1') then
        s_rvalid <= '0';
      elsif(slv_done = '1' and s_rd_ongoing = '1') then
        s_rvalid <= '1';
      end if;
    end if;
  end process p_rvalid_mngt;

  -- purpose: RDATA Management
  p_rdata_mngt : process (clk, rst_n) is
  begin  -- process p_rdata_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      rdata <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Latch RDATA on done and during a read access
      if(slv_done = '1' and s_rd_ongoing = '1') then
        rdata <= slv_rdata;
      end if;

    end if;
  end process p_rdata_mngt;

  -- purpose: RRESP Management
  p_rresp_mngt : process (clk, rst_n) is
  begin  -- process p_rresp_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      rresp <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      if(slv_done = '1' and s_rd_ongoing = '1' and slv_status = '0') then
        rresp <= (others => '0');

      -- Response is slave error
      elsif(slv_done = '1' and s_rd_ongoing = '1' and slv_status = '1') then
        rresp <= "10";
      end if;
    end if;

  end process p_rresp_mngt;

  -- purpose: Read ongoing Management
  p_rd_ongoing_mngt : process (clk, rst_n) is
  begin  -- process p_rd_ongoing_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_rd_ongoing <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Reset the ongoing status when done
      if(slv_done = '1') then
        s_rd_ongoing <= '0';

      elsif(arvalid = '1' and s_arvalid = '0') then
        s_rd_ongoing <= '1';
      end if;

    end if;
  end process p_rd_ongoing_mngt;

  -- =================================

  -- == WRITE CHANNEL MNGT ==


  -- purpose: AWVALID Management
  p_awvalid_mngt : process (clk, rst_n) is
  begin  -- process p_awvalid_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_awvalid <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Reset the signal on Ack
      if(awvalid = '1' and s_awready = '1') then
        s_awvalid <= '0';

      -- Set awvalid to '1' - rising edge detection
      elsif(awvalid = '1' and s_awvalid = '0') then
        s_awvalid <= '1';
      end if;

    end if;
  end process p_awvalid_mngt;


  -- purpose: AWADDR Latch
  p_awaddr_latch : process (clk, rst_n) is
  begin  -- process p_awaddr_latch
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_awaddr <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Latch awaddr
      if(awvalid = '1' and s_awvalid = '0') then
        s_awaddr <= awaddr;
      end if;

    end if;
  end process p_awaddr_latch;

  -- purpose: AWREADY Management
  p_awready_mngt : process (clk, rst_n) is
  begin  -- process p_awready_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_awready <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Reset the signal on Ack
      if(awvalid = '1' and s_awready = '1') then
        s_awready <= '0';

      -- Generate the signal on rising edge
      elsif(awvalid = '1' and s_awvalid = '0') then
        s_awready <= '1';
      end if;

    end if;
  end process p_awready_mngt;


  -- purpose: wvalid Management
  p_wvalid_mngt : process (clk, rst_n) is
  begin  -- process p_wvalid_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_wvalid <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Reset the signal on ACK
      if(wvalid = '1' and s_wready = '1') then
        s_wvalid <= '0';

      -- Generate the signal on rising edge
      elsif(wvalid = '1' and s_wvalid = '0') then
        s_wvalid <= '1';
      end if;

    end if;
  end process p_wvalid_mngt;


  -- purpose: WDATA Latch
  p_wdata_latch : process (clk, rst_n) is
  begin  -- process p_wdata_latch
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_wdata <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Latch wdata on rising edge of wvalid
      if(wvalid = '1' and s_wvalid = '0') then
        s_wdata <= wdata;
      end if;

    end if;
  end process p_wdata_latch;

  -- purpose: Write Strobe Latch Management
  p_wstrb_mngt : process (clk, rst_n) is
  begin  -- process p_wstrb_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_wstrb <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Latch Write Strobe on rising edge of wvalid
      if(wvalid = '1' and s_wvalid = '0') then
        s_wstrb <= wstrb;
      end if;

    end if;
  end process p_wstrb_mngt;

  -- purpose: Wready Management
  p_wready_mngt : process (clk, rst_n) is
  begin  -- process p_wready_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_wready <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Reset the signal on ACK
      if(wvalid = '1' and s_wready = '1') then
        s_wready <= '0';

      -- On rising edge of wvalid -> generate s_wready
      elsif(wvalid = '1' and s_wvalid = '0') then
        s_wready <= '1';
      end if;


    end if;
  end process p_wready_mngt;

  -- == ACCESS to Slave Management ==

  -- purpose: Slave start Management
  P_slv_start_mngt : process (clk, rst_n) is
  begin  -- process P_slv_start_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_start <= '0';
    elsif rising_edge(clk) then         -- rising clock edge

      -- Generate slv_start during an access and when the araddr channel or
      -- write data channel is acknowledge
      if((s_rd_ongoing = '1' and arvalid = '1' and s_arready = '1') or
         (s_wr_ongoing = '1' and wvalid = '1' and s_wready = '1')
         ) then
        slv_start <= '1';
      else
        slv_start <= '0';
      end if;

    end if;
  end process P_slv_start_mngt;

  -- purpose: Slave Addr Management
  p_slv_addr_mngt : process (clk, rst_n) is
  begin  -- process p_slv_addr_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_addr <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge
      if(s_rd_ongoing = '1' and arvalid = '1' and s_arready = '1') then
        slv_addr <= s_araddr;
      else
        slv_addr <= (others => '0');
      end if;

    end if;
  end process p_slv_addr_mngt;

  -- purpose: Slave R/W Access management
  p_slv_rw_mngt : process (clk, rst_n) is
  begin  -- process p_slv_rw_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_rw <= '0';
    elsif rising_edge(clk) then         -- rising clock edge
      if(s_rd_ongoing = '1' and arvalid = '1' and s_arready = '1') then
        slv_rw <= '1';
      else
        slv_rw <= '0';
      end if;

    end if;
  end process p_slv_rw_mngt;

  -- purpose: Slave Write Data management
  p_slv_wdata : process (clk, rst_n) is
  begin  -- process p_slv_wdata
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_wdata <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Set Write strobe for slave
      if(s_wr_ongoing = '1' and wvalid = '1' and s_wready = '1') then
        slv_wdata <= s_wdata;
      end if;

    end if;
  end process p_slv_wdata;


  -- purpose: Slave Strobe management
  p_slv_strobe : process (clk, rst_n) is
  begin  -- process p_slv_strobe
    if rst_n = '0' then                 -- asynchronous reset (active low)
      slv_strobe <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge

      -- Set Write strobe for slave
      if(s_wr_ongoing = '1' and wvalid = '1' and s_wready = '1') then
        slv_strobe <= s_wstrb;
      end if;

    end if;
  end process p_slv_strobe;

  -- ================================

  -- OUTPUTS Affectation
  awready <= s_wready;
  arready <= s_arready;
  rvalid  <= s_rvalid;

end architecture rtl;
