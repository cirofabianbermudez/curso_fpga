`timescale 1 ns / 100 ps

module tb_fir ();
	reg					clk_i;
	reg					rst_i;
	reg					stf_i;
	reg signed	[17:0]	xn_i;
	reg	signed	[17:0]	y_o;
	reg					eof_o;
	
	
	// Instanciacion del modulo
	top_fir	DUT	(
		.clk_i,
		.rst_i,
		.stf_i,
		.xn_i,
		.y_o,
		.eof_o
	);
			
	// Generador de señal de reloj y reset
  	initial begin
    	clk_i = 0; rst_i = 1; stf_i = 0; #10;
        		   rst_i = 0;            #10;
  	end
  
 	always #5 clk_i = ~clk_i; // 100 MHz clock (50*1 ns*2) con 50% duty-cycle
	
	// variables para lectura y escritura de archivos 
	integer write_data, read_data, check;
  	int i;
  	localparam SF = 2.0**-15.0;
  
	// Estímulo de las entradas
	initial begin
    	write_data = $fopen("tb_output.txt","w");  
		read_data = $fopen("x_values.txt","r");
		#50; 
		
    	// run 50 + (340)*iter ns : run 52310 ns
    	for (i = 0; i < 201; i++) begin  
			// Leer una linea del archivo de texto
			check = $fscanf(read_data,"%b\n",xn_i); #10;	  
			
			// Empezar filtro
			stf_i = 1; #10;
	   	 	stf_i = 0;
			
			// Esperar a que termine y escribir el resultado
			#210;					 
      		$fdisplay(write_data, "%32.27f",$itor(y_o)*SF);
			
			// Esperar a que recorra
      		#30;
    	end		
		
		#1000;
		$fclose(write_data);  // close the files
		$fclose(read_data);
	end
    	 

endmodule
