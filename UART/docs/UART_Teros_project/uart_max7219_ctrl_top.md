# Entity: uart_max7219_ctrl_top
## Diagram
![Diagram](uart_max7219_ctrl_top.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
### Table 1.2 Ports
| Port name      | Direction | Type                         | Description |
| -------------- | --------- | ---------------------------- | ----------- |
| clk            | in        | std_logic                    |             |
| rst_n          | in        | std_logic                    |             |
| i_rx           | in        | std_logic                    |             |
| o_tx           | out       | std_logic                    |             |
| o_max7219_load | out       | std_logic                    |             |
| o_max7219_data | out       | std_logic                    |             |
| o_max7219_clk  | out       | std_logic                    |             |
| o_leds         | out       | std_logic_vector(7 downto 0) |             |
## Signals, constants and types
### Signals
| Name           | Type      | Description |
| -------------- | --------- | ----------- |
| s_tx           | std_logic |             |
| s_rx_p1        | std_logic |             |
| s_rx_p2        | std_logic |             |
| s_max7219_load | std_logic |             |
| s_max7219_data | std_logic |             |
| s_max7219_clk  | std_logic |             |
## Processes
- **p_resynch_i_rx**: ***( clk, rst_n )***

## Instantiations
- **i_uart_max7219_display_ctrl_wrapper_0**: uart_max7219_display_ctrl_wrapper

