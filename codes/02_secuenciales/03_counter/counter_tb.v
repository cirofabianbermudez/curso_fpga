// Author: Ciro Fabian Bermudez Marquez
// Name: conter_tb.v
//
// Description: Testbench estimulos secuenciales.

`timescale 1ns / 100 ps
`include "counter.v"

module counter_tb #(
  parameter Width = 4
)();
  // Definición de señales de entrada y salida
  reg clk;
  reg rst;
  wire max_tick;
  wire [Width-1:0] q;

  // Instanciacion del modulo
  counter #(.Width(Width)) dut (
    .clk_i(clk),
    .rst_i(rst), 
    .max_tick_i(max_tick), 
    .q_o(q)
  );

  // Generador de reloj de 100 MHz con duty-cycle de 50 %
  always #5 clk = ~clk;

  // Secuancia de reset
  initial begin
    clk = 0; rst = 1; #10;
             rst = 0; #10;
  end

  initial begin
    // Configuracion de archivos de salida
    $dumpfile("counter_tb.vcd");
    $dumpvars(0,counter_tb);
    
    // Sincronizacion
    #30;

    //Estimulos de prueba
    #300;

    $display("Test completed");
    $finish;
  end

endmodule;