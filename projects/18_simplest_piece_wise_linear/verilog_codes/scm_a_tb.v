`timescale 1ns / 100 ps
`include "scm_a.v"

module scm_a_tb ();

  // Definición de señales de entrada y salida
  reg  [16-1:0] a;
  wire [16-1:0] b;


  // Instanciacion del modulo
  scm_a dut (
    .X(a),
    .Y(b)
  );

  // Abrir archivo de salida
  integer write_data;
  localparam SF = 2.0**-13.0;
  time t;

  // Estimulo de las entradas
  initial begin
    write_data = $fopen("scm_a_output.txt","w");
    $dumpfile("scm_a_tb.vcd");
    $dumpvars(0,scm_a_tb);
    $timeformat(-9, 2, " ns", 10);
    a = 16'b0010000000000000; //  1.0
    #100; t = $time;
    $fdisplay(write_data, "Tiempo: %t\ta = %10.7f\tb = %10.7f",t,$itor(a)*SF,$itor(b)*SF);

    a = 16'b0001000000000000; //  0.5
    #100; t = $time;
    $fdisplay(write_data, "Tiempo: %t\ta = %10.7f\tb = %10.7f",t,$itor(a)*SF,$itor(b)*SF);

    a = 16'b0000100000000000; // 0.25
    #100; t = $time;
    $fdisplay(write_data, "Tiempo: %t\ta = %10.7f\tb = %10.7f",t,$itor(a)*SF,$itor(b)*SF);

    // Cerrar archivo de salida
    $fclose(write_data);

    // Final de simulacion
    $display("Test completed");
    //$display("a = %2d, b = %2d, result = %2d", a, b, c);  

  end

endmodule
