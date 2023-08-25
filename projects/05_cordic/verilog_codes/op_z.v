module op_z #(
  parameter n = 32
) (
  input  signed [n-1:0] z_i,
  input  signed [n-1:0] rom_i,
  input                 d_i,
  output signed [n-1:0] op_o
);

  // d_i = 1 -> Z es negativo
  // d_i = 0 -> Z es positivo
  assign op_o = d_i ? z_i + rom_i : z_i - rom_i;		
  
endmodule