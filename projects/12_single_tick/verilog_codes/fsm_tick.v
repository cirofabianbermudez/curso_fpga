// Author: Julisa Verdejo Palacios
// Name: fsm_tick.v
//
// Description: FSM para logica de single tick

module fsm_tick (
  input      rst_i,
  input      clk_i,
  input      button_i,
  input      z_i,
  output reg start_o,
  output reg en_o
);

  localparam [1:0] s0 = 2'b00,  // Esperar por boton y desactivar base de tiempo
                   s1 = 2'b01,  // Mandar pulso y activar base de tiempo
                   s2 = 2'b10;  // Esperar base de tiempo

  reg [1:0] next_state, present_state;

  always @(button_i, z_i, present_state) begin
    start_o = 1'b0; en_o = 1'b0;
    next_state = present_state;
    case (present_state)
      s0 : begin
             if (button_i)
               next_state = s1;
           end
      s1 : begin 
             start_o = 1'b1; en_o = 1'b1;
             next_state = s2;
           end
      s2 : begin
             start_o = 1'b0; en_o = 1'b1;
             if (z_i)
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