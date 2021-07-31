# Entity: rx_uart
## Diagram
![Diagram](rx_uart.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name    | Type                 | Value     | Description |
| --------------- | -------------------- | --------- | ----------- |
| stop_bit_number | integer range 1 to 2 | 1         |             |
| parity          | t_parity             | even      |             |
| baudrate        | t_baudrate           | b9600     |             |
| data_size       | integer range 5 to 9 | 8         |             |
| polarity        | std_logic            | '1'       |             |
| first_bit       | t_first_bit          | lsb_first |             |
| clock_frequency | integer              | 20000000  |             |
### Table 1.2 Ports
| Port name   | Direction | Type                                     | Description |
| ----------- | --------- | ---------------------------------------- | ----------- |
| reset_n     | in        | std_logic                                |             |
| clock       | in        | std_logic                                |             |
| rx          | in        | std_logic                                |             |
| rx_data     | out       | std_logic_vector(data_size - 1 downto 0) |             |
| rx_done     | out       | std_logic                                |             |
| parity_rcvd | out       | std_logic                                |             |
## Signals, constants and types
### Signals
| Name          | Type                                     | Description |
| ------------- | ---------------------------------------- | ----------- |
| rx_fsm        | t_rx_fsm                                 |             |
| rx_old        | std_logic                                |             |
| start_rx_fe   | std_logic                                |             |
| start_rx_re   | std_logic                                |             |
| start_cnt     | std_logic                                |             |
| tick_data     | std_logic                                |             |
| rx_data_s     | std_logic_vector(data_size - 1 downto 0) |             |
| parity_rcvd_s | std_logic                                |             |
| rx_done_s     | std_logic                                |             |
| cnt_half_bit  | integer range 0 to half_bit_duration     |             |
| cnt_bit       | integer range 0 to bit_duration          |             |
| cnt_data      | integer range 0 to data_size             |             |
| cnt_stop_bit  | integer range 0 to stop_bit_number       |             |
### Constants
| Name              | Type    | Value                                                          | Description |
| ----------------- | ------- | -------------------------------------------------------------- | ----------- |
| bit_duration      | integer |  compute_bit_duration(clock_frequency, baudrate)               |             |
| half_bit_duration | integer |  bit_duration / 2                                              |             |
| number_of_bits    | integer |  number_of_bit_computation(stop_bit_number, parity, data_size) |             |
## Processes
- **p_rx_fsm_mng**: ***( clock, reset_n )***

- **p_start_detect**: ***( clock, reset_n )***

- **p_tick_read_data**: ***( clock, reset_n )***

- **p_data_cnt**: ***( clock, reset_n )***

- **p_rx_mng**: ***( clock, reset_n )***

## State machines
![Diagram_state_machine_0]( stm_rx_uart_00.svg "Diagram")