library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library lib_pkg_utils;
use lib_pkg_utils.pkg_utils.all;

library lib_CFAH1602_v2;
use lib_CFAH1602_v2.pkg_lcd_cfah_types_and_func.all;
use lib_CFAH1602_v2.pkg_lcd_cfah.all;

entity lcd_cfah_itf is

  generic (
    G_CLK_PERIOD_NS      : integer   := 20;  -- Clock Period in ns
    G_BIDIR_POLARITY_READ : std_logic := '0'  -- BIDIR SEL Polarity for READ                                            
    );
  port (
    clk   : in std_logic;               -- Clock
    rst_n : in std_logic;               -- Asynchronous Reset

    i_wdata    : in std_logic_vector(7 downto 0);  -- Data to write
    i_lcd_data : in std_logic_vector(7 downto 0);  -- Data from LCD
    i_rs       : in std_logic;                     -- Register Selection
    i_rw       : in std_logic;                     -- RW selection
    i_start    : in std_logic;                     -- Start tranfert

    o_lcd_wdata : out std_logic_vector(7 downto 0);  -- LCD WData
    o_lcd_rdata : out std_logic_vector(7 downto 0);  -- LCD RDATA
    o_lcd_rw    : out std_logic;                     -- R/W command
    o_lcd_en    : out std_logic;                     -- LCD Enable
    o_lcd_rs    : out std_logic;                     -- LCD RS
    o_bidir_sel : out std_logic;                     -- Bidir Selector
    o_done      : out std_logic);                    -- Done flag

end entity lcd_cfah_itf;

architecture rtl of lcd_cfah_itf is

  -- CONSTANTS
  constant C_tAS_MAX    : integer := clk_period_to_max(G_CLK_PERIOD_NS, C_tAS_DURATION);  -- Max Counter value of tAS Duration
  constant C_tcycE_MAX  : integer := clk_period_to_max(G_CLK_PERIOD_NS, C_tcycE_DURATION);  -- Max counter value for tcycE Duration
  constant C_PWeh_MAX   : integer := clk_period_to_max(G_CLK_PERIOD_NS, C_PWeh_DURATION);  -- Max value for PWeh Duration
  constant C_tH_tAH_MAX : integer := clk_period_to_max(G_CLK_PERIOD_NS, C_tH_tAH_DURATION);  -- Max value for tH tAH duration
  constant C_tDDR_MAX   : integer := clk_period_to_max(G_CLK_PERIOD_NS, C_tDDR_DURATION);  -- Max value for tDDR duration
  constant C_CNT_MAX    : integer := C_tAS_MAX + C_tcycE_MAX;  -- Max Counter

  -- MAX RS RW Counter
  constant C_MAX_RS_RW_cnt     : integer := C_tAS_MAX + C_PWeh_MAX + C_tH_tAH_MAX;
  constant C_MAX_EN_cnt        : integer := C_tAS_MAX + C_PWeh_MAX;  -- MAX En Counter
  constant C_MAX_LCD_WDATA_cnt : integer := C_tAS_MAX + C_PWeh_MAX + C_tH_tAH_MAX;  -- MAX WDATA Counter

  -- INTERNAL Signals
  signal s_cnt     : std_logic_vector(log2(C_tAS_MAX + C_tcycE_MAX) - 1 downto 0);  -- Counter tAS + tcycE
  signal s_wdata   : std_logic_vector(7 downto 0);  -- Input data  
  signal s_ongoing : std_logic;         -- Access ongoing
  signal s_rs      : std_logic;         -- RS
  signal s_rw      : std_logic;         -- RW
  signal s_en      : std_logic;         -- EN
  signal s_done    : std_logic;         -- End of transfert R/W

begin  -- architecture rtl

  -- purpose: RS and RW - Ongoing flag and reset mangement
  p_rs_rw_mngt : process (clk, rst_n) is
  begin  -- process p_rs_rw_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_rs      <= '0';
      s_rw      <= '0';
      s_ongoing <= '0';
      s_wdata   <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- On start -> Generate rs and RW outputs
      if(i_start = '1') then
        s_rs      <= i_rs;
        s_rw      <= i_rw;
        s_ongoing <= '1';
        s_wdata   <= i_wdata;

      -- When counter Reach -> Reset
      elsif(unsigned(s_cnt) = conv_unsigned(C_MAX_RS_RW_cnt, s_cnt'length)) then
        s_rs <= '0';
        s_rw <= '0';

      -- Counter Reach
      elsif(unsigned(s_cnt) = conv_unsigned((C_CNT_MAX - 0), s_cnt'length)) then
        s_wdata <= (others => '0');

      elsif(s_done = '1') then
        s_ongoing <= '0';
      end if;

    end if;
  end process p_rs_rw_mngt;


  -- purpose: Counter Management 
  p_cnt_mngt : process (clk, rst_n) is
  begin  -- process p_cnt_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_cnt  <= (others => '0');
      s_done <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      s_done <= '0';                    -- Pulse

      -- On start or Ongoing -> Inc counter
      if(s_ongoing = '1' and s_done = '0') then  -- or i_start = '1'
        if(unsigned(s_cnt) < conv_unsigned((C_CNT_MAX - 1), s_cnt'length)) then
          s_cnt <= unsigned(s_cnt) + 1;
        else
          s_done <= '1';
        end if;

      -- Reset otherwise
      else
        s_cnt  <= (others => '0');
        s_done <= '0';
      end if;
    end if;
  end process p_cnt_mngt;

  -- purpose: Enable management
  p_en_mngt : process (clk, rst_n) is
  begin  -- process p_en_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      s_en <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge

      if(unsigned(s_cnt) = conv_unsigned((C_tAS_MAX - 1), s_cnt'length)) then
        s_en <= '1';
      elsif(unsigned(s_cnt) = conv_unsigned(C_MAX_EN_cnt, s_cnt'length)) then
        s_en <= '0';
      end if;

    end if;
  end process p_en_mngt;

  -- purpose: Wdata Management
  p_lcd_wdata_mngt : process (clk, rst_n) is
  begin  -- process p_lcd_wdata_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_lcd_wdata <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- Read Access -> Do not drive the bus
      if(s_rw = '1') then
        o_lcd_wdata <= (others => '0');
      -- Write Access
      else

        -- tAS Duration
        if(unsigned(s_cnt) = conv_unsigned((C_tAS_MAX - 1), s_cnt'length)) then
          o_lcd_wdata <= s_wdata;
        elsif(unsigned(s_cnt) = conv_unsigned(C_MAX_LCD_WDATA_cnt, s_cnt'length)) then
          o_lcd_wdata <= (others => '0');
        end if;
      end if;

    end if;
  end process p_lcd_wdata_mngt;

  -- purpose: LCD Read data management
  p_lcd_rdata_mngt : process (clk, rst_n) is
  begin  -- process p_lcd_rdata_mngt
    if rst_n = '0' then                 -- asynchronous reset (active low)    
      o_lcd_rdata <= (others => '0');
    elsif clk'event and clk = '1' then  -- rising clock edge

      -- During Read Access
      if(s_rw = '1') then

        -- Latch Rdata
        if(unsigned(s_cnt) = conv_unsigned(C_MAX_RS_RW_cnt, s_cnt'length)) then
          o_lcd_rdata <= i_lcd_data;    -- Latch Data for Reading       
        end if;

      end if;
    end if;
  end process p_lcd_rdata_mngt;

  -- purpose: Bidir Sel Management
  p_bidir_sel : process (clk, rst_n) is
  begin  -- process p_bidir_sel
    if rst_n = '0' then                 -- asynchronous reset (active low)
      o_bidir_sel <= G_BIDIR_POLARITY_READ;
    elsif clk'event and clk = '1' then  -- rising clock edge

      --READ Access from LCD
      if(s_ongoing = '1' and s_rw = '1') then
        o_bidir_sel <= G_BIDIR_POLARITY_READ;

      -- Write access to LCD
      elsif(s_ongoing = '1' and s_rw = '0') then
        o_bidir_sel <= not G_BIDIR_POLARITY_READ;

      -- Read Access by default
      else
        o_bidir_sel <= G_BIDIR_POLARITY_READ;
      end if;
    end if;
  end process p_bidir_sel;

  -- Outputs affectation
  o_lcd_rs <= s_rs;
  o_lcd_rw <= s_rw;
  o_lcd_en <= s_en;
  o_done   <= s_done;

end architecture rtl;
