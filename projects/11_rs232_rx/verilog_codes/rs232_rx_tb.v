// Author: Julisa Verdejo Palacios
// Name: rs232_rx_tb.v
//
// Description: Testbench de recepcion

`timescale 1ns / 100 ps
`include "counter_rx.v"
`include "sipo_reg_rx.v"
`include "pipo_reg_rx.v"
`include "parity_rx.v"
`include "fsm_rx.v"
`include "rs232_rx.v"

module rs232_rx_tb ();
  // Definición de señales de entrada y salida
  reg         rst;
  reg         clk;
  reg         rx;
  reg  [14:0] baud;
  reg         psel;
  wire  [7:0] dout;
  wire        pcheck;
  wire        eor;

  // Instanciacion del modulo
  rs232_rx dut (
    .rst_i(rst),
    .clk_i(clk),
    .rx_i(rx),
    .baud_i(baud),
    .psel_i(psel),
    .dout_o(dout),
    .pcheck_o(pcheck),
    .eor_o(eor)
  );
  
  localparam [14:0] baud_c = 100_000_000/(4*9600) - 1;
  localparam period =  100_000_000*10/(9600) - 1;  


  // Generador de reloj de 100 MHz con duty-cycle de 50 %
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1; rx = 1; baud = baud_c; psel = 0; #10;
             rst = 0;                                  #10;
  end

  initial begin
    // Configuracion de archivos de salida
    $dumpfile("rs232_rx_tb.vcd");
    $dumpvars(0,rs232_rx_tb);
    
    // Sincronizacion
    #30;
     
    // Delay inicial
    #period;
    #5;
    
    // Start
    rx = 0; psel = 0; #period;
    
    // Data
    rx = 0; #period; // d0
    rx = 1; #period; // d1
    rx = 0; #period; // d2
    rx = 1; #period; // d3
    rx = 0; #period; // d4
    rx = 1; #period; // d5
    rx = 0; #period; // d6
    rx = 1; #period; // d7
    
    // Stop
    rx = 1; #period;
    
    // Delay final
    #period;
    
    
    // Delay inicial
    #period;
    
    // Start
    rx = 0; psel = 1; #period;
    
    // Data
    rx = 0; #period; // d0
    rx = 1; #period; // d1
    rx = 0; #period; // d2
    rx = 1; #period; // d3
    rx = 0; #period; // d4
    rx = 1; #period; // d5
    rx = 0; #period; // d6
    rx = 1; #period; // d7
    rx = 0; #period; // P
    
    // Stop
    rx = 1; #period;
    
    // Delay final
    #period;

    $display("Test completed");
    $finish;
  end

endmodule;
