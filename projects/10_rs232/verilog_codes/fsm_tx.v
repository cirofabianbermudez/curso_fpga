// Author: Julisa Verdejo Palacios
// Name: fsm_tx.v
//
// Description: Maquina de estados de la transmision

module fsm_tx (
  input            clk_i,   // Reloj del sistema
  input            rst_i,   // Reset del sistema
  input            st_i,    // Start
  input            z_i,     // Base de tiempo
  input            psel_i,  // Selector de paridad
  output reg [3:0] sel_o,   // Habilitador de mux
  output reg       eot_o    // Fin de transmision
);

  localparam [3:0] s0  = 4'b0000, // Wait y stop bit
                   s1  = 4'b0001, // Sincronizacion
                   s2  = 4'b0010, // Start bit
                   s3  = 4'b0011, // D0
                   s4  = 4'b0100, // D1
                   s5  = 4'b0101, // D2
                   s6  = 4'b0110, // D3
                   s7  = 4'b0111, // D4
                   s8  = 4'b1000, // D5
                   s9  = 4'b1001, // D6
                   s10 = 4'b1010, // D7
                   s11 = 4'b1011; // Parity

  reg [3:0] present_state, next_state;
  
  // Logica proxima 
  always @(st_i, z_i, psel_i, present_state) begin
    next_state = present_state;
    case (present_state)
      s0 : begin // Wait y stop bit
             sel_o = 4'b0000; eot_o = 1'b1;
             if(st_i)
               next_state = s1;
           end
      s1 : begin // Sincronizacion
             sel_o = 4'b0000; eot_o = 1'b0;
             if (z_i)
               next_state = s2;
           end
      s2 : begin // Start bit
             sel_o = 4'b0001; eot_o = 1'b0;
             if (z_i)
               next_state = s3;
           end
      s3 : begin // D0
             sel_o = 4'b0010; eot_o = 1'b0;
             if (z_i)
               next_state = s4;
           end
      s4 : begin // D1
             sel_o = 4'b0011; eot_o = 1'b0;
             if (z_i)
               next_state = s5;
           end
      s5 : begin // D2
             sel_o = 4'b0100; eot_o = 1'b0;
             if (z_i)
               next_state = s6;
           end
      s6 : begin // D3
             sel_o = 4'b0101; eot_o = 1'b0;
             if (z_i)
               next_state = s7;
           end
      s7 : begin // D4
             sel_o = 4'b0110; eot_o = 1'b0;
             if (z_i)
               next_state = s8;
           end
      s8 : begin // D5
             sel_o = 4'b0111; eot_o = 1'b0;
             if (z_i)
               next_state = s9;
           end
      s9 : begin // D6
             sel_o = 4'b1000; eot_o = 1'b0;
             if (z_i)
               next_state = s10;
           end
     s10 : begin // D7
             sel_o = 4'b1001; eot_o = 1'b0;
             if (z_i) begin
               if (psel_i)
                 next_state = s11;
               else
                 next_state = s0;
             end
           end
     s11 : begin // Paridad
             sel_o = 4'b1010; eot_o = 1'b0;
             if (z_i)
               next_state = s0;
           end
       default : begin     // regresar a S0 por default
                   next_state = s0;
                 end
    endcase	
  end


  // Registro de estado
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      present_state <= 0;
    else
      present_state <= next_state;
  end

endmodule