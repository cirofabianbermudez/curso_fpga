// Author: Guadalupe Alonso Contreras
// Name: flipflop2.v
// Description: D Flip-Flop with falling edge

module flipflop2(
  input wire clk,   //Señal de reloj
  input wire reset, //Señal de reset
  input wire d,     //Entrada
  output reg q      //Salida
);

  always @(negedge clk or posedge reset) begin    //posedge = flancos de subida, negedge = flancos de bajada
    if (reset)      // Si se activa la señal de reinicio
      q <= 1'b0;    // Reiniciar la salida a 0
    else
      q <= d;       // La salida toma el valor de la entrada de datos en el flanco de reloj negativo
  end
endmodule
