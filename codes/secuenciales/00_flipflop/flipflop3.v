// Author: Guadalupe Alonso Contreras
// Name: flipflop.v
// Description: D Flip-Flop with rising edge and enable

module flipflop3(
  input wire clk,   //Señal de reloj
  input wire reset, //Señal de reset
  input wire en,    //Señal de habilitación
  input wire d,     //Entrada
  output reg q      //Salida
);

  always @(posedge clk or posedge reset) begin    //posedge = flancos de subida
    if (reset)       // Si se activa la señal de reinicio
      q <= 1'b0;     // Reiniciar la salida a 0
    else if (en)     // Si la señal de habilitación está activa
      q <= d;        // La salida toma el valor de la entrada de datos en el flanco de reloj positivo
    else
      q <= q;        // Ni enable, ni reset están activos
  end
endmodule
