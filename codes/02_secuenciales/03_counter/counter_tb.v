// Author: Ciro Fabian Bermudez Marquez
// Name: conter_tb.v
// Description: Testbench estimulos secuenciales.

`timescale 1ns / 100 ps
`include "cont.v"

module cont_tb();
  // Definición de señales de entrada y salida
  reg clk;
  reg reset;
  reg en;

  wire [3:0] cnt;

  // Instanciacion del modulo
  cont dut(.clk(clk), .reset(reset), .en(en), .cnt(cnt));

  // Generador de reloj de 100 MHz con duty-cycle de 50 %
  always #5 clk = ~clk;

  // Secuencia de reset
  	// Generador de se�al de reloj y reset
  initial begin
    clk = 0; reset = 1; en = 0; #10;
             reset = 0;         #10;
  end

  initial begin
    // Configuracion de archivos de salida
    $dumpfile("cont_tb.vcd");   //guarda lo que compila
    $dumpvars(0,cont_tb);     //selecciona variable que salen
    #30;

    //Estimulos de prueba
    en = 1; #(10*15);       //(10*15) porque necesitamos 10ns durante 15 ciclos
    en = 0; #50;


    $display("Test completed");
    $finish;
  end

endmodule;