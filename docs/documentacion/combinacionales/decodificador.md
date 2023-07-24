# 02. Decodificador

## _¿Qué es un **decodificador**?_

Un decodificador es un circuito digital que convierte una combinación de señales de entrada en una señal de salida específica. 
Su función principal es descomponer y decodificar una entrada codificada; y activar una única salida correspondiente a la combinación de entrada recibida.
Convierte las entradas de datos en $n$ bits en las $2^n$ salidas codificadas. 
El decodificador generalmente coloca la lógica $1$ n una de sus salidas para crear el código exacto. Para una combinación diferente de entradas binarias de $n$ bits, produce una salida codificada de $2^n$. La salida codificada se produce en función de cada entrada binaria.

![](https://www.electrically4u.com/wp-content/uploads/2020/09/decoder.png?ezimgfmt=ng:webp/ngcb4)
_Figura 1.0. Modelo básico de un decodificador de n entradas._


### _Decodificador para display de 7 segmentos_
Los decodificadores de BCD (_Decimal Codificado en Binario_) a 7 segmentos son muy utilizados para simplificar el uso de los display de 7 segmentos, comúnmente utilizados para mostrar los dígitos decimales de $0$ a $9$ en una pantalla formada por LED's.

![](https://media.geeksforgeeks.org/wp-content/cdn-uploads/bcd.png)

#### Tabla de verdad

|$num$|Entrada $D$|Entrada $C$|Entrada $B$|Entrada $A$|Seg $a$|Seg $b$|Seg $c$|Seg $d$|Seg $e$|Seg $f$|Seg $g$|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|0|0|0|0|0|1|1|1|1|1|1|1|
|1|0|0|0|1|0|1|1|0|0|0|0|
|2|0|0|1|0|1|1|0|1|1|0|1|
|3|0|0|1|1|1|1|1|1|0|0|1|
|4|0|1|0|0|0|1|1|0|0|1|1|
|5|0|1|0|1|1|0|1|1|0|1|1|
|6|0|1|1|0|1|0|1|1|1|1|1|
|7|0|1|1|1|1|1|1|0|0|0|1|
|8|1|0|0|0|1|1|1|1|1|1|1|
|9|1|0|0|1|1|1|1|0|0|1|1|
|A|1|0|1|0|1|1|1|0|1|1|1|
|b|1|0|1|1|0|0|1|1|1|1|1|
|C|1|1|0|0|1|0|0|1|1|1|0|
|d|1|1|0|1|0|1|1|1|1|0|1|
|E|1|1|1|0|1|0|0|1|1|1|1|
|F|1|1|1|1|1|0|0|0|1|1|1|

#### _Implementación en Verilog_

Para ejemplificar el diseño y simulación de un multiplexor 4 a 1 en lenguaje de programación Verilog, desarrollaremos diferentes propuesta de código:

##### Primera propuesta
_Sintaxis case:_

```verilog
module dec7seg (
	input [3:0] binary,
	output reg [6:0] leds //lo declaramos como reg porque es una variable
);

	always @(binary) begin
		case (binary)
			4'd0 : leds = 7'b1111110;
			4'd1 : leds = 7'b0110000;
			4'd2 : leds = 7'b1101101;
			4'd3 : leds = 7'b1111001;
			4'd4 : leds = 7'b0110011;
			4'd5 : leds = 7'b1011011;
			4'd6 : leds = 7'b1011111;
			4'd7 : leds = 7'b1110001;
			4'd8 : leds = 7'b1111111;
			4'd9 : leds = 7'b1110011;
			4'd10 : leds = 7'b1110111;
			4'd11 : leds = 7'b0011111;
			4'd12 : leds = 7'b1001110;
			4'd13 : leds = 7'b0111101;
			4'd14 : leds = 7'b1001111;
			4'd15 : leds = 7'b1000111;
			default : leds = 7'b0000000;
		endcase
	end

endmodule
```

##### Segunda propuesta
_Sintaxis if-else:_

```verilog
module dec7seg_v2 (
	input [3:0] binary,
	output reg [6:0] leds //lo declaramos cono reg porque es una variable
);

	always @(binary) begin
		if (binary == 4'd0) begin
			leds = 7'b1111110;
		end else if (binary == 4'd1) begin
			leds = 7'b0110000;
		end else if (binary == 4'd2) begin
			leds = 7'b1101101;
		end else if (binary == 4'd3) begin
			leds = 7'b1111001;
		end else if (binary == 4'd4) begin
			leds = 7'b0110011;
		end else if (binary == 4'd5) begin
			leds = 7'b1011011;
		end else if (binary == 4'd6) begin
			leds = 7'b1011111;
		end else if (binary == 4'd7) begin
			leds = 7'b1110001;
		end else if (binary == 4'd8) begin
			leds = 7'b1111111;
		end else if (binary == 4'd9) begin
			leds = 7'b1110011;
		end else if (binary == 4'd10) begin
			leds = 7'b1110111;
		end else if (binary == 4'd11) begin
			leds = 7'b0011111;
		end else if (binary == 4'd12) begin
			leds = 7'b1001110;
		end else if (binary == 4'd13) begin
			leds = 7'b0111101;
		end else if (binary == 4'd14) begin
			leds = 7'b1001111;
		end else if (binary == 4'd15) begin
			leds = 7'b1000111;
		end else begin
			leds = 7'b0000000;
		end
	end

endmodule
```

##### Tercera propuesta
_Sintaxis assign:

```verilog
module dec7seg_v3 (
	input [3:0] binary,
	output [6:0] leds
);

	assign leds = (binary == 4'd0 ) ? 7'b1111110 :
			      (binary == 4'd1 ) ? 7'b1111110 :
	              (binary == 4'd2 ) ? 7'b1101101 :
			      (binary == 4'd3 ) ? 7'b1111001 :
			      (binary == 4'd4 ) ? 7'b0110011 :
				  (binary == 4'd5 ) ? 7'b1011011 :
				  (binary == 4'd6 ) ? 7'b1011111 :
				  (binary == 4'd7 ) ? 7'b1110001 :
			      (binary == 4'd8 ) ? 7'b1111111 :
				  (binary == 4'd9 ) ? 7'b1110011 :
				  (binary == 4'd10) ? 7'b1110111 :
				  (binary == 4'd11) ? 7'b0011111 :
				  (binary == 4'd12) ? 7'b1001110 :
				  (binary == 4'd13) ? 7'b0111101 :
				  (binary == 4'd14) ? 7'b1001111 :
				  (binary == 4'd15) ? 7'b1000111 :
									  7'b0000000 ;

endmodule
```

##### TestBench
_Simulación en gtkwave:_

```verilog
`timescale 1ns / 100 ps
`include "dec7seg.v"
`include "dec7seg_v2.v"
`include "dec7seg_v3.v"

module dec7seg_tb();
// Definicion de señales de entrada y salida
	reg [3:0] binary;
	wire [6:0] leds;

	//Instanciacion del modulo
	dec7seg dut(.binary(binary), .leds(leds));
	//dec7seg_v2 dut(.binary(binary), .leds(leds));
	//dec7seg_v3 dut(.binary(binary), .leds(leds));
	
	// Variables para archivo de salida
	integer write_data;
	integer i;
	
	initial begin
		// Configuracion de archivos de salida
		write_data = $fopen("dec7seg_tb_output.txt","w");
		$dumpfile("dec7seg_tb.vcd");
		$dumpvars(0,dec7seg_tb);
		
		for (i = 0; i < 16; i++) begin
		binary = i; #20
		$fdisplay(write_data,"Binary = %4b, Leds = %7b", binary, leds);
		end
	
		$fclose(write_data);
		$display("Test completed");
	end

endmodule;
```

## Referencias
+ (2020, septiembre 16). _What is a decoder? Operation, types and applications_. [https://www.electrically4u.com/what-is-a-decoder-operation-types-and-applications/](https://www.electrically4u.com/what-is-a-decoder-operation-types-and-applications/)
