// Author: Ciro Fabian Bermudez Marquez
// Name: piso_reg.v
//
// Description: Paralel In Serial Out register

module piso_reg #(
  parameter Width = 8	
) (
  input 		        rst_i,
  input 		        clk_i,
  input [Width-1:0] d_i,
  input       [1:0] op_i,
  output            q_o
);	

  reg [Width-1:0] d_mux, d_reg;
	
  always @(d_i, op_i, d_reg) begin
    case (op_i)
      2'b00   : d_mux = d_reg;
      2'b01   : d_mux = d_i;
      2'b10   : d_mux = {d_reg[Width-2:0],1'b0};
      default : d_mux = 0;
    endcase
  end	

  always @(posedge clk_i, posedge rst_i) begin		
    if (rst_i)
      d_reg <= 0;
    else
      d_reg <= d_mux;	 
  end

  assign q_o = d_reg[Width-1];

endmodule