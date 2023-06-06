// Author: Ciro Fabian Bermudez Marquez
// Name: lorenz_tb.v
//
// Run: run 200055 ns 
// for 10000 iterations
`timescale 1ns / 100ps	  

module lorenz_tb #(
	parameter Width = 32 
) ();
	// Definición de señales de entrada y salida
  reg rst;
  reg clk;
  reg start;
  reg signed [Width-1:0] xn;
  reg signed [Width-1:0] yn;
  reg signed [Width-1:0] zn;

  // duracion de  20 * timescale = 20 * 1 ns  = 20ns
  localparam period = 20;  
  
	// Generador de señal de reloj y reset
  initial begin
    clk = 0; rst = 1; start = 0; #10;
             rst = 0;            #10;
  end
  
  always #5 clk = ~clk; // 100 MHz clock (50*1 ns*2) con 50% duty-cycle
		
	// Instanciacion del modulo
  lorenz #(Width) DUT (
    .rst_i(rst),
    .clk_i(clk),
    .start_i(start),
    .xn_o(xn),
    .yn_o(yn),
    .zn_o(zn)
	);
	
  integer write_data;
  int i;
  localparam SF = 2.0**-21.0;
  
	// Estímulo de las entradas
	initial begin
    write_data = $fopen("tb_output.txt");
		#50;
    
    // start oscillator
    start = 1;
    #5;
    // run for 55 + 20*iter ns   200055
    for (i = 0; i < 10000; i++) begin
      //$fdisplay(write_data, "%h\t%h\t%h  %32.27f\t%32.27f\t%32.27f",xn, yn, zn, $itor(xn*SF),$itor(yn*SF),$itor(zn*SF));
      $fdisplay(write_data, "%32.27f\t%32.27f\t%32.27f",$itor(xn)*SF,$itor(yn)*SF,$itor(zn)*SF);
      #20;
    end
    
    $fclose(write_data);  // close the file
    
    // stop oscillator
    //start = 0;
		//$display("xn = %d, yn = %d, zn = %d", xn, yn, zn);
		//$finish;
	end

endmodule