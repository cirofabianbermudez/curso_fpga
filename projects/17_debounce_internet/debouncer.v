// Author: Ciro Fabian Bermudez Marquez
// Name: .v
//
// Description: 

module debouncer (
  input  clk_i,
  input  rst_i,
  input  sw_i,
  output db_level_o,
  output db_tick_o
);

  localparam MaxVal = 26'd50_000_000;  

  // Internal logic 
  reg  [1:0] ff_i;
  reg        ff_o;
  reg [25:0] counter; // more than enough for most frequencies

  wire clear_counter;
  wire counter_max;
  
  // Run the button through two flip-flops to avoid metastability issues
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      ff_i <= 0;
    end else begin
      ff_i[1:0] <= {ff_i[0], sw_i};
    end
  end

  assign clear_counter = ^ff_i;

  // Create the counter. 
  // For a freq of 50MHz a 19bit counter will create a time period
  // to validate the button's stability of 50mil/2**19
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      counter <= 0;
    end else if (clear_counter || counter_max) begin
      counter <= 0;
    end else begin
      counter <= counter + 1'b1;
    end
  end

  assign counter_max = (counter == MaxVal);

  // Create the output data logic
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      ff_o <= 0;
    end else if(counter_max) begin
      ff_o <= ff_i[1];
    end
  end

  assign db_level_o = ff_o;
  
  reg tick_reg;
  
  // single tick circuit
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      tick_reg <= 1'b0;
    else
      tick_reg <= ff_o;
  end
  
  assign db_tick_o = ~tick_reg & ff_o;
  

endmodule