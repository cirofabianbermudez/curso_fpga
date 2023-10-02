// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

`timescale 1ns / 100ps
`include "fsm_sar2.v"

module fsm_sar2_tb ();
  // Definición de señales de entrada y salida
  reg        clk;
  reg        SOC;
  reg        cmp;
  wire [9:0] Q;
  wire [9:0] D;
  wire       EOC;
  wire       sample;

  // Instanciacion del modulo
  fsm_sar2 dut (
    .clk(clk),
    .SOC(SOC),
    .cmp(cmp),
    .Q(Q),
    .D(D),
    .EOC(EOC),
    .sample(sample)
  );
  
  localparam clk_cycle = 10;  

  // Generador de reloj de 100 MHz con duty-cycle de 50%
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; SOC = 0; cmp = 0; #clk_cycle;
                               #clk_cycle;
  end

  initial begin
    // Configuracion de archivos de salida
    $dumpfile("fsm_sar2_tb.vcd");
    $dumpvars(0,fsm_sar2_tb);
    
    // Sincronizacion
    #(clk_cycle*3);
    
    SOC = 1; #clk_cycle;
    SOC = 0; #clk_cycle;
    
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