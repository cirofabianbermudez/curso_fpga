// Author: Julisa Verdejo Palacios
// Name: rs232_rx_tb.v
//
// Description: Testbench de recepcion

`timescale 1ns / 100 ps
`include "mod_m_counter.v"
`include "receiver.v"
`include "rs232_rx.v"


module rs232_rx_tb ();
  // Definición de señales de entrada y salida
  reg         rst;
  reg         clk;
  reg         rx;
  wire  [7:0] dout;
  wire        eor;

  // Instanciacion del modulo
  rs232_rx dut (
    .rst_i(rst),
    .clk_i(clk),
    .rx_i(rx),
    .dout_o(dout),
    .eor_o(eor)
  );
  
  localparam baud =  50_000_000*20/(9600);  
  localparam clk_cycle = 20;  

  // Generador de reloj de 50 MHz con duty-cycle de 50%
  always #10 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1; rx = 1;  #clk_cycle;
             rst = 0;          #clk_cycle;
  end

  initial begin
    // Configuracion de archivos de salida
    $dumpfile("rs232_rx_tb.vcd");
    $dumpvars(0,rs232_rx_tb);
    
    // Sincronizacion
    #(clk_cycle*3);
     
    // Delay inicial
    #(baud*1.29);
    
    // Recepcion
    rx = 0; #baud; // Start
    rx = 0; #baud; // d0
    rx = 1; #baud; // d1
    rx = 0; #baud; // d2
    rx = 1; #baud; // d3
    rx = 0; #baud; // d4
    rx = 1; #baud; // d5
    rx = 0; #baud; // d6
    rx = 1; #baud; // d7
    rx = 1; #baud; // Stop
    #baud;
    
    
    // Recepcion
    rx = 0; #baud; // Start
    rx = 1; #baud; // d0
    rx = 1; #baud; // d1
    rx = 1; #baud; // d2
    rx = 0; #baud; // d3
    rx = 0; #baud; // d4
    rx = 0; #baud; // d5
    rx = 0; #baud; // d6
    rx = 0; #baud; // d7
    rx = 1; #baud; // Stop
    #baud;

    $display("Test completed");
    $finish;
  end

endmodule;
