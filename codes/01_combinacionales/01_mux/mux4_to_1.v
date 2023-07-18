// Author: Guadalupe Alonso
// Name: mux4_to_1.v
//
// Description: Multiplexer 4 inputs 1 output

module mux4_to_1 #(
  parameter Width = 32
) (
  input  [Width-1:0] in1_i,
  input  [Width-1:0] in2_i,
  input  [Width-1:0] in3_i,
  input  [Width-1:0] in4_i,
  input        [1:0] sel_i,
  output [Width-1:0] out_o
);

  assign out_o = sel_i[1] ? (sel_i[0] ? in4_i : in3_i) : (sel_i[0] ? in2_i : in1_i);

endmodule
