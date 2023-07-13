module mult #(
  parameter na = 36,
  parameter nx = 18
) (
  input  signed  [nx-1:0] x_i,
  input  signed  [na-1:0] a_i,
  output signed    [59:0] mult_o
);

  wire  [na + nx -1:0] mult_aux;
  wire  [5:0] sign;
  
  assign mult_aux = (x_i)*(a_i);
  assign sign  = {6{mult_aux[na + nx - 1]}};
  assign mult_o = {sign, mult_aux};
    
endmodule