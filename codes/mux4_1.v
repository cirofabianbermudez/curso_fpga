// Author: Guadalupe Alonso
// Name: mux4_1.v
//
// Description: First option of multiplexer 4 inputs 1 output

module mux4_1 #(
  parameter Width = 32
) (
  input  [Width-1:0] in1,
  input  [Width-1:0] in2,
  input  [Width-1:0] in3,
  input  [Width-1:0] in4,
  input        [1:0] sel,
  output [Width-1:0] ou1
);

  assign ou1 = sel[1] ? (sel[0] ? in4 : in3) : (sel[0] ? in2 : in1);

endmodule
