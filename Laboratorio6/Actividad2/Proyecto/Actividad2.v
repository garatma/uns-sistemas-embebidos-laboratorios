//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module Actividad2(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW
);



//=======================================================
//  REG/WIRE declarations
//=======================================================

	wire [7:0] n1; 
	wire [7:0] n2; 
	wire [7:0] n3; 
	wire [7:0] n4; 
	wire [7:0] n5; 
	wire [7:0] n6; 
	wire [7:0] n7; 
	wire [7:0] n8; 

	wire [2:0] cuenta;

//=======================================================
//  Structural coding
//=======================================================

//	always @(posedge KEY[3])
//		begin
			contador cin(
				.reloj(KEY[2]),
				.reset(0),
				.cuenta(cuenta)
			);

			demultiplexor dm1(
				.reloj(KEY[3]),
				.sel(cuenta),
				.i(SW[7:0]),
				.s1(n1),
				.s2(n2),
				.s3(n3),
				.s4(n4),
				.s5(n5),
				.s6(n6),
				.s7(n7),
				.s8(n8)
			);

			assign LEDR[9] = cuenta[1];
			assign LEDR[8] = cuenta[0];
			assign LEDR[7:0] = n6;

//		end
endmodule
