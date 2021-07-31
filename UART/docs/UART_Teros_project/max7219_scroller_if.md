# Entity: max7219_scroller_if
## Diagram
![Diagram](max7219_scroller_if.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name | Type                 | Value | Description |
| ------------ | -------------------- | ----- | ----------- |
| G_MATRIX_NB  | integer range 2 to 8 | 8     |             |
### Table 1.2 Ports
| Port name            | Direction | Type                          | Description |
| -------------------- | --------- | ----------------------------- | ----------- |
| clk                  | in        | std_logic                     |             |
| rst_n                | in        | std_logic                     |             |
| i_seg_data           | in        | std_logic_vector(7 downto 0)  |             |
| i_seg_data_valid     | in        | std_logic                     |             |
| i_max_tempo_cnt      | in        | std_logic_vector(31 downto 0) |             |
| o_busy               | out       | std_logic                     |             |
| i_max7219_if_done    | in        | std_logic                     |             |
| o_max7219_if_start   | out       | std_logic                     |             |
| o_max7219_if_en_load | out       | std_logic                     |             |
| o_max7219_if_data    | out       | std_logic_vector(15 downto 0) |             |
## Signals, constants and types
### Signals
| Name                     | Type                           | Description |
| ------------------------ | ------------------------------ | ----------- |
| s_matrix_array           | t_matrix_array                 |             |
| s_shift_matrix           | std_logic                      |             |
| s_busy                   | std_logic                      |             |
| s_segment_cnt            | integer range 0 to 8           |             |
| s_matrix_cnt             | integer range 0 to G_MATRIX_NB |             |
| s_tempo_cnt              | std_logic_vector(31 downto 0)  |             |
| s_segment_addr           | std_logic_vector(7 downto 0)   |             |
| s_new_data_flag          | std_logic                      |             |
| s_max7219_start          | std_logic                      |             |
| s_max7219_en_load        | std_logic                      |             |
| s_max7219_data           | std_logic_vector(15 downto 0)  |             |
| s_max7219_if_done        | std_logic                      |             |
| s_max7219_if_done_r_edge | std_logic                      |             |
| s_max7219_if_done_f_edge | std_logic                      |             |
| s_matrix_updated_flag    | std_logic                      |             |
| s_start_tempo            | std_logic                      |             |
| s_tempo_done             | std_logic                      |             |
### Types
| Name           | Type | Description |
| -------------- | ---- | ----------- |
| t_matrix_array |      |             |
## Processes
- **p_latch_inputs**: ***( clk, rst_n )***

- **p_shift_matrix_mngt**: ***( clk, rst_n )***

- **p_max7219_if_mngt**: ***( clk, rst_n )***

- **p_tempo_cnt_mngt**: ***( clk, rst_n )***

- **p_busy_mngt**: ***( clk, rst_n )***

