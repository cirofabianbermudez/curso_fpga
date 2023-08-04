// Author: Julisa Verdejo Palacios
// Name: mux_tx.v
//
// Description: Multiplexor que selecciona que dato se transmitira.

module mux_tx(
  input [7:0] d_i,      // Datos a transmitir
  input       p_i,      // Bit de paridad
  input [3:0] sel_i,    // Selector de dato
  output  reg tx_o      // Transmision
);

  always @(d_i, p_i, sel_i) begin
    case (sel_i)
      4'b0000 : tx_o = 1'b1;    // Stop bit
      4'b0001 : tx_o = 1'b0;    // Start bit
      4'b0010 : tx_o = d_i[0];  // LSB de d_i 
      4'b0011 : tx_o = d_i[1];
      4'b0100 : tx_o = d_i[2];
      4'b0101 : tx_o = d_i[3];
      4'b0110 : tx_o = d_i[4];
      4'b0111 : tx_o = d_i[5];
      4'b1000 : tx_o = d_i[6];
      4'b1001 : tx_o = d_i[7];  // MSB de d_i
      4'b1010 : tx_o = p_i;     // Bit de paridad
      default : tx_o = 1'b1;    // Stop bit
    endcase
  end
  
endmodule