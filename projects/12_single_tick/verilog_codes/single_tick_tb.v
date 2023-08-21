// Author: Julisa Verdejo Palacios
// Name: rs232_rx_tb.v
//
// Description: Testbench de recepcion

`timescale 1ns / 100 ps
`include "clk_div_tick.v"
`include "fsm_tick.v"
`include "single_tick.v"

module single_tick_tb ();
  // Definición de señales de entrada y salida
  reg         rst;
  reg         clk;
  reg  [29:0] k;
  reg         button;
  wire        start;
  
  // Instanciacion del modulo
  single_tick dut (
    .rst_i(rst),
    .clk_i(clk),
    .k_i(k),
    .button_i(button),
    .start_o(start)
  );

  // Generador de reloj de 100 MHz con duty-cycle de 50 %
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1; k = 30'd999; button = 0; #10;
             rst = 0;                              #10;
  end

  initial begin
    // Configuracion de archivos de salida
    $dumpfile("single_tick_tb.vcd");
    $dumpvars(0,single_tick_tb);
    
    // Sincronizacion
    #30;
    
    // Secuencia
    
    // Activar
    button = 1; #10;
    button = 0; #10;
    
    // Esperar primera mitad del tiempo
    #5000;
    
    // Comprobar que no se active
    button = 1; #10;
    button = 0; #10;
    
    // Esperar segunda mitad del tiempo
    #5000;
    
    // Volver a activar 
    button = 1; #10;
    button = 0; #10;
    
    // Esperar que acabe
    #10000;
      
    $display("Test completed");
    $finish;
  end

endmodule;