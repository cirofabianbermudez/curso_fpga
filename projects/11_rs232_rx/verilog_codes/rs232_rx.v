// Author: Julisa Verdejo Palacios
// Name: rs232_rx.v
//
// Description: Recepcion con protoloco de comunicacion rs232.

module rs232_rx (
  input         rst_i,
  input         clk_i,
  input         rx_i,
  input  [14:0] baud_i,
  input         psel_i,
  output  [7:0] dout_o,
  output        pcheck_o,
  output        eor_o
);

  wire z;
  wire [1:0] opc;
  wire       en;
  wire [3:0] cnt;
  wire [3:0] nbits;
  wire [9:0] data_sipo;
  wire [7:0] data_rx;
  wire       pcheck;

  assign nbits   = (psel_i) ? 4'd9 : 4'd8;
  assign data_rx = (psel_i) ? data_sipo[8:1]: data_sipo[9:2];
  assign dout_o  = data_rx;
  assign pcheck_o = (psel_i) ? pcheck : 1'b0; 

  clk_div_rx #(.Width(15)) mod_clk_div_rx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .en_i(1'b1),
    .baud_i(baud_i),
    .z_o(z)
  );

  counter_rx #(.Width(4)) mod_counter_rx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .opc_i(opc),
    .cnt_o(cnt)
  );

  sipo_reg_rx #(.Width(10)) mod_sipo_reg_rx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .din_i(rx_i),
    .en_i(en),
    .dout_o(data_sipo)
  );

  parity_rx mod_parity_rx (
    .din_i(data_rx),
    .pbit_i(data_sipo[9]),
    .pcheck_o(pcheck)
  );

  fsm_rx mod_fsm_rx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .rx_i(rx_i),
    .z_i(z),
    .nbits_i(nbits),
    .cnt_i(cnt),
    .opc_o(opc),
    .en_o(en),
    .eor_o(eor_o)
  );

endmodule
