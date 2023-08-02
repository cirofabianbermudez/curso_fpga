// Author: Guadalupe Alonso
// Name: lut4.v
//
// Description: Forth option of Look Up Table

module lut4(
  input A,
  input B,
  input C,
  input D,
  output reg F
);

  always @(A,B,C,D) begin
    if ( ( A & ~B &  C &  D) | (A & B & ~C & D)  ) begin
      F = 1'b1;
    end else begin
      F = 1'b0;
    end
  end

endmodule
