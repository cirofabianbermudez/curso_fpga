# _¿Qué es un **sumador**?:_

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

```
