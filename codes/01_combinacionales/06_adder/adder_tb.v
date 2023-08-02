// Author: Ciro Fabian Bermudez Marquez
// Author: Alonso Contreras Guadalupe
// Name: adder_tb.v
//
// Simple testbench for adder
`timescale 1ns / 100ps	  
`include "adder.v"

module adder_tb #(
  parameter Width = 32 
) ();

  // Definición de señales de entrada y salida
  reg [Width-1:0] a;
  reg [Width-1:0] b;

  wire [Width-1:0] c;

  // Instanciacion del modulo
  adder #(Width) DUT (
    .a_i(a),
    .b_i(b),
    .sum_o(c)
  );

  // Abrir archivo de salida
  integer write_data;
  localparam SF = 2.0**-21.0;
  time t;
	
  // Estimulo de las entradas
  initial begin
    write_data = $fopen("adder_tb_output.txt","w");
    $dumpfile("adder_tb.vcd");
    $dumpvars(0,adder_tb);
    $timeformat(-9, 2, " ns", 10);
    a = 32'b00000000001000000000000000000000; //  1.0
    b = 32'b00000000001000000000000000000000; //  1.0;
    #100; t = $time;
    $fdisplay(write_data, "Tiempo: %t\ta = %10.7f\tb = %10.7f\tc = %10.7f",t,$itor(a)*SF,$itor(b)*SF,$itor(c)*SF);
        
    a = 32'b00000000001100000000000000000000; //  1.5
    b = 32'b00000000001100000000000000000000; //  1.5;
    #100; t = $time;
    $fdisplay(write_data, "Tiempo: %t\ta = %10.7f\tb = %10.7f\tc = %10.7f",t,$itor(a)*SF,$itor(b)*SF,$itor(c)*SF);
        
    a = 32'b00000000001100000000000000000000; //  1.5
    b = 32'b11111111111100000000000000000000; // -0.5;
    #100; t = $time;
    $fdisplay(write_data, "Tiempo: %t\ta = %10.7f\tb = %10.7f\tc = %10.7f",t,$itor(a)*SF,$itor(b)*SF,$itor(c)*SF);

    // Cerrar archivo de salida
    $fclose(write_data);

    // Final de simulacion
    $display("Test completed");
    //$display("a = %2d, b = %2d, result = %2d", a, b, c);	

  end

endmodule