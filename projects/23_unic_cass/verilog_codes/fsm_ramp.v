// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description: 

module fsm_ramp (
  input      rst_i,
  input      clk_i,
  input      start_i,
  input      tick_i,
  input      max_tick_i,
  input      min_tick_i,
  output reg en_clk_o,
  output reg up_o,
  output reg eos_o
);

  localparam [1:0] s0 = 2'b00,
                   s1 = 2'b01,
                   s2 = 2'b10,
                   s3 = 2'b11;
		
  reg [1:0] state_reg, state_next;
	
  always @(*) begin
    state_next = state_reg; 
    en_clk_o = 1'b1;
    up_o     = 1'b1;
    eos_o    = 1'b0;
    case (state_reg)
      s0: begin // Esperar
            en_clk_o = 1'b0;
            up_o     = 1'b1;
            eos_o    = 1'b1;
            if (start_i) begin
              state_next = s1;
            end 
          end
      s1: begin // Sincronizacion
            en_clk_o = 1'b0;
            up_o     = 1'b1;
            eos_o    = 1'b1;
            if (tick_i) begin
              eos_o    = 1'b0;
              state_next = s2;
            end 
          end
      s2: begin // Incrementar
            if (max_tick_i) begin
              up_o     = 1'b0;
              state_next = s3;
            end 
          end
      s3: begin // Decrementar
            up_o     = 1'b0;
            if (min_tick_i) begin
              en_clk_o = 1'b0;
              state_next = s0;
            end 
          end
    endcase
  end

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      state_reg <= s0;
    end else begin
      state_reg <= state_next;
    end
  end	
  
endmodule
