// Author: Guadalupe Alonso Contreras
// Name: flipflop_en_tb.v
// Description: Testbench estimulos secuenciales.

`timescale 1ns / 100 ps
`include "flipflop3.v"

module flipflop_en_tb();
  // Definición de señales de entrada y salida
  reg clk;
  reg reset;
  reg en;
  reg d;

  wire q;

  // Instanciacion del modulo
  flipflop3 dut(.clk(clk), .reset(reset), .en(en), .d(d), .q(q));

  // Generador de reloj de 100 MHz con duty-cycle de 50 %
  always #5 clk = ~clk;

  // Secuencia de reset
  	// Generador de señal de reloj y reset
  initial begin
    clk = 0; reset = 1;  d = 0;  en = 0; #10;
             reset = 0;                  #10;
  end

  initial begin
    // Configuracion de archivos de salida
    $dumpfile("flipflop_en_tb.vcd");   //guarda lo que compila
    $dumpvars(0,flipflop_en_tb);     //selecciona variable que salen
    #30;

    // Estímulos de prueba
    d = 1; #20;
    d = 0; #20;
    d = 1; #20;
    d = 0; #20;
    d = 1; #20;

    en = 1;
    d = 0; #20;
    d = 1; #20;
    d = 0; #20;
    d = 0; #20;
    d = 1; #20;

    $display("Test completed");
    $finish;
  end

endmodule;