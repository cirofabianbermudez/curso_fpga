// Author: Ciro Fabian Bermudez Marquez
// Name: rom.v
//
// ROM with all required values A(a , b ) = A(10,21)
module rom #(
  parameter Width = 32
) (
  output [Width-1:0] a_o,
  output [Width-1:0] b_o,
  output [Width-1:0] h_o,
  output [Width-1:0] x0_o,
  output [Width-1:0] y0_o,
  output [Width-1:0] z0_o
);

  assign     a_o = 32'b00000000010000000000000000000000; //    2.0000000000000000000000000
  assign     b_o = 32'b00000000110101100110011001100110; //    6.6999998092651367187500000
  assign     h_o = 32'b00000000000000000000100000110001; //    0.0009999275207519531250000
  assign    x0_o = 32'b00000000001000000000000000000000; //    1.0000000000000000000000000
  assign    y0_o = 32'b00000000000000000000000000000000; //    0.0000000000000000000000000
  assign    z0_o = 32'b00000000100100000000000000000000; //    4.5000000000000000000000000

endmodule
