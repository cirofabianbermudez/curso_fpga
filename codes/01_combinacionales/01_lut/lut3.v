// Author: Guadalupe Alonso
// Name: lut3.v
//
// Description: Third option of Look Up Table

module lut3(
  input A,
  input B,
  input C,
  input D,
  output X
);

  and(c1,~A, B,~C);
  and(c2, A, B,~C);
  and(c3, B,~C, D);
  or(X,c1,c2,c3);

endmodule