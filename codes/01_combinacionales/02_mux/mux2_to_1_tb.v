// Author: Ciro Fabian Bermudez Marquez
// Name: mux2_to_1_tb.v
//Test Bench for a Multiplexer: Estimulos combinacionales.

`timescale 1ns / 100 ps
`include "mux4_to_1.v"
`include "mux4_to_1_v2.v"
`include "mux4_to_1_v3.v"

module mux4_to_1_tb #(
  parameter n = 4
) ();

    // Definicion de señales de entrada y salida
    reg  [n-1:0] in1;
    reg  [n-1:0] in2;
    reg  [n-1:0] in3;
    reg  [n-1:0] in4;
    reg    [1:0] sel;

    wire [n-1:0] ou1;

    //Instanciacion del modulo
    //mux4_1      #(.Width(n))  dut(.in1(in1), .in2(in2), .in3(in3), .in4(in4), .sel(sel), .ou1(ou1));
    //mux4_1_v2 #(.Width(n))  dut(.in1(in1), .in2(in2), .in3(in3), .in4(in4), .sel(sel), .ou1(ou1));
    mux4_1_v3 #(.Width(n))  dut(.in1(in1), .in2(in2), .in3(in3), .in4(in4), .sel(sel), .ou1(ou1));

    // Variables para archivo de salida
    integer write_data;
    integer i;
    time t;
    
    // Valores iniciales
    initial begin
        in1 = 4'd1; 
        in2 = 4'd2;
        in3 = 4'd3;
        in4 = 4'd4;
        sel = 2'd0;
    end
    

    initial begin
        // Configuracion de archivos de salida
        write_data = $fopen("mux4_1_tb_output.txt","w");
        $dumpfile("mux4_1_tb.vcd");
        $dumpvars(0,mux4_1_tb);
        $timeformat(-9, 2, " ns", 10);
        
        for (i = 0; i < 4; i++) begin
            sel = i; #20; t = $time;
            $fdisplay(write_data,"Tiempo: %t, Selector = %b, Salida = %b",t ,sel, ou1);
        end

        $fclose(write_data);
        $display("Test completed");
    end

endmodule;
