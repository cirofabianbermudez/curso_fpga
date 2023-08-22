// Author: Julisa Verdejo Palacios
// Name: cmd_decoder.v
//
// Description: Decodificador de comando

module cmd_decoder ( 
  input      [7:0] buff_i,
  output reg       sel_o,
  output reg [1:0] fsmsel_o
);
  
  always @(buff_i) begin
    case (buff_i)
      8'h00   : begin 
                  fsmsel_o = 2'b00; sel_o = 1'b0; 
                end
      8'h01   : begin 
                  fsmsel_o = 2'b01; sel_o = 1'b0; 
                end
      8'h02   : begin 
                  fsmsel_o = 2'b10; sel_o = 1'b1; 
                end
      default : begin 
                  fsmsel_o = 2'b00; sel_o = 1'b0; 
                end
    endcase
  end
  
endmodule