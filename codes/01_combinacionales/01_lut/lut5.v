// Author: Ciro Fabian Bermudez Marquez
// Name: lut5.v
//
// Description: Fifth option of Look Up Table

module lut5(
  input A,
  input B,
  input C,
  input D,
  output F
);

  assign F = ( A & ~B &  C &  D) | ( A &  B & ~C &  D);

endmodule
