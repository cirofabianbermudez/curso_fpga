// Author: Ciro Fabian Bermudez Marquez
// Name: adder.v
//
// Simple signed adder
module adder #(
  parameter Width = 32
) (
  input  signed [Width-1:0] a_i,
  input  signed [Width-1:0] b_i,
  output signed [Width-1:0] sum_o
);

  assign sum_o = a_i + b_i;

endmodule
