module scm_sigma (
    X,
    Y
);

  // Port mode declarations:
  input  signed  [31:0] X;
  output signed  [31:0] Y;

  //Multipliers:

  wire signed [53:0]
    w1,
    w4,
    w5,
    w41943040;

  assign w1 = X;
  assign w4 = w1 << 2;
  assign w5 = w1 + w4;
  assign w41943040 = w5 << 23;

  assign Y = w41943040[53:22];

endmodule
