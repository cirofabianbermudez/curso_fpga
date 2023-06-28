//Aurhor: Guadalupe Alonso
//Name: LUT2_1.v
//
//Another second option of Look Up Table

module LUT2_1(

    input A,
    input B,
    input C,
    input D,
    output x
);

    wire c1;
    wire c2;
    wire c3;

    assign c1 = ~A & B & ~C;
    assign c2 = A & B & ~C;
    assign c3 = B & ~C & D;
    assign x = c1 | c2 | c3;

endmodule