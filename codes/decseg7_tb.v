//Test Bench: Estimulos combinacionales.

`timescale 1ns / 100 ps
`include "decseg7.v"

module decseg7_tb();

    reg [3:0] int;
    wire [6:0] out;

    decseg7 DUT(.int(int), .out(out));

    initial begin
        $dumpfile("decseg7.vcd");   //guarda lo que compila
        $dumpvars(0,decseg7_tb);       //selecciona variable que salen
        int = 4'd0; #20;          //d - decimal, 4 - 4 bits, 0 - asigna ceros a los 4 bits
        int = 4'd1; #20;
        int = 4'd2; #20;
        int = 4'd3; #20;
        int = 4'd4; #20;
        int = 4'd5; #20;
        int = 4'd6; #20;
        int = 4'd7; #20;
        int = 4'd8; #20;
        int = 4'd9; #20;
        int = 4'd10; #20;
        int = 4'd11; #20;
        int = 4'd12; #20;
        int = 4'd13; #20;
        int = 4'd14; #20;
        int = 4'd15; #20;


        //int = 4'd0;
        //#20;

        $display("Test completed");

    end

endmodule;