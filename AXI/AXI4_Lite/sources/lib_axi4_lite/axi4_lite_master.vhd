-------------------------------------------------------------------------------
-- Title      : AXI4 Lite Master
-- Project    : 
-------------------------------------------------------------------------------
-- File       : axi4_lite_master.vhd
-- Author     : Linux-JP  <linux-jp@linuxjp>
-- Company    : 
-- Created    : 2023-08-29
-- Last update: 2024-01-04
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

entity axi4_lite_master is

  generic (
    G_DATA_WIDTH : integer range 8 to 32 := 32;   -- DATA WIDTH
    G_ADDR_WIDTH : integer range 8 to 32 := 32);  -- ADDR WIDTH
  port(

    clk   : in std_logic;               -- Clock system
    rst_n : in std_logic;               -- Asynchronous Reset

    start         : in  std_logic;                                          -- Start the access
    addr          : in  std_logic_vector(G_ADDR_WIDTH - 1 downto 0);        -- Addr of the access
    rnw           : in  std_logic;                                          -- Read ('1') or Write ('0') access
    strobe        : in  std_logic_vector((G_DATA_WIDTH / 8) - 1 downto 0);  -- Write strobe
    master_wdata  : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);        -- Write Data
    done          : out std_logic;                                          -- Access done
    master_rdata  : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);        -- Read Data
    access_status : out std_logic_vector(1 downto 0);                       -- Access Status

    awvalid : out std_logic;                                    -- Address Write Valid
    awaddr  : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Address Write    
    awprot  : out std_logic_vector(2 downto 0);                 -- Adress Write Prot
    awready : in  std_logic;                                    -- Address Write Ready

    wvalid : out std_logic;                                    -- Write Data Valid
    wdata  : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Write Data
    wstrb  : out std_logic_vector((G_DATA_WIDTH / 8) - 1 downto 0);
    wready : in  std_logic;                                    -- Write data Ready

    bready : out std_logic;                     -- Write Channel Response
    bvalid : in  std_logic;                     -- Write Response Channel Valid
    bresp  : in  std_logic_vector(1 downto 0);  -- Write Response Channel resp

    arvalid : out std_logic;                                    -- Read Channel Valid
    araddr  : out std_logic_vector(G_ADDR_WIDTH - 1 downto 0);  -- Read Address channel Ready
    arprot  : out std_logic_vector(2 downto 0);                 --  Read Address channel Ready Prot
    arready : in  std_logic;                                    -- Read Address Channel Ready

    rready : out std_logic;                                    -- Read Data Channel Ready
    rvalid : in  std_logic;                                    -- Read Data Channel Valid
    rdata  : in  std_logic_vector(G_DATA_WIDTH - 1 downto 0);  -- Read Data Channel rdata
    rresp  : in  std_logic_vector(1 downto 0)                  -- Read Data Channel Resp
    );
end entity axi4_lite_master;

architecture rtl of axi4_lite_master is

  -- == TYPES ==
  type t_state is (ST_IDLE, ST_RADDR, ST_RDATA, ST_WR, ST_WRESP);  --ST_WADDR, ST_WDATA, ST_WRESP);  -- States of the FSM

  -- == INTERNAL Signals ==
  signal current_state : t_state;       -- Current State
  signal next_state    : t_state;       -- Next State

  signal arvalid_int : std_logic;       -- ARVALID
  signal rready_int  : std_logic;       -- RREADY
  signal awvalid_int : std_logic;       -- AWVALID
  signal wvalid_int  : std_logic;       -- WVALID
  signal bready_int  : std_logic;       -- BREADY

  signal addr_int         : std_logic_vector(G_ADDR_WIDTH - 1 downto 0);      -- ADDR
  signal master_wdata_int : std_logic_vector(G_DATA_WIDTH - 1 downto 0);      -- WDATA
  signal strobe_int       : std_logic_vector((G_DATA_WIDTH/8) - 1 downto 0);  -- Strobe

  signal rnw_int : std_logic;           -- Read or write access latched
  signal start_p : std_logic;

begin  -- architecture rtl

  -- purpose: Delay Start Access
  p_delay_start : process (clk, rst_n) is
  begin  -- process p_delay_start
    if rst_n = '0' then                 -- asynchronous reset (active low)
      start_p <= '0';
    elsif rising_edge(clk) then         -- rising clock edge
      start_p <= start;
    end if;
  end process p_delay_start;

  -- purpose: Latch inputs on start detection
  -- Start input shall be a pulse on clk period
  p_latch_inputs : process (clk, rst_n) is
  begin  -- process p_latch_inputs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      addr_int         <= (others => '0');
      master_wdata_int <= (others => '0');
      rnw_int          <= '0';
      strobe_int       <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge
      if(start = '1') then
        addr_int         <= addr;
        master_wdata_int <= master_wdata;
        rnw_int          <= rnw;
        strobe_int       <= strobe;
      end if;
    end if;
  end process p_latch_inputs;

  -- purpose: Read Data management
  p_rdata_mngt : process (clk, rst_n) is
  begin  -- process p_rdata_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      master_rdata <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge
      if(rvalid = '1' and rready_int = '1') then
        master_rdata <= rdata;
      end if;
    end if;
  end process p_rdata_mngt;

  -- purpose: Status management
  p_status_mngt : process (clk, rst_n) is
  begin  -- process p_status_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      access_status <= (others => '0');
    elsif rising_edge(clk) then         -- rising clock edge
      if(rvalid = '1' and rready_int = '1') then
        access_status <= rresp;
      elsif(bvalid = '1' and bready_int = '1') then
        access_status <= bresp;
      else
        access_status <= (others => '0');
      end if;
    end if;
  end process p_status_mngt;

  -- purpose: Done management
  -- Generates done output when an access is terminated
  p_done_mngt : process (clk, rst_n) is
  begin  -- process p_done_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      done <= '0';
    elsif rising_edge(clk) then         -- rising clock edge
      if(rvalid = '1' and rready_int = '1') then
        done <= '1';
      elsif(bvalid = '1' and bready_int = '1') then
        done <= '1';
      else
        done <= '0';
      end if;
    end if;
  end process p_done_mngt;


  -- purpose: Update Current State
  p_update_cs : process (clk, rst_n) is
  begin  -- process p_update_cs
    if rst_n = '0' then                 -- asynchronous reset (active low)
      current_state <= ST_IDLE;
    elsif rising_edge(clk) then         -- rising clock edge
      current_state <= next_state;      -- Update next state
    end if;
  end process p_update_cs;

  -- Computes Next States

  p_update_ns : process (current_state, start_p, rnw_int, addr, arvalid_int, arready, rvalid,
                         rready_int, awvalid_int, awready, wvalid_int, wready, bvalid, bready_int) is
  begin  -- process p_update_ns
    case current_state is

      -- Start access
      when ST_IDLE =>
        if(start_p = '1' and rnw_int = '1') then
          next_state <= ST_RADDR;
        elsif(start_p = '1' and rnw_int = '0') then
          next_state <= ST_WR;
        else
          next_state <= ST_IDLE;
        end if;

      when ST_RADDR =>
        if(arvalid_int = '1' and arready = '1') then
          next_state <= ST_RDATA;
        else
          next_state <= ST_RADDR;
        end if;

      when ST_RDATA =>
        if(rvalid = '1' and rready_int = '1') then
          next_state <= ST_IDLE;
        else
          next_state <= ST_RDATA;
        end if;

      when ST_WR =>

        -- Case : All valid (AW and W) are set at the same time with valids signals
        if(awvalid_int = '1' and awready = '1' and wvalid_int = '1' and wready = '1') then
          next_state <= ST_WRESP;
        else
          next_state <= ST_WR;
        end if;

        -- when ST_WADDR =>
        --   if(awvalid_int = '1' and awready = '1') then
        --     next_state <= ST_WDATA;
        --   else
        --     next_state <= ST_WADDR;
        --   end if;

        -- when ST_WDATA =>
        --   if(wvalid_int = '1' and wready = '1') then
        --     next_state <= ST_WRESP;
        --   else
        --     next_state <= ST_WDATA;
        --   end if;

      when ST_WRESP =>
        if(bvalid = '1' and bready_int = '1') then
          next_state <= ST_IDLE;
        else
          next_state <= ST_WRESP;
        end if;

      when others =>
        next_state <= ST_IDLE;
    end case;
  end process p_update_ns;


  -- == Outputs Affectation ==
  arvalid_int <= '1' when current_state = ST_RADDR else '0';
  rready_int  <= '1' when current_state = ST_RDATA else '0';
  awvalid_int <= '1' when current_state = ST_WR    else '0';
  wvalid_int  <= '1' when current_state = ST_WR    else '0';
  bready_int  <= '1' when current_state = ST_WRESP else '0';

  arvalid <= arvalid_int;
  rready  <= rready_int;
  awvalid <= awvalid_int;
  wvalid  <= wvalid_int;
  bready  <= bready_int;

  awaddr <= addr_int         when current_state = ST_WR    else (others => '0');
  araddr <= addr_int         when current_state = ST_RADDR else (others => '0');
  wdata  <= master_wdata_int when current_state = ST_WR    else (others => '0');
  wstrb  <= strobe_int       when current_state = ST_WR    else (others => '0');
  awprot <= (others                                                     => '0');  -- Not Used
  arprot <= (others                                                     => '0');  -- Not Used

end architecture rtl;
