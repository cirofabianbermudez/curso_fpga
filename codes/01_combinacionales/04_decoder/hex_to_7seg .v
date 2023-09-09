// Author: Guadalupe Alonso
// Name: dec7seg.v
//
// Descrition: 7-Segment Decoder Active high

module hex_to_7seg (
  input      [3:0] hex_i,
  input            dp_i,
  output reg [6:0] seg_o,
  output           dp_o
);

  always @(*) begin
    case (hex)
      4'h0    : seg_o = 7'b1111110;
      4'h1    : seg_o = 7'b0110000;
      4'h2    : seg_o = 7'b1101101;
      4'h3    : seg_o = 7'b1111001;
      4'h4    : seg_o = 7'b0110011;
      4'h5    : seg_o = 7'b1011011;
      4'h6    : seg_o = 7'b1011111;
      4'h7    : seg_o = 7'b1110001;
      4'h8    : seg_o = 7'b1111111;
      4'h9    : seg_o = 7'b1110011;
      4'ha    : seg_o = 7'b1110111;
      4'hb    : seg_o = 7'b0011111;
      4'hc    : seg_o = 7'b1001110;
      4'hd    : seg_o = 7'b0111101;
      4'he    : seg_o = 7'b1001111;
      4'hf    : seg_o = 7'b1000111;
      default : seg_o = 7'b0000000;
    endcase
  end
  
  assign dp_o = dp_i;

endmodule
