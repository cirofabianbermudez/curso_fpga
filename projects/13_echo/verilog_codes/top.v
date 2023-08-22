// Author: Julisa Verdejo Palacios
// Name: top.v
//
// Description: echo de recepcion y transmision

module top (
  input         rst_i,
  input         clk_i,
  input         rx_i,
  input         psel_i,
  output        pcheck_o,
  output        tx_o,
  output        eor_o,
  output        eot_o
);

  wire [7:0] data;
  wire       sttx;
  
  rs232_rx mod_rs232_rx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .rx_i(rx_i),
    .baud_i(15'd2603),
    .psel_i(psel_i),
    .dout_o(data),
    .pcheck_o(pcheck_o),
    .eor_o(eor_o)
  );

  rs232_tx mod_rs232_tx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .sttx_i(sttx),
    .d_i(data),
    .baud_i(15'd10415),
    .psel_i(psel_i),
    .tx_o(tx_o),
    .eot_o(eot_o)
  );
  
  fsm_echo mod_fsm_echo (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .eor_i(eor_o),
    .eot_i(eot_o),
    .sttx_o(sttx)
  );
  
endmodule
