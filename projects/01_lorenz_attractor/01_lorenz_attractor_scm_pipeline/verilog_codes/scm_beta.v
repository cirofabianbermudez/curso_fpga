module scm_beta (
    X,
    Y
);

  // Port mode declarations:
  input  signed  [31:0] X;
  output signed  [31:0] Y;

  //Multipliers:

  wire signed [53:0]
    w1,
    w65536,
    w65537,
    w256,
    w65793,
    w1052688,
    w1118481,
    w4473924,
    w5592405,
    w11184810;

  assign w1 = X;
  assign w65536 = w1 << 16;
  assign w65537 = w1 + w65536;
  assign w256 = w1 << 8;
  assign w65793 = w65537 + w256;
  assign w1052688 = w65793 << 4;
  assign w1118481 = w65793 + w1052688;
  assign w4473924 = w1118481 << 2;
  assign w5592405 = w1118481 + w4473924;
  assign w11184810 = w5592405 << 1;

  assign Y = w11184810[53:22];

endmodule
