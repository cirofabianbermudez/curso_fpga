// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

`timescale 1ns / 1ns
`include "debounce.v"

module debounce_tb ();
  // Definición de señales de entrada y salida
  reg  clk;
  reg  rst;
  reg  sw;
  wire db_level;
  wire db_tick;

  // Instanciacion del modulo
  debounce dut (
  .clk_i(clk),
  .rst_i(rst),
  .sw_i(sw),
  .db_level_o(db_level),
  .db_tick_o(db_tick)
  );
  
  localparam delay =  (2**21)*20;  
  localparam clk_cycle = 20;  

  // Generador de reloj de 50 MHz con duty-cycle de 50%
  always #10 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1; sw = 0;  #clk_cycle;
             rst = 0;          #clk_cycle;
  end

  initial begin
    // Configuracion de archivos de salida
    $dumpfile("debounce_tb.vcd");
    $dumpvars(0,debounce_tb);
    
    // Sincronizacion
    #(clk_cycle*3);
    
    #delay;
    
    sw = 1;
    #delay;
    #delay;
    
    sw = 0;
    #delay;
    #delay;
     

    $display("Test completed");
    $finish;
  end

endmodule;
