module Divider(
	reset,
	clk,
	enable,
	Operand_1,
	Operand_2,
	Tag_in,
	Result,
	Tag_out,
	busy
);

//
input reset;
input clk;
input enable;
input [31:0] Operand_1;
input [31:0] Operand_2;
input [5:0] Tag_in;
output [31:0] Result;
output [5:0] Tag_out;
output busy;

//
reg  [2:0] div_counter;
wire [2:0] next_counter;
wire [31:0] div_in;
wire [31:0] div_out;
wire stop;

//
assign next_counter = div_counter + 1'b1;
assign div_in = Operand_1 / Operand_2;
assign Result = div_out;
assign stop = (div_counter >= 3'b110) ? 1'b1 : 1'b0;
assign busy = ~stop;

Register 
#(
	.DATA_WIDTH(32)) InReg
(
	.data_in			(div_in),
	.dafault_data	(32'b0),
	.reset			(reset),
	.enable			(enable),
	.flush			(1'b0),
	.clk				(clk),
	.data_out		(div_out)
);
Register 
#(
	.DATA_WIDTH(6)) TagReg
(
	.data_in			(Tag_in),
	.dafault_data	(6'b0),
	.reset			(reset),
	.enable			(enable),
	.flush			(1'b0),
	.clk				(clk),
	.data_out		(Tag_out)
);

always @(posedge clk, posedge reset) begin
	if(reset == 1'b1) begin
		div_counter = 3'b111;
	end
	else begin
		if(enable == 1'b1) begin
			div_counter <= 3'b0;			
		end
		else if(stop == 1'b1) begin
			div_counter <= div_counter;
		end
		else begin
			div_counter <= next_counter;
		end
	end
end
endmodule