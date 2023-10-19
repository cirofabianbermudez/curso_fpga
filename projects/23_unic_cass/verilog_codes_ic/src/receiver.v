// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description: 

module receiver #(
  parameter Nbits  = 8,
  parameter Sticks = 16
) ( 
  input        clk_i,
  input        rst_i,
  input        rx_i,
  input        tick_i,
  output reg   eor_o,
  output [7:0] dout_o
);

  localparam [1:0] idle  = 2'b00,
                   start = 2'b01,
                   data  = 2'b10,
                   stop  = 2'b11;

  reg [1:0] state_reg, state_next; // state register
  reg [3:0] s_reg    , s_next;     // number of sample ticks
  reg [2:0] n_reg    , n_next;     // number bits recived
  reg [7:0] b_reg    , b_next;     // shift register
  
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin 
      state_reg <= idle;
          s_reg <= 0;
          n_reg <= 0;
          b_reg <= 0;
    end else begin
      state_reg <= state_next;
          s_reg <= s_next;
          n_reg <= n_next;
          b_reg <= b_next;
    end
  end
  
  always @(*) begin
    state_next = state_reg;
    eor_o = 1'b0;
    s_next = s_reg;
    n_next = n_reg;
    b_next = b_reg;
    case (state_reg)
      idle: begin
              if (~rx_i) begin
                state_next = start;
                s_next = 0;
              end
            end
     start: begin
              if (tick_i) begin
                if (s_reg == 7) begin
                  state_next = data;
                  s_next = 0;
                  n_next = 0;
                end else begin
                  s_next = s_reg + 1;
                end
              end
            end
      data: begin
              if (tick_i) begin
                if (s_reg == 15) begin
                  s_next = 0;
                  b_next = {rx_i, b_reg[7:1]};
                  if (n_reg == (Nbits-1)) begin
                    state_next = stop;
                  end else begin
                    n_next = n_reg + 1;
                  end
                end else begin
                  s_next = s_reg + 1;
                end
              end
            end
      stop: begin
              if (tick_i) begin
                if (s_reg == (Sticks-1)) begin
                  state_next = idle;
                  eor_o = 1'b1;
                end else begin
                  s_next = s_reg + 1;
                end
              end
            end
    endcase
  end
  
  assign dout_o = b_reg;
  
endmodule
