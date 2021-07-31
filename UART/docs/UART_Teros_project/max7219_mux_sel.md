# Entity: max7219_mux_sel
## Diagram
![Diagram](max7219_mux_sel.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
### Table 1.2 Ports
| Port name                     | Direction | Type                          | Description |
| ----------------------------- | --------- | ----------------------------- | ----------- |
| clk                           | in        | std_logic                     |             |
| rst_n                         | in        | std_logic                     |             |
| i_mux_sel                     | in        | std_logic_vector(1 downto 0)  |             |
| i_max7219_if_start_config     | in        | std_logic                     |             |
| i_max7219_if_en_load_config   | in        | std_logic                     |             |
| i_max7219_if_data_config      | in        | std_logic_vector(15 downto 0) |             |
| o_max7219_if_done_config      | out       | std_logic                     |             |
| i_max7219_if_start_static     | in        | std_logic                     |             |
| i_max7219_if_en_load_static   | in        | std_logic                     |             |
| i_max7219_if_data_static      | in        | std_logic_vector(15 downto 0) |             |
| o_max7219_if_done_static      | out       | std_logic                     |             |
| i_max7219_if_start_Scroller   | in        | std_logic                     |             |
| i_max7219_if_en_load_Scroller | in        | std_logic                     |             |
| i_max7219_if_data_Scroller    | in        | std_logic_vector(15 downto 0) |             |
| o_max7219_if_done_Scroller    | out       | std_logic                     |             |
| i_max7219_if_done             | in        | std_logic                     |             |
| o_max7219_if_start            | out       | std_logic                     |             |
| o_max7219_if_en_load          | out       | std_logic                     |             |
| o_max7219_if_data             | out       | std_logic_vector(15 downto 0) |             |
## Signals, constants and types
### Signals
| Name                 | Type                          | Description |
| -------------------- | ----------------------------- | ----------- |
| s_max7219_if_start   | std_logic                     |             |
| s_max7219_if_en_load | std_logic                     |             |
| s_max7219_if_data    | std_logic_vector(15 downto 0) |             |
## Processes
- **p_mux_sel_mngt**: ***( clk, rst_n )***

