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

  // Working with primitives

  // and(c1,~A,B);
  // and(c2,c1,~C);
  // and(c3,A,B);
  // and(c4,c3,~C);
  // and(c5,B,~C);
  // and(c6,c5,D);
  // or(X,c2,c4,c6);

endmodule
