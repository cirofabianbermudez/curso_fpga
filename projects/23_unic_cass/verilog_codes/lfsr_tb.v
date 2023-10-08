// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

`timescale 1ns / 100ps
`include "lfsr.v"

module lfsr_tb #(
  parameter Width = 5
)();
  // Definición de señales de entrada y salida
  reg              clk;
  reg              rst;
  reg              en;
  wire [Width-1:0] q;
  wire             rnd;

  // Instanciacion del modulo
  lfsr #(
    .Width(Width)
   ) dut (
    .clk_i(clk),
    .rst_i(rst),
    .en_i(en),
    .q_o(q),
    .rnd_o(rnd)
  );
  
  localparam clk_cycle = 10;  

  // Generador de reloj de 100 MHz con duty-cycle de 50%
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1; en = 0; #clk_cycle;
             rst = 0;         #clk_cycle;
  end

  initial begin
    // Configuracion de archivos de salida
    $dumpfile("lfsr_tb.vcd");
    $dumpvars(0,lfsr_tb);
    
    // Sincronizacion
    #(clk_cycle*3);
    
    en = 1; #clk_cycle;
    
    #(clk_cycle*50);
    
    en = 0; #clk_cycle;

    $display("Test completed");
    $finish;
    
  end

endmodule;