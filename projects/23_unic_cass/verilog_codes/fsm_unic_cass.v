// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

module fsm_unic_cass #(
  parameter Width = 8
) (
  input                  clk_i,
  input                  rst_i,
  input      [Width-1:0] cmd_buffer_i,
  input                  eor_i,
  input                  eot_i,
  input                  eoramp_i,
  input                  eosar_i,
  input                  tick_10ms_i,
  input                  tick_1ms_i,
  output reg             start_tx_o,
  output reg             start_ramp_o,
  output reg             start_sar_o,
  output reg             clear_buffer_o
);

  localparam [3:0] s0 = 4'd0,
                   s1 = 4'd1,
                   s2 = 4'd2,
                   s3 = 4'd3,
                   s4 = 4'd4,
                   s5 = 4'd5,
                   s6 = 4'd6,
                   s7 = 4'd7,
                   s8 = 4'd8;
		
  reg [3:0] state_reg, state_next;
	
  always @(*) begin
    state_next = state_reg;
    start_tx_o     = 1'b0;
    start_ramp_o   = 1'b0;
    start_sar_o    = 1'b0;
    clear_buffer_o = 1'b0;
    case (state_reg)
      s0: begin // Idle
            if (eor_i) begin
              state_next = s1;
            end 
          end
      s1: begin // CMD decode
            if (cmd_buffer_i == 8'h01) begin
              state_next = s2;
            end else begin
              state_next = s0;
            end
          end
      s2: begin // Activate Ramp
            start_ramp_o = 1'b1;
            state_next = s3;
          end
      s3: begin // Sync with tick_10ms
             if (tick_10ms_i) begin
               state_next = s4;
             end
          end
      s4: begin // Activate SAR
            start_sar_o = 1'b1;
            state_next = s5;
          end
      s5: begin // Wait SAR
            if (eosar_i) begin
              state_next = s6;
            end     
          end
      s6: begin // Activate tx
            start_tx_o = 1'b1;
            state_next = s7;
          end
      s7: begin // Wait tx
            if (eot_i) begin
              if (eoramp_i) begin
                state_next = s0;
              end else begin
                state_next = s8;
              end
            end
          end
      s8: begin // Sync with tick_1ms
             if (tick_1ms_i) begin
               state_next = s4;
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