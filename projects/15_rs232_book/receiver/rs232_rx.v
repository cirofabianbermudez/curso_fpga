// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

module rs232_rx (
  input         rst_i,
  input         clk_i,
  input         rx_i,
  output  [7:0] dout_o,
  output        eor_o
);
  
  wire tick;
  
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
    .eor_o(eor_o),
    .dout_o(dout_o)
  );

endmodule