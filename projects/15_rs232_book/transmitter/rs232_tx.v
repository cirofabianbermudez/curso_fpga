// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

module rs232_tx (
  input         rst_i,
  input         clk_i,
  input         stt_i,
  input   [7:0] din_o,
  output        tx_o,
  output        eot_o
);
  
  wire tick;
  
  mod_m_counter mod_mod_m_counter (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .max_tick_o(tick)
  );
  
  transmitter mod_transmitter( 
    .clk_i(clk_i),
    .rst_i(rst_i),
    .stt_i(stt_i),
    .tick_i(tick),
    .din_i(din_i),
    .tx_o(tx_o),
    .eot_o(eot_o)
);

endmodule