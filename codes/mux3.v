//Author: Guadalupe Alonso
//Name: mux3.v
//
//Second option of multiplexer 4 inputs 1 output
module mux3 #(
   parameter Width = 32
) (
    input  [Width-1:0] in1,
    input  [Width-1:0] in2,
    input  [Width-1:0] in3,
    input  [Width-1:0] in4,
    input  [1:0]       sel,
    output [Width-1:0] ou1
);

    case (sel)
        2d'0   : ou1 = in1;
        2d'1   : ou1 = in2;
        2d'2   : ou1 = in3;
        2d'3   : ou1 = in4;
        default: ou1 = 0;
    endcase

endmodule