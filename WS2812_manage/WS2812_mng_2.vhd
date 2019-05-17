library ieee;
use ieee.std_logic_1164.all;

library lib_ws2812;
use lib_ws2812.pkg_ws2812.all;


entity WS2812_mng_2 is
  generic(T0H : integer := T0H;
          T0L : integer := T0L;
          T1H : integer := T1H;
          T1L : integer := T1L
          );
  port(clock      : in  std_logic;                      -- Input clock
       reset_n    : in  std_logic;                      -- Asynchronous reset
       start      : in  std_logic;                      -- Start a frame
       led_config : in  std_logic_vector(23 downto 0);  -- Led configuration
       frame_done : out std_logic;                      -- Frame terminated
       d_out      : out std_logic                       -- Serial output
       );
end WS2812_mng_2;

architecture arch_WS2812_mng_2 of WS2812_mng_2 is

  -- CONSTANTS
  constant max_T0 : integer := T0H + T0L;  -- Max duration of the 0 logical
  constant max_T1 : integer := T1H + T1L;  -- Max duration of the 1 logical


  constant max_T : integer := 62;       -- Max period of the PWM

  signal cnt_pwm : integer range 0 to max_T;  -- Counter for the PWM period
  signal TH_s    : integer range 0 to max_T;  -- Time on
  signal load_TH : std_logic;  -- Signal that load the new duty cycle when = '1'

  signal curr_TH  : integer range 0 to max_T;  -- The current TH to set
  signal pwm_done : std_logic;  -- Flag that indicates when a period of PWM is over

  signal cnt_24 : integer range 0 to 23;  -- Counter 23 until 0

  signal frame_gen : std_logic;         -- Gen frame when = '1'

  -- Signals
  signal start_s  : std_logic;          -- Old start input
  signal start_re : std_logic;          -- Flag that indicates the RE of start

  signal led_config_s : std_logic_vector(23 downto 0);  -- Latch config

  signal d_out_s : std_logic;           -- To output


begin


  -- purpose: This process detect the rising edge of the start input 
  p_start_re_manage : process (clock, reset_n) is
  begin  -- process p_start_re_manage
    if reset_n = '0' then                   -- asynchronous reset (active low)
      start_s <= '0';                       -- Init to '0'
    elsif clock'event and clock = '1' then  -- rising clock edge
      start_s <= start;
    end if;
  end process p_start_re_manage;
  start_re <= start and not start_s;        -- RE detect


  -- purpose: This process latch the inputs during the RE of start
  p_inputs_latch : process (clock, reset_n) is
  begin  -- process p_inputs_latch
    if reset_n = '0' then                   -- asynchronous reset (active low)
      led_config_s <= (others => '0');
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(start_re = '1') then
        led_config_s <= led_config;
      end if;
    end if;
  end process p_inputs_latch;


  -- purpose: This process manages the frame generation
  p_gen_frame_mng : process (clock, reset_n) is
  begin  -- process p_gen_frame_mng
    if reset_n = '0' then                   -- asynchronous reset (active low)
      frame_gen <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(start_re = '1') then
        frame_gen <= '1';
      elsif(cnt_24 = 0 and pwm_done = '1') then
        frame_gen <= '0';
      end if;
    end if;
  end process p_gen_frame_mng;

  -- purpose: This process counts the transmitted bits 
  p_bit_counter : process (clock, reset_n) is
  begin  -- process p_bit_counter
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_24 <= 23;
    elsif clock'event and clock = '1' then  -- rising clock edge

      if(frame_gen = '1') then
        if(pwm_done = '1') then
          if(cnt_24 > 0) then
            cnt_24 <= cnt_24 - 1;
          else
            cnt_24 <= 23;
          end if;
        end if;
      else
        cnt_24 <= 23;
      end if;
    end if;
  end process p_bit_counter;



  -- purpose: This process select the duration of the HIGH level of the PWM 
  p_sel_th : process (clock, reset_n) is
  begin  -- process p_sel_th
    if reset_n = '0' then                   -- asynchronous reset (active low)
      load_TH <= '0';
      curr_TH <= 0;
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(start_re = '1') then
        load_TH <= '1';
      end if;

      if(frame_gen = '1') then
        if(pwm_done = '1') then
          if(led_config_s(cnt_24) = '1') then
            curr_TH <= T1H;
          elsif(led_config_s(cnt_24) = '0') then
            curr_TH <= T0H;
          end if;
        end if;
      end if;

    end if;
  end process p_sel_th;


  -- This process counts until Max_T and generates the PWM output
  p_pwm_cnt : process (clock, reset_n) is
  begin  -- process p_pwm_cnt
    if reset_n = '0' then                   -- asynchronous reset (active low)
      cnt_pwm  <= 0;
      TH_s     <= 0;
      d_out_s  <= '0';
      pwm_done <= '0';
    elsif clock'event and clock = '1' then  -- rising clock edge
      if(frame_gen = '1') then
        if(load_TH = '1') then
          TH_s <= curr_TH;
        end if;

        if(cnt_pwm = max_T) then
          cnt_pwm  <= 0;                -- RAZ
          pwm_done <= '1';
        else
          cnt_pwm  <= cnt_pwm + 1;      -- Inc cnt
          pwm_done <= '0';
        end if;

        if(cnt_pwm >= TH_s) then
          d_out_s <= '0';
        else
          d_out_s <= '1';
        end if;
      end if;
    end if;
  end process p_pwm_cnt;

  d_out <= d_out_s;


end arch_WS2812_mng_2;
