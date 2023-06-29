// Author: Ciro Fabian Bermudez Marquez
// Name: sub.v
//
// Simple signed subtracter
module sub #(
  parameter Width = 32
) (
  input  signed [Width-1:0] a_i,
  input  signed [Width-1:0] b_i,
  output signed [Width-1:0] sub_o
);

  assign sub_o = a_i - b_i;		

endmodule
