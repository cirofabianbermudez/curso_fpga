module shift_reg #(
  parameter n = 32
) (
  input      [n-1:0] d_i,
  input        [3:0] addr_i,
  output reg [n-1:0] q_o
);

  wire sign;			 
  assign sign = d_i[n-1];
  
  always @(addr_i,d_i) begin
    case(addr_i)
      0 : q_o = d_i;
  	  1 : q_o = { { 1{sign}} , d_i[n-1: 1] }; 
      2 : q_o = { { 2{sign}} , d_i[n-1: 2] }; 
      3 : q_o = { { 3{sign}} , d_i[n-1: 3] }; 
      4 : q_o = { { 4{sign}} , d_i[n-1: 4] }; 
      5 : q_o = { { 5{sign}} , d_i[n-1: 5] }; 
      6 : q_o = { { 6{sign}} , d_i[n-1: 6] }; 
      7 : q_o = { { 7{sign}} , d_i[n-1: 7] }; 
      8 : q_o = { { 8{sign}} , d_i[n-1: 8] }; 
      9 : q_o = { { 9{sign}} , d_i[n-1: 9] }; 
     10 : q_o = { {10{sign}} , d_i[n-1:10] }; 
     11 : q_o = { {11{sign}} , d_i[n-1:11] }; 
     12 : q_o = { {12{sign}} , d_i[n-1:12] }; 
     13 : q_o = { {13{sign}} , d_i[n-1:13] }; 
     14 : q_o = { {14{sign}} , d_i[n-1:14] }; 
     15 : q_o = { {15{sign}} , d_i[n-1:15] };  
  	 default : q_o = d_i; 				
    endcase
  end
  
endmodule