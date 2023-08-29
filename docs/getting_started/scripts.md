# Scripts

## 1. Automatizar Icarus Verilog

Considere que se tienen dos archivos, uno llamado `mymodule.v`, el cual contiene un diseño en Verilog y otro llamado `mymodule_tb.v`, el cual se utiliza para simular el diseño. El flujo de trabajo en [Icarus Verilog](https://bleyer.org/icarus/) consiste en los siguientes pasos:

1. Editar el módulo principal o el archivo de simulación.
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
5. Insertar todas las señales necesarios en la simulación y analizar su comportamiento.

El problema con la metodología anterior es que se necesitan realizar muchos pasos cada vez que se hace una pequeña modificación a los archivos `.v`. 

Una manera para solventar esta problemática es guardar la simulación generada en GTKWave con la extensión `.gtkw`, después abrirla y recargar el archivo `.vcd`. No obstante aún es necesario compilar y ejecutar nuevamente el código cada vez que se realice un cambio.

Para que este proceso repetitivo sea más sencillo se puede utilizar un script escrito en bash para reducir todo este proceso a una sola línea de comando. En la siguiente tabla se muestran los scripts para cada sistema operativo:

<figure markdown>
  <figcaption> <b>Tabla 1.</b> Scripts para automatizar compilación, ejecución y visualizador para Icarus Verilog y GTKWave escrito en lenguaje bash.</figcaption>


| Plataforma  |                            Enlace                            | Probada |
| ----------- | :----------------------------------------------------------: | :-----: |
| **Windows** | [simu_wind.sh](https://github.com/cirofabianbermudez/curso_fpga/blob/main/codes/00_bash_scripts/simu_wind.sh) |    ✓    |
| **Linux**   | [simu_linux.sh](https://github.com/cirofabianbermudez/curso_fpga/blob/main/codes/00_bash_scripts/simu_linux.sh) |    ✓    |
| **Mac**     | [simu_mac.sh](https://github.com/cirofabianbermudez/curso_fpga/blob/main/codes/00_bash_scripts/simu_mac.sh) |    ✓    |

</figure>


## 2. Consideraciones por sistema operativo

###  2.1. Windows

Para utilizarlo en Windows es necesario tener instalado [Git Bash](https://git-scm.com/downloads), este programa además de permitirnos utilizar el control de versiones de Git incluye una terminal que deja al usuario ejecutar algunos comandos Linux dentro de Windows.

Comandos:
``` plain linenums="1"
./simu_wind.sh mymodule_tb
./simu_wind.sh mymodule_tb -v
```

### 2.1. Linux
La primera vez puede requerir cambiar los permisos de ejecución del archivo con el comando:
``` plain linenums="1"
chmod +x simu_linux.sh
```
Comandos:
``` plain linenums="1"
./simu_linux.sh mymodule_tb
./simu_linux.sh mymodule_tb -v
```

### 2.3. Mac
Comandos:
``` plain linenums="1"
source simu_mac.sh mymodule_tb
source simu_mac.sh mymodule_tb -v
```

## 2. Ejemplo de uso del script

Para compilar y ejecutar el testbench y  abrir el visualizador de onda se utiliza el siguiente comando:
``` plain linenums="1"
./simu_wind.sh mymodule_tb
```
no se requiere especificar la extensión.

Una vez ejecutado el comando se desplegará una consola de Git Bash con la siguiente información:
``` plain linenums="1"
1. Compiling verilog code...
2. Runing simulation...
VCD info: dumpfile mymodule_tb.vcd opened for output.
Test completed
mymodule_tb.v:46: $finish called at xxxx (xxps)
3. Opening wave viewer..
It took 0.223 seconds.
Press enter to continue
```

### 2.1. Uso de banderas

Para solo compilar se le añade al comando la bandera `-c` de la siguiente manera:
``` plain linenums="1"
./simu_wind.sh mymodule_tb -c
```

Para solo ejecutar el archivo compilado se le añade al comando la bandera `-r` de la siguiente manera:
``` plain linenums="1"
./simu_wind.sh mymodule_tb -r
```

Se pueden combinar las banderas para hacer dos cosas al mismo tiempo de la siguiente manera:
``` plain linenums="1"
./simu_wind.sh mymodule_tb -c -r
```

Para solo abrir el visualizador de forma de onda se le añade al comando la bandera `-v` de la siguiente manera:
``` plain linenums="1"
./simu_wind.sh mymodule_tb -v
```

### 2.2. Manejo de errores
Si se ingresa una bandera equivocada al programa, no se ingresa el nombre del archivo o el archivo no existe se desplegará un mensaje de error como el siguiente:
``` plain linenums="1"
You must specify the file name.
Use: simu_wind.sh <file> [options]
Options:
  none: Compile, simulate and open viewer.
    -c: Just compile code.
    -r: Just run simulation.
    -v: Just open wave viewer.
It is possible to use more than one option at the same time.
Press enter to continue
```

## 3. Referencias

[^1]:  “Bash Scripting Tutorial – Linux Shell Script and Command Line for Beginners”, freeCodeCamp.org, el 20 de marzo de 2023.<https://www.freecodecamp.org/news/bash-scripting-tutorial-linux-shell-script-and-command-line-for-beginners/> (consultado el 05 de agosto de 2023).

