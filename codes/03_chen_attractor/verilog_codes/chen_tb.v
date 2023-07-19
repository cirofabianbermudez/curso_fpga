// Author: Alonso Contreras Guadalupe
// Name: chen_tb.v
//
// Run: run 200055 ns 

`timescale 1ns / 100ps	  
`include "chen.v"

module chen_tb #(
  parameter Width = 32 
) ();
  // Definicion de senales de entrada y salida
  reg rst;
  reg clk;
  reg start;
  wire [Width-1:0] xn;
  wire [Width-1:0] yn;
  wire [Width-1:0] zn;

  // Generador de se�al de reloj y reset
  initial begin
    clk = 0; rst = 1; start = 0; #10;
             rst = 0;            #10;
  end
  
  // clock signal 100 MHz
  always #5 clk = ~clk;
		
  // Instanciacion del modulo
  chen #(.Width(Width)) dut (
    .rst_i(rst),
    .clk_i(clk),
    .start_i(start),
    .xn_o(xn),
    .yn_o(yn),
    .zn_o(zn)
	);
	
  integer write_data;
  integer i;
  localparam SF = 2.0**-21.0;
  
  // Estimulo de las entradas
  initial begin
    write_data = $fopen("chen_tb_output.txt","w");
    $dumpfile("chen_tb.vcd");
    $dumpvars(0,chen_tb);
	#30;
    
    // start oscillator
    start = 1;
    #5;
    // run for 55 + 20*iter ns   200055
    for (i = 0; i < 100000; i++) begin
      //$fdisplay(write_data, "%h\t%h\t%h  %32.27f\t%32.27f\t%32.27f",xn, yn, zn, $itor(xn*SF),$itor(yn*SF),$itor(zn*SF));
      $fdisplay(write_data, "%32.27f\t%32.27f\t%32.27f",$itor(xn)*SF,$itor(yn)*SF,$itor(zn)*SF);
      #20;
    end

    // close the file
    $fclose(write_data);  
    
    // stop oscillator
    start = 0;
    #10;

    // Final de simulacion
    $display("Test completed");
    $finish;

	end

endmodule
