// COMP12111 Exercise 1 - Combinatorial Design Testbench
//
// Version 2024. P W Nutter
//
// To do:
// - Declare internal buses and wires
// - Add display decoder instance
// - Produce test stimulus
//
// Make sure you document your code and marks may be awarded/lost for the 
// quality of the comments given. Please document in the header the changes 
// made, when and by whom.
//
// Comments:
//


`timescale  1ns / 100ps
`default_nettype none

module Display_Decoder_Testbench;

//  Internal signals have been defined for you
//  and must be used for this excercise 
//  DO NOT alter names, and ensure that your signals
//  are wired up correctly to your design under test 

reg  [3:0]  input_code;       
wire [14:0] segment_pattern;

// create your instance of Display_Decoder




/* Comment block

#VALUE      creates a delay of VALUE ps
a=VALUE;    sets the value of input 'a' to VALUE
$stop;      tells the simulator to stop

*/

// test stimulus

initial
begin
#100  

// Enter you stimulus below this line
// Make sure you test all input combinations with a delay
// -------------------------------------------------------





// -------------------------------------------------------
// Please make sure your stimulus is above this line

#100 $stop;
end


endmodule

`default_nettype wire
