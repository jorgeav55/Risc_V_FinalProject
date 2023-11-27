module Multiplier (
	reset,
	clk,
	Operand_1,
	Operand_2,
	Tag_in,
	Result,
	Tag_out
);

input reset;
input clk;
input [31:0] Operand_1;
input [31:0] Operand_2;
input [5:0] Tag_in;
output [31:0] Result;
output [5:0] Tag_out;

//
wire [31:0] mult_result [4:0];
wire [5:0]  tag [4:0];

//
assign mult_result[0] = Operand_1 * Operand_2;
assign Result = mult_result[4];
assign tag[0] = Tag_in;
assign Tag_out = tag[4];

genvar i;
generate
	for (i=0;i<4;i=i+1) begin : mult_
		Register 
		#(
			.DATA_WIDTH(32)) mult_bit_
		(
			.data_in			(mult_result[i]),
			.dafault_data	(32'b0),
			.reset			(reset),
			.enable			(1'b1),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(mult_result[i+1])
		);
		Register 
		#(
			.DATA_WIDTH(6)) tag_bit_
		(
			.data_in			(tag[i]),
			.dafault_data	(6'b0),
			.reset			(reset),
			.enable			(1'b1),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(tag[i+1])
		);
	end
endgenerate

endmodule