// Author: Julisa Verdejo Palacios
// Name: fsm_rx.v
//
// Description: Maquina de estado para control de recepcion.

module fsm_rx (
  input            rst_i,
  input            clk_i,
  input            rx_i,
  input            z_i,
  input      [3:0] nbits_i,
  input      [3:0] cnt_i,
  output reg [1:0] opc_o,   // counter
  output reg       en_o,   // sipo
  output reg       eor_o
);

  localparam [3:0] s0  = 4'b0000, // Esperar rx
                   s1  = 4'b0001, // Flanco 1
                   s2  = 4'b0010, // Flanco 2
                   s3  = 4'b0011, // Recorrer bit
                   s4  = 4'b0100, // Flanco 3
                   s5  = 4'b0101, // Flanco 4
                   s6  = 4'b0110, // Sumar contador
                   s7  = 4'b0111, // Flanco de salida 1
                   s8  = 4'b1000; // Flanco de salida 2

  reg [3:0] present_state, next_state;

  // Logica proximo estado y decodificacion de salida
  always @(rx_i, z_i, nbits_i, cnt_i, present_state) begin
    next_state = present_state;
    opc_o = 2'b01; en_o = 1'b0; eor_o = 1'b0;
    case (present_state)
      s0 : begin // Esperar rx
             opc_o = 2'b00; en_o = 1'b0; eor_o = 1'b1;
             if (~rx_i)
               next_state = s1;
           end
      s1 : begin // Flanco 1
             if (z_i)
               next_state = s2;
           end
      s2 : begin // Flanco 2
             if (z_i)
               next_state = s3;
           end
      s3 : begin // Recorrer bit
             opc_o = 2'b01; en_o = 1'b1; eor_o = 1'b0;
             next_state = s4;
           end
      s4 : begin // Flanco 3
             if (z_i)
               next_state = s5;
           end
      s5 : begin // Flanco 4
             if (z_i) begin
               if (cnt_i == nbits_i) begin
                 next_state = s7;
               end else begin
                 next_state = s6;
               end
             end
           end
      s6 : begin // Sumar contador
             opc_o = 2'b10; en_o = 1'b0; eor_o = 1'b0;
             next_state = s1;
           end
      s7 : begin // Flanco de salida 1
             if (z_i)
               next_state = s8;
           end
      s8 : begin // Flanco de salida 2
             if (z_i)
               next_state = s0;
           end
 default : begin // Regresar a s0 por default
             next_state = s0;
           end
    endcase 
  end

  // Registro de estado
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      present_state <= s0;
    else
      present_state <= next_state;
  end

endmodule
