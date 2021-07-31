# Entity: tx_uart
## Diagram
![Diagram](tx_uart.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name    | Type                 | Value     | Description |
| --------------- | -------------------- | --------- | ----------- |
| stop_bit_number | integer range 1 to 2 | 1         |             |
| parity          | t_parity             | even      |             |
| baudrate        | t_baudrate           | b115200   |             |
| data_size       | integer range 5 to 9 | 8         |             |
| polarity        | std_logic            | '1'       |             |
| first_bit       | t_first_bit          | lsb_first |             |
| clock_frequency | integer              | 20000000  |             |
### Table 1.2 Ports
| Port name | Direction | Type                                     | Description |
| --------- | --------- | ---------------------------------------- | ----------- |
| reset_n   | in        | std_logic                                |             |
| clock     | in        | std_logic                                |             |
| start_tx  | in        | std_logic                                |             |
| tx_data   | in        | std_logic_vector(data_size - 1 downto 0) |             |
| tx        | out       | std_logic                                |             |
| tx_done   | out       | std_logic                                |             |
## Signals, constants and types
### Signals
| Name             | Type                                     | Description |
| ---------------- | ---------------------------------------- | ----------- |
| tx_fsm           | t_rs232_tx_fsm                           |             |
| latch_done_s     | std_logic                                |             |
| start_tx_s       | std_logic                                |             |
| start_tx_r_edge  | std_logic                                |             |
| tx_data_s        | std_logic_vector(data_size - 1 downto 0) |             |
| tx_s             | std_logic                                |             |
| cnt_bit_duration | integer range 0 to bit_duration - 1      |             |
| tick_data        | std_logic                                |             |
| cnt_data         | integer range 0 to data_size             |             |
| cnt_bit          | integer range 0 to number_of_bits        |             |
| cnt_stop_bit     | integer range 0 to stop_bit_number       |             |
| tx_done_s        | std_logic                                |             |
| parity_value     | std_logic                                |             |
### Constants
| Name           | Type    | Value                                                          | Description |
| -------------- | ------- | -------------------------------------------------------------- | ----------- |
| bit_duration   | integer |  compute_bit_duration(clock_frequency, baudrate)               |             |
| number_of_bits | integer |  number_of_bit_computation(stop_bit_number, parity, data_size) |             |
## Processes
- **p_tx_fsm_mng**: ***( clock, reset_n )***

- **p_start_tx_re_gen**: ***( clock, reset_n )***

- **p_latch_data**: ***( clock, reset_n )***

- **p_tick_gen_bit**: ***( clock, reset_n )***

- **p_bit_cnt**: ***( clock, reset_n )***

- **p_tx_gen**: ***( clock, reset_n )***

## State machines
![Diagram_state_machine_0]( stm_tx_uart_00.svg "Diagram")