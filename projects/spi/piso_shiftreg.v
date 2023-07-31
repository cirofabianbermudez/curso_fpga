/*	Autor : Julisa Verdejo Palacios
	email: julisa.verdejo@gmail.com
 	Nombre del archivo: piso_shiftreg.v
	Departamento: Laboratorio de Sistemas Digitales (INAOE)
	Fecha: 18 de julio de 2023
	Descripcion:
	
	Registro con entrada en paralelo y salida en serie con 
	desplazamiento hacia la izquierda.
								 
*/

module piso_shiftreg #(
  parameter n = 8	
) (
  input 		rst_i,
  input 		clk_i,
  input [n-1:0]	din_i,
  input   [1:0] op_i,
  output 		dout_o
);	

  reg [n-1:0] d_mux,d_reg;
	
  always @(din_i, op_i, d_reg) begin
	case(op_i)
		2'b00 : d_mux = d_reg;
		2'b01 : d_mux = din_i;
		2'b10 : d_mux = {d_reg[n-2:0],1'b0};
		2'b11 : d_mux = 0;
		default : d_mux = 0;
	endcase
  end
	
  always @(posedge clk_i, posedge rst_i) begin		
	if (rst_i)
		d_reg <= 0;
	else
		d_reg <= d_mux;	 
  end
	
  assign dout_o = d_reg[n-1];
	
endmodule
