// Author: Ciro Fabian Bermudez Marquez
// Name: adder.v
//
// Simple absolute value
module abs #(
  parameter Width = 16
) (
  input  signed [Width-1:0] x_i,
  output signed [Width-1:0] abs_o
);

  assign abs_o = ( x_i[Width-1] == 1'b1 ) ? -x_i : x_i;

endmodule
