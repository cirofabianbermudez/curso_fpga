// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description: 

module debounce_explicit ( 
  input      clk_i,
  input      rst_i,
  input      sw_i,
  output reg db_level_o,
  output reg db_tick_o
);

  // symbolic state_declaration
  localparam [1:0] zero  = 2'b00,
                   wait1 = 2'b01,
                   one   = 2'b10,
                   wait0 = 2'b11;

  // number of counter bits (2^Nbits * 20ns = 40ns)
  localparam Nbits = 21;

  reg  [1:0] state_reg, state_next;
  reg  [Nbits-1:0] q_reg;
  wire [Nbits-1:0] q_next;
  wire q_zero;
  reg  q_load, q_dec;

  // fsmd state and data registers
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      state_reg <= zero;
      q_reg     <= 0;
    end else begin
      state_reg <= state_next;
      q_reg     <= q_next;
    end
  end

  assign q_next = (q_load) ? {Nbits{1'b1}} : 
                   (q_dec) ?     q_reg - 1 : 
                                 q_reg     ;

  assign q_zero = (q_next == 0);


  // next state logic for read and write pointers
  always @(*) begin
    state_next = state_reg;
    q_load = 1'b0;
    q_dec  = 1'b0;
    db_tick_o = 1'b0;
    case (state_reg)
      zero : begin
               db_level_o = 1'b0;
               if (sw_i) begin
                 state_next  = wait1;
                 q_load = 1'b1;
               end
             end
     wait1 : begin 
               db_level_o = 1'b0;
               if (sw_i) begin
                 q_dec = 1'b1;
                 if (q_zero) begin
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
                 q_load = 1'b1;
               end
             end
     wait0 : begin
               db_level_o = 1'b1;
               if (~sw_i) begin
                 q_dec = 1'b1;
                 if (q_zero) begin
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
