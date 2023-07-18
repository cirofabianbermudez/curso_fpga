// Author: Ciro Fabian Bermudez Marquez
// Name: mult.v
//
// Fixed point multiplier A(a , b ) = A(10,21)
//                        M(ap, bp) = M(21,42)
//						  left_lim  = bp + a = 42 + 10 = 52
//						  right_lim	= bp - b = 42 - 21 = 21

module mult #(
  parameter Width = 32
) (
  input  signed [Width-1:0] a_i,
  input  signed [Width-1:0] b_i,
  output signed [Width-1:0] mult_o
);

  wire [Width*2-1:0] temp;

  assign temp = a_i * b_i; 
  assign mult_o = temp[52:21];		

endmodule
