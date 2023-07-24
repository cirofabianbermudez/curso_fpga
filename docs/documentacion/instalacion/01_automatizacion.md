# 01. Scripts

## Instalación
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

### links utiles
- Uso de `$dumpvars` en el [enlace](https://www.referencedesigner.com/tutorials/verilog/verilog_62.php#:~:text=The%20simplest%20way%20to%20use%20it%20is%20without%20any%20argument.&text=%24dumpvars(0%2C%20toptestbench_module),instantiated%20by%20this%20top%20module.)
- Cómo instalar las herramientas Icarus y GTKwave, [video](https://www.youtube.com/watch?v=3Xm6fgKAO94&list=PLTFN8e-Y3kpEhLKNox-tRNJ9eNFxZopA.0)
- Ejemplo de como utilizar Icarus y GTKwave, [video](https://www.youtube.com/watch?v=-EKjm7G4HcI)
- Articulo de cómo instalar en macOS, [enlace](https://saiankit.medium.com/how-to-simulate-verilog-models-on-macos-5a6f821b2c4f)