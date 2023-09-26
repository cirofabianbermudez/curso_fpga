// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

module top (
  input         clk_i,
  input         rst_i,
  input         rx_i,
  input         sw_i,
  output  [7:0] dout_o,
  output        empty_o,
  output        full_o
);
  
  wire tick;
  wire eor;
  wire [7:0] rx_data;
  wire rd;
  
  mod_m_counter mod_mod_m_counter (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .max_tick_o(tick)
  );
  
  receiver mod_receiver ( 
    .clk_i(clk_i),
    .rst_i(rst_i),
    .rx_i(rx_i),
    .tick_i(tick),
    .eor_o(eor),
    .dout_o(rx_data)
  );  
  
  fifo #(
    .Width(8), 
    .AddrBits(3)
  ) mod_fifo ( 
    .clk_i(clk_i),
    .rst_i(rst_i),
    .wr_i(eor),
    .rd_i(rd),
    .w_data_i(rx_data),
    .r_data_o(dout_o),
    .empty_o(empty_o),
    .full_o(full_o)
  );
  
  debouncer mod_debouncer (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .sw_i(sw_i),
    .db_level_o(),
    .db_tick_o(rd)
  );

endmodule
