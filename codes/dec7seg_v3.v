// Author: Guadalupe Alonso
// Name: dec7seg_v3.v
//
// Description: 7-Segment Decoder: third option

module dec7seg_v3 (
  input  [3:0] binary,
  output [6:0] leds
);

  assign leds = (binary == 4'd0 ) ? 7'b1111110 :
                (binary == 4'd1 ) ? 7'b1111110 :
                (binary == 4'd2 ) ? 7'b1101101 :
                (binary == 4'd3 ) ? 7'b1111001 :
                (binary == 4'd4 ) ? 7'b0110011 :
                (binary == 4'd5 ) ? 7'b1011011 :
                (binary == 4'd6 ) ? 7'b1011111 :
                (binary == 4'd7 ) ? 7'b1110001 :
                (binary == 4'd8 ) ? 7'b1111111 :
                (binary == 4'd9 ) ? 7'b1110011 :
                (binary == 4'd10) ? 7'b1110111 :
                (binary == 4'd11) ? 7'b0011111 :
                (binary == 4'd12) ? 7'b1001110 :
                (binary == 4'd13) ? 7'b0111101 :
                (binary == 4'd14) ? 7'b1001111 :
                (binary == 4'd15) ? 7'b1000111 :
                                    7'b0000000 ;

endmodule
