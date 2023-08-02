// Author: Guadalupe Alonso
// Name: lut1.v
//
// Description: First option of Look Up Table

module lut1(
  input A,
  input B,
  input C,
  input D,
  output F
);

  assign F = (~A & ~B & D) | (B & ~C & ~D) | (~A & C & ~D);

endmodule
