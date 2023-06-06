// Author: Ciro Fabian Bermudez Marquez
// Name: generic_tb.v
//
// Run: run 500 ns
`timescale 1ns / 100ps	  

module mult_tb #(
	parameter Width = 32 
) ();
	// Definición de señales de entrada y salida
	reg [Width-1:0] a;
	reg [Width-1:0] b;
	reg [Width-1:0] c;
	
	// Generador de señal de reloj
	//reg clk;
  //always #5 clk = ~clk;
		
	// Instanciacion del modulo
  mult #(Width) DUT (
    .a_i(a),
    .b_i(b),
    .mult_o(c)
	);
	
	// Estímulo de las entradas
	initial begin
    a = 32'b00000000001000000000000000000000; // 2
    b = 32'b00000000001000000000000000000000; // 2;
		#100;
		
		a = 32'b00000000001100000000000000000000; // 3
    b = 32'b00000000001100000000000000000000; // 3;
		#100;
		
		a = 32'b00000000001100000000000000000000; // 3
    b = 32'b11111111111100000000000000000000; // -1;
		#100;
		
		$display("a = %d, b = %d, result = %d", a, b, c);	
		$finish;
	end

endmodule