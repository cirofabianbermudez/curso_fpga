//Author: Guadalupe Alonso
//Name: decseg7_2.v
//
//7-Segment Decoder: second option
module decseg7_2 (
    input [3:0] int,
    output reg [6:0] out        //lo declaramos cono reg porque es una variable
);
    always @(int)
    begin
        if (int == 4'd0) begin
            out=7'b0000000;
        end else if (int == 4'd1) begin
            out=7'b0110000; 
        end else if (int == 4'd2) begin
            out=7'b1101101; 
        end else if (int == 4'd3) begin
            out=7'b1111001; 
        end else if (int == 4'd4) begin
            out=7'b0110011; 
        end else if (int == 4'd5) begin
            out=7'b1011011; 
        end else if (int == 4'd6) begin
            out=7'b1011111; 
        end else if (int == 4'd7) begin
            out=7'b1110001; 
        end else if (int == 4'd8) begin
            out=7'b1111111; 
        end else if (int == 4'd9) begin
            out=7'b1110011; 
        end else if (int == 4'd10) begin
            out=7'b1110111; 
        end else if (int == 4'd11) begin
            out=7'b0011111; 
        end else if (int == 4'd12) begin
            out=7'b1001110; 
        end else if (int == 4'd13) begin
            out=7'b0111101; 
        end else if (int == 4'd14) begin
            out=7'b1001111; 
        end else if (int == 4'd15) begin
            out=7'b1000111; 
        end else begin 
            out=7'b0000000;
        end
    end

endmodule