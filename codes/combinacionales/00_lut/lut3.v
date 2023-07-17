// Author: Guadalupe Alonso
// Name: lut3.v
//
// Description: Second option of Look Up Table

module lut3(
  input A,
  input B,
  input C,
  input D,
  output X
);

  // Working with primitives
  and(c1,~A,B);
  and(c2,c1,~C);
  and(c3,A,B);
  and(c4,c3,~C);
  and(c5,B,~C);
  and(c6,c5,D);
  or(X,c2,c4,c6);

endmodule
