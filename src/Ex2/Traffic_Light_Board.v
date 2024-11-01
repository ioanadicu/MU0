// COMP12111 Exercise 2 - Sequential Design
//
// Version 2024. P W Nutter
//
// This is the Verilog module used for connecting the traffic light to the Lab board
//
// TODO
// Delacre internal buses and wires
// Add traffic light instance
// Connect traffic light to BoardI1
//
// Make sure you document your code and marks may be awarded/lost for the 
// quality of the comments given.
//
// Add your comments:
//
// This module integrates the traffic light FSM with the experimental board
//

`timescale  1ns / 100ps
`default_nettype none

module Traffic_Light_Board (
// FPGA external connections - do not edit
output wire         Buzzer_pin,
output wire         dac_cs_pin,
output wire         dac_load_pin,
output wire         dac_pd_pin,
output wire         dac_we_pin,
output wire [10:0]  Traffic_lights_pin,
output wire [14:0]  Segments_pin,
output wire [5:0]   Columns_pin,
output wire [3:0]   keyrow_pin,
output wire [11:0]  dac_data_pin,
output wire [1:0]   S7_leds_pin,
inout wire  [3:0]   ftdi,
input wire          Clk,
input wire          Reset,
input wire  [3:0]   Simple_buttons_pin,
input wire  [5:0]   keycol_pin
 );


// Declare any internal buses and wires here (connections)

wire [5:0] light_sequence; 	// wire for the FSM lightning output, 6 bits because lightseq, Crossing_B are 6 bits
wire [3:0] car_sensors; 	// wire for D1 and D2, [3:0] because Simple_buttons is [3:0], will only use bits 2, 3 and 1 for the reset button
wire Clock;					// wire for clock

// Instantiatiate Trafic_Light here

Traffic_Light TL1(	.lightseq(light_sequence),	// output from FSM to internal wire
					.D1(car_sensors[3]),		// connecting D1 sensor to wire
					.D2(car_sensors[2]),		// connecting D2 sensor to wire
					.clock(Clock),				// clock wire from board connected to FSM clock input
					.reset(car_sensors[1])		// FSM reset - we'll use one of the pedestrian buttons as a reset button for our FSM
);

// Make connections to the components on BoardV3 in the instantiation below.

BoardV3 BoardI1 ( // Board user pins
             // outputs - can be left unconnected
             .Clk_100MHz(),
             .Clk_25MHz(), 
	         .Clk_1kHz(),
	         .Clk_1Hz(Clock),					// connecting to the clock wire
             .Simple_buttons(car_sensors),	    // connecting Simple_buttons[] to car_sensors wire
             .button(),
	    	 // inputs - must be connected	       
	         .Crossing_B(light_sequence), 		// connecting Crossing_B lights to the outputs wire
             .Crossing_A(5'b0_0000), 
	         .Buzzer(1'b0),
	         .S7_leds(2'b00),
	         .Digit0(15'b000_0000_0000_0000), 
	         .Digit1(15'b000_0000_0000_0000),
	         .Digit2(15'b000_0000_0000_0000), 
	         .Digit3(15'b000_0000_0000_0000),
	         .Digit4(15'b000_0000_0000_0000),
	         .Digit5(15'b000_0000_0000_0000),	     
	         .dac_we(1'b1),
	         .dac_data(12'b0000_0000_0000),
	     
	     // DO NOT EDIT BELOW THIS LINE
             // Ackie - used for MU0
	     // Ackie outputs
             .bp_mem_write_en(),
	         .bp_mem_data_write(),
	         .breakpoint_adr(),
	         .mem_addr(),
	         .mem_dout(),
	         .mem_wen(),
             .proc_clk(),
	         .proc_reset(),
	        	      
	     // Ackie inputs
	         .bp_detected(1'b1),
             .bp_mem_data_read(1'b1),
	         .proc_cc(4'b0000),
	         .mem_din(16'b0000_0000_0000_0000),
	         .proc_din(16'b0000_0000_0000_0000),
             .proc_fetch(1'b0),
             .proc_halted(1'b0),
	     
	     // External FPGA connections(pins)
	         .Clk(Clk),
	         .Reset(Reset),
	         .keycol_pin(keycol_pin),
             .keyrow_pin(keyrow_pin),
             .Simple_buttons_pin(Simple_buttons_pin),
             .S7_leds_pin(S7_leds_pin),
             .Buzzer_pin(Buzzer_pin),
             .dac_data_pin(dac_data_pin),
             .dac_cs_pin(dac_cs_pin),
             .dac_load_pin(dac_load_pin),
             .dac_pd_pin(dac_pd_pin),
             .dac_we_pin(dac_we_pin),
	         .ftdi(ftdi),
	         .Traffic_lights_pin(Traffic_lights_pin),
	         .Segments_pin(Segments_pin),
             .Columns_pin(Columns_pin)
);
	     
	      

endmodule

`default_nettype wire
