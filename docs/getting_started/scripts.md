# Scripts

## 1. Automatizar Icarus Verilog

Considere que se tiene un archivo llamado `mymodule.v` el cual contiene un diseño en Verilog y su respectivo archivo de simulación `mymodule_tb.v`. El flujo de trabajo en [Icarus Verilog](https://bleyer.org/icarus/) consiste en los siguientes pasos:

1. Editar el módulo principal y el archivo de simulación.
2. Compilar el código con el comando:
``` plain linenums="1"
iverilog -o mymodule_tb.vvp mymodule_tb.v
```
3. Ejecutar el código compilado con el comando:
``` plain linenums="1"
vvp mymodule.vvp
```
4. Abrir GTKWave con el comando:
``` plain linenums="1"
start gtkwave mymodule.vcd
```
5. Insertar todas las señales de la simulación y  analizar su comportamiento.

El problema con la metodología anterior es que se necesitan realizar muchos pasos cada vez que se haga una pequeña modificación a los archivos `.v`. 

Una manera para solventar esta problemática es guardar la simulación generada en GTKWave con la extensión `.gtkw`, después abrirla y recargar el archivo `.vcd`. No obstante aún es necesario compilar y ejecutar nuevamente el código cada vez que se realice un cambio.

Para que este proceso repetitivo sea más sencillo:

<figure markdown>
  <figcaption> <b>Tabla 1.</b> Scripts para automatizar compilación, ejecución y visualizador para Icarus Verilog y GTKWave escrito en lenguaje bash.</figcaption>


| Plataforma  |                            Enlace                            | Probada |
| ----------- | :----------------------------------------------------------: | :-----: |
| **Windows** | [simu_wind.sh](https://github.com/cirofabianbermudez/curso_fpga/blob/main/codes/00_bash_scripts/simu_wind.sh) |    ✓    |
| **Linux**   | [simu_linux.sh](https://github.com/cirofabianbermudez/curso_fpga/blob/main/codes/00_bash_scripts/simu_linux.sh) |         |
| **Mac**     | [simu_mac.sh](https://github.com/cirofabianbermudez/curso_fpga/blob/main/codes/00_bash_scripts/simu_mac.sh) |    ✓    |

</figure>



## 2. Uso de script