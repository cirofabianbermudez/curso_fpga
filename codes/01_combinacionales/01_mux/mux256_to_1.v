// Author: Ciro Fabian Bermudez Marquez
// Name: mux256_to_1.v
//
// Description: Simple multiplexer 256 inputs 1 output

module mux256_to_1 (
  input  [255:0] in_i,
  input    [7:0] sel_i,
  output         out_o
);

  assign out_o = in_i[sel_i];

endmodule
