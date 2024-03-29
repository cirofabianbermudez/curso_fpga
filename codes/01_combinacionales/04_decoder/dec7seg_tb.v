// Author: Guadalupe Alonso Contreras
// Name: lut1_tb.v
//
// Descrition: 7-Segment Decoder Active high

`timescale 1ns / 100 ps
`include "hex_to_7seg.v"

module dec7seg_tb();
  // Definicion de señales de entrada y salida
  reg  [3:0] binary;
  wire [6:0] leds;

  //Instanciacion del modulo
  hex_to_7seg dut(.binary(binary), .leds(leds));

  // Variables para archivo, iteraciones y tiempo
  integer write_data;
  integer i;
  time t;

  initial begin
    // Configuracion de archivos de salida
    write_data = $fopen("dec7seg_tb_output.txt","w");
    
    // Salida de simulacion y variables de salida
    $dumpfile("dec7seg_tb.vcd");
    $dumpvars(0,dec7seg_tb);
    
    // Configuracion de formato de tiempo
    $timeformat(-9, 2, " ns", 10);

    // Simular todas las combinaciones posibles
    for (i = 0; i < 16; i++) begin
        binary = i; #20; t = $time;
        $fdisplay(write_data,"Time = %t, binary = %b, leds = %b", t, binary, leds);
    end

    // Cerrar archivo de texto
    $fclose(write_data);
    
    // Terminar simulacion
    $display("Test completed");
    $finish;
    
  end

endmodule;