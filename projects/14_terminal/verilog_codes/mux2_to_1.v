// Author: Julisa Verdejo Palacios
// Name: mux2_to_1.v
//
// Description: Simple mux

module mux2_to_1 #(
  parameter Width = 8
) (
  input  [Width-1:0] in1_i,
  input  [Width-1:0] in2_i,
  input              sel_i,
  output [Width-1:0] mux_o
);

  assign mux_o = sel_i ? in2_i : in1_i;

endmodule
