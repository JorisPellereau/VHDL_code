-------------------------------------------------------------------------------
-- Title      : TOP Block of an FPGA with JTAG and AXI4 Lite Slaves
-- Project    : 
-------------------------------------------------------------------------------
-- File       : jtag_axi4_lite_top.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-09-18
-- Last update: 2023-09-18
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2023 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2023-09-18  1.0      linux-jp	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;

entity jtag_7seg_top is
  generic (
    SEL_ALTERA_VJTAG : boolean := false  -- Selection of the VJTAG component
    );
  port (
    clk   : in std_logic;                -- Clock System
    rst_n : in std_logic;                -- Asynchronous Reset

    -- 7 Segments
    o_seg0 : out std_logic_vector(6 downto 0);  -- SEG 0
    o_seg1 : out std_logic_vector(6 downto 0);  -- SEG 1
    o_seg2 : out std_logic_vector(6 downto 0);  -- SEG 2
    o_seg3 : out std_logic_vector(6 downto 0);  -- SEG 3
    o_seg4 : out std_logic_vector(6 downto 0);  -- SEG 4
    o_seg5 : out std_logic_vector(6 downto 0);  -- SEG 5
    o_seg6 : out std_logic_vector(6 downto 0);  -- SEG 6
    o_seg7 : out std_logic_vector(6 downto 0);  -- SEG 7

    -- LCD

    -- RED LEDS
    ledr : out std_logic_vector(17 downto 0);  -- RED LEDS

    -- GREEN LEDS
    ledg : out std_logic_vector(8 downto 0)  -- GREEN LEDS
    );

end entity jtag_7seg_top;

architecture rtl of jtag_7seg_top is

  -- == COMPONENTS ==
  component reset_gen is
    port (
      clk     : in  std_logic;          -- Clock
      arst_n  : in  std_logic;          -- Synchronous Input Reset
      o_rst_n : out std_logic);         -- Output synchronous Reset
  end component;

  -- Component Altera VJTAG with 6 IR length
  component altera_vjtag is
    port (
      tdi                : out std_logic;  -- tdi
      tdo                : in  std_logic                    := 'X';  -- tdo
      ir_in              : out std_logic_vector(5 downto 0);         -- ir_in
      ir_out             : in  std_logic_vector(5 downto 0) := (others => 'X');  -- ir_out107
      virtual_state_cdr  : out std_logic;  -- virtual_state_cdr
      virtual_state_sdr  : out std_logic;  -- virtual_state_sdr
      virtual_state_e1dr : out std_logic;  -- virtual_state_e1dr
      virtual_state_pdr  : out std_logic;  -- virtual_state_pdr
      virtual_state_e2dr : out std_logic;  -- virtual_state_e2dr
      virtual_state_udr  : out std_logic;  -- virtual_state_udr
      virtual_state_cir  : out std_logic;  -- virtual_state_cir
      virtual_state_uir  : out std_logic;  -- virtual_state_uir
      tck                : out std_logic   -- clk
      );
  end component altera_vjtag;

  -- Component altera VJTAG with 24 IR length
  component altera_vjtag_24ir is
    port (
      tdi                : out std_logic;  -- tdi
      tdo                : in  std_logic                     := 'X';  -- tdo
      ir_in              : out std_logic_vector(23 downto 0);         -- ir_in
      ir_out             : in  std_logic_vector(23 downto 0) := (others => 'X');  -- ir_out
      virtual_state_cdr  : out std_logic;  -- virtual_state_cdr
      virtual_state_sdr  : out std_logic;  -- virtual_state_sdr
      virtual_state_e1dr : out std_logic;  -- virtual_state_e1dr
      virtual_state_pdr  : out std_logic;  -- virtual_state_pdr
      virtual_state_e2dr : out std_logic;  -- virtual_state_e2dr
      virtual_state_udr  : out std_logic;  -- virtual_state_udr
      virtual_state_cir  : out std_logic;  -- virtual_state_cir
      virtual_state_uir  : out std_logic;  -- virtual_state_uir
      tck                : out std_logic   -- clk
      );
  end component altera_vjtag_24ir;

  component vjtag_intf is

    generic (
      G_DATA_WIDTH : integer range 1 to 32 := 32;  -- DAta Width
      G_ADDR_WIDTH : integer range 8 to 32 := 32;
      G_IR_WIDTH   : integer range 6 to 24 := 6);  -- VJTAG IR Width
    port (
      clk_jtag   : in std_logic;                   -- JTAG Clock
      rst_n_jtag : in std_logic;                   -- Asynchronous Reset

      tdi   : in  std_logic;            -- TDI Data from Virtual JTAG
      tdo   : out std_logic;            -- TDO Data to Virtual JTAG
      ir_in : in  std_logic_vector(G_IR_WIDTH - 1 downto 0);  -- IR IN Vector
      sdr   : in  std_logic;            -- SDR state from Virtual JTAG
      udr   : in  std_logic;            -- UDR state from Virtual JTAG
      cdr   : in  std_logic;

      addr        : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Addr
      data_out    : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Data out
      data_in     : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- DATA IN to read
      data_in_val : in  std_logic;      -- Data in Valid
      rnw         : out std_logic;      -- Read not Write signal
      start       : out std_logic);     -- Start Read or Write Access

  end component vjtag_intf;

  component axi4_lite_master is

    generic (
      G_DATA_WIDTH : integer range 8 to 32 := 32;   -- DATA WIDTH
      G_ADDR_WIDTH : integer range 8 to 32 := 32);  -- ADDR WIDTH

    port(

      clk   : in std_logic;             -- Clock system
      rst_n : in std_logic;             -- Asynchronous Reset

      start         : in  std_logic;    -- Start the access
      addr          : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Addr of the access
      rnw           : in  std_logic;    -- Read ('1') or Write ('0') access
      strobe        : in  std_logic_vector((G_DATA_WIDTH / 8) - 1 downto 0);  -- Write strobe
      master_wdata  : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Write Data
      done          : out std_logic;    -- Access done
      master_rdata  : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Read Data
      access_status : out std_logic_vector(1 downto 0);  -- Access Status

      awvalid : out std_logic;          -- Address Write Valid
      awaddr  : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Address Write    
      awprot  : out std_logic_vector(2 downto 0);  -- Adress Write Prot
      awready : in  std_logic;          -- Address Write Ready

      wvalid : out std_logic;           -- Write Data Valid
      wdata  : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Write Data
      wstrb  : out std_logic_vector((G_DATA_WIDTH / 8) - 1 downto 0);
      wready : in  std_logic;           -- Write data Ready

      bready : out std_logic;           -- Write Channel Response
      bvalid : in  std_logic;           -- Write Response Channel Valid
      bresp  : in  std_logic_vector(1 downto 0);  -- Write Response Channel resp

      arvalid : out std_logic;          -- Read Channel Valid
      araddr  : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
      arprot  : out std_logic_vector(2 downto 0);  --  Read Address channel Ready Prot
      arready : in  std_logic;          -- Read Address Channel Ready

      rready : out std_logic;           -- Read Data Channel Ready
      rvalid : in  std_logic;           -- Read Data Channel Valid
      rdata  : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
      rresp  : in  std_logic_vector(1 downto 0)  -- Read Data Channel Resp
      );
  end component axi4_lite_master;

  component axi4_lite_slave_itf is

    generic (
      G_AXI4_LITE_ADDR_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite ADDR WIDTH
      G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32  -- AXI4 Lite DATA WIDTH
      );
    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      -- Write Address Channel signals
      awvalid : in  std_logic;          -- Address Write Valid
      awaddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Address Write
      awprot  : in  std_logic_vector(2 downto 0);  -- Adress Write Prot
      awready : out std_logic;          -- Address Write Ready

      -- Write Data Channel
      wvalid : in  std_logic;           -- Write Data Valid
      wdata  : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Write Data
      wstrb  : in  std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
      wready : out std_logic;           -- Write data Ready

      -- Write Response Channel
      bready : in  std_logic;           -- Write Channel Response
      bvalid : out std_logic;           -- Write Response Channel Valid
      bresp  : out std_logic_vector(1 downto 0);  -- Write Response Channel resp

      -- Read Address Channel
      arvalid : in  std_logic;          -- Read Channel Valid
      araddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
      arprot  : in  std_logic_vector(2 downto 0);  --  Read Address channel Ready Prot
      arready : out std_logic;          -- Read Address Channel Ready

      -- Read Data Channel
      rready : in  std_logic;           -- Read Data Channel Ready
      rvalid : out std_logic;           -- Read Data Channel Valid
      rdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
      rresp  : out std_logic_vector(1 downto 0);  -- Read Data Channel Response

      -- Slave Registers Interface
      slv_start  : out std_logic;       -- Start the access
      slv_rw     : out std_logic;       -- Read or write access
      slv_addr   : out std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Slave Addr
      slv_wdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave Write Data
      slv_strobe : out std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Write strobe

      slv_done   : in std_logic;        -- Slave access done
      slv_rdata  : in std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Slave RDATA
      slv_status : in std_logic_vector(1 downto 0)  -- Slave status        
      );

  end component axi4_lite_slave_itf;

  component axi4_lite_7segs is
    generic (
      G_AXI4_LITE_ADDR_WIDTH : integer range 32 to 64 := 32;  -- AXI4 Lite ADDR WIDTH
      G_AXI4_LITE_DATA_WIDTH : integer range 32 to 64 := 32  -- AXI4 Lite DATA WIDTH
      );
    port (
      clk   : in std_logic;             -- Clock
      rst_n : in std_logic;             -- Asynchronous Reset

      -- Write Address Channel signals
      awvalid : in  std_logic;          -- Address Write Valid
      awaddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Address Write
      awprot  : in  std_logic_vector(2 downto 0);  -- Adress Write Prot
      awready : out std_logic;          -- Address Write Ready

      -- Write Data Channel
      wvalid : in  std_logic;           -- Write Data Valid
      wdata  : in  std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Write Data
      wstrb  : in  std_logic_vector((G_AXI4_LITE_DATA_WIDTH / 8) - 1 downto 0);  -- Write Strobe
      wready : out std_logic;           -- Write data Ready

      -- Write Response Channel
      bready : in  std_logic;           -- Write Channel Response
      bvalid : out std_logic;           -- Write Response Channel Valid
      bresp  : out std_logic_vector(1 downto 0);  -- Write Response Channel resp

      -- Read Address Channel
      arvalid : in  std_logic;          -- Read Channel Valid
      araddr  : in  std_logic_vector(G_AXI4_LITE_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
      arprot  : in  std_logic_vector(2 downto 0);  --  Read Address channel Ready Prot
      arready : out std_logic;          -- Read Address Channel Ready

      -- Read Data Channel
      rready : in  std_logic;           -- Read Data Channel Ready
      rvalid : out std_logic;           -- Read Data Channel Valid
      rdata  : out std_logic_vector(G_AXI4_LITE_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
      rresp  : out std_logic_vector(1 downto 0);  -- Read Data Channel Response

      -- 7 Segments
      o_seg0 : out std_logic_vector(6 downto 0);  -- SEG 0
      o_seg1 : out std_logic_vector(6 downto 0);  -- SEG 1
      o_seg2 : out std_logic_vector(6 downto 0);  -- SEG 2
      o_seg3 : out std_logic_vector(6 downto 0);  -- SEG 3
      o_seg4 : out std_logic_vector(6 downto 0);  -- SEG 4
      o_seg5 : out std_logic_vector(6 downto 0);  -- SEG 5
      o_seg6 : out std_logic_vector(6 downto 0);  -- SEG 6
      o_seg7 : out std_logic_vector(6 downto 0)   -- SEG 7
      );

  end component axi4_lite_7segs;

  component bit_extender is
    generic (
      G_PULSE_WIDTH : positive := 10);  -- Extended Pulse Width
    port (
      clk_sys   : in  std_logic;        -- Clock system
      rst_n     : in  std_logic;        -- Asynchronous Reset
      pulse_in  : in  std_logic;        -- Input pulse to extend
      pulse_out : out std_logic);       -- Output Extended Pulse
  end component bit_extender;


  -- == INTERNAL Signals ==
  --Signals and registers declared for VJI instance
  signal tck   : std_logic;
  signal tdi   : std_logic;
  signal tdo   : std_logic;
  signal cdr   : std_logic;
  signal e1dr  : std_logic;
  signal e2dr  : std_logic;
  signal pdr   : std_logic;
  signal sdr   : std_logic;
  signal udr   : std_logic;
  signal uir   : std_logic;
  signal cir   : std_logic;
  signal ir_in : std_logic_vector(23 downto 0);

  signal rst_n_synch : std_logic;

  signal start_clk_jtag : std_logic;
  signal addr           : std_logic_vector(31 downto 0);
  signal rnw            : std_logic;
  signal strobe         : std_logic_vector((32/8) - 1 downto 0);
  signal master_wdata   : std_logic_vector(31 downto 0);
  signal master_rdata   : std_logic_vector(31 downto 0);
  signal access_status  : std_logic_vector(1 downto 0);


  -- Write Address Channel signals
  signal awvalid : std_logic;                          -- Address Write Valid
  signal awaddr  : std_logic_vector(32 - 1 downto 0);  -- Address Write
  signal awprot  : std_logic_vector(2 downto 0);       -- Adress Write Prot
  signal awready : std_logic;                          -- Address Write Ready

  -- Write Data Channel
  signal wvalid : std_logic;                                -- Write Data Valid
  signal wdata  : std_logic_vector(32 - 1 downto 0);        -- Write Data
  signal wstrb  : std_logic_vector((32 / 8) - 1 downto 0);  -- Write Strobe
  signal wready : std_logic;                                -- Write data Ready

  -- Write Response Channel
  signal bready : std_logic;            -- Write Channel Response
  signal bvalid : std_logic;            -- Write Response Channel Valid
  signal bresp  : std_logic_vector(1 downto 0);  -- Write Response Channel resp

  -- Read Address Channel
  signal arvalid : std_logic;           -- Read Channel Valid
  signal araddr  : std_logic_vector(32 - 1 downto 0);  -- Read Address channel Ready
  signal arprot  : std_logic_vector(2 downto 0);  --  Read Address channel Ready Prot
  signal arready : std_logic;           -- Read Address Channel Ready

  -- Read Data Channel
  signal rready : std_logic;            -- Read Data Channel Ready
  signal rvalid : std_logic;            -- Read Data Channel Valid
  signal rdata  : std_logic_vector(32 - 1 downto 0);  -- Read Data Channel rdata
  signal rresp  : std_logic_vector(1 downto 0);  -- Read Data Channel Response

  signal start_clk    : std_logic;      -- Start in CLK clock domain
  signal start_clk_p1 : std_logic;      -- Start in CLK clock domain
  signal start_clk_p2 : std_logic;      -- Start in CLK clock domain

  signal start_clk_r_edge : std_logic;  -- Rising Edge of start

  signal done_clk      : std_logic;     -- Done signal in clk clock domain
  signal done_extended : std_logic;  -- Done signal extended in clk clock domain


  signal done_extended_clk_jtag_p1     : std_logic;  -- Done extended resynchronize in clk_jtag clock domain
  signal done_extended_clk_jtag_p2     : std_logic;  -- Done extended resynchronize in clk_jtag clock domain
  signal done_extended_clk_jtag        : std_logic;  -- Done extended resynchronize in clk_jtag clock domain
  signal done_extended_clk_jtag_r_edge : std_logic;  -- rising edge

  signal cnt_sdr    : unsigned(8 downto 0);  -- SDR Counter
  signal sdr_p      : std_logic;             -- SDR pipe one time
  signal sdr_r_edge : std_logic;             -- SDR Rising edge detection
  signal sdr_f_edge : std_logic;             -- SDR Falling edge detection

  signal ledr_int : std_logic_vector(17 downto 0);  -- RED LEDS

  signal shift_reg : std_logic_vector(31 downto 0);  -- Get TDI data

begin  -- architecture rtl

  -- Instanciation of Reset generation
  i_reset_gen_0 : reset_gen
    port map (
      clk     => clk,
      arst_n  => rst_n,
      o_rst_n => rst_n_synch
      );


  -- Instanciation of VIRTUAL JTAG Controller
  -- Generated from Quartus II
  g_altera_vjtag : if(SEL_ALTERA_VJTAG = false) generate
    i_altera_vjtag_0 : altera_vjtag
      port map (
        tdo                => tdo,
        tck                => tck,
        tdi                => tdi,
        ir_in              => ir_in(5 downto 0),
        ir_out             => open,
        virtual_state_cdr  => cdr,
        virtual_state_e1dr => e1dr,
        virtual_state_e2dr => e2dr,
        virtual_state_pdr  => pdr,
        virtual_state_sdr  => sdr,
        virtual_state_udr  => udr,
        virtual_state_uir  => uir,
        virtual_state_cir  => cir
        );
  end generate;

  g_altera_vjtag_24ir : if(SEL_ALTERA_VJTAG = true) generate
    i_altera_vjtag_24ir_0 : altera_vjtag_24ir
      port map (
        tdo                => tdo,
        tck                => tck,
        tdi                => tdi,
        ir_in              => ir_in,
        ir_out             => open,
        virtual_state_cdr  => cdr,
        virtual_state_e1dr => e1dr,
        virtual_state_e2dr => e2dr,
        virtual_state_pdr  => pdr,
        virtual_state_sdr  => sdr,
        virtual_state_udr  => udr,
        virtual_state_uir  => uir,
        virtual_state_cir  => cir
        );

  end generate;

-- Instanciation of VRITUAL JTAG Interface
-- TCK JTAG has a maximal frequency of 10MHz and may vary
  i_vjtag_intf_0 : vjtag_intf
    generic map (
      G_DATA_WIDTH => 32,
      G_ADDR_WIDTH => 32,
      G_IR_WIDTH   => 6
      )
    port map(
      clk_jtag   => tck,
      rst_n_jtag => rst_n_synch,  --'1',                -- TBD pas de reset ..

      tdi   => tdi,
      tdo   => tdo,
      ir_in => ir_in(5 downto 0),
      sdr   => sdr,
      udr   => udr,
      cdr   => cdr,

      addr        => addr,
      data_out    => master_wdata,
      data_in     => master_rdata,
      data_in_val => done_extended_clk_jtag_r_edge,
      rnw         => rnw,
      start       => start_clk_jtag
      );

-- purpose: SDR Pipe
  p_pipe_sdr : process (tck, rst_n_synch) is
  begin  -- process p_pipe_sdr
    if rst_n_synch = '0' then           -- asynchronous reset (active low)
      sdr_p <= '0';
    elsif rising_edge(tck) then         -- rising clock edge
      sdr_p <= sdr;
    end if;
  end process p_pipe_sdr;

  sdr_r_edge <= sdr and not sdr_p;
  sdr_f_edge <= not sdr and sdr_p;

-- purpose: Counter of SDR pulse
  p_cnt_sdr : process (tck, rst_n_synch) is
  begin  -- process p_cnt_sdr
    if rst_n_synch = '0' then           -- asynchronous reset (active low)
      cnt_sdr <= (others => '0');
    elsif rising_edge(tck) then         -- rising clock edge

      --  if(udr = '1') then                --sdr_f_edge = '1') then
      --      cnt_sdr <= (others => '0');
--      elsif(sdr = '1') then
      if(sdr = '1' and ir_in(0) = '1') then
        cnt_sdr <= cnt_sdr + 1;         -- Inc Counter
      end if;

    end if;
  end process p_cnt_sdr;

-- purpose: LEDR Update
  p_ledr_mngt : process (tck, rst_n_synch) is
  begin  -- process p_ledr_mngt
    if rst_n_synch = '0' then           -- asynchronous reset (active low)
      ledr_int <= (others => '0');
    elsif rising_edge(tck) then         -- rising clock edge

      if(udr = '1') then
        ledr_int <= shift_reg(17 downto 0);
      end if;

    end if;
  end process p_ledr_mngt;

  -- purpose: Shift REG
  p_shift_reg : process (tck, rst_n_synch) is
  begin  -- process p_shift_reg
    if rst_n_synch = '0' then           -- asynchronous reset (active low)
      shift_reg <= (others => '0');
    elsif rising_edge(tck) then         -- rising clock edge
      if(sdr = '1') then
        --shift_reg <= shift_reg(31 - 1 downto 0) & tdi;
        shift_reg <= tdi & shift_reg(31 downto 1);
      end if;

    end if;
  end process p_shift_reg;

  -- purpose: LEDG Mngt
  p_ledg_mngt : process (tck, rst_n_synch) is
  begin  -- process p_ledg_mngt
    if rst_n_synch = '0' then           -- asynchronous reset (active low)
      ledg <= (others => '0');
    elsif rising_edge(tck) then         -- rising clock edge
      ledg <= "000" & ir_in(5 downto 0);
    end if;
  end process p_ledg_mngt;

  -- purpose: Double resynchronization of start_clk_jtag in clk clock domain
  p_resynch_start : process (clk, rst_n) is
  begin  -- process p_resynch_start
    if rst_n = '0' then                 -- asynchronous reset (active low)
      start_clk_p1 <= '0';
      start_clk_p2 <= '0';
      start_clk    <= '0';
    elsif rising_edge(clk) then         -- rising clock edge
      start_clk_p1 <= start_clk_jtag;
      start_clk_p2 <= start_clk_p1;
      start_clk    <= start_clk_p2;
    end if;
  end process p_resynch_start;

  -- Rising edge detection of start
  start_clk_r_edge <= start_clk_p2 and not start_clk;

  strobe <= (others => '0');            -- Not Used


  -- purpose: Resynchronization in tck clock domain of the signal done_extended
  p_ressynch_done_extended : process (tck, rst_n_synch) is
  begin  -- process p_ressynch_done_extended
    if rst_n_synch = '0' then           -- asynchronous reset (active low)
      done_extended_clk_jtag_p1 <= '0';
      done_extended_clk_jtag_p2 <= '0';
      done_extended_clk_jtag    <= '0';
    elsif rising_edge(tck) then         -- rising clock edge
      done_extended_clk_jtag_p1 <= done_extended;
      done_extended_clk_jtag_p2 <= done_extended_clk_jtag_p1;
      done_extended_clk_jtag    <= done_extended_clk_jtag_p2;
    end if;
  end process p_ressynch_done_extended;


  done_extended_clk_jtag_r_edge <= done_extended_clk_jtag_p2 and not done_extended_clk_jtag;


  -- Instanciation of bit extender
  -- Extender the pulse done_clk in x width in order to be detected in the
  -- slower clock domain clk_jtag
  i_bit_extender_0 : bit_extender
    generic map(
      G_PULSE_WIDTH => 2*5
      )
    port map (
      clk_sys   => clk,
      rst_n     => rst_n_synch,
      pulse_in  => done_clk,
      pulse_out => done_extended
      );

  -- Instanciation of AXI4 LITE MASTER
  i_axi4_lite_master_0 : axi4_lite_master
    generic map(
      G_DATA_WIDTH => 32,
      G_ADDR_WIDTH => 32
      )
    port map(
      clk   => clk,
      rst_n => rst_n_synch,

      start         => start_clk_r_edge,
      addr          => addr,            -- Considered as STATIC
      rnw           => rnw,             -- Considered as STATIC
      strobe        => strobe,          -- Considered as STATIC
      master_wdata  => master_wdata,    -- Considered as STATIC
      done          => done_clk,
      master_rdata  => master_rdata,
      access_status => access_status,

      awvalid => awvalid,
      awaddr  => awaddr,
      awprot  => awprot,
      awready => awready,

      wvalid => wvalid,
      wdata  => wdata,
      wstrb  => wstrb,
      wready => wready,

      bready => bready,
      bvalid => bvalid,
      bresp  => bresp,

      arvalid => arvalid,
      araddr  => araddr,
      arprot  => arprot,
      arready => arready,

      rready => rready,
      rvalid => rvalid,
      rdata  => rdata,
      rresp  => rresp
      );

  -- Instanciation of AXI4 LITE 7 SEGMENT Controller
  i_axi4_lite_7segs_0 : axi4_lite_7segs
    generic map (
      G_AXI4_LITE_ADDR_WIDTH => 32,
      G_AXI4_LITE_DATA_WIDTH => 32
      )
    port map (
      clk   => clk,
      rst_n => rst_n_synch,

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

      -- 7 Segments
      o_seg0 => o_seg0,
      o_seg1 => o_seg1,
      o_seg2 => o_seg2,
      o_seg3 => o_seg3,
      o_seg4 => o_seg4,
      o_seg5 => o_seg5,
      o_seg6 => o_seg6,
      o_seg7 => o_seg7
      );


  -- Outputs
  ledr <= ledr_int;
end architecture rtl;
