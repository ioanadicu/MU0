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
// This file defines the behaviour of a traffic light junction as a FSM, using a 3-box model
//

`timescale  1ns / 100ps
`default_nettype none

// defining the outputs for the traffic lights
`define R__R__ 6'b100100	// states 0, 8
`define RA_R__ 6'b110100	// state 1
`define __GR__ 6'b001100	// states 2-6
`define _A_R__ 6'b010100	// state 7
`define R__RA_ 6'b100110	// state 9
`define R____G 6'b100001	// states 10-14
`define R___A_ 6'b100010	// state 15

module Traffic_Light ( 	output reg [5:0] lightseq,	//the 6-bit light sequence
		         		input  wire      clock,		//clock that drives the fsm
		         		input  wire      reset,		//reset signal 
		         		input  wire      D1, D2);	//inputs from cars


// declare internal variables here
// according to instructions page 7, we need to define 2 values as reg: one for the current_state and one for the next_state
reg [3:0] current_state;	// both values are 4 bits as we have 16 states (2^4 = 16)
reg [3:0] next_state;


// implement your next state combinatorial logic block here
always @ (*)	// asynchronous (w/o global clock), combinatorial (the output depends on current inputs), we use = blocking assignment
begin
	case(current_state)
		4'b0000: next_state = 4'b0001;	// from state 0  it goes to state 1  no matter what
		4'b0001: next_state = 4'b0010;	// from state 1  it goes to state 2  no matter what
		4'b0010: next_state = 4'b0011;	// from state 2  it goes to state 3  no matter what
		4'b0011: next_state = 4'b0100;	// from state 3  it goes to state 4  no matter what
		4'b0100: if(D2)	next_state = 4'b0111;	// if a car is waiting it goes to state 7
				 else	next_state = 4'b0101;	// or goes to state 5
		4'b0101: if(D2)	next_state = 4'b0111;	// if a car is waiting it goes to state 7
				 else	next_state = 4'b0110;	// or goes to state 6
		4'b0110: next_state = 4'b0111;	// from state 6  it goes to state 7  no matter what
		4'b0111: next_state = 4'b1000;	// from state 7  it goes to state 8  no matter what
		4'b1000: next_state = 4'b1001;	// from state 8  it goes to state 9  no matter what
		4'b1001: next_state = 4'b1010;	// from state 9  it goes to state 10 no matter what
		4'b1010: next_state = 4'b1011;	// from state 10 it goes to state 11 no matter what
		4'b1011: next_state = 4'b1100;	// from state 11 it goes to state 12 no matter what
		4'b1100: if(D1)	next_state = 4'b1111;	// if a car is waiting it goes to state 15
				 else	next_state = 4'b1101;	// or goes to state 13
		4'b1101: if(D1)	next_state = 4'b1111;	// if a car is waiting it goes to state 15
				 else 	next_state = 4'b1110; 	// or goes to state 14
		4'b1110: next_state = 4'b1111;	// from state 14 it goes to state 15 no matter what
		4'b1111: next_state = 4'b0000;	// from state 15 it goes to state 0  no matter what
		default: next_state = 4'b0000;	// a default case that goes to the beginning (state 0)
	endcase
end


// implement your current state assignment, register, here
always @ (posedge clock, posedge reset)		// even if it is synchronous it  also acts asynchronously because of the reset, we use <= non-blocking assignment. sequential(depends on both current inputs and past states)
begin
	if(reset)
		current_state <= 4'b0000;	// if the reset button is pressed go to the initial state
	else
		current_state <= next_state;	// or go to the next state
end


// implement your output logic here
always @ (*) // combinatoriaial, asynchronous, we use = blocking assignment
begin
	case (current_state)
		4'b0000, 4'b1000: lightseq = `R__R__;		// states 0, 8
		4'b0001: lightseq = `RA_R__;				// state 1
		4'b0010, 4'b0011, 4'b0100, 4'b0101, 4'b0110: lightseq = `__GR__;	// states 2-6
		4'b0111: lightseq = `_A_R__;				// state 7
		4'b1001: lightseq = `R__RA_;				// state 9
		4'b1010, 4'b1011, 4'b1100, 4'b1101, 4'b1110: lightseq = `R____G;	// states 10-14
		4'b1111: lightseq = `R___A_;				// state 15
		default: lightseq = `R__R__;				// default case for testing
	endcase
end


endmodule

`default_nettype wire
