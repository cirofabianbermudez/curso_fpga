# Decodificadores

## 1. Códigos

<figure markdown>
  <figcaption> <b>Tabla 1.</b> Tabla de verdad para decodificador de 7 segmentos.</figcaption>
  
|Decimal|$a$|$b$|$c$|$d$|$e$|$f$|$g$|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|0|1|1|1|1|1|1|1|
|1|0|1|1|0|0|0|0|
|2|1|1|0|1|1|0|1|
|3|1|1|1|1|0|0|1|
|4|0|1|1|0|0|1|1|
|5|1|0|1|1|0|1|1|
|6|1|0|1|1|1|1|1|
|7|1|1|1|0|0|0|1|
|8|1|1|1|1|1|1|1|
|9|1|1|1|0|0|1|1|
|A|1|1|1|0|1|1|1|
|B|0|0|1|1|1|1|1|
|C|1|0|0|1|1|1|0|
|D|0|1|1|1|1|0|1|
|E|1|0|0|1|1|1|1|
|F|1|0|0|0|1|1|1|

</figure>

=== "Versión 1"

    ``` verilog title="dec7seg.v" linenums="1"
    --8<-- "codes/01_combinacionales/04_decoder/dec7seg.v:6"
    ```

=== "Versión 2"

    ``` verilog title="dec7seg_v2.v" linenums="1"
    --8<-- "codes/01_combinacionales/04_decoder/dec7seg_v2.v:6"
    ```
    
=== "Versión 3"

    ``` verilog title="dec7seg_v3.v" linenums="1"
    --8<-- "codes/01_combinacionales/04_decoder/dec7seg_v3.v:6"
    ```

## 2. Verificación
``` verilog title="dec7seg_tb.v" linenums="1"
--8<-- "codes/01_combinacionales/04_decoder/dec7seg_tb.v:6"
```