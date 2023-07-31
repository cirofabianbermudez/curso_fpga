/*	Autor : Julisa Verdejo Palacios
	Email: julisa.verdejo@gmail.com
 	Nombre del archivo: counter.v
	Departamento: Laboratorio de Sistemas Digitales (INAOE)
	Fecha: 19 de julio de 2023
	Descripcion:
	
	Contador descendente que genera un timer de: 400us

*/ 

module counter #(
  parameter n = 3	
) (
  input 		 	rst_i,
  input 		 	clk_i,
  input	 [1:0]	 	opc_i,
  output [n-1:0]	cnt_o,
  output 			flag_o
);	

  reg [n-1:0] d_mux, d_reg;
	
  always @(opc_i, d_reg) begin
	case(opc_i)
		2'b00 : d_mux = 0;
		2'b01 : d_mux = d_reg;
		2'b10 : d_mux = d_reg + 1;
		2'b11 : d_mux = 0;
		default : d_mux = d_reg;
	endcase
  end
	
  always @(posedge clk_i, posedge rst_i) begin		
	if (rst_i)
		d_reg <= 0;
	else
		d_reg <= d_mux;	 
  end
	
  assign cnt_o = d_reg;
  assign flag_o = (cnt_o == 9) ? 1:0;
  
endmodule
