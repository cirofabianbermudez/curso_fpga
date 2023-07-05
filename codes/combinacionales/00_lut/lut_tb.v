// Author: Guadalupe Alonso Contreras
// Name: lut1_tb.v
// Description: Testbench estimulos combinacionales.

`timescale 1ns / 100 ps
`include "lut1.v"
`include "lut2.v"
`include "lut3.v"

module lut_tb();
  // Definición de señales de entrada y salida
  reg A;
  reg B;
  reg C;
  reg D;

  wire X;

  // Instanciacion del modulo
  //lut1 dut(.A(A), .B(B), .C(C), .D(D), .X(X));
  //lut2 dut(.A(A), .B(B), .C(C), .D(D), .X(X));
  lut3 dut(.A(A), .B(B), .C(C), .D(D), .X(X));

  // Variables para archivo y ciclo for
  integer write_data;
  integer i;

  initial begin
    // Configuracion de archivos de salida
    write_data = $fopen("lut_tb_output.txt","w");
    $dumpfile("lut_tb.vcd");   //guarda lo que compila
    $dumpvars(0,lut_tb);     //selecciona variable que salen

    //b - binario, 4 - 4 bits, 0 - asigna ceros a los 4 bits
    //{A,B,C,D} = 4'd0; #20;   
    //{A,B,C,D} = 4'd1; #20;
    //{A,B,C,D} = 4'd2; #20;
    //{A,B,C,D} = 4'd3; #20;
    //{A,B,C,D} = 4'd4; #20;
    //{A,B,C,D} = 4'd5; #20;
    //{A,B,C,D} = 4'd6; #20;
    //{A,B,C,D} = 4'd7; #20;
    //{A,B,C,D} = 4'd8; #20;
    //{A,B,C,D} = 4'd9; #20;
    //{A,B,C,D} = 4'd10; #20;
    //{A,B,C,D} = 4'd11; #20;
    //{A,B,C,D} = 4'd12; #20;
    //{A,B,C,D} = 4'd13; #20;
    //{A,B,C,D} = 4'd14; #20;
    //{A,B,C,D} = 4'd15; #20;

    for (i = 0; i < 16; i++) begin
        {A,B,C,D} = i; #20;
        $fdisplay(write_data,"Entradas = %b, X = %7b", i, X);
    end

    $fclose(write_data);
    // A = 0; B = 0; C = 0; D = 0;
    // #20;

    $display("Test completed");
  end

endmodule;
