### _¿Qué es una **tabla de verdad**?:_
Se describe como una funcionalidad que el diseñador digital puede programar para conocer la relación que existe entre entradas y salidas de un circuito lógico por medio de su función booleana. La tabla enumera todas las combinaciones posibles y muestra el resultado lógico correspondiente para cada combinación.

##### _Ejemplo:_
Tomando como base el circuito lógico descrito en la Figura 1.0:
![](https://nandland.com/articles/images/boolean-algebra-equation-logic-gates2.png)
_Figura 1.0: Ejemplo de circuito lógico_.

La ecuación booleana que lo describe se puede ver representada de la siguiente manera: 
$$
Q=A*B+A'
$$
Por lo que, tenemos una tabla de verdad de la siguiente forma:

|Entrada $A$|Entrada $B$|Salida $Q$|
|:-------:|:-------:|:------:|
|0|0|1|
|0|1|1|
|1|0|0|
|1|1|1|

Por otro para entender mejor una tabla de verdad podemos desarrollarla de la siguiente forma:

|$A$|$B$|$A'$|$A*B$|$Q=A*B+A'$|
|:-:|:-:|:--:|:--:|:---:|
|0|0|1|0|1|
|0|1|1|0|1|
|1|0|0|0|0|
|1|1|0|1|1|

Donde, entendemos que las columnas $A$ y $B$ representan las entradas, la columna $A'$ representa la negación de la entrada $A$, la columna $A*B$ representa la operación _AND_ entre $A$ y $B$; y la última columna, $Q=A*B+A'$, muestra la salida resultante para cada combinación de entrada. 

### _Implementación en Verilog:_

Para ejemplificar el diseño y simulación de una tabla de verdad en lenguaje de programación Verilog, utilizaremos el ejemplo descrito en la Figura 1.2, y desarrollaremos diferentes módelos de diseño para una única tabla de verdad. 

![](https://cursos.clavijero.edu.mx/cursos/148_ac/modulo2/contenidos/imagenes/tema2.3/10_Ejemplo_diagrama_logico.jpg)
_Figura 1.2: Ejemplo de circuito lógico a diseñar._

Considerando la ecuación booleana completa: 
$$
x=A'BC'+ABC'+BC'D
$$
Desarrollaremos dos propuestas de diseño que nos permiten simular directamente la ecuación booleana obtenida o describiendo las diferentes conexiones que se observan en el diagrama, sin necesidad de tener una tabla de verdad que la describa. 

#### Primera propuesta de diseño para una LUT: Asignación de ecuación booleana:

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

#### Segunda propuesta: Sintaxis condicional describiendo conexiones en el diagrama

```verilog
module lut2(
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

Por otro lado, si tenemos el siguiente ejemplo de tabla de verdad para un circuito digital de 4 entradas y 1 salida, en el cual se definieron estados en alto aleatorios:

|Entrada $D$|Entrada $C$|Entrada $B$|Entrada $A$|Salida $x$|
|:-:|:-:|:-:|:-:|:-:|
|0|0|0|0|0|
|0|0|0|1|1|
|0|0|1|0|0|
|0|0|1|1|0|
|0|1|0|0|0|
|0|1|0|1|0|
|0|1|1|0|0|
|0|1|1|1|1|
|1|0|0|0|0|
|1|0|0|1|0|
|1|0|1|0|0|
|1|0|1|1|1|
|1|1|0|0|0|
|1|1|1|0|0|
|1|1|1|1|1|

Considerando que los casos que nos importan es cuando la salida $x$ se encuentra en alto, tendríamos la siguiente tabla de verdad:

|$D$|$C$|$B$|$A$|$x$|
|:-:|:-:|:-:|:-:|:-:|
|0|0|0|0|1|
|0|1|1|1|1|
|1|0|1|1|1|
|1|1|1|1|1|

Por lo tanto, tendríamos la siguiente sintaxis en Verilog:

#### Tercera propuesta: Sentencia if-else con base a una tabla de verdad dada

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

Para observar el correcto funcionamiento de nuestras propuestas de LUTs utilizaremos el programa _gtkwave_ para simular la respuesta de un TestBench que describa los parametros necesarios de funcionamiento de nuestras LUTs, como se observa en el siguiente bloque de código:

#### TestBench para simulación en gtkwave:

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
		
		for (i = 0; i < 16; i++) begin
		{A,B,C,D} = i; #20;
		$fdisplay(write_data,"Entradas = %b, X = %7b", i, X);
		end
		
		$fclose(write_data);
		$display("Test completed");
	end

endmodule;
```
