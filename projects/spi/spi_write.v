/*	Autor : Julisa Verdejo Palacios
	email: julisa.verdejo@gmail.com
 	Nombre del archivo: spi_write.v
	Departamento: Laboratorio de Sistemas Digitales (INAOE)
	
	Fecha: 19 de julio de 2023
	
*******************************************************************

	Notas de sintaxis:

	_i : Esta extension indica que se trata de una entrada (input)
	_o : Esta extension indica que se trata de una salida (output)
	
*******************************************************************

	Descripcion del codigo:
	
								 
*/ 

module spi_write
  (
  input 		clk_i,
  input 		rst_i,
  input 		str_i,
  input 		busy_i,
  output 		mosi_o,
  output		dclk_o,
  output 		cs_o,
  output 		eow_o  
);

  wire [1:0] opc1, opc2;
  wire slow_clk, flag, hab;
  wire [7:0] count;
  
  localparam cmd_i = 8'b10010111;
  
  piso_shiftreg #(.n(8))	mod_piso	(.rst_i(rst_i), .clk_i(clk_i), .din_i(cmd_i), .op_i(opc1), .dout_o(mosi_o));
  counter		#(.n(8))	mod_cnt		(.rst_i(rst_i), .clk_i(clk_i), .opc_i(opc2), .cnt_o(count), .flag_o(flag));
  clk_div		#(.n(31))	mod_clkdiv	(.clk_i(clk_i), .rst_i(rst_i), .h_i(hab), .kmax_i(39), .slow_clk_o(slow_clk));
  fsm_spiw					mod_fsm		(.clk_i(clk_i), .rst_i(rst_i), .str_i(str_i), .busy_i(busy_i), .slow_clk_i(slow_clk), .flag_i(flag), .opc1_o(opc1), .opc2_o(opc2), .cs_o(cs_o), .dclk_o(dclk_o), .hab_o(hab), .eow_o(eow_o));
	
endmodule