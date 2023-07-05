// Author: Guadalupe Alonso
// Name: lut3.v
//
// Description: Third option of Look Up Table

module lut3(
  input A,
  input B,
  input C,
  input D,
  output reg X
);

  always @(A,B,C,D) begin
    if ( (A & ~B & ~C & ~D) | (A & B & C & ~D) | (A & B & ~C & D) | (A & B & C & D) ) begin
      X = 1;
    end else begin
      X = 0;
    end
  end

endmodule
