# Introducción a Verilog

## 1. Comentarios
Los comentarios cortos empizan con `//` y continuan hasta el final de la línea.
Los comentarios largos empiezan con `/*` y terminan con `*/`


<figure markdown>
  <figcaption> <b>Tabla 1.</b>name .</figcaption>

|      |                             |
| ---- | --------------------------- |
| `0`  | valor lógico 0              |
| `1`  | valor lógico 1              |
| `z`  | triestado (alta impedancia) |
| `x`  | valor desconocido           |

</figure>


<figure markdown>
  <figcaption> <b>Tabla 2.</b> name .</figcaption>

|      |                             |
| ---- | --------------------------- |
| `d`  | decimal            |
| `b`  | binary              |
| `h`  | hexadecimal |
| `o`  | octal           |

</figure>


``` plain linenums="1"
[size]'[radix]constant
```

<figure markdown>
  <figcaption> <b>Tabla 3.</b> name .</figcaption>

| Name     | Description	   | Usage	|
| ---- | --------------------------- | ---- |
| and  | $f = (a b)$            | 	|
| nand  | $f = (a b)$              | 	|
| or  | $f = (a b)$ | 	|
| nor  | $f = (a b)$           | 	|
| xor  | $f = (a b)$           | 	|
| xnor  | $f = (a b)$           | 	|
| not  | $f = (a b)$           | 	|
| buf  | $f = (a b)$           | 	|

</figure>