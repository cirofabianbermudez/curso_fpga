# 06. Flip-Flop

## _¿Qué es un **Flip-Flop**?_
Circuitos con dos estados estables que se pueden utilizar para almacenar datos binarios. Los datos almacenados se pueden cambiar aplicando diferentes entradas.

### Flip Flop tipo D

El flip-flop tipo D pera solo con transiciones de reloj positivas o transiciones de reloj negativas. La salida del flip-flop D es insensible a los cambios en la entrada, excepto por la transición activa de la señal del reloj. 

![](https://www.tutorialspoint.com/digital_circuits/images/d_flipflop.jpg)

Por lo que, su función es dejar pasar lo que entra por D, a la salida Q, después de un pulso del reloj.

#### Tabla de verdad

|_clk_|_D_|_Q_|_Q'_|
|:-:|:-:|:-:|:-:|
|0|0|NC|NC|
|0|1|NC|NC|
|1|0|0|1|
|1|1|1|0|

## _Implementación en Verilog_
Para ejemplificar el diseño y simulación de un Flip-Flop tipo D en lenguaje de programación Verilog, desarrollaremos diferentes propuesta de código en la que se pudiera observar su implementación de la forma más sencilla posible:

### Primera propuesta
_Flip-Flop tipo D con activación en flancos de subida y reset asíncrono:_

```verilog
module flipflop1(
	input clk,   //Señal de reloj
	input reset, //Señal de reset
	input d,     //Entrada
	output reg q //Salida
);

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 1'b0;
		else
			q <= d;
	end

endmodule
```

### Segunda propuesta
_Flip-Flop tipo D con activación en flancos de bajada y reset asíncrono:_

```verilog
module flipflop2(
	input wire clk,   //Señal de reloj
	input wire reset, //Señal de reset
	input wire d,     //Entrada
	output reg q      //Salida
);

	always @(negedge clk or posedge reset) begin
		if (reset)
			q <= 1'b0;
		else
			q <= d;
	end

endmodule
```

### TestBench

```verilog
`timescale 1ns / 100 ps
`include "flipflop1.v"
`include "flipflop2.v"

module flipflop_tb();
	// Definición de señales de entrada y salida
	reg clk;
	reg reset;
	reg d;
	
	wire q;
	
	// Instanciacion del modulo
	flipflop1 dut(.clk(clk), .reset(reset), .d(d), .q(q));
	//flipflop2 dut(.clk(clk), .reset(reset), .d(d), .q(q));
	
	// Generador de reloj de 100 MHz con duty-cycle de 50 %
	always #5 clk = ~clk;
	
	// Secuencia de reset
		// Generador de se�al de reloj y reset
	initial begin
		clk = 0; reset = 1; d = 0; #10;
		         reset = 0; #10;
	end
	
	initial begin
		// Configuracion de archivos de salida
		$dumpfile("flipflop_tb.vcd"); //guarda lo que compila
		$dumpvars(0,flipflop_tb); //selecciona variable que salen
		#30;
		
		// Estímulos de prueba
		d = 1; #20;
		d = 0; #20;
		d = 1; #20;
		
		$display("Test completed");
		$finish;
	end

endmodule;
```

### Tercera propuesta
_Flip-Flop tipo D con activación en flancos de subida, reset asíncrono y habilitador (enable):_

```verilog
module flipflop3(
	input wire clk, //Señal de reloj
	input wire reset, //Señal de reset
	input wire en, //Señal de habilitación
	input wire d, //Entrada
	output reg q //Salida
);
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 1'b0;
		else if (en)
			q <= d;
		else
			q <= q;
	end

endmodule
```

### TestBench

```verilog
`timescale 1ns / 100 ps
`include "flipflop3.v"

module flipflop_en_tb();
	// Definición de señales de entrada y salida
	reg clk;
	reg reset;
	reg en;
	reg d;
	
	wire q;
	
	// Instanciacion del modulo
	flipflop3 dut(.clk(clk), .reset(reset), .en(en), .d(d), .q(q));
	
	// Generador de reloj de 100 MHz con duty-cycle de 50 %
	always #5 clk = ~clk;
	
	// Secuencia de reset
	// Generador de señal de reloj y reset
	initial begin
		clk = 0; reset = 1; d = 0; en = 0; #10;
		         reset = 0; d = 1; en = 1; #10;
	end
	
	initial begin
		// Configuracion de archivos de salida
		$dumpfile("flipflop_en_tb.vcd"); //guarda lo que compila
		$dumpvars(0,flipflop_en_tb); //selecciona variable que salen
		#30;
		
		// Estímulos de prueba
		d = 1; #20;
		d = 0; #20;
		d = 1; #20;
		
		$display("Test completed");
		$finish;
	end

endmodule;
```

## Referencias
+ _Flip Flop tipo D con reset y eneable Verilog_. (s/f). Gist. Recuperado el 12 de julio de 2023, de [https://gist.github.com/davilamds/937b372d27bb91ab399123f9d6da1baf](https://gist.github.com/davilamds/937b372d27bb91ab399123f9d6da1baf)
+ _D Flip Flop in Digital Electronics—Javatpoint_. (s/f). Recuperado el 12 de julio de 2023, de [https://www.javatpoint.com/d-flip-flop-in-digital-electronics](https://www.javatpoint.com/d-flip-flop-in-digital-electronics)
