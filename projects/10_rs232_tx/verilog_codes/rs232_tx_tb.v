// Author: Julisa Verdejo Palacios
// Name: rs232_tx_tb.v
//
// Description: Calcula la paridad tipo (even) de los datos de entrada

`timescale 1ns / 100 ps
`include "mux_tx.v"
`include "parity_tx.v"
`include "clk_div_tx.v"
`include "fsm_tx.v"
`include "rs232_tx.v"

module rs232_tx_tb ();
  // Definición de señales de entrada y salida
  reg         rst;
  reg         clk;
  reg         sttx;
  reg   [7:0] d;
  reg  [14:0] baud;
  reg         psel;
  wire        tx;
  wire        eot;

  // Instanciacion del modulo
  rs232_tx dut (
    .rst_i(rst), 
    .clk_i(clk),
    .sttx_i(sttx),
    .d_i(d),
    .baud_i(baud),
    .psel_i(psel),
    .tx_o(tx),
    .eot_o(eot)
  );

  // Generador de reloj de 100 MHz con duty-cycle de 50 %
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1; sttx = 0; d = 8'b01110011; baud = 15'd10415; psel = 0; #10;
             rst = 0;                                                        #10;
  end

  initial begin
    // Configuracion de archivos de salida
    $dumpfile("rs232_tx_tb.vcd");
    $dumpvars(0,rs232_tx_tb);
    
    // Sincronizacion
    #30;

    //Estimulos de prueba
    sttx = 1; #10;
    sttx = 0; #10;
    
    // Esperar que acabe la transmision
    #(10*10415*11);
    
    
    //Estimulos de prueba
    psel = 1; #10;
    sttx = 1; #10;
    sttx = 0; #10;
    
    // Esperar que acabe la transmision
    #(10*10415*12);

    $display("Test completed");
    $finish;
  end

endmodule;