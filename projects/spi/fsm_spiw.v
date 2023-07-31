/*	Autor : Julisa Verdejo Palacios
	Email: julisa.verdejo@gmail.com
 	Nombre del archivo: fsm_spiw.v
	Departamento: Laboratorio de Sistemas Digitales (INAOE)
	Fecha: 19 de julio de 2023
	Descripcion:
*/ 

module fsm_spiw
  (
  input 				clk_i,
  input 				rst_i,
  input 				str_i,
  input 				busy_i,
  input 				slow_clk_i,
  input					flag_i,
  output reg	[1:0]	opc1_o,
  output reg 	[1:0]	opc2_o,  
  output reg 	  		cs_o,
  output reg 	  		dclk_o,
  output reg 	  		hab_o,  
  output reg 	  		eow_o
);

  reg [2:0] present_state, next_state;

  always @(str_i, busy_i, slow_clk_i, flag_i, present_state) begin
	next_state = present_state;	  
	case(present_state)
		0	: begin
			  	opc1_o = 2'b11; opc2_o = 2'b11; cs_o = 1'b1; dclk_o = 0; hab_o = 1'b0; eow_o = 1'b1;
				if(str_i)
					next_state = 1;
				else
					next_state = present_state;
			  end
		
		1	: begin
			  	opc1_o = 2'b11; opc2_o = 2'b11; cs_o = 1'b0; dclk_o = 0; hab_o = 1'b0; eow_o = 1'b1;
				if(busy_i)
					next_state = present_state;
				else
					next_state = 2;
			  end
		
		2	: begin
			  	opc1_o = 2'b01; opc2_o = 2'b01; cs_o = 1'b0; dclk_o = 0; hab_o = 1'b1; eow_o = 1'b0;
				if(slow_clk_i)
					next_state = 3;
				else
					next_state = present_state;
		      end
		
		3	: begin
			  	opc1_o = 2'b00; opc2_o = 2'b01; cs_o = 1'b0; dclk_o = 1; hab_o = 1'b1; eow_o = 1'b0;
				if(slow_clk_i)
					next_state = 4;
				else
					next_state = present_state;			
			  end 
		
		4	: begin
			  	opc1_o = 2'b10; opc2_o = 2'b10; cs_o = 1'b0; dclk_o = 0; hab_o = 1'b1; eow_o = 1'b0;
				next_state = 5;			
			  end
		
		5	: begin
			  	opc1_o = 2'b00; opc2_o = 2'b01; cs_o = 1'b0; dclk_o = 0; hab_o = 1'b1; eow_o = 1'b0;
				if(slow_clk_i) begin
					if(flag_i == 1 || busy_i == 1) begin
						next_state = 0;
					end else begin
					    next_state = 3;
					end
				end else begin
				     next_state = present_state;	
				end
		      end 
		
		default	: begin
			  		opc1_o = 2'b11; opc2_o = 2'b11; cs_o = 1'b1; dclk_o = 0; hab_o = 1'b0; eow_o = 1'b1;
					next_state = 0;
			      end
	endcase
  end  
  
  always@ (posedge clk_i, posedge rst_i) begin
	if (rst_i)
		present_state <= 0;
	else
		present_state <= next_state;
  end	  
  
endmodule
