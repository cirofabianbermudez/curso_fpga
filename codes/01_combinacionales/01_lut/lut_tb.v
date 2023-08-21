// Author: Guadalupe Alonso Contreras y Ciro Fabian Bermudez Marquez
// Name: lut_tb.v
//
// Description: Testbench estimulos combinacionales.

`timescale 1ns / 100 ps
`include "lut1.v"

module lut_tb();
  // Definición de señales de entrada y salida
  reg A;
  reg B;
  reg C;
  reg D;
  wire F;

  // Instanciacion del modulo
  lut1 dut(.A(A), .B(B), .C(C), .D(D), .F(F));

  // Variables para archivo, iteraciones y tiempo
  integer write_data;
  integer i;
  time t;

  initial begin
    // Configuracion de archivos de salida
    write_data = $fopen("lut_tb_output.txt","w");
    
    // Salida de simulacion y variables de salida
    $dumpfile("lut_tb.vcd");
    $dumpvars(0,lut_tb);
    
    // Configuracion de formato de tiempo
    $timeformat(-9, 2, " ns", 10);

    // Simular todas las combinaciones posibles
    for (i = 0; i < 16; i = i + 1) begin
        {A,B,C,D} = i; #20; t = $time;
        $fdisplay(write_data,"Time = %t, {A,B,C,D} = %b, X = %b", t, {A,B,C,D}, F);
    end

    // Cerrar archivo de texto
    $fclose(write_data);

    // Terminar simulacion
    $display("Test completed");
    $finish;

  end

endmodule
