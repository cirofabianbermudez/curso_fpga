Pasos a seguir:
1. Ejecutar A1_filter.m, aquí se encuentra la descripción del problema y la metodología para diseñar un filtro FIR pasa bandas, genera
	- A1_x_values.mat, guarda las señal con ruido, x
	- A1_filter_val.mat, guarda los coeficientes, h1
	- A1_y_output.mat, guarda la señal filtrada, y1
	- A1_all_variables.mat
2. Ejecutar A2_coef_conv.m, este script carga A1_filter_val.mat, y cuantiza los coeficientes del filtro (h1/an), se genera la rom de coeficientes para poder copiarla y pegarla y usarla en verilog, además crea un archivo real_coef.txt donde se guardan los coeficientes cuantizados convertidos a punto flotante, 
3. Ejecutar el archivo A3_noise_signal_export.m, este script carga el archivo A1_x_values.mat, y cuantiza la señal con ruido, guardando un archivo x_values.txt en binario, además, guarda un archivo x_values_real.txt que contienen los valores cuantizados convertidos a punto flotante.
4. Copiar el archivo x_values.txt al workspace de ActiveHDL
5. Ejecutar la simulación por el tiempo indicado, como la señal de ruido tiene 201 muestras, según la descripción del testbench se utiliza la siguiente ecuación para calcular el tiempo de simulación, `run 50 + (340)*iter ns =  run 52310 ns`.
6. Copiar la salida del testbench tb_output.txt al workspace de matlab
7. Ejecutar A4_analisis.m para realizar los calculos de error y la comprobación del diseño.