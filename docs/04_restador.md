# _¿Qué es un **restador**?:_

Dispositivo que resta dos números y produce un resultado, por lo que, un restador digital se ocupa de la resta de dígitos binarios. 
La regla general se ve expresada en la siguiente tabla de verdad:

|$A$|$B$|$y=A-B$|
|:-:|:-:|:-:|
|0|0|0|
|0|1|1|
|1|0|1|
|1|1|0|

## Restador completo

Este circuito cuenta con tres entradas y dos salidas, las entradas $A$, $B$ y $B_{in}$ denotan el minuendo, el sustraendo y el préstamo anterior, respectivamente. Las dos salidas, $D$ y $B_{out}$ representan la diferencia y la salida prestada, respectivamente. 

![](https://media.geeksforgeeks.org/wp-content/uploads/full-subtractor.jpg)
![](https://media.geeksforgeeks.org/wp-content/uploads/full-subtractor-logic-gate.jpg)
_Figura 1.0. Esquema de un restador completo._

### Tabla de verdad

|$A$|$B$|$B_{in}$|$D$|$B_{out}$|
|:-:|:-:|:-:|:-:|:-:|
|0|0|0|0|0|
|0|0|1|1|1|
|0|1|0|1|1|
|0|1|1|0|1|
|1|0|0|1|0|
|1|0|1|0|0|
|1|1|0|0|0|
|1|1|1|1|1|

## Semirestador

Cuenta con dos entradas, _A_ y _B_, y dos salidas que son _diferencia_ y _préstamo_. La primer salida es la diferencia entre los dos bits de entrada, mientras que la segunda indica si fue necesario tomar prestado durante la resta. 

![](https://media.geeksforgeeks.org/wp-content/cdn-uploads/gq/2015/08/halfsub.png)

![](https://media.geeksforgeeks.org/wp-content/uploads/20230316145016/Half-Subtractor-in-Digital-Logic.png)
_Figura 2.0. Esquema de un semirestador._

### Tabla de verdad

|$A$|$B$|$Diff$|$Borrow$|
|:-:|:-:|:-:|:-:|
|0|0|0|0|
|0|1|1|1|
|1|0|1|0|
|1|1|0|0|

## _Implementación en Verilog_
Para ejemplificar el diseño y simulación de un restador en lenguaje de programación Verilog, desarrollaremos diferentes propuesta de código en la que se pudiera observar su implementación de la forma más sencilla posible:

```verilog
module sub #(
	parameter Width = 32
) (
	input signed [Width-1:0] a_i,
	input signed [Width-1:0] b_i,
	output signed [Width-1:0] sub_o
);

	assign sub_o = a_i - b_i;

endmodule
```

## _TestBench_
```verilog
`timescale 1ns / 100ps
`include "sub.v"

module sub_tb #(
	parameter Width = 32
) ();

	// Definici�n de se�ales de entrada y salida
	reg [Width-1:0] a;
	reg [Width-1:0] b;
	
	wire [Width-1:0] c;
	
	// Instanciacion del modulo
	sub #(Width) DUT (
		.a_i(a),
		.b_i(b),
		.sub_o(c)
	);
	
	// Abrir archivo de salida
	integer write_data;
	localparam SF = 2.0**-21.0;
	time t;
	// Estimulo de las entradas
	initial begin
		write_data = $fopen("sub_tb_output.txt","w");
		$dumpfile("sub_tb.vcd");
		$dumpvars(0,sub_tb);
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
