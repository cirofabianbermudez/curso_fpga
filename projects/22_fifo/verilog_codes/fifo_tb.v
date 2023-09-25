// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description: 

`timescale 1ns / 100 ps
`include "fifo.v"

module fifo_tb #(
  parameter Width = 8,
  parameter AddrBits = 3
)();
  // Definición de señales de entrada y salida
  reg               clk;
  reg               rst;
  reg               wr;
  reg               rd;
  reg   [Width-1:0] w_data;
  wire  [Width-1:0] r_data;
  wire              empty;
  wire              full;

  // Instanciacion del modulo
  fifo #(
    .Width(Width), 
    .AddrBits(AddrBits) 
  ) dut (
    .clk_i(clk),
    .rst_i(rst),
    .wr_i(wr),
    .rd_i(rd),
    .w_data_i(w_data),
    .r_data_o(r_data),
    .empty_o(empty),
    .full_o(full)
  );
  
  localparam clk_cycle = 10;  

  // Generador de reloj de 100 MHz con duty-cycle de 50 porciento
  always #5 clk = ~clk;

  // Secuencia de reset y condiciones iniciales
  initial begin
    clk = 0; rst = 1; wr = 0; rd = 0; w_data = 8'd0; #clk_cycle;
             rst = 0;                                #clk_cycle;
  end

  initial begin
    // Configuracion de archivos de salida
    $dumpfile("fifo_tb.vcd");
    $dumpvars(0,fifo_tb);
    
    // Sincronizacion
    #(clk_cycle*3);
    
    // Write
    w_data = 8'd0; wr = 1; #clk_cycle;
                   wr = 0; #clk_cycle;
                   
    w_data = 8'd1; wr = 1; #clk_cycle;
                   wr = 0; #clk_cycle;
                   
    w_data = 8'd2; wr = 1; #clk_cycle;
                   wr = 0; #clk_cycle;
                   
    w_data = 8'd3; wr = 1; #clk_cycle;
                   wr = 0; #clk_cycle;
                    
    w_data = 8'd4; wr = 1; #clk_cycle;
                   wr = 0; #clk_cycle;
                   
    w_data = 8'd5; wr = 1; #clk_cycle;
                   wr = 0; #clk_cycle;
                   
    w_data = 8'd6; wr = 1; #clk_cycle;
                   wr = 0; #clk_cycle;
                   
    w_data = 8'd7; wr = 1; #clk_cycle;
                   wr = 0; #clk_cycle;
                   
    // Delay         
    #(clk_cycle*3);
    
    // Read
    rd = 1; #clk_cycle;
    rd = 0; #clk_cycle;
    
    rd = 1; #clk_cycle;
    rd = 0; #clk_cycle;
    
    rd = 1; #clk_cycle;
    rd = 0; #clk_cycle;
    
    rd = 1; #clk_cycle;
    rd = 0; #clk_cycle;
    
    rd = 1; #clk_cycle;
    rd = 0; #clk_cycle;
    
    rd = 1; #clk_cycle;
    rd = 0; #clk_cycle;
    
    rd = 1; #clk_cycle;
    rd = 0; #clk_cycle;
    
    rd = 1; #clk_cycle;
    rd = 0; #clk_cycle;

    $display("Test completed");
    $finish;
  end

endmodule;
