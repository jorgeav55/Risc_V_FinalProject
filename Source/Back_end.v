module Back_end(
	reset,
	clk,
//Outputs
	CDB_tag,
	CDB_valid,
	CDB_data,
	CDB_branch,
	CDB_branch_taken,
	issueque_full_integer,
	issueque_full_ld_st,
	issueque_full_mul,
	issueque_full_div,
//Inputs
	dispatch_opcode,
	dispatch_en_integer,
	dispatch_en_ld_st,
	dispatch_en_mul,
	dispatch_en_div,
	dispatch_rd_tag,
	dispatch_rs1_data,
	dispatch_rs1_tag,
	dispatch_rs1_valid,
	dispatch_rs2_data,
	dispatch_rs2_tag,
	dispatch_rs2_valid,
	dispatch_imm
);

//
input reset;
input clk;
input	[4:0]		 dispatch_opcode;
input				 dispatch_en_integer;
input				 dispatch_en_ld_st;
input				 dispatch_en_mul;
input				 dispatch_en_div;
input	[5:0]		 dispatch_rd_tag;
input	[31:0]	 dispatch_rs1_data;
input	[5:0]		 dispatch_rs1_tag;
input				 dispatch_rs1_valid;
input	[31:0]	 dispatch_rs2_data;
input	[5:0]		 dispatch_rs2_tag;
input				 dispatch_rs2_valid;
input	[31:0]	 dispatch_imm;

output	[5:0]	 CDB_tag;
output			 CDB_valid;
output	[31:0] CDB_data;
output			 CDB_branch;
output			 CDB_branch_taken;
output			 issueque_full_integer;
output			 issueque_full_ld_st;
output			 issueque_full_mul;
output			 issueque_full_div;

//
wire ready_int;
wire ready_mult;
wire ready_div;
wire ready_ld_buf;
wire issue_int;
wire issue_mult;
wire issue_div;
wire issue_ls_buf;
wire [31:0] ALU_rs1_data;
wire [31:0] ALU_rs2_data;
wire [31:0] ALU_data;
wire [5:0]  ALU_tag;
wire [4:0]  ALU_opcode;
wire ALU_branch;
wire ALU_branch_taken;
wire [31:0] Mult_rs1_data;
wire [31:0] Mult_rs2_data;
wire [31:0] Mult_data;
wire [5:0]  Mult_tag_in;
wire [5:0]  Mult_tag_out;
wire [31:0] Div_rs1_data;
wire [31:0] Div_rs2_data;
wire [31:0] Div_data;
wire [5:0]  Div_tag_in;
wire [5:0]  Div_tag_out;
wire Div_busy;
wire [31:0] Mem_address;
wire [31:0] Mem_data_in;
wire [31:0] Mem_data_out;
wire [5:0]  Mem_tag_in;
wire [5:0]  Mem_tag_out;
wire [1:0]  Mem_opcode;
wire Mem_ready;
wire Mem_done;

Integer_Reservation_Station ALU_rs( 
	.reset(reset),
	.clk(clk),
	.dispatch_rs1_data(dispatch_rs1_data),
	.dispatch_rs1_tag(dispatch_rs1_tag),
	.dispatch_rs1_data_val(~dispatch_rs1_valid),
	.dispatch_rs2_data(dispatch_rs2_data),
	.dispatch_rs2_tag(dispatch_rs2_tag),
	.dispatch_rs2_data_val(~dispatch_rs2_valid),
	.dispatch_opcode(dispatch_opcode),
	.dispatch_rd_tag(dispatch_rd_tag),
	.dispatch_enable(dispatch_en_integer),
	.issueque_full(issueque_full_integer),
	.cdb_tag(CDB_tag),
	.cdb_data(CDB_data),
	.cdb_valid(CDB_valid),
	.issueque_ready(ready_int),
	.issueque_rs1_data(ALU_rs1_data),
	.issueque_rs2_data(ALU_rs2_data),
	.issueque_rd_tag(ALU_tag),
	.issueque_opcode(ALU_opcode),
	.issueblk_done(issue_int)
);

ALU #(.LENGTH(32)) ALU_block(
	.A(ALU_rs1_data),
	.B(ALU_rs2_data),
	.control(ALU_opcode),
	.result(ALU_data),
	.branch(ALU_branch),
	.branch_taken(ALU_branch_taken)
);

//`undef USE_OPCODE
Mult_Div_Reservation_Station Mult_rs( 
	.reset(reset),
	.clk(clk),
	.dispatch_rs1_data(dispatch_rs1_data),
	.dispatch_rs1_tag(dispatch_rs1_tag),
	.dispatch_rs1_data_val(~dispatch_rs1_valid),
	.dispatch_rs2_data(dispatch_rs2_data),
	.dispatch_rs2_tag(dispatch_rs2_tag),
	.dispatch_rs2_data_val(~dispatch_rs2_valid),
	//.dispatch_opcode(5'b0000),
	.dispatch_rd_tag(dispatch_rd_tag),
	.dispatch_enable(dispatch_en_mul),
	.issueque_full(issueque_full_mul),
	.cdb_tag(CDB_tag),
	.cdb_data(CDB_data),
	.cdb_valid(CDB_valid),
	.issueque_ready(ready_mult),
	.issueque_rs1_data(Mult_rs1_data),
	.issueque_rs2_data(Mult_rs2_data),
	.issueque_rd_tag(Mult_tag_in),
	//.issueque_opcode(),
	.issueblk_done(issue_mult)
);

Multiplier Mult( 
	.reset(reset),
	.clk(clk),
	.Operand_1(Mult_rs1_data),
	.Operand_2(Mult_rs2_data),
	.Tag_in(Mult_tag_in),
	.Result(Mult_data),
	.Tag_out(Mult_tag_out)
);

Mult_Div_Reservation_Station Div_rs( 
	.reset(reset),
	.clk(clk),
	.dispatch_rs1_data(dispatch_rs1_data),
	.dispatch_rs1_tag(dispatch_rs1_tag),
	.dispatch_rs1_data_val(~dispatch_rs1_valid),
	.dispatch_rs2_data(dispatch_rs2_data),
	.dispatch_rs2_tag(dispatch_rs2_tag),
	.dispatch_rs2_data_val(~dispatch_rs2_valid),
	//.dispatch_opcode(5'b0000),
	.dispatch_rd_tag(dispatch_rd_tag),
	.dispatch_enable(dispatch_en_div),
	.issueque_full(issueque_full_div),
	.cdb_tag(CDB_tag),
	.cdb_data(CDB_data),
	.cdb_valid(CDB_valid),
	.issueque_ready(ready_div),
	.issueque_rs1_data(Div_rs1_data),
	.issueque_rs2_data(Div_rs2_data),
	.issueque_rd_tag(Div_tag_in),
	//.issueque_opcode(),
	.issueblk_done(issue_div)
);

Divider Div( 
	.reset(reset),
	.clk(clk),
	.enable(issue_div),
	.Operand_1(Div_rs1_data),
	.Operand_2(Div_rs2_data),
	.Tag_in(Div_tag_in),
	.Result(Div_data),
	.Tag_out(Div_tag_out),
	.busy(Div_busy)
);

Load_store_queue	LS_rs(
	.reset(reset),
	.clk(clk),
	.dispatch_rs1_data(dispatch_rs1_data),
	.dispatch_rs1_tag(dispatch_rs1_tag),
	.dispatch_rs1_data_val(~dispatch_rs1_valid),
	.dispatch_rs2_data(dispatch_rs2_data),
	.dispatch_rs2_tag(dispatch_rs2_tag),
	.dispatch_rs2_data_val(~dispatch_rs2_valid),
	.dispatch_imm(dispatch_imm),
	.dispatch_opcode(dispatch_opcode[1:0]),
	.dispatch_rd_tag(dispatch_rd_tag),
	.dispatch_enable(dispatch_en_ld_st),
	.issueque_full(issueque_full_ld_st),
	.cdb_tag(CDB_tag),
	.cdb_data(CDB_data),
	.cdb_valid(CDB_valid),
	.issueque_ready(Mem_ready),
	//.issueque_rs1_data(),
	.issueque_rs2_data(Mem_data_in),
	.issueque_address(Mem_address),
	.issueque_rd_tag(Mem_tag_in),
	.issueque_opcode(Mem_opcode),
	.issueblk_done(Mem_done)
);

Data_Memory Data_cache(
	.clk(clk),
	.Data_in(Mem_data_in),
	.Address(Mem_address),
	.Tag_in(Mem_tag_in),
	.Opcode(Mem_opcode),
	.LS_ready_in(Mem_ready),
	.LS_ready_out(ready_ld_buf),
	.LS_done_out(Mem_done),
	.LS_done_in(issue_ls_buf),
	.Data_out(Mem_data_out),
	.Tag_out(Mem_tag_out)
);

Issue_Unit CDB_ctrl(
	.reset(reset),
	.clk(clk),
	.ALU_branch(ALU_branch),
	.ALU_branch_taken(ALU_branch_taken),
	.ready_int(ready_int),
	.ready_mult(ready_mult),
	.ready_div(ready_div),
	.ready_ld_buf(ready_ld_buf),
	.div_exec_ready(Div_busy),
	.int_data(ALU_data),
	.int_tag(ALU_tag),
	.mult_data(Mult_data),
	.mult_tag(Mult_tag_out),
	.div_data(Div_data),
	.div_tag(Div_tag_out),
	.ld_buf_data(Mem_data_out),
	.ld_buf_tag(Mem_tag_out),
	.CDB_tag(CDB_tag),
	.CDB_data(CDB_data),
	.CDB_valid(CDB_valid),
	.CDB_branch(CDB_branch),
	.CDB_branch_taken(CDB_branch_taken),
	.issue_int(issue_int),
	.issue_mult(issue_mult),
	.issue_div(issue_div),
	.issue_ls_buf(issue_ls_buf)
);

endmodule