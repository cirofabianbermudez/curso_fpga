// Author: Guadalupe Alonso
// Name: dec7seg.v
//
// Descrition: 7-Segment Decoder 

module dec7seg (
  input      [3:0] binary,
  output reg [6:0] leds        //lo declaramos como reg porque es una variable
);

  always @(binary) begin
    case (binary)
      4'd0    : leds = 7'b1111110;
      4'd1    : leds = 7'b0110000;
      4'd2    : leds = 7'b1101101;
      4'd3    : leds = 7'b1111001;
      4'd4    : leds = 7'b0110011;
      4'd5    : leds = 7'b1011011;
      4'd6    : leds = 7'b1011111;
      4'd7    : leds = 7'b1110001;
      4'd8    : leds = 7'b1111111;
      4'd9    : leds = 7'b1110011;
      4'd10   : leds = 7'b1110111;
      4'd11   : leds = 7'b0011111;
      4'd12   : leds = 7'b1001110;
      4'd13   : leds = 7'b0111101;
      4'd14   : leds = 7'b1001111;
      4'd15   : leds = 7'b1000111;
      default : leds = 7'b0000000;
    endcase
  end

endmodule
