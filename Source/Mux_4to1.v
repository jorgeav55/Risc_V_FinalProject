`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer:  Edgar Barba & Jorge Velazquez
// Module: Mux_4to1
// Description:
// Data Multiplexer. 
// If Sel == 00b then S = A
// If Sel == 01b then S = B
// If Sel == 10b then S = C
// If Sel == 11b then S = D
// 
//////////////////////////////////////////////////////////////////////////////////

module MUX_4to1 #(parameter INPUT_LENGTH=32)(
	input [INPUT_LENGTH-1:0]A, B, C, D,
	input [1:0]selector,
	output reg[INPUT_LENGTH-1:0]S
);
always @*
begin
	case (selector)
		2'b00:S=A;
		2'b01:S=B;
		2'b10:S=C;
		2'b11:S=D;
	endcase
end
endmodule	