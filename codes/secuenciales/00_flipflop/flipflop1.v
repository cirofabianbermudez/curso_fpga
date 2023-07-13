// Author: Guadalupe Alonso Contreras
// Name: flipflop.v
// Description: D Flip-Flop with rising edge. Asincrono.

module flipflop1(
  input  clk,   //Señal de reloj (por defecto son wire, si no se especifica)
  input  reset, //Señal de reset
  input  d,     //Entrada
  output reg q      //Salida
);

  //always @(posedge clk) -> Sincrono. Solo depende del clk.
  //always toma los valores que tenía guardados antes de entrar al bloque de codigo, por lo que si no entra en ninguna de las condiciones descrita, se queda con el valor anterior. 
  always @(posedge clk or posedge reset) begin    //posedge = flancos de subida
    if (reset)      // Si se activa la señal de reinicio
      q <= 1'b0;    // Reiniciar la salida a 0
    else
      q <= d;       // La salida toma el valor de la entrada de datos en el flanco de reloj positivo
  end
endmodule
