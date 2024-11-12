// COMP12111 Exercise 3 - MU0_Mux16 
// Version 2024. P W Nutter
// 
// 2-to-1 16-bit MUX implementation
//
// Implement using behavioural Verilog
//
// Comments:
//
// This Verilog module implements a 12-bit 2-to-1 multiplexer for the MU0 processor. It takes two 12-bit inputs
// and selects one of them as the output based on a single-bit select signal (S). The module has the
// following ports:
// 	- A = 12-bit input
//	- B = 12-bit input
//	- S = 1-bit control signal to select which of the two inputs is connected to the output
//	- Q = 12-bit output that is connected to one of the inputs
//

// Do not touch the following line it is required for simulation 
`timescale 1ns/100ps

// for simulation purposes, do not delete
`default_nettype none

// module definition

module MU0_Mux16 (
input  wire  [15:0] A, 
input  wire  [15:0] B, 
input  wire         S, 
output reg   [15:0] Q);


// Combinatorial logic for 2to1 multiplexor
// S is select, A channel0, B channel1

always @(*) // asynchronous (w/o global clock), combinatorial (the output depends on current inputs), we use = blocking assignment
begin
	if (S == 1'b0)	Q = A; // if S = 0 we output A
	else 			Q = B; // else (S = 1) we output B
end


endmodule 

// for simulation purposes, do not delete
`default_nettype wire
