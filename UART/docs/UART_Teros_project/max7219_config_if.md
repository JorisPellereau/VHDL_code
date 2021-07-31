# Entity: max7219_config_if
## Diagram
![Diagram](max7219_config_if.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name | Type    | Value | Description |
| ------------ | ------- | ----- | ----------- |
| G_MATRIX_NB  | integer | 8     |             |
### Table 1.2 Ports
| Port name            | Direction | Type                          | Description |
| -------------------- | --------- | ----------------------------- | ----------- |
| clk                  | in        | std_logic                     |             |
| rst_n                | in        | std_logic                     |             |
| i_decod_mode         | in        | std_logic_vector(7 downto 0)  |             |
| i_intensity          | in        | std_logic_vector(7 downto 0)  |             |
| i_scan_limit         | in        | std_logic_vector(7 downto 0)  |             |
| i_shutdown           | in        | std_logic_vector(7 downto 0)  |             |
| i_display_test       | in        | std_logic                     |             |
| i_new_config_val     | in        | std_logic                     |             |
| o_config_done        | out       | std_logic                     |             |
| i_max7219_if_done    | in        | std_logic                     |             |
| o_max7219_if_start   | out       | std_logic                     |             |
| o_max7219_if_en_load | out       | std_logic                     |             |
| o_max7219_if_data    | out       | std_logic_vector(15 downto 0) |             |
## Signals, constants and types
### Signals
| Name                     | Type                          | Description |
| ------------------------ | ----------------------------- | ----------- |
| s_init_config            | std_logic                     |             |
| s_init_config_p          | std_logic                     |             |
| s_init_config_p2         | std_logic                     |             |
| s_new_config_val         | std_logic                     |             |
| s_new_config_val_r_edge  | std_logic                     |             |
| s_config_done            | std_logic                     |             |
| s_cnt_config             | std_logic_vector(2 downto 0)  |             |
| s_cnt_config_done        | std_logic                     |             |
| s_cnt_matrix             | std_logic_vector(3 downto 0)  |             |
| s_cnt_matrix_up          | std_logic                     |             |
| s_cnt_matrix_done        | std_logic                     |             |
| s_cnt_matrix_done_p1     | std_logic                     |             |
| s_max7219_if_start       | std_logic                     |             |
| s_max7219_if_en_load     | std_logic                     |             |
| s_max7219_if_data        | std_logic_vector(15 downto 0) |             |
| s_max7219_if_done        | std_logic                     |             |
| s_max7219_if_done_r_edge | std_logic                     |             |
## Processes
- **p_latch_inputs**: ***( clk, rst_n )***

- **p_cnt_matrix**: ***( clk, rst_n )***

- **p_cnt_config**: ***( clk, rst_n )***

- **p_config_mngt**: ***( clk, rst_n )***

- **p_max7219_if_mngt**: ***( clk, rst_n )***

- **p_config_done_mngt**: ***( clk, rst_n )***

