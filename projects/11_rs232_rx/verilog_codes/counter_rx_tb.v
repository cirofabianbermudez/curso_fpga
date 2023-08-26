// Author: Julisa Verdejo Palacios
// Name: counter_rx_tb.v
//
// Description: Testbench de recepcion

`timescale 1ns / 100 ps
`include "counter_rx.v"

module counter_rx_tb ();
  // Definición de señales de entrada y salida
  reg       rst;
  reg       clk;
  reg       en;
  reg [2:0] vmax;
  wire      flag;

  // Instanciacion del modulo
  counter_rx #(.Width(3)) dut (
    .rst_i(rst),
    .clk_i(clk),
    .en_i(en),
    .vmax_i(vmax),
    .flag_o(flag)
  );
  
  // Generador de reloj de 100 MHz con duty-cycle de 50%
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1; vmax = 3'd5; en = 0; #10;
             rst = 0;                      #10;
  end

  initial begin

    // Configuracion de archivos de salida
    $dumpfile("counter_rx_tb.vcd");
    $dumpvars(0,counter_rx_tb);
    
    // Sincronizacion
    #35;

    en = 1; #10;
    #520;

    en = 0;
    #100;

    $display("Test completed");
    $finish;

  end

endmodule;
