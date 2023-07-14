module mux_256_to_1 (
  input [255:0] in,
  input   [7:0] sel,
  output        out
);

  assign out = in[sel];

endmodule
