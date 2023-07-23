module scm_h (
    X,
    Y
);

  // Port mode declarations:
  input  signed  [31:0] X;
  output signed  [31:0] Y;

  //Multipliers:

  wire signed [53:0]
    w1,
    w2048,
    w2049,
    w4,
    w3,
    w48,
    w2097,
    w4194;

  assign w1 = X;
  assign w2048 = w1 << 11;
  assign w2049 = w1 + w2048;
  assign w4 = w1 << 2;
  assign w3 = w4 - w1;
  assign w48 = w3 << 4;
  assign w2097 = w2049 + w48;
  assign w4194 = w2097 << 1;

  assign Y = w4194[53:22];

endmodule
