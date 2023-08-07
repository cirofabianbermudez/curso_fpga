// Author: Julisa Verdejo Palacios
// Name: rs232_tx.v
//
// Description: Modulo top de transmision rs232

module rs232_tx #(
  parameter Width = 15
) (
  input              clk_i,  // Reloj del sistema
  input              rst_i,  // Reset del sistema
  input              st_i,   // Start
  input        [7:0] d_i,    // Datos de entrada
  input  [Width-1:0] baud_i, // Selector de paridad
  input              psel_i, // Selector de paridad
  output             tx_o,   // Transmision
  output             eot_o   // Fin de transmision	
);

  wire       z;
  wire       p; 
  wire [3:0] sel; 
  
  mux_tx mod_mux_tx (
    .d_i(d_i),
    .p_i(p),
    .sel_i(sel),
    .tx_o(tx_o)
  );
  
  parity mod_parity (
    .d_i(d_i), 
    .p_o(p)
  );
  
  fsm_tx mod_fsm_tx (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .st_i(st_i),
    .z_i(z),
    .psel_i(psel_i),
    .sel_o(sel),
    .eot_o(eot_o)
  );
  
  freq_div #(.Width(Width)) mod_freq_div (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .en_i(1'b1),
    .baud_i(baud_i),
    .z_o(z)
  );
  
endmodule