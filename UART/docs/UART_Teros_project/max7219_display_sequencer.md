# Entity: max7219_display_sequencer
## Diagram
![Diagram](max7219_display_sequencer.svg "Diagram")
## Description
## Generics and ports
### Table 1.1 Generics
| Generic name              | Type      | Value | Description |
| ------------------------- | --------- | ----- | ----------- |
| G_FIFO_DEPTH              | integer   | 10    |             |
| G_RAM_ADDR_WIDTH_STATIC   | integer   | 8     |             |
| G_RAM_DATA_WIDTH_STATIC   | integer   | 16    |             |
| G_RAM_ADDR_WIDTH_SCROLLER | integer   | 8     |             |
| G_RAM_DATA_WIDTH_SCROLLER | integer   | 8     |             |
| G_USE_ALTERA              | std_logic | '0'   |             |
### Table 1.2 Ports
| Port name        | Direction | Type                                                     | Description |
| ---------------- | --------- | -------------------------------------------------------- | ----------- |
| clk              | in        | std_logic                                                |             |
| rst_n            | in        | std_logic                                                |             |
| i_static_dyn     | in        | std_logic                                                |             |
| i_new_display    | in        | std_logic                                                |             |
| i_new_config_val | in        | std_logic                                                |             |
| i_config_done    | in        | std_logic                                                |             |
| o_new_config_val | out       | std_logic                                                |             |
| i_start_ptr      | in        | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| i_last_ptr       | in        | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| i_ptr_equality   | in        | std_logic                                                |             |
| o_start_ptr      | out       | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| o_last_ptr       | out       | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| o_static_val     | out       | std_logic                                                |             |
| i_ram_start_ptr  | in        | std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0) |             |
| i_msg_length     | in        | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
| i_busy_scroller  | in        | std_logic                                                |             |
| o_ram_start_ptr  | out       | std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0) |             |
| o_msg_length     | out       | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
| o_start_scroll   | out       | std_logic                                                |             |
| o_mux_sel        | out       | std_logic_vector(1 downto 0)                             |             |
## Signals, constants and types
### Signals
| Name                        | Type                                                     | Description |
| --------------------------- | -------------------------------------------------------- | ----------- |
| s_current_state             | t_states                                                 |             |
| s_next_state                | t_states                                                 |             |
| s_config_done               | std_logic                                                |             |
| s_config_done_r_edge        | std_logic                                                |             |
| s_new_config_val            | std_logic                                                |             |
| s_new_config_val_r_edge     | std_logic                                                |             |
| s_new_config_val_from_seq   | std_logic                                                |             |
| s_new_display               | std_logic                                                |             |
| s_new_display_r_edge        | std_logic                                                |             |
| s_cmd_wr_ptr                | integer range 0 to G_FIFO_DEPTH - 1                      |             |
| s_cmd_rd_ptr                | integer range 0 to G_FIFO_DEPTH - 1                      |             |
| s_cmd_fifo_cnt              | integer range 0 to G_FIFO_DEPTH                          |             |
| s_cmd_wr_ptr_up             | std_logic                                                |             |
| s_cmd_rd_ptr_up             | std_logic                                                |             |
| s_static_wr_ptr             | integer range 0 to G_FIFO_DEPTH - 1                      |             |
| s_static_rd_ptr             | integer range 0 to G_FIFO_DEPTH - 1                      |             |
| s_scroller_wr_ptr           | integer range 0 to G_FIFO_DEPTH - 1                      |             |
| s_scroller_rd_ptr           | integer range 0 to G_FIFO_DEPTH - 1                      |             |
| s_next_cmd_config           | std_logic                                                |             |
| s_next_cmd_static           | std_logic                                                |             |
| s_next_cmd_scroller         | std_logic                                                |             |
| s_start_ptr_static_array    | t_static_array                                           |             |
| s_last_ptr_static_array     | t_static_array                                           |             |
| s_ram_start_scroller_array  | t_scroller_addr_array                                    |             |
| s_msg_length_scroller_array | t_scroller_data_array                                    |             |
| s_cmd_array                 | t_next_cmd_array                                         |             |
| s_fifo_full                 | std_logic                                                |             |
| s_fifo_empty                | std_logic                                                |             |
| s_cmd_val                   | std_logic                                                |             |
| s_cmd_type                  | std_logic_vector(1 downto 0)                             |             |
| s_mux_sel                   | std_logic_vector(1 downto 0)                             |             |
| s_start_ptr                 | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| s_last_ptr                  | std_logic_vector(G_RAM_ADDR_WIDTH_STATIC - 1 downto 0)   |             |
| s_ram_start_ptr             | std_logic_vector(G_RAM_ADDR_WIDTH_SCROLLER - 1 downto 0) |             |
| s_msg_length                | std_logic_vector(G_RAM_DATA_WIDTH_SCROLLER - 1 downto 0) |             |
| s_ptr_equality_r_edge       | std_logic                                                |             |
| s_ptr_equality              | std_logic                                                |             |
| s_busy_scroller             | std_logic                                                |             |
| s_busy_scroller_f_edge      | std_logic                                                |             |
### Types
| Name                  | Type                                     | Description |
| --------------------- | ---------------------------------------- | ----------- |
| t_states              | (IDLE, WAIT_CMD, CONFIG, STATIC, SCROLL) |             |
| t_static_array        |                                          |             |
| t_scroller_addr_array |                                          |             |
| t_scroller_data_array |                                          |             |
| t_next_cmd_array      |                                          |             |
## Processes
- **p_pipe_inputs**: ***( clk, rst_n )***

- **p_curr_state_mngt**: ***( clk, rst_n )***

- **p_new_cmd_decod**: ***( clk, rst_n )***

- **p_fifo_cmd_write**: ***( clk, rst_n )***

- **p_fifo_cmd_read**: ***( clk, rst_n )***

- **p_cmd_fifo_cnt**: ***( clk, rst_n )***

- **p_fifo_cmd_status**: ***( clk, rst_n )***

- **p_fifo_data_static_write**: ***( clk, rst_n )***

- **p_fifo_data_scroller_write**: ***( clk, rst_n )***

- **p_outputs_mngt**: ***( clk, rst_n )***

