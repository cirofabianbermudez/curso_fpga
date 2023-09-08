// Author: Ciro Fabian Bermudez Marquez
// Name: rom.v
//
// ROM with all required values A(a , b ) = A(9,22)
module rom #(
   parameter Width = 16
) (
    output [Width-1:0] x0_o,
    output [Width-1:0] y0_o,
    output [Width-1:0] z0_o
);
  
  assign    x0_o = 16'b0000000000000000; //    0.0000000000000000000000000
  assign    y0_o = 16'b1110100110011010; //   -0.6999511718750000000000000
  assign    z0_o = 16'b0000000000000000; //    0.0000000000000000000000000

endmodule
