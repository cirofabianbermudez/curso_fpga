// Author: Guadalupe Alonso Contreras
// Name: lut1_tb.v
//Test Bench for a 7-Segment decoder: Estimulos combinacionales.

`timescale 1ns / 100 ps
`include "dec7seg.v"
`include "dec7seg_v2.v"
`include "dec7seg_v3.v"

module dec7seg_tb();
    // Definicion de señales de entrada y salida
    reg  [3:0] binary;
    wire [6:0] leds;

    //Instanciacion del modulo
    dec7seg dut(.binary(binary), .leds(leds));
    //dec7seg_v2 dut(.binary(binary), .leds(leds));
    //dec7seg_v3 dut(.binary(binary), .leds(leds));

    // Variables para archivo de salida
    integer write_data;
    integer i;

    initial begin
        // Configuracion de archivos de salida
        write_data = $fopen("dec7seg_tb_output.txt","w");
        $dumpfile("dec7seg_tb.vcd");
        $dumpvars(0,dec7seg_tb);

        // d - decimal, 4 - 4 bits, 0 - asigna ceros a los 4 bits
        // binary = 4'd0; #20;
        // binary = 4'd1; #20;
        // binary = 4'd2; #20;
        // binary = 4'd3; #20;
        // binary = 4'd4; #20;
        // binary = 4'd5; #20;
        // binary = 4'd6; #20;
        // binary = 4'd7; #20;
        // binary = 4'd8; #20;
        // binary = 4'd9; #20;
        // binary = 4'd10; #20;
        // binary = 4'd11; #20;
        // binary = 4'd12; #20;
        // binary = 4'd13; #20;
        // binary = 4'd14; #20;
        // binary = 4'd15; #20;

        for (i = 0; i < 16; i++) begin
            binary = i; #20
            $fdisplay(write_data,"Binary = %4b, Leds = %7b", binary, leds);
        end

        $fclose(write_data);

        //binary = 4'd0;
        //#20;

        $display("Test completed");
    end

endmodule;