// Author: Ciro Fabian Bermudez Marquez
// Name: rom.v
//
// ROM with all required values A(a , b ) = A(9,22)
module rom #(
   parameter Width = 32
) (
    output [Width-1:0] sigma_o,
    output [Width-1:0] beta_o,
    output [Width-1:0] rho_o,
	output [Width-1:0] h_o,
	output [Width-1:0] x0_o,
	output [Width-1:0] y0_o,
	output [Width-1:0] z0_o
);

  assign sigma_o = 32'b00000010100000000000000000000000; //   10.0000000000000000000000000
  assign   rho_o = 32'b00000111000000000000000000000000; //   28.0000000000000000000000000
  assign  beta_o = 32'b00000000101010101010101010101010; //    2.6666665077209472656250000
  assign     h_o = 32'b00000000000000000001000001100010; //    0.0009999275207519531250000
  assign    x0_o = 32'b00000000000000000000000000000000; //    0.0000000000000000000000000
  assign    y0_o = 32'b11111111111111110101110000101001; //   -0.0099999904632568359375000
  assign    z0_o = 32'b00000010010000000000000000000000; //    9.0000000000000000000000000

endmodule
