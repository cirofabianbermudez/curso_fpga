// Author: Ciro Fabian Bermudez Marquez
// Name: mux.v
//
// Simple multiplexer 2 inputs 1 output
module mux #(
  parameter Width = 32
) (
  input  [Width-1:0] in1_i,
  input  [Width-1:0] in2_i,
  input              sel_i,
  output [Width-1:0] mux_o
);

  assign mux_o = sel_i ? in2_i : in1_i;

endmodule
