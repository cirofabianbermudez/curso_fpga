// Author: Ciro Fabian Bermudez Marquez
// Name: piso_reg.v
//
// Description: Paralel In Serial Out register

module piso_reg #(
  parameter n = 8	
) (
  input 		    rst,
  input 		    clk,
  input [n-1:0]	d,
  input	  [1:0]	op,
  output 		    q
);	

  reg [n-1:0] d_mux, d_reg;
	
  always @(d, op, d_reg) begin
    case (op)
      2'b00 : d_mux = d_reg;
      2'b01 : d_mux = d;
      2'b10 : d_mux = {d_reg[n-2:0],1'b0};
      default : d_mux = 0;
    endcase						   
  end	

  always @(posedge clk, posedge rst) begin		
    if (rst)
      d_reg <= 0;
    else
      d_reg <= d_mux;	 
  end
	
  assign q = d_reg[n-1];
	
endmodule