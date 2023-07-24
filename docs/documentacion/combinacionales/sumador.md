# 03. Sumador

## _¿Qué es un **sumador**?:_

Circuito combinacional que realiza la suma de bits, generalmente realizan las operaciones aritméticas en código binario, decimal o BCD. En los casos en los que se esté empleando un complemento a dos para representar números negativos, el sumador se convertirá en un _sumador-substractor_. 
![](https://lc.fie.umich.mx/~jfelix/LabDigI/Practicas/P8/Lab_Digital%20I-8_html_5088b93f.png)
_Figura 1.0. Modelo de un sumador de dos entradas._

## Sumador completo
Suma tres entradas y produce dos salidas. Las primeras dos entradas son _A_ y _B_; y la tercera entrada es un acarreo de entrada, también cuenta con un acarreo en la salida. 
![](https://media.geeksforgeeks.org/wp-content/uploads/1-77.png)
_Figura 1.0. Representación de un sumador completo._

### Tabla de verdad

|$A$|$B$|$C_{in}$|$Sum$|$C_{out}$|
|:-:|:-:|:-:|:-:|:-:|
|0|0|0|0|0|
|0|0|1|1|0|
|0|1|0|1|0|
|0|1|1|0|1|
|1|0|0|1|0|
|1|0|1|0|1|
|1|1|0|0|1|
|1|1|1|1|1|

## Semisumador
Suma dos dígitos binarios simples _A_ y _B_, denominados sumandos, y sus salidas son _Suma (S)_ y _Acarreo (C)_. La señal del acarreo representa y desbordamiento en el siguiente dígito en una adición de varios dígitos. 
Dos semisumadores pueden ser combinados para hacer un sumador completo, añadiendo una compuerta _OR_ para combinar sus salidas de acarreo. 

![](https://upload.wikimedia.org/wikipedia/commons/d/d9/Half_Adder.svg)
_Figura 1.0. Representación de un semisumador._

### Tabla de verdad

|$A$|$B$|$C$|$S$|
|:-:|:-:|:-:|:-:|
|0|0|0|0|
|1|0|0|1|
|0|1|0|1|
|1|1|1|0|

## _Implementación en Verilog_
Para ejemplificar el diseño y simulación de un sumador en lenguaje de programación Verilog, desarrollaremos diferentes propuesta de código en la que se pudiera observar su implementación de la forma más sencilla posible:

```verilog
module adder #(
	parameter Width = 32
) (
	input signed [Width-1:0] a_i,
	input signed [Width-1:0] b_i,
	output signed [Width-1:0] sum_o
);

	assign sum_o = a_i + b_i;

endmodule
```

## _Testbench_

_Simulación en gtkwave:_
```verilog
`timescale 1ns / 100ps
`include "adder.v"

module adder_tb #(
	parameter Width = 32
) ();

	// Definici�n de se�ales de entrada y salida
	reg [Width-1:0] a;
	reg [Width-1:0] b;
	
	wire [Width-1:0] c;
	
	// Instanciacion del modulo
	adder #(Width) DUT (
		.a_i(a),
		.b_i(b),
		.sum_o(c)
	);
	
	// Abrir archivo de salida
	integer write_data;
	localparam SF = 2.0**-21.0;
	time t;
	// Estimulo de las entradas
	initial begin
		write_data = $fopen("adder_tb_output.txt","w");
		$dumpfile("adder_tb.vcd");
		$dumpvars(0,adder_tb);
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

## Referencias
+ Full Adder in Digital Logic. (2017, marzo 21). _GeeksforGeeks_. [https://www.geeksforgeeks.org/full-adder-in-digital-logic/](https://www.geeksforgeeks.org/full-adder-in-digital-logic/)
