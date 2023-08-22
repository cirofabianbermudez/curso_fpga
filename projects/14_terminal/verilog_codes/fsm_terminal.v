// Author: Julisa Verdejo Palacios
// Name: fsm_terminal.v
//
// Description: FSM para terminal de comandos

module fsm_terminal (
  input      rst_i,
  input      clk_i,
  input      eor_i,
  input      eofsm_i,
  output reg en_o,
  output reg clear_o,
  output reg stfsm_o
);

  localparam [3:0] s0  = 4'd0,  // Detectar activacion de rx
                   s1  = 4'd1,  // Esperar que termine rx 
                   s2  = 4'd2,  // Cargar buffer
                   s3  = 4'd3,  // Activar fsm
                   s4  = 4'd4;  // Esperar a que termine


  reg [3:0] next_state, present_state;

  always @(eor_i, eofsm_i, present_state) begin
    en_o = 1'b0; clear_o = 1'b0; stfsm_o = 1'b0;
    next_state = present_state;
    case (present_state)
      s0 : begin // Detectar activacion de rx y limpiar buffer
             en_o = 1'b0; clear_o = 1'b1; stfsm_o = 1'b0;
             if (~eor_i)
               next_state = s1;
           end
      s1 : begin // Esperar que termine rx 
             if (eor_i)
               next_state = s2;
           end
      s2 : begin // Cargar buffer
             en_o = 1'b1; clear_o = 1'b0; stfsm_o = 1'b0;
             next_state = s3;
           end
      s3 : begin // Activamos fsm
              en_o = 1'b0; clear_o = 1'b0; stfsm_o = 1'b1;
              next_state = s4;
           end            
      s4 : begin // Esperar que termine la fsm
             if (eofsm_i)
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