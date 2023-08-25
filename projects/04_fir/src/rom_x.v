// A(7,10)
module rom_x #(
  parameter  Addr = 6,
  parameter Width = 18
) (
  input       [Addr-1:0] addr,
  output reg [Width-1:0] value_x
);

  always@(addr) begin
    case(addr)
      0: value_x = 18'b111111101000000000; // -1.500
      1: value_x = 18'b111111110000000000; // -1.000
      2: value_x = 18'b000000000000000000; //  0.000
      3: value_x = 18'b000000010000000000; //  1.000
      4: value_x = 18'b000000011000000000; //  1.500
      5: value_x = 18'b000000100000000000; //  2.000
      default : value_x = 18'b000000000000000000;         
    endcase
  end    
  
endmodule