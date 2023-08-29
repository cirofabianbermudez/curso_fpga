`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2016 09:21:44 PM
// Design Name: 
// Module Name: debounce_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module debounce_tb();

//Inputs in the module enable_sr. Need to use register type
reg clk = 0; //clock signal
reg btn; //input button

//Outputs in the module enable_sr. Need to use net type
wire LED; //LED output. Light up when btn is pressed
wire dbsig; //debounced signal to logic analyzer
wire button_out1; //flip-flop1 signal to logic analyzer
wire button_out2; //flip-flop2 signal to logic analyzer

// Instantiate the Unit Under Test (UUT) for module debouncing
debouncing uut(
    .clk(clk),
    .btn(btn),
    .LED(LED),
    .dbsig(dbsig),
    .button_out1(button_out1),
    .button_out2(button_out2)
    );
    
// Generate the continuous clock signal. Wait for 10ns. Period is 20ns
always #10 clk = ~clk;

//Generate the button stimulus
initial begin 
    btn = 0; 
    #10 btn = 1;
end 

// Need initial whenever we run finish or we need to include it in the begin end 
	initial
		#4000 $finish;

    
   
endmodule
