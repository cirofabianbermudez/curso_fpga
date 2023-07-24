# Getting started

## 1. Introducción

Existen diversas maneras para trabajar con Verilog, entre las más populares se encuentran:

- [Aldec-HDL Student Edition](https://www.aldec.com/en/products/fpga_simulation/active_hdl_student)
- [Vivado ML Edition](https://www.xilinx.com/products/design-tools/vivado/vivado-ml.html)
- [Intel Quartus Prime Lite Edition](https://www.intel.la/content/www/xl/es/products/details/fpga/development-tools/quartus-prime/resource.html)
- [Icarus Verilog](https://bleyer.org/icarus/)

sin embargo, a pesar de que todas estas opciones son gratuitas, no están disponibles en todos los sistemas operativos, en la siguiente tabla se muestran las diferentes compatibilidades:


<figure markdown>


  <figcaption> <b>Tabla 1.</b> Compabilidad en diferentes sistemas operativos.</figcaption>

| Software                                                     | Linux | Windows | Mac  |
| ------------------------------------------------------------ | :---: | :-----: | :--: |
| [Aldec-HDL Student Edition](https://www.aldec.com/en/products/fpga_simulation/active_hdl_student) |       |    ✓    |      |
| [Vivado ML Edition](https://www.xilinx.com/products/design-tools/vivado/vivado-ml.html) |   ✓   |    ✓    |      |
| [Intel Quartus Prime Lite Edition](https://www.intel.la/content/www/xl/es/products/details/fpga/development-tools/quartus-prime/resource.html) |   ✓   |    ✓    |      |
| [Icarus Verilog](https://bleyer.org/icarus/)                 |   ✓   |    ✓    |  ✓   |

</figure>

por lo anterior es buena idea comenzar a aprender Verilog utilizando [Icarus Verilog](https://bleyer.org/icarus/), el cual es un compilador libre ([open source](https://www.redhat.com/en/topics/open-source/what-is-open-source)) para el lenguaje de descripción de hardware IEEE-1364 Verilog. A diferencia de las otras opciones los cuales cuentan con GUI y programas adicionales, [Icarus Verilog](https://bleyer.org/icarus/) funciona desde terminal y solo cuenta con herramientas para analizar, compilar y simular el código Verilog, lo cual es más que suficiente. Las principales ventajas que cuenta esta herramienta son: 1) es muy ligera y fácil de instalar, 2) es compatible con diversos sistemas operativos y 3) su compilador es muy robusto, otras herramientas son más permisivas con los errores en el código.

La ventaja de instalar [Vivado ML Edition](https://www.xilinx.com/products/design-tools/vivado/vivado-ml.html) o [Intel Quartus Prime Lite Edition](https://www.intel.la/content/www/xl/es/products/details/fpga/development-tools/quartus-prime/resource.html) es que cuentan con todas las herramientas necesarias para llevar el flujo de diseño en FPGA.

``` mermaid
flowchart LR
  A[Especificaciones] ==> B[HDL];
  B ==> C[Síntesis];
  C ==> D[Place and Route];
  D ==> E[Verificación del circuito];
  B -.-> F[Simulación];
  D -.-> G[Análisis de tiempo estático];
```



## 2. Instalación de herramientas

Para comenzar a trabajar con [Icarus Verilog](https://bleyer.org/icarus/) es necesario instalar los siguientes programas:

- Instalar un compilador de verilog, [Icarus Verilog](https://bleyer.org/icarus/) es el más popular. 
  - Para windows  `scoop install iverilog`
  - Para macOS  `brew install icarus-verilog`
- Instalar un visualizador de forma de onda para verilog. [GTKwave](https://gtkwave.sourceforge.net/) es una muy buena opción.
  - Para Windows ya vienen preinstalado con Icarus.
  - Para macOS basta con entrar al siguiente [enlace](https://sourceforge.net/projects/gtkwave/files/latest/download) e instalar.
- Crear los códigos  `circuit.v` y su archivo de simulación `circuit_tb.v`
- En el archivo de simulación es necesario incluir:

```verilog
`timescale 1ns / 100 ps
`include "circuit.v"

initial begin
  $dumpfile("circuit_tb.vcd");
  $dumpvars(0, circuit_tb);
  
  $display("Test complete");
end
```

- Los comandos a ejecutar son:

```plain
iverilog -o circuit_tb.vvp circuit_tb.v
vvp circuit_tb.vvp
start gtkwave
```


<figure markdown>
  ![Image title](https://dummyimage.com/600x400/){ width="500" }
  <figcaption><b>Figura 1.</b> Nombre de la imagen.</figcaption>
</figure>







!!! note "Note"

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.


### links utiles

- Uso de `$dumpvars` en el [enlace](https://www.referencedesigner.com/tutorials/verilog/verilog_62.php#:~:text=The%20simplest%20way%20to%20use%20it%20is%20without%20any%20argument.&text=%24dumpvars(0%2C%20toptestbench_module),instantiated%20by%20this%20top%20module.)
- Cómo instalar las herramientas Icarus y GTKwave, [video](https://www.youtube.com/watch?v=3Xm6fgKAO94&list=PLTFN8e-Y3kpEhLKNox-tRNJ9eNFxZopA.0)
- Ejemplo de como utilizar Icarus y GTKwave, [video](https://www.youtube.com/watch?v=-EKjm7G4HcI)
- Articulo de cómo instalar en macOS, [enlace](https://saiankit.medium.com/how-to-simulate-verilog-models-on-macos-5a6f821b2c4f)
- Pagina de verilog, [enlace](https://www.verilog.com/)