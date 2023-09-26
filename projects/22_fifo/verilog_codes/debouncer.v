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

  localparam Width  = 26; 
  localparam MaxVal = 26'd50_000_000;

  // Internal logic 
  reg [1:0] ff_i;
  reg       ff_o;
  reg [Width-1:0] counter; // more than enough for most frequencies
  reg [Width-1:0] counter_next;
  wire clear_counter;
  wire counter_max;
  
  // Run the button through two flip-flops to avoid metastability issues
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      ff_i <= 0;
      counter <= 0;
    end else begin
      ff_i[1:0] <= {ff_i[0], sw_i};
      counter <= counter_next;
    end
  end

  assign clear_counter = ^ff_i;
  assign counter_max = (counter == MaxVal);
  
  always @(*) begin
    case ( {clear_counter, counter_max} )
      2'b00 : counter_next = counter + 1'b1;
      2'b01 : counter_next = counter;
    default : counter_next = { Width {1'b0} };
    endcase
  end

  // Create the output data logic
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i) begin
      ff_o <= 0;
    end else if(counter_max) begin
      ff_o <= ff_i[1];
    end
  end

  assign db_level_o = ff_o;
  
  // Edge detector circuit
  reg tick_reg;
  
  always @(posedge clk_i, posedge rst_i) begin
    if (rst_i)
      tick_reg <= 1'b0;
    else
      tick_reg <= ff_o;
  end
  
  assign db_tick_o = ~tick_reg & ff_o;
  
endmodule