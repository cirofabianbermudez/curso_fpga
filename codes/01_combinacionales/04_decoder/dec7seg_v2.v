// Author: Guadalupe Alonso
// Name: dec7seg_v2.v
//
// Description: 7-Segment Decoder: second option

module dec7seg_v2 (
  input      [3:0] binary,
  output reg [6:0] leds       
);

  always @(binary) begin
    if (binary == 4'd0) begin
        leds = 7'b1111110;
    end else if (binary == 4'd1) begin
        leds = 7'b0110000; 
    end else if (binary == 4'd2) begin
        leds = 7'b1101101; 
    end else if (binary == 4'd3) begin
        leds = 7'b1111001; 
    end else if (binary == 4'd4) begin
        leds = 7'b0110011; 
    end else if (binary == 4'd5) begin
        leds = 7'b1011011; 
    end else if (binary == 4'd6) begin
        leds = 7'b1011111; 
    end else if (binary == 4'd7) begin
        leds = 7'b1110001; 
    end else if (binary == 4'd8) begin
        leds = 7'b1111111; 
    end else if (binary == 4'd9) begin
        leds = 7'b1110011; 
    end else if (binary == 4'd10) begin
        leds = 7'b1110111; 
    end else if (binary == 4'd11) begin
        leds = 7'b0011111; 
    end else if (binary == 4'd12) begin
        leds = 7'b1001110; 
    end else if (binary == 4'd13) begin
        leds = 7'b0111101; 
    end else if (binary == 4'd14) begin
        leds = 7'b1001111; 
    end else if (binary == 4'd15) begin
        leds = 7'b1000111; 
    end else begin 
        leds = 7'b0000000;
    end
  end

endmodule
