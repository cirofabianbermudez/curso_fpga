// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

`timescale 1ns / 100ps
`include "fsm_sar.v"

module fsm_sar_tb ();
  // Definición de señales de entrada y salida
  reg        clk;
  reg        rst;
  reg        start;
  reg        cmp;
  wire [9:0] result;
  wire [9:0] dac;
  wire       sample;
  wire       eoc;

  // Instanciacion del modulo
  fsm_sar #( 
    .Width(10)
  ) dut (
    .clk_i(clk),
    .rst_i(rst),
    .start_i(start),
    .cmp_i(cmp),
    .result_o(result), 
    .dac_o(dac),
    .sample_o(sample),
    .eoc_o(eoc)
  );

  localparam clk_cycle = 10;  

  // Generador de reloj de 100 MHz con duty-cycle de 50%
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1; start = 0; cmp = 0; #clk_cycle;
             rst = 0;                     #clk_cycle;
  end

  initial begin
    // Configuracion de archivos de salida
    $dumpfile("fsm_sar_tb.vcd");
    $dumpvars(0,fsm_sar_tb);
    
    // Sincronizacion
    #(clk_cycle*3);
    
    start = 1; #clk_cycle;
    start = 0; #clk_cycle;
    
    @(negedge clk) cmp = 0;
    @(negedge clk) cmp = 1;
    @(negedge clk) cmp = 0;
    @(negedge clk) cmp = 1;
    @(negedge clk) cmp = 0;
    @(negedge clk) cmp = 1;
    @(negedge clk) cmp = 0;
    @(negedge clk) cmp = 1;
    @(negedge clk) cmp = 0;
    @(negedge clk) cmp = 1;
    @(negedge clk) cmp = 0;
    @(negedge clk) cmp = 1;
     
    
    #(clk_cycle*3);

    $display("Test completed");
    $finish;
    
  end

endmodule;