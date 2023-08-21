// Author: Julisa Verdejo Palacios
// Name: rs232_tx.v
//
// Description: Modulo top de transmision rs232

module rs232_tx (
  input         rst_i,
  input         clk_i,
  input         sttx_i,  // Start
  input   [7:0] d_i,     // Datos de entrada
  input  [14:0] baud_i,  // Constante de baudios
  input         psel_i,  // Selector de paridad
  output        tx_o,    // Transmision
  output        eot_o    // Fin de transmision
);

  wire       z;
  wire       p; 
  wire [3:0] sel; 
  
  mux_tx mod_mux_tx (
    .d_i(d_i),
    .pbit_i(p),
    .sel_i(sel),
    .tx_o(tx_o)
  );
  
  parity_tx mod_parity_tx (
    .d_i(d_i), 
    .pbit_o(p)
  );
  
  clk_div_tx #(.Width(15)) mod_clk_div_tx(
    .rst_i(rst_i),
    .clk_i(clk_i),
    .en_i(1'b1),
    .baud_i(baud_i),
    .z_o(z)
  );
  
  fsm_tx mod_fsm_tx (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .sttx_i(sttx_i),
    .z_i(z),
    .psel_i(psel_i),
    .sel_o(sel),
    .eot_o(eot_o)
  );
  
  
endmodule