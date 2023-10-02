// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

`timescale 1ns / 100ps
`include "mod_n_counter.v"
`include "ff_toggle.v"
`include "univ_counter.v"
`include "fsm_ramp.v"
`include "ramp.v"

module ramp_tb #(
  parameter Width = 10
)();
  // Definición de señales de entrada y salida
  reg              clk;
  reg              rst;
  reg              start;
  wire [Width-1:0] cnt;
  wire             tim;
  wire             tick_10ms;
  wire             tick_1ms;
  wire             eos;

  // Instanciacion del modulo
  ramp #(
    .Width(Width)
  ) dut (
    .clk_i(clk),
    .rst_i(rst),
    .start_i(start),
    .cnt_o(cnt),
    .time_o(tim),
    .tick_10ms_o(tick_10ms),
    .tick_1ms_o(tick_1ms),
    .eos_o(eos)
  );
  
  localparam clk_cycle = 10;  

  // Generador de reloj de 100 MHz con duty-cycle de 50%
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1;  start = 0; #clk_cycle;
             rst = 0;             #clk_cycle;
  end

  initial begin
    // Configuracion de archivos de salida
    $dumpfile("ramp_tb.vcd");
    $dumpvars(0,ramp_tb);
    
    // Sincronizacion
    #(clk_cycle*10);
    
    start = 1; #clk_cycle;
    start = 0; #clk_cycle;

    #(clk_cycle*20*200000);

    $display("Test completed");
    $finish;
    
  end

endmodule;