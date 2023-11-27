module Data_Memory(
	clk,
	Data_in,
	Address,
	Tag_in,
	Opcode,
	LS_ready_in,
	LS_ready_out,
	LS_done_out,
	LS_done_in,
	Data_out,
	Tag_out
);

//
input clk;
input [31:0] Data_in;
input [31:0] Address;
input [5:0] Tag_in;
input [1:0] Opcode;
input LS_ready_in;
input LS_done_in;
output LS_ready_out;
output LS_done_out;
output [31:0] Data_out;
output [5:0] Tag_out;


//
wire write_enable;

//
assign write_enable = (Opcode == 2'b10) && (LS_ready_in == 1'b1) ? 1'b1 : 1'b0;
assign Tag_out = (Opcode == 2'b01) && (LS_ready_in == 1'b1) && (LS_done_in == 1'b1) ? Tag_in : 6'b0;
assign LS_ready_out = (Opcode == 2'b01) && (LS_ready_in == 1'b1) ? 1'b1 : 1'b0;
assign LS_done_out = ((Opcode == 2'b10) && (LS_ready_in == 1'b1)) || ((Opcode == 2'b01) && (LS_ready_in == 1'b1) && (LS_done_in == 1'b1)) ? 1'b1 : 1'b0;

Single_Port_RAM #(.DATA_WIDTH(32), .ADDRESS_WIDTH(32)) Cache (
	.data(Data_in),
	.address((Address + 32'hEFFF_0000)),
	.write_enable(write_enable), 
	.read_enable(1'b1), 
	.clock(clk),
	.Q(Data_out) 
);


endmodule