`timescale 1 ns / 100 ps

`include "mac.v"
`include "rom_a.v"
`include "rom_x.v"

module mac_tb ();
  // Definición de señales de entrada y salida
  reg         clk;
  reg         rst;
  reg         stf;
  
  wire  [17:0] x;
  wire  [35:0] a;
  
  // reg   [5:0] n;
  // reg   [5:0] s;
  localparam [5:0] n = 5;
  localparam [5:0] s = 28;
  
  
  wire [17:0] y;
  wire  [5:0] i;
  wire        eof;
  
  // 100 MHz clock
  always #5 clk = ~clk;
    
  // Secuencia de reset y valores iniciales  
  initial begin
    clk = 0; rst = 1; stf = 0; #10;
             rst = 0;          #10;
  end
  
  // Instanciacion de los modulos
  rom_x  mod_rom_x (.addr(i), .value_x(x));    // A(7,10)
  rom_a  mod_rom_a (.addr(i), .value_a(a));    // A(7,28)
  mac dut (
    .clk_i(clk),
    .rst_i(rst),
    .stf_i(stf),
    .x_i(x),
    .a_i(a),
    .n_i(n),
    .s_i(s),
    .y_o(y),
    .i_o(i),
    .eof_o(eof)
  );  

  // Estimulo de las entradas
  initial begin
    $dumpfile("mac_tb.vcd");
    $dumpvars(0,mac_tb);
    // Esperar secuencia de reset
    #30;
    
    // Activar MAC
    stf = 1; #10;
    stf = 0; #10;
    
    // Esperar a que acabe la MAC
    #50;
    
    // Activar MAC
    stf = 1; #10;
    stf = 0; #10;
    
    // Esperar a que acabe la MAC
    #50;
    
    // Final de simulacion
    $display("Test completed");
    $finish;
  end

endmodule