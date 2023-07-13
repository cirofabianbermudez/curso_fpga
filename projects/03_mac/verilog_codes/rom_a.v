// A(7,28)
module rom_a #(
  parameter  Addr = 6,
  parameter Width = 36
) (
  input       [Addr-1:0] addr,
  output reg [Width-1:0] value_a
);
  
  always@(addr) begin
    case(addr)
      0: value_a = 36'b000000101000000000000000000000000000; //  2.500
      1: value_a = 36'b000000110000000000000000000000000000; //  3.000
      2: value_a = 36'b000000111000000000000000000000000000; //  3.500
      3: value_a = 36'b000001000000000000000000000000000000; //  4.000
      4: value_a = 36'b000001001000000000000000000000000000; //  4.500
      5: value_a = 36'b000001010000000000000000000000000000; //  5.000
      default : value_a = 36'b000000000000000000000000000000000000;         
    endcase
  end    
  
endmodule