
1. Se debe crear un programa principal _'sample.v'_ donde escribimos el código que define nuestro circuito a simular.
2. Creamos un programa _TestBench_ _'sample_tb.v'_ que nos permitirá probrar el programa principal con algunos valores dados como entradas, para generar un gráfico con el que podremos analizar la salida esperada.
3. Para compilar y ejecutar debemos seguir los siguientes pasos:

* Compilamos usando el comando: 
```terminal
iverilog -o muestra_tb.vvp muestra_tb.v
```

* Ejecutamos el código usando: 
```terminal
vvp muestra_tb.vvp
```

* Para abrir la aplicación _gtkwave_ podemos ir directamente a nuestra aplicaciones y ejecutar el programa o podemos escribir en la terminal:
```terminal
open -a gtkwave
```

* Ya en el programa, presionamos ```cmd + T``` para abrir un nuevo Tab y seleccionamos en archivo ```.vcd``` creado.
* Cuando ya aparece en _gtkwave_ seleccionaos nuestro archivo, para posteriormente seleccionar las señales de entrada y salida en una pestaña inferior e insertarlas.

### Ejemplo con LUT1:

1. Archivo _LUT1.v_:
```verilog
module LUT1(
	input A,
	input B,
	input C,
	input D,
	output x
);

	assign x=(~A & B & ~C) | (A & B & ~C) | (B & ~C & D);

endmodule
```

2. Archivo _LUT1_tb.v_:
```verilog
//Test Bench: Estimulos combinacionales.
`timescale 1ns / 100 ps
`include "LUT1.v"

module LUT1_tb();
	reg A;
	reg B;
	reg C;
	reg D;
	wire x;
	  
	LUT1 DUT(.A(A), .B(B), .C(C), .D(D), .x(x));
	
	initial begin
		$dumpfile("LUT1_tb.vcd"); //guarda lo que compila
		$dumpvars(0,LUT1_tb); //selecciona variable que salen
		{A,B,C,D} = 4'b0000; #20; //b - binario, 4 - 4 bits, 0 - asigna ceros a los 4 bits
		{A,B,C,D} = 4'b0001; #20;
		{A,B,C,D} = 4'b0010; #20;
		{A,B,C,D} = 4'b0011; #20;
		{A,B,C,D} = 4'b0100; #20;
		{A,B,C,D} = 4'b0101; #20;
		{A,B,C,D} = 4'd6; #20;
		{A,B,C,D} = 4'd7; #20;
		{A,B,C,D} = 4'd8; #20;
		{A,B,C,D} = 4'd9; #20;
		{A,B,C,D} = 4'd10; #20;
		{A,B,C,D} = 4'd11; #20;
		{A,B,C,D} = 4'd12; #20;
		{A,B,C,D} = 4'd13; #20;
		{A,B,C,D} = 4'd14; #20;
		{A,B,C,D} = 4'd15; #20;     // 15 parametros de entrada para mediciones
		
		//A = 0; B = 0; C = 0; D = 0;
		//#20;
		
		$display("Test completed");
	
	end

endmodule;
```

3. Abriendo una terminal directamente en _Visual Studio Code_:
![[Captura de Pantalla 2023-06-28 a la(s) 12.27.33.png]]