// Author: Ciro Fabian Bermudez Marquez
// Name: lorenz_tb.v
//
// Run: run 200055 ns 

`timescale 1ns / 100ps	  
`include "adder.v"
`include "sub.v"
`include "abs.v"
`include "rom.v"
`include "scm_h.v"
`include "scm_a.v"
`include "mux.v"
`include "cu.v"
`include "ff_hab.v"
`include "piecewise_linear.v"

module piecewise_linear_tb #(
  parameter Width = 16
) ();
  // Definición de señales de entrada y salida
  reg rst;
  reg clk;
  reg start;
  wire signed [Width-1:0] xn;
  wire signed [Width-1:0] yn;
  wire signed [Width-1:0] zn;
 
  // Generador de señal de reloj y reset
  initial begin
    clk = 0; rst = 1; start = 0; #10;
             rst = 0;            #10;
  end
  
  // clock signal 100 MHz
  always #5 clk = ~clk;
  
  // Instanciacion del modulo
  piecewise_linear #(.Width(Width)) dut (
    .rst_i(rst),
    .clk_i(clk),
    .start_i(start),
    .xn_o(xn),
    .yn_o(yn),
    .zn_o(zn)
  );
	
  integer write_data;
  integer i;
  localparam SF = 2.0**-13.0;
  
  // Estímulo de las entradas
  initial begin
    write_data = $fopen("piecewise_linear_tb_output.txt","w");
    $dumpfile("piecewise_linear_tb.vcd");
    $dumpvars(0,piecewise_linear_tb);
	  #30;
    
    // start oscillator
    start = 1;
    #5;
    // run for 55 + 20*iter ns   200055
    for (i = 0; i < 100000; i = i + 1) begin
      //$fdisplay(write_data, "%h\t%h\t%h  %32.27f\t%32.27f\t%32.27f",xn, yn, zn, $itor(xn)*SF,$itor(yn)*SF,$itor(zn)*SF);
      $fdisplay(write_data, "%32.27f\t%32.27f\t%32.27f",$itor(xn)*SF,$itor(yn)*SF,$itor(zn)*SF);
      #20;
    end
    
    // close the file
    $fclose(write_data);  // close the file
    
    // stop oscillator
    start = 0;
    #10;
    
    // Final de simulacion
    $display("Test completed");
    $finish;
    
  end

endmodule
