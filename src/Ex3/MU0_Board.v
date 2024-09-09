// COMP12111 Exercise 3 - MU0_Board 
// Version 2024. P W Nutter
//
// Provides the funcitonality required to interface
// to the peripherals on the 1st year experimental board
//

`timescale 1ns / 100ps
`default_nettype none
 

module MU0_Board (
// FPGA external connections - do not edit
output wire  Buzzer_pin,
output wire  dac_cs_pin,
output wire  dac_load_pin,
output wire  dac_pd_pin,
output wire  dac_we_pin,
output wire [10:0]  Traffic_lights_pin,
output wire [14:0]  Segments_pin,
output wire [5:0]   Columns_pin,
output wire [3:0]   keyrow_pin,
output wire [11:0]  dac_data_pin,
output wire [1:0]   S7_leds_pin,
inout wire [3:0]  ftdi,
input wire Clk,
input wire Reset,
input wire [3:0]  Simple_buttons_pin,
input wire [5:0]  keycol_pin
 );


// Buses in the design
wire  [3:0]  digit5;
wire  [15:0]  breakpoint_adr;
wire  [15:0]  mem_din;
wire  [14:0]  Display_Digit1;
wire  [14:0]  Display_Digit0;
wire  [11:0]  dac_data;
wire  [15:0]  mem_dout;
wire  [3:0]  digit1;
wire  [23:0]  buttons;
wire  [15:0]  proc_din;
wire  [14:0]  Display_Digit2;
wire  [15:0]  mu0_dout;
wire  [3:0]  digit3;
wire  [10:0]  traffic_lights;
wire  [11:0]  mem_addr;
wire  [3:0]  digit2;
wire  [3:0]  digit0;
wire  [3:0]  Simple_buttons;
wire  [14:0]  Display_Digit3;
wire  [14:0]  Display_Digit5;
wire  [1:0]  s7_leds;
wire  [3:0]  digit4;
wire  [15:0]  mu0_din;
wire  [14:0]  Display_Digit4;
wire  [3:0]  proc_cc;
wire  [11:0]  proc_addr;
wire NC1;
wire Clk_1Hz, Clk_1kHz, Clk_25MHz, Clk_100MHz;
wire dac_we;
wire bp_mem_write_en;
wire bp_mem_data_write;
wire bp_detected;
wire bp_mem_data_read;
wire mem_wen;
wire proc_clk;
wire proc_reset;
wire proc_fetch;
wire proc_halted;
wire buzzer_pulses;
wire writeEn0;

BoardV3 Board1 ( .Crossing_B(traffic_lights[10:5]),
     .Crossing_A(traffic_lights[4:0]), .Clk_1Hz(Clk_1Hz),
     .Clk_25MHz(Clk_25MHz), .dac_we(dac_we), .dac_data(dac_data[11:0]),
     .dac_we_pin(dac_we_pin), .dac_cs_pin(dac_cs_pin),
     .dac_load_pin(dac_load_pin), .dac_pd_pin(dac_pd_pin),
     .Columns_pin(Columns_pin[5:0]), .Segments_pin(Segments_pin[14:0]),
     .Simple_buttons(Simple_buttons[3:0]), .ftdi(ftdi[3:0]),
     .S7_leds(s7_leds[1:0]),
     .Simple_buttons_pin(Simple_buttons_pin[3:0]),
     .Buzzer_pin(Buzzer_pin), .Digit0(Display_Digit0[14:0]),
     .Digit1(Display_Digit1[14:0]), .Digit2(Display_Digit2[14:0]),
     .Digit3(Display_Digit3[14:0]), .Digit4(Display_Digit4[14:0]),
     .Digit5(Display_Digit5[14:0]), .Reset(Reset),
     .S7_leds_pin(S7_leds_pin[1:0]), .Clk_100MHz(Clk_100MHz),
     .Clk(Clk), .keycol_pin(keycol_pin[5:0]),
     .dac_data_pin(dac_data_pin[11:0]), .button(buttons[23:0]),
     .keyrow_pin(keyrow_pin[3:0]),
     .Traffic_lights_pin(Traffic_lights_pin[10:0]),
     .bp_mem_write_en(bp_mem_write_en),
     .bp_mem_data_write(bp_mem_data_write),
     .breakpoint_adr(breakpoint_adr[15:0]), .bp_detected(bp_detected),
     .bp_mem_data_read(bp_mem_data_read), .proc_cc(proc_cc[3:0]),
     .mem_addr(mem_addr[11:0]), .mem_dout(mem_dout[15:0]),
     .mem_wen(mem_wen), .proc_clk(proc_clk), .proc_reset(proc_reset),
     .mem_din(mem_din[15:0]), .proc_din(proc_din[15:0]),
     .proc_fetch(proc_fetch), .proc_halted(proc_halted),
     .Buzzer(buzzer_pulses), .Clk_1kHz(Clk_1kHz));
     
MU0 MU01 ( .srcC(mem_addr[1:0]), .regC(proc_din[15:0]),
     .Addr(proc_addr[11:0]), .Clk(proc_clk), .Din(mu0_din[15:0]),
     .Dout(mu0_dout[15:0]), .Halted(proc_halted), .cc(proc_cc[1:0]),
     .Rd(NC1), .Reset(proc_reset), .Wr(writeEn0),
     .fetch(proc_fetch));

MU0_Memory MEM1 ( .keypad(buttons[15:0]),
     .Simple_buttons(Simple_buttons[3:0]),
     .buttons_AtoH(buttons[23:16]), .s7_leds(s7_leds[1:0]),
     .traffic_lights(traffic_lights[10:0]),
     .breakpoint_mem_adr(breakpoint_adr[15:0]),
     .buzzer_pulses(buzzer_pulses), .digit0(digit0[3:0]),
     .digit1(digit1[3:0]), .digit2(digit2[3:0]), .digit3(digit3[3:0]),
     .digit4(digit4[3:0]), .digit5(digit5[3:0]),
     .WEnAckie_bp(bp_mem_write_en), .bp_mem_detected(bp_detected),
     .bp_mem_data_ackie_read(bp_mem_data_read),
     .bp_mem_data_ackie_write(bp_mem_data_write), .Clk(Clk_25MHz),
     .write_data1(mem_dout[15:0]), .write_data0(mu0_dout[15:0]),
     .address1(mem_addr[11:0]), .address0(proc_addr[11:0]),
     .WEn1(mem_wen), .WEn0(writeEn0), .read_data1(mem_din[15:0]),
     .read_data0(mu0_din[15:0]));
     
Display_Decoder Display0 ( digit0[3:0], Display_Digit0[14:0]);
Display_Decoder Display1 ( digit1[3:0], Display_Digit1[14:0]);
Display_Decoder Display2 ( digit3[3:0], Display_Digit3[14:0]);
Display_Decoder Display3 ( digit2[3:0], Display_Digit2[14:0]);
Display_Decoder Display4 ( digit4[3:0], Display_Digit4[14:0]);
Display_Decoder Display5 ( digit5[3:0], Display_Digit5[14:0]);

assign proc_cc[3:2] = 2'b00;
assign dac_data = 12'b0000_0000_0000;
assign dac_we = 1'b1; // Disable D2A

endmodule

`default_nettype wire
