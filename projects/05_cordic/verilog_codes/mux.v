module mux #(
  parameter n = 32
) (
  input  [n-1:0] in1_i,
  input  [n-1:0] in2_i,
  input          sel_i,
  output [n-1:0] mux_o
);

  assign mux_o = sel_i ? in2_i : in1_i;

endmodule