# 01. Multiplexor

## ¿Qué es un multiplexor?

Es un circuito lógico combinacional que permite seleccionar uno de varios canales de entrada y dirigirlo hacia una única salida. Actúa como un selector de datos que permite la transmisión de una señal de entrada específica a través de una sola línea de salida, en función de señales de control.

##### _Multiplexor 2 a 1:_
Un multiplexor 2 a 1 consta de dos entradas, una entrada de selección y una salida, como se muestra en la Figura 2.0. Dependiendo de la señal de selección, la salida se conecta a cualquiera de las entradas. Dado que hay dos señales de entrada, sólo son posibles dos formas de conectar las entradas a las salidas, por lo que se necesita un selector para realizar estas operaciones.

![Mux2_1](https://upload.wikimedia.org/wikipedia/commons/3/39/Multiplexer_2-to-1.svg)
_Figura 2.0: Modelo de un multiplexor 2 a 1._
+ $A=I_1$
+ $B=I_2$
+ $Z=O_1$
+ $S_0=SEL$

#### Tabla de verdad para mux 2 a 1:

|$O_1$|$SEL$|
|:-:|:-:|
|$I_1$|$0$|
|$I_2$|$1$|

De acuerdo a lo anterior, entendemos que el selector de un multiplexor 2 a 1, únicamente tiene como opción, esocger entre la salida $I_1$ o $I_2$ dependiendo si esté se encuentra con un $1$ o $0$ lógico. 
Por otro lado, la cantidad de bits de cada una de las entradas es irrelevante. Únicamente se debe de considerar que la misma cantidad de bits que entran, son los que salen. 

### _Implementación en Verilog:_

Para ejemplificar el diseño y simulación de un multiplexor 2 a 1 en lenguaje de programación Verilog, desarrollaremos la siguiente propuesta de código:

#### Propuesta de diseño de multiplexor 2 a 1: 
```Verilog
module mux #(
parameter Width = 32
) (
input  [Width-1:0] in1_i,
input  [Width-1:0] in2_i,
input              sel_i,
output [Width-1:0] mux_o
);

assign mux_o = sel_i ? in2_i : in1_i;

endmodule
```


##### _Multiplexor 4 a 1:_
Un multiplexor 4 a 1 toma cuatro entradas y dirige una única entrada seleccionada a la salida, como se muestra en la Figura 2.1. La selección de la entrada se controla mediante entradas de selección. 

![](https://allaboutfpga.com/wp-content/uploads/2016/01/multiplexer-4-to-1.png)
_Figura 2.1: Modelo de multiplexor 4 a 1._

+ $A=I_1$
+ $B=I_2$
+ $C=I_3$
+ $D=I_4$
+ $Z=O_1$
+ $S_1=S_1$
+ $S_2=S_2$

De acuerdo a la descripción anterior entendemos que:
$$
\begin{gather*}
4\;entradas=4\;combinaciones \\
2^{n\;bits}=4 \therefore n=2\;bits \\
2^{n\;selectores}=4\;entradas\;de\;datos \therefore n=2\;entradas\;de\;selección
\end{gather*}
$$
Al tener 4 entradas de datos tendremos 2 entradas de selección, lo que significa manejar 2 bits en la selección para cumplir con la cantidad de combinaciones que tenemos a la entrada. Se puede observar con mayor claridad en la siguiente tabla de verdad.

#### Tabla de verdad para mux 4 a 1:

| |$S_1$|$S_2$|$O_1$|
|:-:|:-:|:-:|:-:|
|$0$|$0$|$0$|$I_1$|
|$1$|$0$|$1$|$I_2$|
|$2$|$1$|$0$|$I_3$|
|$3$|$1$|$1$|$I_1$|

### _Implementación en Verilog:_

Para ejemplificar el diseño y simulación de un multiplexor 4 a 1 en lenguaje de programación Verilog, desarrollaremos diferentes propuesta de código:

#### Primera propuesta de diseño para un multiplexor 4 a 1: Sintaxis condicional

```Verilog
module mux1 #(
	parameter Width = 32
) (
	input  [Width-1:0] in1,
	input  [Width-1:0] in2,
	input  [Width-1:0] in3,
	input  [Width-1:0] in4,
	input  [1:0]       sel,
	output [Width-1:0] ou1
);

	assign ou1 = sel[1] ? (sel[0] ? in4 : in3) : (sel[0] ? in2 : in1);

endmodule
```

#### Segunda propuesta: Sintaxis if-else

```Verilog
module mux2 #(
	parameter Width = 32
) (
	input  [Width-1:0] in1,
	input  [Width-1:0] in2,
	input  [Width-1:0] in3,
	input  [Width-1:0] in4,
	input  [1:0]       sel,
	output [Width-1:0] ou1
);

	always @(in1,in2,in3,in4,sel)
	begin
		if (sel == 0) begin
			ou1=in1;
		end else if (sel == 1) begin
			ou1=in2;
		end else if (sel == 2) begin
			ou1=in3;
		end else if (sel == 3) begin
			ou1=in4;
		end else begin
			ou1=0;
		end
	end

endmodule
```

#### Tercera propuesta: Sintaxis case 

```Verilog
module mux3 #(
	parameter Width = 32
) (
	input  [Width-1:0] in1,
	input  [Width-1:0] in2,
	input  [Width-1:0] in3,
	input  [Width-1:0] in4,
	input  [1:0]       sel,
	output [Width-1:0] ou1
);

	case (sel)
		2d'0 : ou1 = in1;
		2d'1 : ou1 = in2;
		2d'2 : ou1 = in3;
		2d'3 : ou1 = in4;
		default: ou1 = 0;
	endcase

endmodule
```


#### TestBench para simulación en gtkwave:

```verilog
`timescale 1ns / 100 ps
`include "mux4_1.v"
`include "mux4_1_v2.v"
`include "mux4_1_v3.v"

module mux4_1_tb #(
	parameter n = 4
) ();

	// Definicion de señales de entrada y salida
	reg [n-1:0] in1;
	reg [n-1:0] in2;
	reg [n-1:0] in3;
	reg [n-1:0] in4;
	reg [1:0] sel;
	
	wire [n-1:0] ou1;
	
	//Instanciacion del modulo
	//mux4_1 #(.Width(n)) dut(.in1(in1), .in2(in2), .in3(in3), .in4(in4), .sel(sel), .ou1(ou1));
	//mux4_1_v2 #(.Width(n)) dut(.in1(in1), .in2(in2), .in3(in3), .in4(in4), .sel(sel), .ou1(ou1));
	mux4_1_v3 #(.Width(n)) dut(.in1(in1), .in2(in2), .in3(in3), .in4(in4), .sel(sel), .ou1(ou1));
	
	// Variables para archivo de salida
	integer write_data;
	integer i;
	time t;
	
	// Valores iniciales
	initial begin
		in1 = 4'd1;
		in2 = 4'd2;
		in3 = 4'd3;
		in4 = 4'd4;
		sel = 2'd0;
	end
	
	initial begin
		// Configuracion de archivos de salida
		write_data = $fopen("mux4_1_tb_output.txt","w");
		$dumpfile("mux4_1_tb.vcd");
		$dumpvars(0,mux4_1_tb);
		$timeformat(-9, 2, " ns", 10);
		
		for (i = 0; i < 4; i++) begin
			sel = i; #20; t = $time;
			$fdisplay(write_data,"Tiempo: %t, Selector = %b, Salida = %b",t ,sel, ou1);
		end
		
		$fclose(write_data);
		$display("Test completed");
	end

endmodule;
```
