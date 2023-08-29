// Author: Ciro Fabian Bermudez Marquez
// Name: cu.v
//
// Control Unit for system
module cu (
  input      rst_i,
  input      clk_i,
  input      start_i,
  output reg en_o,
  output reg sel_o
);

  localparam [1:0]
    s0 = 0, // Esperar   1
    s1 = 1,	// Habilitar 1
    s2 = 2,	// Esperar   2
    s3 = 3;	// Habilitar 2
		
  reg [1:0] state_reg, state_next;
	
  always @(start_i, state_reg) begin
    state_next = state_reg; // default state_next
    case (state_reg)
      s0: begin
            sel_o = 0;
            en_o  = 0;
            if (start_i) begin
              state_next = s1;
            end 
          end
      s1: begin
            sel_o = 0;
            en_o  = 1;
            state_next = s2;
          end
      s2: begin
            sel_o = 1;
            en_o  = 0;
            if (start_i) begin
              state_next = s3;
            end 
          end
      s3: begin
            sel_o = 1;
            en_o  = 1;
            state_next = s2;
         end
      default: begin
                 sel_o = 0;
                 en_o  = 0;
                 state_next = s0;
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