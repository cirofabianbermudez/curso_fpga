// Author: Julisa Verdejo Palacios
// Name: parity_tx.v
//
// Description: Calcula la paridad tipo (even) de los datos de entrada

module parity_tx (
  input  [7:0] d_i,    //Datos de entrada
  output       pbit_o  //Bit de paridad
);

  assign pbit_o = ^ d_i;

endmodule