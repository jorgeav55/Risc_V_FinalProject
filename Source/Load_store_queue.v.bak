module Load_store_queue	(
	reset,
	clk,
	dispatch_rs1_data,
	dispatch_rs1_tag,
	dispatch_rs1_data_val,
	dispatch_rs2_data,
	dispatch_rs2_tag,
	dispatch_rs2_data_val,
	dispatch_opcode,
	dispatch_rd_tag,
	dispatch_enable,
	issueque_full,
	cdb_tag,
	cdb_data,
	cdb_valid,
	issueque_ready,
	issueque_rs1_data,
	issueque_rs2_data,
	issueque_rd_tag,
	issueque_opcode,
	issueblk_done
);

//Input and Output declaration
input reset;
input clk;
input [31:0] dispatch_rs1_data;
input [5:0] dispatch_rs1_tag;
input dispatch_rs1_data_val;
input [31:0] dispatch_rs2_data;
input [5:0] dispatch_rs2_tag;
input dispatch_rs2_data_val;
input [1:0] dispatch_opcode;
input [5:0] dispatch_rd_tag;
input dispatch_enable;
output issueque_full;
input [5:0] cdb_tag;
input [31:0] cdb_data;
input cdb_valid;
output issueque_ready;
output [31:0] issueque_rs1_data;
output [31:0] issueque_rs2_data;
output [5:0] issueque_rd_tag;
output [1:0] issueque_opcode;
input issueblk_done;

//
wire 	[2:0] 	next_write_pointer;
wire 	[2:0] 	current_write_pointer;
wire 	[2:0] 	next_read_pointer;
wire 	[2:0] 	current_read_pointer;

//
assign 	issueque_full = (current_write_pointer[1:0] == current_read_pointer[1:0]) && (current_write_pointer[2] != current_read_pointer[2]) ? 1'b1 : 1'b0;
assign 	next_write_pointer = current_write_pointer + 1'b1;
assign 	next_read_pointer = current_read_pointer + 1'b1;

Queue LS_Queue( 
	.clk(clk),
	.reset(reset),
	.flush(1'b0),
	.write_enable(dispatch_enable),
	.write_pointer(current_write_pointer[1:0]),
	.read_pointer(current_read_pointer[1:0]),	
	.dispatch_rs1_data(dispatch_rs1_data),
	.dispatch_rs1_tag(dispatch_rs1_tag),
	.dispatch_rs1_data_val(dispatch_rs1_data_val),
	.dispatch_rs2_data(dispatch_rs2_data),
	.dispatch_rs2_tag(dispatch_rs2_tag),
	.dispatch_rs2_data_val(dispatch_rs2_data_val),
	.dispatch_opcode(dispatch_opcode),
	.dispatch_rd_tag(dispatch_rd_tag),
	.CDB_tag(cdb_tag),
	.CDB_data(cdb_data),
	.CDB_valid(cdb_valid),
	.issueque_ready(issueque_ready),
	.issueque_rs1_data(issueque_rs1_data),
	.issueque_rs2_data(issueque_rs2_data),
	.issueque_rd_tag(issueque_rd_tag),
	.issueque_opcode(issueque_opcode),
	.issueblk_done(issueblk_done)
);

Register
#(
	.DATA_WIDTH(3)) Wp
(
	.data_in			(next_write_pointer),
	.dafault_data	(3'b0),
	.reset			(reset),
	.enable			(dispatch_enable & ~issueque_full),
	.flush			(1'b0),
	.clk				(clk),
	.data_out		(current_write_pointer)
);

Register
#(
	.DATA_WIDTH(3)) Rp
(
	.data_in			(next_read_pointer),
	.dafault_data	(3'b0),
	.reset			(reset),
	.enable			(issueblk_done & issueque_ready),
	.flush			(1'b0),
	.clk				(clk),
	.data_out		(current_read_pointer)
);

endmodule