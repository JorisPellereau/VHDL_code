# Entity: uart_cmd_decod
## Diagram
![Diagram](uart_cmd_decod.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name | Type                 | Value | Description |
| ------------ | -------------------- | ----- | ----------- |
| G_NB_CMD     | integer              | 4     |             |
| G_CMD_LENGTH | integer              | 10    |             |
| G_DATA_WIDTH | integer range 5 to 9 | 8     |             |
### Table 1.2 Ports
| Port name    | Direction | Type                                        | Description |
| ------------ | --------- | ------------------------------------------- | ----------- |
| clk          | in        | std_logic                                   |             |
| rst_n        | in        | std_logic                                   |             |
| i_data       | in        | std_logic_vector(G_DATA_WIDTH - 1 downto 0) |             |
| i_data_valid | in        | std_logic                                   |             |
| o_commands   | out       | std_logic_vector(G_NB_CMD - 1 downto 0)     |             |
| o_discard    | out       | std_logic                                   |             |
## Signals, constants and types
### Signals
| Name            | Type                                    | Description |
| --------------- | --------------------------------------- | ----------- |
| s_cmd_2_store   | t_cmd_array                             |             |
| s_cnt_data      | std_logic_vector(7 downto 0)            |             |
| s_cnt_data_done | std_logic                               |             |
| s_commands      | std_logic_vector(G_NB_CMD - 1 downto 0) |             |
| s_discard       | std_logic                               |             |
| s_cmd_check     | std_logic                               |             |
| s_raz_cnt       | std_logic                               |             |
## Processes
- **p_store_data**: ***( clk, rst_n )***

- **p_cnt_data**: ***( clk, rst_n )***

- **p_check_cmd**: ***( clk, rst_n )***

