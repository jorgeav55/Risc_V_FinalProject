module Issue_Unit(
	reset,
	clk,
	ALU_branch,
	ALU_branch_taken,
	ready_int,
	ready_mult,
	ready_div,
	ready_ld_buf,
	div_exec_ready,
	int_data,
	int_tag,
	mult_data,
	mult_tag,
	div_data,
	div_tag,
	ld_buf_data,
	ld_buf_tag,
	CDB_tag,
	CDB_data,
	CDB_valid,
	CDB_branch,
	CDB_branch_taken,
	issue_int,
	issue_mult,
	issue_div,
	issue_ls_buf
);

//
input reset;
input clk;
input ALU_branch;
input ALU_branch_taken;
input ready_int;
input ready_mult;
input ready_div;
input ready_ld_buf;
input div_exec_ready;
input [31:0]	int_data;
input [5:0]		int_tag;
input [31:0]	mult_data;
input [5:0]		mult_tag;
input [31:0]	div_data;
input [5:0]		div_tag;
input [31:0]	ld_buf_data;
input [5:0]		ld_buf_tag;
output issue_int;
output issue_mult;
output issue_div;
output issue_ls_buf;
output [31:0] 	CDB_data;
output [5:0] 	CDB_tag;
output CDB_valid;
output CDB_branch;
output CDB_branch_taken;

//
wire issue_valid;

//
assign CDB_valid = (CDB_branch == 1'b1)? 1'b0: issue_valid;

Issue_logic Issue(
.reset(reset),
.clk(clk),
.ready_int(ready_int),
.ready_mult(ready_mult),
.ready_div(ready_div),
.ready_ld_buf(ready_ld_buf),
.div_exec_ready(div_exec_ready),
.issue_int(issue_int),
.issue_mult(issue_mult),
.issue_div(issue_div),
.issue_ls_buf(issue_ls_buf),
.ins_issued(issue_valid)
);

CDB_Control CDBctrl(
.reset(reset),
.clk(clk),
.int_data(int_data),
.int_tag(int_tag),
.mult_data(mult_data),
.mult_tag(mult_tag),
.div_data(div_data),
.div_tag(div_tag),
.ld_buf_data(ld_buf_data),
.ld_buf_tag(ld_buf_tag),
.CDB_tag(CDB_tag),
.CDB_data(CDB_data),
//CDB_valid,
//CDB_branch,
//CDB_branch_taken
.issue_int(issue_int),
.issue_mult(issue_mult),
.issue_div(issue_div),
.issue_ls_buf(issue_ls_buf)
);

Register 
#(
	.DATA_WIDTH(1)) branch
(
	.data_in			(ALU_branch),
	.dafault_data	(1'b0),
	.reset			(reset),
	.enable			(issue_int),
	.flush			(~issue_int),
	.clk				(clk),
	.data_out		(CDB_branch)
);
Register 
#(
	.DATA_WIDTH(1)) branch_res
(
	.data_in			(ALU_branch_taken),
	.dafault_data	(1'b0),
	.reset			(reset),
	.enable			(issue_int),
	.flush			(~issue_int),
	.clk				(clk),
	.data_out		(CDB_branch_taken)
);

endmodule