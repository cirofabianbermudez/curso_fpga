## 1. Multiplexor:

_¿Qué es?:_
Dispositivo que transmite datos de varias entradas a una única salida. Se trata de un circuito combinacional que tiene entradas de control, las cuales pueden seleccionar solamente una de las entradas de datos a la que le permiten transmitir desde la entrada seleccionada hacia la salida. 
El funcionamiento de estos dispositivos está basado en circuitos con **compuertas lógicas** que se conectan de manera tal que todas las entradas salen por la misma salida, pero para ellos debe seleccionarse la entrada que enviará los datos hacia la salida.

### 1.1 Multiplexor 2 a 1:

![Mux2_1](https://upload.wikimedia.org/wikipedia/commons/3/39/Multiplexer_2-to-1.svg)
+ $A=I_1$
+ $B=I_2$
+ $Z=O_1$
+ $S_0=SEL$

#### Tabla de verdad:

|$O_1$|$SEL$|
|:-:|:-:|
|$I_1$|$0$|
|$I_2$|$1$|

De acuerdo a lo anterior, entendemos que el selector de nuestro multiplexor 2 a 1, únicamente tiene opción de esocger entre la salida $I_1$ o $I_2$ dependiendo si esté se encuentra con un $1$ o $0$ lógico. 

Por otro lado, la cantidad de bits de cada una de nuestras entradas es irrelevante. Únicamente se debe de considerar que la misma cantidad de bits que entran, son los que salen. 

## Fórmulas importantes:
$$
\begin{gather*}
2^{num\;bits}-1=Máximo\;número\;para\;contar \\
2^{num\;bits}=Combinaciones
\end{gather*}
$$

|$2^{num\;bits}$|$Combinaciones$|
|:----:|:---------:|
|$2^2$|$4$|
|$2^3$|$8$|
|$2^4$|$16$|
|$2^5$|$32$|
|$2^6$|$64$|

+ Para saber el número máximo al que podemos contar. restamos -1 al número de combinaciones.
+ El número de entradas del mux nos dice el número de combinaciones.

## Fórmula condicional:
$$
\begin{gather*}
output = condition\;?\;true\;:\;false 
\end{gather*}
$$

## 1.1.1 Código en Verilog

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


### 1.2 Multiplexor 4 a 1:

![Mux4_1](https://allaboutfpga.com/wp-content/uploads/2016/01/multiplexer-4-to-1.png)

+ $A=I_1$
+ $B=I_2$
+ $C=I_3$
+ $D=I_4$
+ $Z=O_1$
+ $S_1=S_1$
+ $S_2=S_2$

## Fórmulas:
$$
\begin{gather*}
4\;entradas=4\;combinaciones \\
2^{n}=4 \therefore n=2\;bits \\
2^{n}=4\;entradas\;de\;datos \therefore n=2\;entradas\;de\;selección
\end{gather*}
$$
## Tabla de verdad:

| |$S_1$|$S_2$|$O_1$|
|:-:|:-:|:-:|:-:|
|$0$|$0$|$0$|$I_1$|
|$1$|$0$|$1$|$I_2$|
|$2$|$1$|$0$|$I_3$|
|$3$|$1$|$1$|$I_1$|

## 1.2.1 Código en Verilog

#### Primera opción:

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

#### Segunda opción:

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

#### Tercera opción:

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



## 2. LUT: Look Up Table. Tablas de verdad

La tabla de verdad es un instrumentos utilizado para la simplificación de circuitos digitales a través de su ecuación booleana. 

Existen diferentes formas de programar una tabla de verdad en _verilog_, como se muestra a continuación.

Tomando en cuenta el siguiente ejemplo: 

![[img 1.jpeg]]

#### 2.1 Códigos en Verilog:

#### Primera opción: Ecuación booleanda directa:

```verilog
module lut1(
	input A,
	input B,
	input C,
	input D,
	output x
);

	assign x=(~A & B & ~C) | (A & B & ~C) | (B & ~C & D);

endmodule
```

#### Segunda opción: Tomando como base su diagrama y múltiples assign

```verilog
module lut2_1(
	input A,
	input B,
	input C,
	input D,
	output x
);

	wire c1;
	wire c2;
	wire c3;
	
	assign c1 = ~A & B & ~C;
	assign c2 = A & B & ~C;
	assign c3 = B & ~C & D;
	assign x = c1 | c2 | c3;

	// Working with primitives
	//and(c1,~A,B);
	//and(c2,c1,~C);
	//and(c3,A,B);
	//and(c4,c3,~C);
	//and(c5,B,~C);
	//and(c6,c5,D);
	//or(y,c2,c4,c6);


endmodule
```

#### Tercera opción: Sentencia if-else conociendo su tabla de verdad

```verilog
	module lut3(
	input A,
	input B,
	input C,
	input D,
	output reg x
);

	always @(A,B,C,D)
	begin
		if((A & ~B & ~C & ~D) | (A & B & C & ~D) | (A & B & ~C & D) | (A & B & C & D))
			x=1;
		else
			x=0;
	end

endmodule
```


#### 2.2 TestBench:

```verilog
`timescale 1ns / 100 ps
`include "lut1.v"
`include "lut2.v"
`include "lut3.v"

module lut_tb();
	// Definición de señales de entrada y salida
	reg A;
	reg B;
	reg C;
	reg D;
	
	wire X;
	
	// Instanciacion del modulo
	//lut1 dut(.A(A), .B(B), .C(C), .D(D), .X(X));
	//lut2 dut(.A(A), .B(B), .C(C), .D(D), .X(X));
	lut3 dut(.A(A), .B(B), .C(C), .D(D), .X(X));
	
	// Variables para archivo y ciclo for
	integer write_data;
	integer i;
	
	initial begin
		// Configuracion de archivos de salida
		write_data = $fopen("lut_tb_output.txt","w");
		$dumpfile("lut_tb.vcd"); //guarda lo que compila
		$dumpvars(0,lut_tb); //selecciona variable que salen
		
		//b - binario, 4 - 4 bits, 0 - asigna ceros a los 4 bits
		//{A,B,C,D} = 4'd0; #20;
		//{A,B,C,D} = 4'd1; #20;
		//{A,B,C,D} = 4'd2; #20;
		//{A,B,C,D} = 4'd3; #20;
		//{A,B,C,D} = 4'd4; #20;
		//{A,B,C,D} = 4'd5; #20;
		//{A,B,C,D} = 4'd6; #20;
		//{A,B,C,D} = 4'd7; #20;
		//{A,B,C,D} = 4'd8; #20;
		//{A,B,C,D} = 4'd9; #20;
		//{A,B,C,D} = 4'd10; #20;
		//{A,B,C,D} = 4'd11; #20;
		//{A,B,C,D} = 4'd12; #20;
		//{A,B,C,D} = 4'd13; #20;
		//{A,B,C,D} = 4'd14; #20;
		//{A,B,C,D} = 4'd15; #20;
		
		for (i = 0; i < 16; i++) begin
		{A,B,C,D} = i; #20;
		$fdisplay(write_data,"Entradas = %b, X = %7b", i, X);
		end
		
		$fclose(write_data);
		// A = 0; B = 0; C = 0; D = 0;
		// #20;
		
		$display("Test completed");
	end

endmodule;
```


## 3. Codificadores:

Los codificadores son circuitos integrados digitales que se utilizan para generar un código binario digital para cada entrada. 
Un codificador generalmente consta de un pin de habilitación que generalmente se establece en alto para indicar el funcionamiento.
Tienen dos tipos de entradas: de control y de datos. Las entradas de datos son las que componen el códigp a 'traducir'. Las entradas de control por su parte pueden ser de selección, las cuañes se emplean en la codificación, y de habilitación, que existen en muchos tipos de integrados, y se encargan de permitir o no el proceso de trabajo. 

Estan compuestos por: 
$$
\begin{gather*}
2^{n\;entradas} = n\; salidas
\end{gather*}
$$
En los codificadores, sólo una de las entradas puede estar activa. El código de salida indica qué entrada es la que está activa.

### 4. Decodificador para display de 7 segmentos

#### 4.1 Códigos en Verilog:

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

#### 4.2 TestBench:

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
		
		// d - decimal, 4 - 4 bits, 0 - asigna ceros a los 4 bits
		// binary = 4'd0; #20;
		// binary = 4'd1; #20;
		// binary = 4'd2; #20;
		// binary = 4'd3; #20;
		// binary = 4'd4; #20;
		// binary = 4'd5; #20;
		// binary = 4'd6; #20;
		// binary = 4'd7; #20;
		// binary = 4'd8; #20;
		// binary = 4'd9; #20;
		// binary = 4'd10; #20;
		// binary = 4'd11; #20;
		// binary = 4'd12; #20;
		// binary = 4'd13; #20;
		// binary = 4'd14; #20;
		// binary = 4'd15; #20;
		
		for (i = 0; i < 16; i++) begin
		binary = i; #20
		$fdisplay(write_data,"Binary = %4b, Leds = %7b", binary, leds);
		end
	
		$fclose(write_data);
		
		//binary = 4'd0;
		//#20;
		
		$display("Test completed");
	end

endmodule;
```


## 5. Flip-Flops:

_¿Qué son?:_
Circuitos con dos estados estables que se pueden utilizar para almacenar datos binarios. Los datos almacenados se pueden cambiar aplicando diferentes entradas.

### SR Flip Flop:

En este diagrama la salida se cambia (es decir, los datos almacendos se cambian) solo cuando da una señal de reloj activa. De lo contrario, incluso si _S_ o _R_ están activos, los datos no cambiarán. 

![SR](https://www.electronicsforu.com/wp-contents/uploads/2017/08/SR-flip-flop.png)

+ Set input (_S_)
+ Reset input (_R_)

 En este sistema, cuando configura _S_ como activo, la salida _Q_ sería alta y _Q'_ sería baja. Una vez que se establecen las salidas, el cableado del circuito se mantiene hasta que _S_ o _R_ suban, o se apague la alimentación.

#### Tabla de verdad SR:

|Modo de operación|clk|_S_|_R_|_Q_|_Q'_|
|:--------:|:-:|:-:|:-:|:-:|:-:|
|Mismo estado|x|0|0|x|x|
|Reset|↑|0|1|0|1|
|Set|↑|1|0|1|0|
|Condición no válida|↑|1|1|NC|NC|

![SR](http://circuitossecuenciales.weebly.com/uploads/2/3/7/6/23768053/1612763_orig.png)


### JK Flip Flop:

El flip-flop JK es una mejora del flip-flop SR donde $S=R=1$.
![JK](https://www.electronicsforu.com/wp-contents/uploads/2017/08/JK-Flip-Flop-756x420.png)

![JK](https://grdp.co/cdn-cgi/image/width=500,height=500,quality=50,f=auto/https://gs-post-images.grdp.co/2022/7/jk-flip-flop-img1657880657870-71.png-rs-high-webp.png)

La condición de entrada de $J=K=1$ da una salida que invierte el estado de salida.
Si las entradas de datos _J_ y _K_ son diferentes (es decir, alta y baja), entonces la salida _Q_ toma el valor de _J_ en el siguiente borde del reloj. Si tanto _J_ como _K_ son bajos, entonces no ocurre ningún cambio. Si _J_ como _K_ están altos en el borde del reloj, la salida cambiará de un estado a otro. 
Puede funcionar como _Set_ o _Reset_ Flip-Flops.

#### Tabla de verdad JK:

|_J_|_K_|_Q_|_Q'_|State|
|:-:|:-:|:-:|:-:|:-:|
|0|0|0|0|Hold|
|0|0|1|1|Hold|
|0|1|0|0|Reset|
|0|1|1|0|Reset|
|1|0|0|1|Set|
|1|0|1|1|Set|
|1|1|0|1|Toggel|
|1|1|1|0|Toggel|


### D Flip Flop:

La salida solo se puede cambiar en el borde del reloj, y si la entrada cambia en otros momentos, la salida no se verá afectada.

![[Captura de Pantalla 2023-07-03 a la(s) 12.44.27.png]]

Su función es dejar pasar lo que entra por D, a la salida Q, después de un pulso del reloj.

#### Tabla de verdad D:

|_clk_|_D_|_Q_|_Q'_|
|:-:|:-:|:-:|:-:|
|0|0|NC|NC|
|0|1|NC|NC|
|1|0|0|1|
|1|1|1|0|


### T Flip Flop:

El flip-flop T es como un flip-flop JK. Estas son básicamente versiones de una sola entrada. Esta forma modificada se obtiene conectando las entradas J y K juntas. Solo tiene una entrada junto con la entrada del reloj.

![T](https://www.electronicsforu.com/wp-contents/uploads/2019/04/t-flip-flop-1-500x266.jpg)

#### Tabla de verdad D:

|_T_|_Q_|_Q'_|
|:-:|:-:|:-:|
|0|0|0|
|1|0|1|
|0|1|1|
|1|1|0|

![T](http://circuitossecuenciales.weebly.com/uploads/2/3/7/6/23768053/2276899_orig.png)



