module scm_rho (
    X,
    Y
);

  // Port mode declarations:
  input  signed  [31:0] X;
  output signed  [31:0] Y;

  //Multipliers:

  wire signed [53:0]
    w1,
    w8,
    w7,
    w58720256;

  assign w1 = X;
  assign w8 = w1 << 3;
  assign w7 = w8 - w1;
  assign w58720256 = w7 << 23;

  assign Y = w58720256[53:22];

endmodule
