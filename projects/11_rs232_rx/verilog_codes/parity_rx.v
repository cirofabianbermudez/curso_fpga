// Author: Julisa Verdejo Palacios
// Name: parity_rx.v
//
// Description:

module parity_rx (
  input  [7:0] din_i,
  input        pbit_i,
  output       pcheck_o
);

  wire parity_eval;

  assign parity_eval = ^ din_i;
  assign pcheck_o = pbit_i ^ parity_eval;

endmodule
