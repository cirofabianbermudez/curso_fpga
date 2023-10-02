// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

module fsm_sar #(
  parameter Width = 10
) (
  input                  clk_i,
  input                  rst_i,
  input                  start_i,
  input                  cmp_i,
  output reg [Width-1:0] result_o,
  output     [Width-1:0] dac_o,
  output reg             sample_o,
  output reg             eoc_o
);
  
  localparam [1:0] s0 = 2'b00,  // Wait
                   s1 = 2'b01,  // Sample
                   s2 = 2'b10,  // Convertion
                   s3 = 2'b11;  // Done
                   
  reg       [1:0] state_reg, state_next;
  reg [Width-1:0]  mask_reg, mask_next;
  reg [Width-1:0]  res_reg,  res_next;
  reg              enable;
  
  always @(*) begin
    sample_o = 1'b0;
    eoc_o    = 1'b0;
    enable   = 1'b0;
    mask_next  = mask_reg;
    res_next   = res_reg;
    state_next = state_reg;
    case (state_reg)
      s0: begin  // Wait
            eoc_o = 1'b1;
            if (start_i) begin
              state_next = s1;
            end
          end
      s1: begin // Sample
            state_next = s2;
            sample_o  = 1'b1;
            mask_next = 10'b1000000000;
            res_next  = 10'b0000000000;
          end
      s2: begin // Convertion
            mask_next = mask_reg >> 1;
            if (cmp_i) begin
              res_next  = res_reg | mask_reg;
            end
            if (mask_reg[0]) begin
              state_next = s3;
            end  
          end
      s3: begin // Done
            state_next = s0;
            enable = 1'b1;
          end
    endcase
  end

  assign dac_o = res_reg | mask_reg;

  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      state_reg <= s0;
      mask_reg  <= { Width {1'b0} };
      res_reg   <= { Width {1'b0} };
    end else begin
      state_reg <= state_next;
      mask_reg  <= mask_next;
      res_reg   <= res_next;
    end
  end
  
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      result_o <= { Width {1'b0} };
    end else if (enable) begin
      result_o <= res_reg;
    end
  end
  
endmodule