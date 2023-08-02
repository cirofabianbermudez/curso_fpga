// Author: Guadalupe Alonso
// Name: lut2.v
//
// Description: Second option of Look Up Table

module lut2(
  input A,
  input B,
  input C,
  input D,
  output F
);

  wire c1;
  wire c2;
  wire c3;

  assign c1 = ~A & ~B &  D;
  assign c2 =  B & ~C & ~D;
  assign c3 = ~A &  C & ~D;
  assign  F = c1 | c2 | c3;

endmodule
