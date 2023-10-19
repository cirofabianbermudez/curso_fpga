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
  output reg             start_sar_o
);

  localparam [2:0] s0 = 3'd0,
                   s1 = 3'd1,
                   s2 = 3'd2,
                   s3 = 3'd3,
                   s4 = 3'd4,
                   s5 = 3'd5,
                   s6 = 3'd6,
                   s7 = 3'd7;
		
  reg [2:0] state_reg, state_next;
	
  always @(*) begin
    state_next = state_reg;
    start_tx_o     = 1'b0;
    start_ramp_o   = 1'b0;
    start_sar_o    = 1'b0;
    case (state_reg)
      s0: begin // Idle
            if (eor_i) begin
              state_next = s1;
            end 
          end
      s1: begin // CMD decode and activate Ramp
            if (cmd_buffer_i == 8'h01) begin
              state_next = s2;
              start_ramp_o = 1'b1;
            end else begin
              state_next = s0;
            end
          end
      s2: begin // Sync with tick_10ms and activate SAR
             if (tick_10ms_i) begin
               start_sar_o = 1'b1;
               state_next = s3;
             end
          end
      s3: begin // Wait SAR and activate tx
            if (eosar_i) begin
              start_tx_o = 1'b1;
              state_next = s4;
            end
          end
      s4: begin // Wait tx
            if (eot_i) begin
               if (eoramp_i) begin
                 state_next = s6;
               end else begin
                 state_next = s5;
               end
            end
          end
      s5: begin // Sync with tick_1ms and activate SAR
            if (tick_1ms_i) begin
              start_sar_o = 1'b1;
              state_next = s3;
            end
          end
      s6: begin // Dummy state
            state_next = s7;
          end
      s7: begin // Dummy state
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
