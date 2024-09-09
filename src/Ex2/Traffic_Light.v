// Verilog HDL for "COMP12111", "trafficlight" "functional"
//
// COMP12111 - Exercise 2 – Sequential Circuits
//
// Version 2024. P W Nutter
//
// This is the Verilog module for the traffic light junction
//
// The aim of this exercise is complete the finite state machine using the
// state transition diagram given in the laboratory notes. 
//
// DO NOT change the interface to this design or it may not be marked completely
// when submitted.
//
// Make sure you document your code and marks may be awarded/lost for the 
// quality of the comments given.
//
// Add your comments:
//
//
//

`timescale  1ns / 100ps
`default_nettype none

module Traffic_Light ( 	output reg [5:0] lightseq,	//the 6-bit light sequence
		         		input  wire      clock,		//clock that drives the fsm
		         		input  wire      reset,		//reset signal 
		         		input  wire      D1, D2);	//inputs from cars

// declare internal variables here
	


// implement your next state combinatorial logic block here



// implement your current state assignment, register, here



// implement your output logic here




endmodule

`default_nettype wire
