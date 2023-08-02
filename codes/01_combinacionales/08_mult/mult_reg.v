// Author: Ciro Fabian Bermudez Marquez
// Name: mult_reg.v
//
// Fixed point multiplier A(a , b ) = A(9,22)
//                        M(ap, bp) = M(19,44)
//						  left_lim  = bp + a = 44 + 9 = 53
//						  right_lim	= bp - b = 44 - 22 = 22

module mult_reg #(
   parameter Width = 32,
   parameter Ent = 9,
   parameter Frac = 22
) (
  input                         rst_i,
  input                         clk_i,
  input      signed [Width-1:0] a_i,
  input      signed [Width-1:0] b_i,
  output reg signed [Width-1:0] mult_o
);

  wire [Width*2-1:0] temp;
  wire   [Width-1:0] mult_w;

  assign temp = a_i * b_i; 
  assign mult_w = temp[Frac*2+Ent:Frac];

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin 
      mult_o <= 0;
    end else begin
      mult_o <= mult_w;
    end
  end  

endmodule
