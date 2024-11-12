// COMP12111 Exercise 3 - MU0_Reg16 Testbench
// Version 2024. P W Nutter
//
// Testbench for the 16-bit Register
// DUT is instantiated for you.
// Need to complete the test stimulus.
//
// Comments:
//
// Testing pairs of inputs, covering unknown modes and different number combinations of the signals.
// 

// Do not touch the following lines as they required for simulation 
`timescale  1ns / 100ps
`default_nettype none

module MU0_Reg16_Testbench();

//  Internal signals have been defined for you
//  and must be used for this excercise 
//  DO NOT alter the names of these signals 

reg   [15:0] D;
reg          Clk;
reg          Reset;
reg          En; 
wire  [15:0] Q;


// The design has been instantiated for you below:

MU0_Reg16 top(.D(D), .Clk(Clk), .Reset(Reset), .En(En), .Q(Q) );


/* Comment block

#VALUE      creates a delay of VALUE ps
a=VALUE;    sets the value of input 'a' to VALUE
$stop;      tells the simulator to stop

*/

// Clk setup

initial Clk = 1'b0;	// initialise clock to 0 at time 0

// the following always block creates the clock signal, period is 2 x 50ns = 100ns
always					// always do the following
begin
	#50					// wait half a clock period
	Clk = ~Clk;		// invert the clock (~ is a binary NOT operation)
end

initial
begin
// Enter you stimulus below this line
// -------------------------------------------------------

	Reset = 1'bx; // Unknown mode
	En = 1'bx;
	D = 16'hxxxx;
	// Expect Q = 16'hxxxx

	#100; // Reset high, En low
	Reset = 1'b1;
	En = 1'b0;
	D = 16'h1111;
	// Expect Q = 16'h0000

	#100; // Reset high, En high (reset should be prioritized)
	Reset = 1'b1;
	En = 1'b1;
	D = 16'h1111;
	// Expect Q = 16'h0000

	#100; // Reset low, En high
	Reset = 1'b0;
	En = 1'b1;
	D = 16'h2222;
	// Expect Q = 16'h2222

	#100; // Reset low, En low
	Reset = 1'b0;
	En = 1'b0;
	D = 16'h3333;
	// Expect Q = 16'h2222

// -------------------------------------------------------
// Please make sure your stimulus is above this line

#100 $stop;
end


endmodule

`default_nettype wire
