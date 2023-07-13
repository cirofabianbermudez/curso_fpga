// Author: Guadalupe Alonso Contreras
// Name: flipflop_tb.v
// Description: Testbench estimulos secuenciales.

`timescale 1ns / 100 ps
`include "flipflop1.v"
`include "flipflop2.v"

module flipflop_tb();
  // Definición de señales de entrada y salida
  reg clk;
  reg reset;
  reg d;

  wire q;

  // Instanciacion del modulo
  flipflop1 dut(.clk(clk), .reset(reset), .d(d), .q(q));
  //flipflop2 dut(.clk(clk), .reset(reset), .d(d), .q(q));

  // Generador de reloj de 100 MHz con duty-cycle de 50 %
  always #5 clk = ~clk;

  // Secuencia de reset
  	// Generador de se�al de reloj y reset
  initial begin
    clk = 0; reset = 1;  d = 0; #10;
             reset = 0;         #10;
  end

  initial begin
    // Configuracion de archivos de salida
    $dumpfile("flipflop_tb.vcd");   //guarda lo que compila
    $dumpvars(0,flipflop_tb);     //selecciona variable que salen
    #30;

    // Estímulos de prueba
    d = 1; #20;
    d = 0; #20;
    d = 1; #20;

    $display("Test completed");
    $finish;
  end

endmodule;