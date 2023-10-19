// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description:

module ramp #(
  parameter Width = 10
) ( 
  input              clk_i,
  input              rst_i,
  input              start_i,
  output [Width-1:0] cnt_o,
  output             time_o,
  output             tick_10ms_o,
  output             tick_1ms_o,
  output             eos_o
);

  wire tick;
  wire fsm_en;
  wire fsm_up;
  wire max;
  wire min;
  
  assign tick_10ms_o = tick;

  mod_n_counter #(            // MaxVal = FPGA_freq * Tiempo      
    .Width(14),               // 5      26             17
    .MaxVal(10_000)          // 20     10_000_000     100_000     100
  ) mod_mod_n_counter_1ms (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .max_tick_o(tick_1ms_o)
  ); 
  
  mod_n_counter #(
    .Width(17),               //                       20
    .MaxVal(100_000)        //                       1_000_000   1_000
  ) mod_mod_n_counter_10ms (
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
  
  univ_counter #(
    .Width(Width)
  ) mod_univ_counter (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .en_i(tick & fsm_en),
    .up_i(fsm_up),
    .cnt_o(cnt_o),
    .max_tick_o(max),
    .min_tick_o(min)
  );

  fsm_ramp mod_fsm_ramp (
    .rst_i(rst_i),
    .clk_i(clk_i),
    .start_i(start_i),
    .tick_i(tick),
    .max_tick_i(max),
    .min_tick_i(min),
    .en_clk_o(fsm_en),
    .up_o(fsm_up),
    .eos_o(eos_o)
  );

endmodule
