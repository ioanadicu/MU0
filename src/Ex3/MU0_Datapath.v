// COMP12111 Exercise 3 - MU0_Datapath 
// Version 2024. P W Nutter
//
// MU0 datapath design - structural Verilog
// Design is incomplet - functional components of the
// MU0 datapath need instantiation.
// Use the names used in the lab instructions.
//
// Comments:
//
// This Verilog module implements the datapath of the MU0 processor, integrating the ALU, registers, multiplexers,
// and flag generation to enable processing operations. The datapath is responsible for executing instructions
// by coordinating data flow, arithmetic and logical operations, and updating key registers (Program Counter, 
// Accumulator, and Instruction Register) based on control signals.
//

// Do not touch the following line it is required for simulation 
`timescale 1ns/100ps

// for simulation purposes, do not delete
`default_nettype none

module MU0_Datapath(
input  wire        Clk,
input  wire        Reset,
input  wire [15:0] Din,
input  wire        X_sel,
input  wire        Y_sel,
input  wire        Addr_sel,
input  wire        PC_En,
input  wire        IR_En,
input  wire        Acc_En,
input  wire [1:0]  M,
output wire [3:0]  F,			// top 4 bits of the instruction
output wire [11:0] Address,
output wire [15:0] Dout,
output wire        N,
output wire        Z,
output wire [11:0] PC,
output wire [15:0] Acc);


// Define internal signals using names from the datapath schematic
wire [15:0] X;
wire [15:0] Y;
wire [15:0] IR;
wire [15:0] ALU;


// Instantiate Datapath components

//MU0 registers

// Accumulator
// Making use of the MU0_Reg16 module we developed, the Accumulator stores the result of ALU operations.
MU0_Reg16 ACCReg (
	.Clk(Clk),
	.Reset(Reset),
	.En(Acc_En),
	.D(ALU), // Full 16-bit ALU output is stored in the Accumulator
	.Q(Acc)
);

// Program Counter (PC)
// Making use of MU0_Reg12 module we developed, the PC stores the current instruction address.
MU0_Reg12 PCReg (
	.Clk(Clk),
	.Reset(Reset),
	.En(PC_En),
	.D(ALU[11:0]), // Only the lower 12 bits of the ALU output are used for the PC
	.Q(PC)
);

// Instruction Register (IR)
// Making use of the MU0_Reg16 module, the IR holds the current instruction fetched from memory.
MU0_Reg16 IRReg (
	.Clk(Clk),
	.Reset(Reset),
	.En(IR_En),
	.D(Din),	// The instruction is loaded from the memory input
	.Q(IR)
);


// MU0 multiplexors

// X Multiplexer
// Making use of the MU0_Mux16 module, this selects between the Accumulator and {4'b0000, PC[11:0]} for the ALU's X input
MU0_Mux16 XMux (
	.A(Acc),
	.B({4'b0000, PC[11:0]}), // Concatenate 4 zeros with PC to form a 16-bit input
	.S(X_sel),
	.Q(X)	// Output connected to ALU input X
);

// Y Multiplexer
// Making use of the MU0_Mux16 module, this selects between the IR and the external data input (Din) for the ALU's Y input
MU0_Mux16 YMux (
	.A(Din),
	.B(IR),
	.S(Y_sel),
	.Q(Y)	// Output connected to ALU input X
);

// Address Multiplexer
// Making use of the MU0_Mux12 module, this selects between the PC and the lower 12 bits of the IR for the Adress output
MU0_Mux12 AddrMux (
	.A(PC),
	.B(IR[11:0]),	// Lower 12 bits of IR
	.S(Addr_sel),
	.Q(Address)		// Output connected to Address
);


// MU0 ALU
// Making use of the MU0_Alu module, this performs operations on inputs X and Y based on the 2-bit M
MU0_Alu MU0_ALU (
	.X(X),
	.Y(Y),
	.M(M),
	.Q(ALU)
);


// MU0 Flag generation
// Making use of the MU0_Flags module, the Negative flag (N) is set if the Accumulator is negative, the Zero flag (Z) is set if all bits of Acc are 0
MU0_Flags FLAGS (
	.Acc(Acc),
	.N(N),
	.Z(Z)
);

// The following connects X and Dout together, there's no need for you to do so
// use X when defining your datapath structure
assign Dout = X;
// Buffer added F is op 4 bits of the instruction
assign F = IR[15:12];

endmodule 

// for simulation purposes, do not delete
`default_nettype wire
