# Verilog Reference

Este es un resumen de fundamentos básicos de Verilog extraído de los libros [^1] [^2] [^3].

## 1. Comentarios
- Los comentarios cortos empiezan con `//` y continúan hasta el final de la línea.
- Los comentarios largos empiezan con `/*` y terminan con `*/`.

## 2. Tipos de datos

### 2.1. Sistema de cuatro valores
En la mayoría de los tipos de datos se utilizan cuatro valores básicos:
<figure markdown>
  <figcaption> <b>Tabla 1.</b> Conjunto de valores .</figcaption>

|  Valor    |    Descripción        |
| ---- | -------------------------- |
| 0  | valor lógico 0               |
| 1  | valor lógico 1               |
| z  | triestado (alta impedancia)  |
| x  | valor desconocido            |

</figure>

### 2.2. Grupos de tipos de datos

Verilog tiene dos grupos principales de tipos de datos: `net` y `variable`. 

- Grupo `net`
:    Los tipos de datos del grupo de `net` representan las conexiones físicas entre componentes de hardware. Se utilizan como salidas de asignaciones continuas (_continuous assignments_) y como señales de conexión entre distintos módulos. El tipo de datos más utilizado en este grupo es `wire`. Como su nombre indica, representa un cable de conexión.
El tipo de datos `wire` representa una señal de 1 bit, como:
``` verilog linenums="1"
wire po, p1; // dos señales de 1 bit
```
Cuando una colección de señales se agrupa en un bus, podemos representarla mediante una arreglo unidimensional (vector), como:
``` verilog linenums="1"
wire [7:0]  datal, data2; // bus de 8 bits
wire [31:0] addr;         // direccion de 32 bits
```
A veces se necesita una matriz bidimensional para representar una memoria. Por ejemplo, una memoria de 32 por 4 (es decir, una memoria tiene 32 palabras y cada palabra tiene 4 bits de ancho) puede representarse como:
``` verilog linenums="1"
wire [3:0] mem1 [31:0];   // memoria de 32 por 4
```
- Grupo `variable`
:    Los tipos de datos del grupo `variable` representan el almacenamiento abstracto en el modelado de comportamiento (_behavioral modeling_) y se utilizan en las salidas de las asignaciones de procedimiento (_procedural assignments_). Hay cinco tipos de datos en este grupo: `reg`, `integer`, `real`, `time` y `realtime`. El tipo de datos más utilizado en este grupo es `reg` y puede sintetizarse. El circuito inferido puede contener o no componentes físicos de almacenamiento. Los tres últimos tipos de datos sólo pueden utilizarse en modelado y simulación. 

### 2.3. Representación numérica
Una constante entera en Verilog puede representarse en varios formatos. Su forma general es:
``` plain linenums="1"
[sign][size]'[base][value]
```

- El término `[base]` especifica la base del número, que pueden ser los siguientes:

<figure markdown>
  <figcaption> <b>Tabla 2.</b> Diferentes bases .</figcaption>

|  Base    | Descripción |
| ---- | --------------- |
| d  | decimal           |
| b  | binary            |
| h  | hexadecimal       |
| o  | octal             |

</figure>

- El término `[value]` especifica el valor del número en la base correspondiente. Puede incluirse el carácter de guión bajo `_` para mayor claridad.

- El término `[size]` especifica el número de bits de un número. Es opcional. El número se conoce como número dimensionado (_sized number_) cuando existe un término `[size]` y como número no dimensionado en caso contrario. 

**Número con tamaño especificado (Sized number)**
:    Un número con tamaño especificado describe explícitamente el número de bits. Si el tamaño del valor es menor que el término `[size]` especificado, se rellenan ceros delante para extender el número. excepto en varios casos especiales. El valor `z` o `x` se rellena si el MSB del valor es `z` o `x`, y el MSB se rellena si se utiliza el tipo de datos con signo `signed`;

**Número sin tamaño especificado (Unsized number)**
:    Un número sin tamaño  especificado omite el término `[size]`. Su tamaño real depende del ordenador anfitrión, pero debe ser de al menos 32 bits. El término `'[base]` también puede omitirse si el número está en formato decimal. 

Ejemplos:

<figure markdown>
  <figcaption> <b>Tabla 3.</b> Ejemplos de números con tamaño especificado y sin especificar.</figcaption>

| Número     | 	Valor almacenado   | Comentarios	|
| ---- | --------------------------- | ---- |
| 8'b10101010   | 10101010          | 	                |
| 8'b1010_1010  | 10101010          | Se ignora el `_` 	|
| 8'o5          | 00000101            | 	                |
| 8'h5f         | 01011111          |                  	|
| 8'd8          | 00001000          | 	        |
| 8'b0          | 00000000          | 0 extendido    	|
| 8'b1          | 00000001          | 1 extendido    	|
| -8'b00000001  | 11111111      | Complemento 2 de  00000001  |
| 1             | 000...001         | Extendido a 32 bits         	|
| -1             | 111...111        | Extendido a 32 bits         	|

</figure>


## 3. Esqueleto del programa

Como su nombre indica, el HDL se utiliza para describir hardware. Cuando desarrollamos o examinamos un código Verilog, es mucho más fácil de comprender si pensamos en términos de "organización de hardware" en lugar de "algoritmo secuencial". La mayoría de los códigos Verilog siguen un  esqueleto básico que consta de tres partes:

1. Declaración de puertos I/O.
2. Declaración de señales.
3. Cuerpo del módulo.

### 3.1. Declaración de puertos I/O
La declaración de puertos  especifica los modos, tipos de datos y nombres de los puertos I/O del módulo. La sintaxis es:
``` verilog linenums="1"
module [module_name] (
  [mode] [data_type] [port_name],
  [mode] [data_type] [port_name],
  . . .
  [mode] [data_type] [port_name]
);
```

El `[mode]` puede ser `input`, `output` o `inout`, que representan el puerto de entrada, salida o bidireccional, respectivamente. Nótese que no hay coma en la última declaración. El término `[data-type]` puede omitirse si es `wire`. Por ejemplo:

=== "Versión 1"

    ``` verilog linenums="1"
    module mymodule (
      input  wire i1, i1,
      output wire o1
    );
    ```

=== "Versión 2"

    ``` verilog linenums="1"
    module mymodule (
      input  i1, i1,
      output o1
    );
    ```
### 3.2. Cuerpo del programa
A diferencia de un programa en lenguaje C, en el que las sentencias se ejecutan secuencialmente, el cuerpo del programa de un módulo Verilog sintetizable puede considerarse como una colección de partes de circuito. Estas partes se operan en paralelo y se ejecutan concurrentemente. Hay varias maneras de describir una parte:

- Asignación continua (continuous assignment).
- Bloque `always`.
- Instanciación de módulos (module instantiation).

La primera forma de describir una parte de un circuito es mediante una asignación continua. Es útil para circuitos combinacionales simples. Su sintaxis simplificada es
``` verilog linenums="1"
assign [signal_name] = [expression];
```
Cada asignación continua puede considerarse como una parte del circuito. La señal del lado izquierdo es la salida y las señales utilizadas en la expresión del lado derecho son las entradas. La expresión describe la función de este circuito. Por ejemplo, considere la siguiente sentencia:
``` verilog linenums="1"
assign eq = p0 | p1;
```
Es un circuito que realiza la operación or. Cuando `p0` o `p1` cambian de valor, se activa esta sentencia y se evalúa la expresión. El nuevo valor se asigna a `eq` después del retardo de propagación.

La segunda forma de describir una parte del circuito es utilizando un bloque `always`. Dentro del bloque `always` se utilizan asignaciones procedimentales (_procedural assignments_) más abstractas, por lo que puede utilizarse para describir el funcionamiento de circuitos más complejos.

La tercera forma de describir una parte del circuito es mediante la instanciación de módulos. La instanciación crea una instancia de otro módulo y nos permite incorporar módulos prediseñados como subsistemas del módulo actual. 

### 3.3 Declaración de señales

La parte de la declaración especifica las señales internas y los parámetros utilizados en el módulo. Las señales internas pueden considerarse como los cables de interconexión entre las partes del circuito. La sintaxis simplificada de la declaración de señales es:
``` verilog linenums="1"
[data_type] [port_name];
```

**Implicit net**

En Verilog, no es necesario declarar explícitamente un identificador. Si se omite una declaración, se asume que es una red implícita (implicit net). El tipo de dato por defecto es `wire`. Podemos eliminar las declaraciones explícitas. Ver los siguientes códigos que corresponden a un **comparador de 1 bit** en forma implícita y explicita:

=== "Explícito"

    ``` verilog title="eql.v" linenums="1"
    module eql (
      // I/O ports
      input  wire i0, il,
      output wire eq
    );
    
      // signal declaration
      wire p0, pl;
    
      // body
      // product terms
      assign p0 = ~i0 & ~il;
      assign p1 =  i0 &  il;
      // sum of two product terms
      assign eq = p0 | p1;
    
    endmodule
    ```

=== "Implícito"

    ``` verilog title="eql_implicit.v" linenums="1"
    module eql_implicit (
      // I/O ports
      input  i0, il,
      output eq
    );
    
      // no internal signal declaration


      // body
      // product terms must be placed in front
      assign p0 = ~i0 & ~il;  // implicit declaration
      assign p1 =  i0 &  il;  // implicit declaration
      // sum of two product terms
      assign eq = p0 | p1;
    
    endmodule
    ```

Aunque el código es más compacto, puede introducir errores sutiles de identificadores mal escritos. Para mayor claridad y documentación, en recomendable siempre utilizar declaraciones explícitas.

## 4. Descripción estructural

Un sistema digital suele estar compuesto por varios subsistemas más pequeños. Esto nos permite construir un gran sistema a partir de componentes más sencillos o prediseñados. Verilog proporciona un mecanismo, conocido como instanciación de módulos (_module instantiation_), para realizar esta tarea. Este tipo de código se denomina descripción estructural (_structural description_).

Analicemos un **comparador de 2 bits**. Sean las entradas `a` y `b` y la salida `check`. La señal `check` es verdadera cuando ambos bits de `a` y `b` son iguales. Una alternativa al diseño del comparador de 2 bits es utilizar comparadores de 1 bit previamente construidos como bloques de construcción. Dos comparadores de 1 bit se utilizan para comprobar los dos bits individuales y sus resultados se alimentan a una compuerta and. La señal check es verdadera sólo cuando ambos bits son iguales. En los siguientes códigos se muestran la descripción a nivel compuerta y utilizando una descripción estructural.


=== "Estructural"

    ``` verilog title="eq2.v" linenums="1"
    module eq2 (
      input  [1:0] a, b,
      output check
    );
    
      // signal declaration
      wire e0, e1;
    
      // instantiate two 1-bit comparators
      eq1 eq_bit0_unit (.i0(a[0]), .i1(b[0]), .eq(e0));
      eq1 eq_bit1_unit (.i0(a[1]), .i1(b[1]), .eq(e1));
      // a and b are equal if individual bits are equal
      assign check = e0 & e1;
    
    endmodule
    ```

=== "Nivel compuerta"

    ``` verilog title="eq2_sop.v" linenums="1"
    module eq2_sop (
      input  [1:0] a, b,
      output check
    );
    
      // signal declaration
      wire p0, pl, p2, p3;
    
      // product terms
      assign p0 = (~a[1] & ~b[1]) & (~a[0] & ~b[0]);
      assign p1 = (~a[1] & ~b[1]) & ( a[0] &  b[0]);
      assign p2 = ( a[1] &  b[1]) & (~a[0] & ~b[0]);
      assign p3 = ( a[1] &  b[1]) & ( a[0] &  b[0]);
      // sum of two product terms
      assign check = p0 | p1 | p2 | p3;
    
    endmodule
    ```

El código incluye dos sentencias de instanciación de módulos. La sintaxis simplificada de la instanciación de módulos es la siguiente:

``` verilog linenums="1"
[module_name] [instance_name] (
  .[port_name]([signal_name]),
  .[port_name]([signal_name]),
  . . .
  .[port_name]([signal_name])
);
```


### 4.1 Conexión por nombre

La primera parte de la declaración especifica qué componente se utiliza. El término `[module_name]` indica el nombre del módulo y el término `[instance_name]` proporciona un id único para una instancia. La segunda parte es la conexión de puertos, que indica las conexiones entre los puertos I/O de un módulo instanciado (el módulo de nivel inferior) y las señales externas utilizadas en el módulo actual (el módulo de nivel superior). Esta forma de asignación se conoce como conexión por nombre (_connection by name_). El orden de los pares puerto-nombre y señal-nombre no importa.

El mapeo de puertos refleja las conexiones de un diagrama a bloques. La declaración de instanciación del componente representa un circuito encapsulado en una "caja negra" cuya función se define en otro módulo.

Este ejemplo demuestra la estrecha relación que existe entre un diagrama de bloques y el código. El código es esencialmente una descripción textual de un esquema. 

### 4.2 Conexión por nombre conexión por lista ordenada

Un esquema alternativo para asociar los puertos y las señales externas es la conexión por lista ordenada (_connection by ordered list_). En este esquema, los nombres de los puertos del módulo de nivel inferior se omiten y las señales del módulo de nivel superior se enumeran en el mismo orden que la declaración de puertos del módulo de nivel inferior. Con este esquema, las dos declaraciones de instanciación de módulos del comparador de 2 bits pueden reescribirse como:

``` verilog  linenums="1"
eq1 eq_bit0_unit (a[0], b[0], e0);
eq1 eq_bit1_unit (a[1], b[1], e1);
```
Aunque este esquema hace el código más compacto, es propenso a errores, especialmente para un módulo con muchos puertos I/O. Por ejemplo, si modificamos el código del módulo de nivel inferior y cambiamos el orden de dos puertos en la declaración de puertos, también habrá que corregir todos los módulos instanciados. Si esto se hace accidentalmente durante la edición del código, el orden alterado de los puertos puede no detectarse durante la síntesis y dar lugar a errores difíciles de encontrar. 



## 5. Operadores

<figure markdown>
  <figcaption> <b>Tabla 4.</b> Operadores en Verilog.</figcaption>


| Tipo de operación | Símbolo de operador	| Descripción	| Número de operandos	|
| ---- | --------------------------- | ---- | ---- |
| **Aritméticos**    | +                   | Suma                                                      | 2                   |
|                    | -                   | Resta                                                     | 2                   |
|                    | *                   | Multiplicación                                            | 2                   |
|                    | /                   | División                                                  | 2                   |
|                    | %                   | Módulo                                                    | 2                   |
|                    | **                  | Exponenciación                                            | 2                   |
| **Desplazamiento** | >>                  | Desplazamiento lógico a la derecha (llena con ceros)      | 2                   |
|                    | <<                  | Desplazamiento lógico a la izquierda (llena con ceros) | 2	|
|  | >>> | Desplazamiento aritmético a la derecha (mantiene signo) | 2	|
|  | <<< | Desplazamiento aritmético a la izquierda (mantiene signo) | 2	|
| **Relacional** | > | Mayor que | 2	|
|  | < | Menor que | 2	|
|  | >= | Mayor o igual que | 2	|
|  | <= | Menor o igual que | 2	|
| **Igualdad** | == | Igual | 2	|
|  | != | Diferente | 2	|
|  | === | Igualdad de casos | 2	|
|  | !== | Desigualdad de casos | 2	|
| **Bitwise** | ~ | Negación bitwise | 1	|
|  | & | AND bitwise | 2	|
|  | \| | OR bitwise | 2	|
|  | ^ | XOR bitwise | 2	|
| **Reducción** | & | Reducción AND | 1	|
|  | \| | Reducción OR | 1	|
|  | ^ | Reducción XOR | 1	|
| **Lógicos** | ! | Negación lógica | 1	|
|  | && | AND lógica | 2	|
|  | \|\| | OR lógica | 2	|
| **Concatenación** | { } | Concatenación | Cualquier	|
|  | { { } } | Replicación | Cualquier	|
| **Condicional** | ? : | Condicional | 3	|

</figure>


<figure markdown>
  <figcaption> <b>Tabla 5.</b> Precedencia de los operadores .</figcaption>

| Operador                      | Precedencia |
| ----------------------------- | ----------- |
| !    ~    +    -    (unarios) | más alto    |
| **                            |             |
| *    /    %                   |             |
| +    -    (binario)           |             |
| >>    <<    >>>    <<<        |             |
| <    <=    >    >=            |             |
| ==    !=    ===    !==        |             |
| &                             |             |
| ^                             |             |
| \|                            |             |
| &&                            |             |
| \|\|                          |             |
| ?:                            | más bajo    |


</figure>







# Referencias
[^1]: S. D. Brown y Z. G. Vranesic, Fundamentals of digital logic with Verilog design, Third edition. New York: McGraw-Hill Higher Education, 2014.
[^2]: S. Palnitkar, Verilog HDL: A Guide to Digital Design and Synthesis, Prentice-Hall, Inc, 1996.
[^3]: Pong P. Chu, FPGA Prototyping by Verilog Examples Xilinx Spartan-3 Version, Wiley & Sons, Incorporated, John, 2008.