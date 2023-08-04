// Author: Julisa Verdejo Palacios
// Name: parity.v
//
// Description: Calcula la paridad tipo (even) de los datos de entrada

module parity (
  input  [7:0] d_i,  //Datos de entrada
  output       p_o   //Bit de paridad
);

  assign p_o = ^ d_i;

endmodule