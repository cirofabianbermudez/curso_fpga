# Getting started

## 1. Introducción

### 1.1. ¿Qué es Verilog?

[Verilog](https://www.verilog.com/) es un lenguaje de descripción de hardware o HDL (Hardware Description Language) que es utilizado para describir sistemas digitales como una memoria, un sumador, una ALU, un controlador o un microprocesador. Permite a los diseñadores diseñar a varios niveles de abstracción. Es el HDL más utilizado y cuenta con una comunidad de usuarios de más de 50.000 diseñadores activos.

### 1.2. Plataformas
Existen diversas plataformas para trabajar con Verilog, entre las más populares se encuentran:

- [Aldec-HDL Student Edition](https://www.aldec.com/en/products/fpga_simulation/active_hdl_student)
- [Vivado ML Edition](https://www.xilinx.com/products/design-tools/vivado/vivado-ml.html)
- [Intel Quartus Prime Lite Edition](https://www.intel.la/content/www/xl/es/products/details/fpga/development-tools/quartus-prime/resource.html)
- [Icarus Verilog](https://bleyer.org/icarus/)

sin embargo, a pesar de que todas estas opciones cuentan con sus versiones gratuitas, no todas están disponibles en todos los sistemas operativos, en la siguiente tabla se muestran las diferentes compatibilidades:

<figure markdown>
  <figcaption> <b>Tabla 1.</b> Compabilidad en diferentes sistemas operativos.</figcaption>

| Software                                                     | Linux | Windows | Mac  |
| ------------------------------------------------------------ | :---: | :-----: | :--: |
| [Aldec-HDL Student Edition](https://www.aldec.com/en/products/fpga_simulation/active_hdl_student) |       |    ✓    |      |
| [Vivado ML Edition](https://www.xilinx.com/products/design-tools/vivado/vivado-ml.html) |   ✓   |    ✓    |      |
| [Intel Quartus Prime Lite Edition](https://www.intel.la/content/www/xl/es/products/details/fpga/development-tools/quartus-prime/resource.html) |   ✓   |    ✓    |      |
| [Icarus Verilog](https://bleyer.org/icarus/)                 |   ✓   |    ✓    |  ✓   |

</figure>

por lo anterior, es buena idea comenzar a trabajar con Verilog utilizando [Icarus Verilog](https://bleyer.org/icarus/), el cual es un compilador libre ([open source](https://www.redhat.com/en/topics/open-source/what-is-open-source)) para el lenguaje de descripción de hardware [IEEE-1364-2005](https://ieeexplore.ieee.org/document/1620780) Verilog.

A diferencia de las otras opciones los cuales cuentan con GUI (Graphical User Interface) y programas adicionales, [Icarus Verilog](https://bleyer.org/icarus/) funciona desde terminal y solo cuenta con herramientas necesarias para analizar, compilar y simular el código Verilog.

Las principales ventajas que cuenta esta herramienta sobre las otras son: 

1. Es muy ligera y fácil de instalar.
2. Es compatible con Linux, Windows y Mac.
3. Su compilador es rápido, muy robusto y estricto.

El instalador del programa pesa aproximadamente 20MB y el programa instalado en disco utiliza 80MB. A diferencia de [Aldec-HDL Student Edition](https://www.aldec.com/en/products/fpga_simulation/active_hdl_student) el cual es muy permisivo con los errores en el código, [Icarus Verilog](https://bleyer.org/icarus/) es muy estricto, lo que se traduce en un código que tienes mayores posibilidades de ser sintetizado sin inconvenientes. 

La ventaja de instalar [Vivado ML Edition](https://www.xilinx.com/products/design-tools/vivado/vivado-ml.html) o [Intel Quartus Prime Lite Edition](https://www.intel.la/content/www/xl/es/products/details/fpga/development-tools/quartus-prime/resource.html) es que cuentan con todas las herramientas necesarias para llevar a cabo de manera completa el flujo de diseño en FPGA. En el siguiente diagrama se muestra el flujo de diseño en FPGA[^1]:

``` mermaid
%%{ 
  init : { 
    "theme" : "default", 
    "flowchart" : { 
      "curve" : 
    }
  }
}%%
graph LR
  A[Especificaciones] --> B[HDL];
  B --> C[Síntesis];
  C --> D[Place and Route];
  D --> E[Verificación del circuito];
  B -.-> F[Simulación];
  D -.-> G[Análisis de tiempo estático];
```
Una de las estrategias más comunes al trabajar con Verilog es primero compilar y simular el código en [Icarus Verilog](https://bleyer.org/icarus/) y una vez probado pasar a [Vivado ML Edition](https://www.xilinx.com/products/design-tools/vivado/vivado-ml.html) o [Intel Quartus Prime Lite Edition](https://www.intel.la/content/www/xl/es/products/details/fpga/development-tools/quartus-prime/resource.html) para realizar la síntesis, el place and route y generar el archivo de programación para la FPGA. La ventaja de hacerlo de esta manera es que la compilación y la simulación es más rápida en [Icarus Verilog](https://bleyer.org/icarus/), lo que se traduce en un ahorro en el tiempo de diseño.

## 2. Instalación

### 2.1. Icarus Verilog

#### 2.1.1. Windows

La manera recomendada para realizar la instalación en Windows es utilizando [Scoop](https://scoop.sh/), un instalador de línea de comandos diseñado específicamente para Windows. A continuación se muestran los pasos para instalar [Scoop](https://scoop.sh/) e [Icarus Verilog](https://bleyer.org/icarus/).

???+ note "Nota"
    Se sugiere visitar la página oficial de Scoop para verificar si ha habido cambios en los comandos de instalación. La información fue revisada por última vez el 29/07/2023.
    
???+ note "Note"
    Si se instala [Icarus Verilog](https://bleyer.org/icarus/) de manera manual es necesario agregar la carpeta de instalación al `PATH`.

1. Abrir una terminal de [PowerShell](https://learn.microsoft.com/es-mx/powershell/)  o Windows PowerShell y ejecutar las siguientes dos lineas de comando para instalar [Scoop](https://scoop.sh/) :
``` plain linenums="1"
Set-ExecutionPolicy RemoteSigned -Scope CurrentUse
irm get.scoop.sh | iex
```
2.  Una vez instalado, ejecutar el comando siguiente comando para verificar que la instalación fue exitosa:
``` plain linenums="1"
scoop --version
```
3. Ejecutar el siguiente comando para instalar [Icarus Verilog](https://bleyer.org/icarus/):
``` plain linenums="1"
scoop install iverilog
```
4. Verificar que la instalación fue exitosa ejecutando los siguientes comandos:
``` plain linenums="1"
scoop list
iverilog
```
5. En Windows, al instalar [Icarus Verilog](https://bleyer.org/icarus/) se incluye preinstalado el visor de formas de ondas [GTKWave](https://gtkwave.sourceforge.net/), para verificar que funciona correctamente, ejecuta el siguiente comando:
``` plain linenums="1"
gtkwave --version
gtkwave
```

#### 2.1.2. Linux
Para sistemas operativos Linux basados en Debian/Ubuntu la instalación es muy sencilla. Seguir los siguientes pasos:

1. Abrir una terminal  y ejecutar el siguiente comando:
``` plain linenums="1"
sudo apt install iverilog gtkwave
```
2. Verificar que la instalación fue exitosa ejecutando los siguientes comandos:
``` plain linenums="1"
iverilog
gtkwave --version
gtkwave
```

#### 2.1.3. Mac




- - Para windows  `scoop install iverilog`
  - Para macOS  `brew install icarus-verilog`
- Instalar un visualizador de forma de onda para verilog. [GTKwave](https://gtkwave.sourceforge.net/) es una muy buena opción.
  - Para Windows ya vienen preinstalado con Icarus.
  - Para macOS basta con entrar al siguiente [enlace](https://sourceforge.net/projects/gtkwave/files/latest/download) e instalar.
- Crear los códigos  `circuit.v` y su archivo de simulación `circuit_tb.v`
- En el archivo de simulación es necesario incluir:



## 3. Primer programa



``` verilog linenums="1"
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






https://gitlab.com/jjchico/verilog-course.v/-/tree/master/verilog?ref_type=heads



- Uso de `$dumpvars` en el [enlace](https://www.referencedesigner.com/tutorials/verilog/verilog_62.php#:~:text=The%20simplest%20way%20to%20use%20it%20is%20without%20any%20argument.&text=%24dumpvars(0%2C%20toptestbench_module),instantiated%20by%20this%20top%20module.)
- Cómo instalar las herramientas Icarus y GTKwave, [video](https://www.youtube.com/watch?v=3Xm6fgKAO94&list=PLTFN8e-Y3kpEhLKNox-tRNJ9eNFxZopA.0)
- Ejemplo de como utilizar Icarus y GTKwave, [video](https://www.youtube.com/watch?v=-EKjm7G4HcI)
- Articulo de cómo instalar en macOS, [enlace](https://saiankit.medium.com/how-to-simulate-verilog-models-on-macos-5a6f821b2c4f)
- Pagina de verilog, [enlace](https://www.verilog.com/)
- Market share de fpgas, [enlace](https://www.icdrex.com/lattice-avant-of-mid-range-fpgas-may-be-the-biggest-winner/#:~:text=According%20to%20the%20data%20released,of%20the%20global%20FPGA%20market.)

## 4. Referencias
[^1]:  “FPGA vs. ASIC Design Flow”, Xilinx. <https://www.xilinx.com/video/fpga/fpga-vs-asic-design-flow.html> (consultado el 29 de julio de 2023).