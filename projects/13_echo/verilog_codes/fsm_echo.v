// Author: Julisa Verdejo Palacios
// Name: fsm_tick.v
//
// Description: FSM para logica de single tick

module fsm_echo (
  input      rst_i,
  input      clk_i,
  input      eor_i,
  input      eot_i,
  output reg sttx_o
);

  localparam [1:0] s0 = 2'b00,  // Detectar activacion de rx
                   s1 = 2'b01,  // Esperar que termine rx 
                   s2 = 2'b10,  // Activar tx
                   s3 = 2'b11;  // Esperar que termine tx

  reg [1:0] next_state, present_state;

  always @(eor_i, eot_i, present_state) begin
    sttx_o = 1'b0;
    next_state = present_state;
    case (present_state)
      s0 : begin // Detectar activacion de rx
             if (~eor_i)
               next_state = s1;
           end
      s1 : begin // Esperar que termine rx 
             if (eor_i)
               next_state = s2;
           end
      s2 : begin // Activar tx
             sttx_o = 1'b1;
             next_state = s3;
           end
      s3 : begin // Esperar que termine tx
             if (eot_i)
               next_state = s0;
           end            
 default : begin
             next_state = s0;
           end
    endcase
  end

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      present_state <= s0;
    else
      present_state <= next_state;
  end

endmodule