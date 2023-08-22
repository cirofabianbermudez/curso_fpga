// Author: Julisa Verdejo Palacios
// Name: fsm_ciro.v
//
// Description: 

module fsm_ciro (
  input            rst_i,
  input            clk_i,
  input            stc_i,
  input            eot_i,
  output reg       sttx_o,
  output reg [7:0] data_o,
  output reg       eoc_o
);

  localparam [3:0] s0  = 4'd0,  // Esperar por stc_i
                   s1  = 4'd1,  // Mandar y
                   s2  = 4'd2,  // Esperar que termine
                   s3  = 4'd3,  // Mandar o
                   s4  = 4'd4,  // Esperar que termine
                   s5  = 4'd5,  // Mandar y
                   s6  = 4'd6,  // Esperar que termine
                   s7  = 4'd7,  // Mandar e
                   s8  = 4'd8,  // Esperar que termine
                   s9  = 4'd9,  // 
                   s10 = 4'd10, // 
                   s11 = 4'd11, // 
                   s12 = 4'd12, // 
                   s13 = 4'd13, // 
                   s14 = 4'd14, // 
                   s15 = 4'd15; // 

  reg [3:0] next_state, present_state;

  always @(stc_i, eot_i, present_state) begin
    sttx_o = 1'b0; data_o = 8'h00; eoc_o = 1'b0;
    next_state = present_state;
    case (present_state)
      s0 : begin // Esperar por stc_i
             sttx_o = 1'b0; data_o = 8'h00; eoc_o = 1'b1;
             if (stc_i)
               next_state = s1;
           end
      s1 : begin // Mandar c
             sttx_o = 1'b1; data_o = 8'h63; eoc_o = 1'b0;
             next_state = s2;
           end
      s2 : begin // Esperar que termine
             sttx_o = 1'b0; data_o = 8'h63; eoc_o = 1'b0;
             if (eot_i)
               next_state = s3;
           end
      s3 : begin // Mandar i
             sttx_o = 1'b1; data_o = 8'h69; eoc_o = 1'b0;
             next_state = s4;
           end
      s4 : begin // Esperar que termine
             sttx_o = 1'b0; data_o = 8'h69; eoc_o = 1'b0;
             if (eot_i)
               next_state = s5;
           end
      s5 : begin // Mandar r
             sttx_o = 1'b1; data_o = 8'h72; eoc_o = 1'b0;
             next_state = s6;
           end
      s6 : begin // Esperar que termine
             sttx_o = 1'b0; data_o = 8'h72; eoc_o = 1'b0;
             if (eot_i)
               next_state = s7;
           end
      s7 : begin // Mandar o
             sttx_o = 1'b1; data_o = 8'h6f; eoc_o = 1'b0;
             next_state = s8;
           end
      s8 : begin // Esperar que termine
             sttx_o = 1'b0; data_o = 8'h6f; eoc_o = 1'b0;
             if (eot_i)
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