/*	Autor : Julisa Verdejo Palacios
	email: julisa.verdejo@gmail.com
 	Nombre del archivo: rs232_tx.v
	Departamento: Laboratorio de Sistemas Digitales (INAOE)
	
	Fecha: 03 de julio de 2023
	
*******************************************************************

	Notas de sintaxis:

	_i : Esta extension indica que se trata de una entrada (input)
	_o : Esta extension indica que se trata de una salida (output)
	
*******************************************************************

	Descripcion del codigo:
	
	En este modulo solo se instancian todos los bloques usados
	para la transmision de datos.
*/


module rs232_tx
  (
  input			clk_i,	//señal de reloj 
  input			rst_i,	//reset de sistema 
  input			st_i,	//start
  input			psel_i,	//selector de paridad
  input	[7:0]	d_i,	//datos a transmitir
  output		tx_o,	//salida serial de la transmision de datos
  output 		eot_o	//fin de transmision	
);

	
  wire z;
  wire p; 
  wire [3:0] en; 
	
  localparam k = 10415;
  
  clk_div	#(.n(14))	mod_clk_div	(.clk_i(clk_i), .rst_i(rst_i), .h_i(1'b1), .k_i(k), .slow_clk_o(z));
  
  parity				mod_parity	(.d_i(d_i), .p_o(p));
  
  mux					mod_mux		(.p_i(p), .d_i(d_i), .sel_i(en), .tx_o(tx_o));
  
  tx_fsm				mod_tx_fsm	(.clk_i(clk_i), .rst_i(rst_i), .st_i(st_i), .psel_i(psel_i), .z_i(z), .en_o(en), .eot_o(eot_o));
  
endmodule