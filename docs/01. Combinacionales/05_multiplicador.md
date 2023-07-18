# 05. Multiplicador

## _Implementación en Verilog_
Para ejemplificar el diseño y simulación de un multiplicador en lenguaje de programación Verilog, desarrollaremos diferentes propuesta de código en la que se pudiera observar su implementación de la forma más sencilla posible:

```verilog
module mult #(
	parameter Width = 32
) (
	input signed [Width-1:0] a_i,
	input signed [Width-1:0] b_i,
	output signed [Width-1:0] mult_o
);

	wire [Width*2-1:0] temp;
	
	assign temp = a_i * b_i;
	assign mult_o = temp[52:21];

endmodule
```

## _TestBench_
```verilog
`timescale 1ns / 100ps
`include "mult.v"

module mult_tb #(
	parameter Width = 32
) ();

// Definici�n de se�ales de entrada y salida
	reg [Width-1:0] a;
	reg [Width-1:0] b;
	
	wire [Width-1:0] c;
	
	// Instanciacion del modulo
	mult #(Width) DUT (
		.a_i(a),
		.b_i(b),
		.mult_o(c)
	);
	
	// Abrir archivo de salida
	integer write_data;
	localparam SF = 2.0**-21.0;
	time t;
	// Estimulo de las entradas
	initial begin
		write_data = $fopen("mult_tb_output.txt","w");
		$dumpfile("mult_tb.vcd");
		$dumpvars(0,mult_tb);
		$timeformat(-9, 2, " ns", 10);
		a = 32'b00000000001000000000000000000000; // 1.0
		b = 32'b00000000001000000000000000000000; // 1.0;
		#100; t = $time;
		$fdisplay(write_data, "Tiempo: %t\ta = %10.7f\tb = %10.7f\tc = %10.7f",t,$itor(a)*SF,$itor(b)*SF,$itor(c)*SF);
		a = 32'b00000000001100000000000000000000; // 1.5
		b = 32'b00000000001100000000000000000000; // 1.5;
		#100; t = $time;
		$fdisplay(write_data, "Tiempo: %t\ta = %10.7f\tb = %10.7f\tc = %10.7f",t,$itor(a)*SF,$itor(b)*SF,$itor(c)*SF);
		a = 32'b00000000001100000000000000000000; // 1.5
		b = 32'b11111111111100000000000000000000; // -0.5;
		#100; t = $time;
		$fdisplay(write_data, "Tiempo: %t\ta = %10.7f\tb = %10.7f\tc = %10.7f",t,$itor(a)*SF,$itor(b)*SF,$itor(c)*SF);
		
		// Cerrar archivo de salida
		$fclose(write_data);
		
		// Final de simulacion
		$display("Test completed");
		//$display("a = %2d, b = %2d, result = %2d", a, b, c);
	
	end

endmodule
```
