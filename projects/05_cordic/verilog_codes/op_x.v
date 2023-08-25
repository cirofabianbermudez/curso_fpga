module op_x #(
  parameter n = 32
) (
  input  signed [n-1:0] x_i,
  input  signed [n-1:0] y_i,
  input                 d_i,
  output signed [n-1:0] op_o
);

  // d_i = 1 -> Z es negativo
  // d_i = 0 -> Z es positivo
  assign op_o = d_i ? x_i + y_i : x_i - y_i;
  
endmodule