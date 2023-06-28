//Aurhor: Guadalupe Alonso
//Name: LUT3.v
//
//Third option of Look Up Table

module LUT3(

    input A,
    input B,
    input C,
    input D,
    output reg x
);

    always @(A,B,C,D)
    begin
        if((A & ~B & ~C & ~D) | (A & B & C & ~D) | (A & B & ~C & D) | (A & B & C & D))
            x=1;
        else
            x=0;
    end

endmodule