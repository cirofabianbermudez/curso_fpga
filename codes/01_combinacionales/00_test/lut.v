// Author: Ciro Fabian Bermudez Marquez
// Name: lut.v
//
// Description: Look Up Table test code

module lut(
  input A,
  input B,
  input C,
  output F
);

  assign F = (~A & C) | (B & C);

endmodule
