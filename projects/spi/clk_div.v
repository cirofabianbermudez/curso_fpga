/*	Autor : Julisa Verdejo Palacios
	Email: julisa.verdejo@gmail.com
 	Nombre del archivo: clk_div.v
	Departamento: Laboratorio de Sistemas Digitales (INAOE)
	Fecha: 17 de julio de 2023
	Descripcion:

	Contador descendente que genera un timer de: 400us

*/

module clk_div #(
  parameter n = 6
) (
  input          clk_i,
  input          rst_i,	
  input          h_i,		
  input	 [n-1:0] kmax_i,
  output		 slow_clk_o	 
);

  wire	[n-1:0]	mux1;
  wire	[n-1:0]	mux2;
  wire			comp;
  reg	[n-1:0]	d_reg; 

  assign mux1 = h_i ? d_reg-1 : d_reg;
  assign mux2 = comp ? kmax_i : mux1;
  assign comp = (d_reg == 0) ? 1 : 0;
  
  always @(posedge clk_i, posedge rst_i) begin
    if(rst_i)
      d_reg <= 0;
	else
      d_reg <= mux2;
  end
  
  assign slow_clk_o = comp; 
  

endmodule
