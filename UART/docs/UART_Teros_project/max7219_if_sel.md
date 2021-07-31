# Entity: max7219_if_sel
## Diagram
![Diagram](max7219_if_sel.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name              | Type    | Value | Description |
| ------------------------- | ------- | ----- | ----------- |
| G_RAM_ADDR_WIDTH_STATIC   | integer | 8     |             |
| G_RAM_DATA_WIDTH_STATIC   | integer | 16    |             |
| G_RAM_ADDR_WIDTH_SCROLLER | integer | 8     |             |
| G_RAM_DATA_WIDTH_SCROLLER | integer | 8     |             |
### Table 1.2 Ports
| Port name                    | Direction | Type                                                     | Description |
| ---------------------------- | --------- | -------------------------------------------------------- | ----------- |
| clk                          | in        | std_logic                                                |             |
| rst_n                        | in        | std_logic                                                |             |
| i_static_dyn                 | in        | std_logic                                                |             |
| i_new_config_val             | in        | std_logic                                                |             |
| o_new_config_val             | out       | std_logic                                                |             |
| i_start_static               | in        | std_logic                                                |             |
| o_start_static               | out       | std_logic                                                |             |
| i_start_scroll               | in        | std_logic                                                |             |
| i_ram_start_ptr_scroller     | in        | std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0) |             |
| i_msg_length_scroller        | in        | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
| i_max_tempo_cnt_scroller     | in        | std_logic_vector(31 downto 0)                            |             |
| o_start_scroll               | out       | std_logic                                                |             |
| o_ram_start_ptr_scroller     | out       | std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0) |             |
| o_msg_length_scroller        | out       | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
| o_max_tempo_cnt_scroller     | out       | std_logic_vector(31 downto 0)                            |             |
| i_config_done                | in        | std_logic                                                |             |
| i_max7219_if_start_config    | in        | std_logic                                                |             |
| i_max7219_if_en_load_config  | in        | std_logic                                                |             |
| i_max7219_if_data_config     | in        | std_logic_vector(15 downto 0)                            |             |
| o_max7219_if_done_config     | out       | std_logic                                                |             |
| i_static_busy                | in        | std_logic                                                |             |
| i_max7219_if_start_static    | in        | std_logic                                                |             |
| i_max7219_if_en_load_static  | in        | std_logic                                                |             |
| i_max7219_if_data_static     | in        | std_logic_vector(15 downto 0)                            |             |
| o_max7219_if_done_static     | out       | std_logic                                                |             |
| i_scroller_busy              | in        | std_logic                                                |             |
| i_max7219_if_start_dynamic   | in        | std_logic                                                |             |
| i_max7219_if_en_load_dynamic | in        | std_logic                                                |             |
| i_max7219_if_data_dynamic    | in        | std_logic_vector(15 downto 0)                            |             |
| o_max7219_if_done_dynamic    | out       | std_logic                                                |             |
| i_max7219_if_done            | in        | std_logic                                                |             |
| o_max7219_if_start           | out       | std_logic                                                |             |
| o_max7219_if_en_load         | out       | std_logic                                                |             |
| o_max7219_if_data            | out       | std_logic_vector(15 downto 0)                            |             |
## Signals, constants and types
### Signals
| Name           | Type      | Description |
| -------------- | --------- | ----------- |
| s_config_sel   | std_logic |             |
| s_static_sel   | std_logic |             |
| s_dyn_sel      | std_logic |             |
| s_start_scroll | std_logic |             |
| s_start_static | std_logic |             |
| s_start_config | std_logic |             |
| s_new_config   | std_logic |             |
## Processes
- **p_latch_inputs**: ***( clk, rst_n )***

- **p_start_mngt**: ***( clk, rst_n )***

- **p_mux_sel_mngt**: ***( clk, rst_n )***

