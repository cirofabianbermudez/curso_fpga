//Test Bench: Estimulos combinacionales.

`timescale 1ns / 100 ps
`include "LUT1.v"

module LUT1_tb();

    reg A;
    reg B;
    reg C;
    reg D;
    wire x;

    LUT1 DUT(.A(A), .B(B), .C(C), .D(D), .x(x));

    initial begin
        $dumpfile("LUT1_tb.vcd");   //guarda lo que compila
        $dumpvars(0,LUT1_tb);       //selecciona variable que salen
        {A,B,C,D} = 4'b0000; #20;   //b - binario, 4 - 4 bits, 0 - asigna ceros a los 4 bits
        {A,B,C,D} = 4'b0001; #20;
        {A,B,C,D} = 4'b0010; #20;
        {A,B,C,D} = 4'b0011; #20;
        {A,B,C,D} = 4'b0100; #20;
        {A,B,C,D} = 4'b0101; #20;
        {A,B,C,D} = 4'd6; #20;
        {A,B,C,D} = 4'd7; #20;
        {A,B,C,D} = 4'd8; #20;
        {A,B,C,D} = 4'd9; #20;
        {A,B,C,D} = 4'd10; #20;
        {A,B,C,D} = 4'd11; #20;
        {A,B,C,D} = 4'd12; #20;
        {A,B,C,D} = 4'd13; #20;
        {A,B,C,D} = 4'd14; #20;
        {A,B,C,D} = 4'd15; #20;

        //A = 0; B = 0; C = 0; D = 0;
        //#20;

        $display("Test completed");

    end

endmodule;