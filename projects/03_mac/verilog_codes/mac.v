`include "adder.v"
`include "mult.v"
`include "ff_hab.v"
`include "ff_opc.v"
`include "counter_opc.v"
`include "ajuste.v"
`include "fsm_mac.v"

module mac (
  input         clk_i,
  input         rst_i,
  input         stf_i,
  input  [17:0] x_i,
  input  [35:0] a_i,
  input   [5:0] n_i,
  input   [5:0] s_i,
  output [17:0] y_o,
  output  [5:0] i_o,
  output        eof_o
);

  // Conexiones entre modulos
  wire [59:0] p, u, q, r;    
  // Conexiones entre FSM y Contador
  wire z;
  wire [1:0] opc;
  // Conexiones entre FSM y flip flops
  wire ldr;
  wire [1:0] lda;  
  
  mult         #(.na(36), .nx(18)) mod_mult    (.x_i(x_i),     .a_i(a_i),     .mult_o(p));
  adder        #(.n(60))           mod_adder   (.p_i(p),       .q_i(q),       .sum_o(u));
  ff_opc       #(.n(60))           mod_ff_opc  (.clk_i(clk_i), .rst_i(rst_i), .hab_i(lda),   .d_i(u),     .q_o(q));
  fsm_mac                          mod_fsm_mac (.clk_i(clk_i), .rst_i(rst_i), .stf_i(stf_i), .z_i(z),     .opc_o(opc), .lda_o(lda), .ldr_o(ldr), .eof_o(eof_o));
  counter_opc  #(.n(6))            mod_count   (.clk_i(clk_i), .rst_i(rst_i), .n_i(n_i),     .opc_i(opc), .i_o(i_o),   .z_o(z));
  ff_hab       #(.n(60))           mod_ff_hab  (.clk_i(clk_i), .rst_i(rst_i), .hab_i(ldr),   .d_i(u),     .q_o(r));  
  ajuste                           mod_ajus    (.r_i(r),       .s_i(s_i),     .y_o(y_o));
  
endmodule