// Author: Guadalupe Alonso
// Name: lut2.v
//
// Description: Second option of Look Up Table

module lut2(
  input A,
  input B,
  input C,
  input D,
  output X
);

  wire c1;
  wire c2;
  wire c3;

  assign c1 = ~A & B & ~C;
  assign c2 = A & B & ~C;
  assign c3 = B & ~C & D;
  assign  X = c1 | c2 | c3;

endmodule
