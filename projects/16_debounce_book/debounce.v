// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description: 

module debounce ( 
  input      clk_i,
  input      rst_i,
  input      sw_i,
  output reg db_level_o,
  output reg db_tick_o
);

  // symbolic state_declaration
  localparam [1:0] zero  = 2'b00,
                   wait0 = 2'b01,
                   one   = 2'b10,
                   wait1 = 2'b11;

  // number of counter bits (2^Nbits * 20ns = 40ns)
  localparam Nbits = 26;

  reg [Nbits-1:0] q_reg, q_next;
  reg [1:0] state_reg, state_next;

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      state_reg <= zero;
      q_reg     <= {Nbits{1'b0}};
    end else begin
      state_reg <= state_next;
      q_reg     <= q_next;
    end
  end

  // next state logic for read and write pointers
  always @(*) begin
    state_next = state_reg;
    q_next = q_reg;
    db_tick_o = 1'b0;
    case (state_reg)
      zero : begin
               db_level_o = 1'b0;
               if (sw_i) begin
                 state_next  = wait1;
                 q_next = {Nbits{1'b1}};
               end
             end
     wait1 : begin 
               db_level_o = 1'b0;
               if (sw_i) begin
                 q_next = q_reg - 26'd1;
                 if (q_next == {Nbits{1'b0}}) begin
                   state_next = one;
                   db_tick_o = 1'b1;
                 end
               end else begin
                 state_next = zero;
               end
             end
       one : begin
               db_level_o = 1'b1;
               if (~sw_i) begin
                 state_next = wait0;
                 q_next = {Nbits{1'b1}};
               end
             end
     wait0 : begin
               db_level_o = 1'b1;
               if (~sw_i) begin
                 q_next = q_reg - 26'd1;
                 if (q_next == {Nbits{1'b0}}) begin
                   state_next = zero;
                 end
               end else begin
                 state_next = one;
               end
             end
	default : begin
	            state_next = zero;
	          end
    endcase
  end

endmodule
