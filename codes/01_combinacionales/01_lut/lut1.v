// Author: Guadalupe Alonso
// Name: lut1.v
//
// Description: First option of Look Up Table

module lut1(
  input A,
  input B,
  input C,
  input D,
  output X
);

  assign X = (~A & B & ~C) | (A & B & ~C) | (B & ~C & D);

endmodule
