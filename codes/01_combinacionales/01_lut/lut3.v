// Author: Guadalupe Alonso
// Name: lut3.v
//
// Description: Third option of Look Up Table

module lut3(
  input A,
  input B,
  input C,
  input D,
  output F
);
  wire c1;
  wire c2; 
  wire c3;
  
  and(c1,~A,~B, D);
  and(c2, B,~C,~D);
  and(c3,~A,C,~D);
  or(F,c1,c2,c3);

endmodule