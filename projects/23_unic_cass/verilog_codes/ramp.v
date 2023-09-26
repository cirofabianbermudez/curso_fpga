// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

module ramp ( 
  input        clk_i,
  input        rst_i,
  input        start_i,
  output [7:0] cnt_o,
  output       time_o,
  output       max_o,
  output       min_o,
  output       eos_o
);
  
  wire tick;
  wire fsm_en;
  wire fsm_up;
  
  mod_n_counter #(
    .Width(26),             // 5
    .MaxVal(10_000_000)     // 20
  ) mod_mod_n_counter (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .max_tick_o(tick)
  );
  
  ff_toggle mod_ff_toggle (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .en_i(tick),
    .q_o(time_o)
  );
  
  univ_counter #(.Width(8)) mod_univ_counter (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .en_i(tick & fsm_en),
    .up_i(fsm_up),
    .cnt_o(cnt_o),
    .max_tick_o(max_o),
    .min_tick_o(min_o)
  );

  fsm_ramp mod_fsm_ramp (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .start_i(start_i),
    .tick_i(tick),
    .max_tick_i(max_o),
    .min_tick_i(min_o),
    .en_clk_o(fsm_en),
    .up_o(fsm_up),
    .eos_o(eos_o)
);

endmodule
