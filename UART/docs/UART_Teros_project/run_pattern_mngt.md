# Entity: run_pattern_mngt
## Diagram
![Diagram](run_pattern_mngt.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name              | Type                 | Value | Description |
| ------------------------- | -------------------- | ----- | ----------- |
| G_RAM_DATA_WIDTH_STATIC   | integer              | 16    |             |
| G_RAM_ADDR_WIDTH_STATIC   | integer              | 8     |             |
| G_RAM_DATA_WIDTH_SCROLLER | integer              | 8     |             |
| G_RAM_ADDR_WIDTH_SCROLLER | integer              | 8     |             |
| G_UART_DATA_WIDTH         | integer range 5 to 9 |       |             |
### Table 1.2 Ports
| Port name                   | Direction | Type                                                     | Description |
| --------------------------- | --------- | -------------------------------------------------------- | ----------- |
| clk                         | in        | std_logic                                                |             |
| rst_n                       | in        | std_logic                                                |             |
| i_run_static_pattern        | in        | std_logic                                                |             |
| o_run_static_pattern_done   | out       | std_logic                                                |             |
| o_run_static_pattern_rdy    | out       | std_logic                                                |             |
| o_run_static_discard        | out       | std_logic                                                |             |
| i_run_scroller_pattern      | in        | std_logic                                                |             |
| o_run_scroller_pattern_done | out       | std_logic                                                |             |
| o_run_scroller_pattern_rdy  | out       | std_logic                                                |             |
| o_run_scroller_discard      | out       | std_logic                                                |             |
| i_rx_data                   | in        | std_logic_vector(G_UART_DATA_WIDTH - 1 downto 0)         |             |
| i_rx_done                   | in        | std_logic                                                |             |
| o_static_dyn                | out       | std_logic                                                |             |
| o_new_display               | out       | std_logic                                                |             |
| o_en_static                 | out       | std_logic                                                |             |
| i_ptr_equality_static       | in        | std_logic                                                |             |
| o_start_ptr_static          | out       | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| o_last_ptr_static           | out       | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| i_static_busy               | in        | std_logic                                                |             |
| i_scroller_busy             | in        | std_logic                                                |             |
| o_ram_start_ptr_scroller    | out       | std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0) |             |
| o_msg_length_scroller       | out       | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
| i_load_tempo_scroller       | in        | std_logic                                                |             |
| o_load_tempo_scroller_done  | out       | std_logic                                                |             |
| o_max_tempo_cnt_scroller    | out       | std_logic_vector(31 downto 0)                            |             |
## Signals, constants and types
### Signals
| Name                          | Type                                                     | Description |
| ----------------------------- | -------------------------------------------------------- | ----------- |
| s_run_static_pattern_rdy      | std_logic                                                |             |
| s_run_static_ongoing          | std_logic                                                |             |
| s_run_scroller_pattern_rdy    | std_logic                                                |             |
| s_run_scroller_ongoing        | std_logic                                                |             |
| s_start_ptr_static            | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| s_last_ptr_static             | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| s_cnt_1                       | integer range 0 to 1                                     |             |
| s_ram_start_ptr_scroller      | std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0) |             |
| s_msg_length                  | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
| s_max_tempo_cnt_scroller      | std_logic_vector(31 downto 0)                            |             |
| s_load_tempo_scroller_rdy     | std_logic                                                |             |
| s_load_tempo_scroller_ongoing | std_logic                                                |             |
| s_cnt_3                       | integer range 0 to 4                                     |             |
## Processes
- **p_pulse_cmd_mngt**: ***( clk, rst_n )***

- **p_rx_data_mngt**: ***( clk, rst_n )***

