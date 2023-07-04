// Author: Guadalupe Alonso Contreras
// Name: mux4_1_tb.v
//Test Bench for a Multiplexer: Estimulos combinacionales.

`timescale 1ns / 100 ps
`include "mux4_1.v"
`include "mux4_1_v2.v"
`include "mux4_1_v3.v"

module mux4_1_tb();
    // Definicion de señales de entrada y salida

    reg        in1;
    reg        in2;
    reg        in3;
    reg        in4;
    reg  [1:0] sel;

    wire       ou1;

    //Instanciacion del modulo
    mux4_1 dut(.in1(in1), .in2(in2), .in3(in3), .in4(in4), .sel(sel), .ou1(ou1));
    //mux4_1_v2 dut(.in1(in1), .in2(in2), .in3(in3), .in4(in4), .sel(sel), .ou1(ou1));
    //mux4_1_v3 dut(.in1(in1), .in2(in2), .in3(in3), .in4(in4), .sel(sel), .ou1(ou1));

    // Variables para archivo de salida
    integer write_data;
    integer i;

    initial begin
        // Configuracion de archivos de salida
        write_data = $fopen("mux4_1_tb_output.txt","w");
        $dumpfile("mux4_1_tb.vcd");
        $dumpvars(0,mux4_1_tb);

        // d - decimal, 4 - 4 bits, 0 - asigna ceros a los 4 bits
        // sel = 2'd0; #20;
        // sel = 2'd1; #20;
        // sel = 2'd2; #20;
        // sel = 2'd3; #20;


        // Definición de señales de reloj
        // always @(in1,in2,in3,in4) begin
        //     in1 = 32'h00000000; 
        //     #5;
        //     in2 = 32'hFFFFFFFF;
        //     #10;
        //     in3 = 32'h00000000;
        //     #15;
        //     in4 = 32'hFFFFFFFF;
        //     #20;
        //     in1 = 32'hFFFFFFFF;
        //     #15;
        //     in2 = 32'h00000000;
        //     #10;
        //     in3 = 32'hFFFFFFFF;
        //     #5;
        //     in4 = 32'h00000000;
        //     #20;
        // end


        for (i = 0; i < 4; i++) begin
            sel = i; #20
            $fdisplay(write_data,"Selector = %2b, Salida = %32b", sel, ou1);
        end

        $fclose(write_data);

        //sel = 2'd0;
        //#20;

        $display("Test completed");
    end

endmodule;