// Author: Julisa Verdejo Palacios
// Name: freq_div.v
//
// Description: Contador descendente que genera una base de tiempo de xxxx baudios 

module freq_div #(
  parameter Width = 14
) (
  input             clk_i,  // Reloj del sistema
  input             rst_i,  // Reset del sistema
  input             en_i,   // Habilitador que decrementa o mantiene al contador 
  input [Width-1:0] baud_i, // Valor que se le carga a la base de tiempo 
  output            z_o     // Salida de la base de tiempo	
);
  
  reg  [Width-1:0] reg_q;
  wire [Width-1:0] mux1;
  wire [Width-1:0] mux2;
  wire             comp;

  assign mux1 = (en_i) ? reg_q - 1 : reg_q; // Decrementa o mantiene el contador
  assign mux2 = (comp) ? baud_i : mux1;     // Carga baud o selecciona mux1
  
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      reg_q <= 0;
    else
      reg_q <= mux2;    
  end

  assign comp = (reg_q == 0) ? 1'b1 : 1'b0; // Genera pulsos cada que se llega a 0
  assign z_o = comp;
  
endmodule