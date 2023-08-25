`timescale 1ns / 100 ps

module cordic_tb #(
  parameter n = 32,
  parameter m = 4
) ();

  // Definición de señales de entrada y salida    
	reg          clk;
	reg          rst;
	reg          stc;
	reg  [n-1:0] z0;
  wire         eoc;
	wire [n-1:0] xn;
	wire [n-1:0] yn;
  wire [n-1:0] zn;
  
  // 100 MHz clock (5*1ns*2) con 50% duty-cycle
  always #5 clk = ~clk; 
  
  // Instanciacion del modulo
  cordic #(.n(n),.m(m)) dut (.clk_i(clk), .rst_i(rst), .stc_i(stc), .z0_i(z0), .eoc_o(eoc), .xn_o(xn), .yn_o(yn), .zn_o(zn) );
  
  // Secuencia de reset inicial y valores por defecto
  initial begin
    clk = 0; rst = 1; stc = 0;  z0 = 32'b00010100000000000000000000000000; #10;
             rst = 0;           #10;
  end
  
  // Variables para archivo y ciclo for
  //integer write_data;
  //integer i;

  initial begin
    //Configuracion de archivos de salida
    write_data = $fopen("cordic_tb_output.txt","w");
    //$dumpfile("cordic_tb.vcd");  
    //$dumpvars(0,cordic_tb);         

    //for (i = 0; i < 16; i++) begin
    //    #20;
    //    $fdisplay(write_data,"Hello");
    //end

    //$fclose(write_data);
    #30;
    
    stc = 1; #10;
    stc = 0; #10;
    
    #500;
    $display("Test completed");
    $finish;
  end

endmodule
