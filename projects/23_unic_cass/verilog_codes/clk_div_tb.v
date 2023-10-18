// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

`timescale 1ns / 100ps
`include "clk_div.v"

module clk_div_tb ();
  // Definición de señales de entrada y salida
  reg        clk;
  reg        rst;
  wire       square;

  // Instanciacion del modulo
  clk_div #( 
    .Width(3),
    .MaxVal(5)
  ) dut (
    .clk_i(clk),
    .rst_i(rst),
    .square_o(square)
  );

  localparam clk_cycle = 10;  

  // Generador de reloj de 100 MHz con duty-cycle de 50%
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1;  #clk_cycle;
             rst = 0;  #clk_cycle;
  end

  initial begin
    // Configuracion de archivos de salida
    $dumpfile("clk_div_tb.vcd");
    $dumpvars(0,clk_div_tb);
    
    // Sincronizacion
    #(clk_cycle*3);
    
    #(clk_cycle*100);

    $display("Test completed");
    $finish;
    
  end

endmodule;