// Author: Ciro Fabian Bermudez Marquez
// Name: cmd_decoder.v
//
// Description: 

module cmd_decoder ( 
  input      [7:0] buff_i,
  output reg [1:0] opcode_o
);
  
  always @(*) begin
    case (buff_i)
      8'h01    : opcode_o = 2'b01;
      8'h02    : opcode_o = 2'b10;
      default  : opcode_o = 2'b00; 
    endcase
  end
  
endmodule
