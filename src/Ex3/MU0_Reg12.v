// COMP12111 Exercise 3 - MU0_Reg12 
// Version 2024. P W Nutter
// 
// 12-bit Register implementation
//
// Implement using behavioural Verilog
//
// Comments:
//
// This Verilog module implements a 12-bit register for the MU0 Processor. It is updated at every rising edge of the clock
// when the Clock Enable Input is hight. It also features a asynchronous Reset which clears the output Q to 0. This module 
// has the following ports:
//	- Clk = the clock input to the register
//	- Reset = the reset input to the register
//	- En = clock enable input to the register
//	- D = 12-bit data input
//	- Q = 12-bit output representing the 12-bit value stored in the register
//

// Do not touch the following line it is required for simulation 
`timescale 1ns/100ps

// for simulation purposes, do not delete
`default_nettype none

// module definition

module MU0_Reg12 (
input  wire        Clk, 
input  wire        Reset,     
input  wire        En, 
input  wire [11:0] D, 
output reg  [11:0] Q
);

// behavioural code - clock driven

always @(posedge Clk, posedge Reset) // even if it is synchronous it acts asynchronously because of the reset, we use <= non-blocking assignment. sequential(depends on both current inputs and past states)

begin
	if(Reset)
		Q <= 12'h000; // Resets Q to 0 when asynchronous Reset input is high
	else if(En)
		Q <= D; // On the rising edge of Clk, if En is high, the value of D is loaded into the register and Q is updated with its value
end


endmodule 

// for simulation purposes, do not delete
`default_nettype wire
