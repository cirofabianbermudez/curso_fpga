// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

module unic_cass ( 
  input        clk_i,
  input        rst_i,
  input        rx_i,
  output        tx_o,
  output [7:0] dout_o
);

  wire tick;
  wire eor;
  wire [7:0] rx_data;

  mod_n_counter #(
    .Width(6),
    .MaxVal(54) // (100 * 10**(6)) / (115200 * 16)
  ) mod_mod_n_counter ( 
   .clk_i(clk_i),
   .rst_i(rst_i),
   .max_tick_o(tick)
  );

  receiver #(
    .Nbits(8),
    .Sticks(16)
  ) mod_receiver ( 
    .clk_i(clk_i),
    .rst_i(rst_i),
    .rx_i(rx_i),
    .tick_i(tick),
    .eor_o(eor),
    .dout_o(rx_data)
  );

  ff_buffer #(
    .Width(8)
  ) mod_ff_buffer ( 
    .rst_i(rst_i),
    .clk_i(clk_i),
    .en_i(eor),
    .clear_i(1'b0),
    .din_i(rx_data),
    .dout_o(dout_o)
  );

  transmitter #(
  .Nbits(8),
  .Sticks(16)
  ) mod_transmitter ( 
    .clk_i(clk_i),
    .rst_i(rst_i),
    .stt_i(eor),
    .tick_i(tick),
    .din_i(rx_data),
    .tx_o(tx_o),
    .eot_o()
  );

endmodule
