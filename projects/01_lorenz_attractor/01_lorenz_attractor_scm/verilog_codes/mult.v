// Author: Ciro Fabian Bermudez Marquez
// Name: mult.v
//
// Fixed point multiplier A(a , b ) = A(9,22)
//                        M(ap, bp) = M(19,44)
//						  left_lim  = bp + a = 44 + 9 = 53
//						  right_lim	= bp - b = 44 - 22 = 22

module mult #(
   parameter Width = 32,
   parameter Ent = 9,
   parameter Frac = 22
) (
  input  signed [Width-1:0] a_i,
  input  signed [Width-1:0] b_i,
  output signed [Width-1:0] mult_o
);

  wire [Width*2-1:0] temp;

  assign temp = a_i * b_i; 
  assign mult_o = temp[Frac*2+Ent:Frac];		

endmodule
