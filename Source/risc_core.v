module risc_core(
	input reset,
	input clk
);

//
wire [5:0]	 CDB_tag;
wire 			 CDB_valid;
wire [31:0]	 CDB_data;
wire 			 CDB_branch;
wire 			 CDB_branch_taken;
wire 			 issueque_full_integer;
wire 			 issueque_full_ld_st;
wire 			 issueque_full_mul;
wire 			 issueque_full_div; 
wire 	[4:0]	 dispatch_opcode;
wire 			 dispatch_en_integer;
wire 			 dispatch_en_ld_st;
wire 			 dispatch_en_mul;
wire 			 dispatch_en_div;
wire 	[5:0]	 dispatch_rd_tag;
wire 	[31:0] dispatch_rs1_data;
wire 	[5:0]	 dispatch_rs1_tag;
wire 			 dispatch_rs1_valid;
wire 	[31:0] dispatch_rs2_data;
wire 	[5:0]	 dispatch_rs2_tag;
wire 			 dispatch_rs2_valid;
wire 	[31:0] dispatch_imm;

Front_end FrontEnd(
//Inputs
	.clk(clk),
	.reset(reset),
	.CDB_tag(CDB_tag),
	.CDB_valid(CDB_valid),
	.CDB_data(CDB_data),
	.CDB_branch(CDB_branch),
	.CDB_branch_taken(CDB_branch_taken),
	.issueque_full_integer(issueque_full_integer),
	.issueque_full_ld_st(issueque_full_ld_st),
	.issueque_full_mul(issueque_full_mul),
	.issueque_full_div(issueque_full_div),
//Outputs
	.dispatch_opcode(dispatch_opcode),
	.dispatch_en_integer(dispatch_en_integer),
	.dispatch_en_ld_st(dispatch_en_ld_st),
	.dispatch_en_mul(dispatch_en_mul),
	.dispatch_en_div(dispatch_en_div),
	.dispatch_rd_tag(dispatch_rd_tag),
	.dispatch_rs1_data(dispatch_rs1_data),
	.dispatch_rs1_tag(dispatch_rs1_tag),
	.dispatch_rs1_valid(dispatch_rs1_valid),
	.dispatch_rs2_data(dispatch_rs2_data),
	.dispatch_rs2_tag(dispatch_rs2_tag),
	.dispatch_rs2_valid(dispatch_rs2_valid),
	.dispatch_imm(dispatch_imm)
);

Back_end BackEnd(
//Outputs
	.clk(clk),
	.reset(reset),
	.CDB_tag(CDB_tag),
	.CDB_valid(CDB_valid),
	.CDB_data(CDB_data),
	.CDB_branch(CDB_branch),
	.CDB_branch_taken(CDB_branch_taken),
	.issueque_full_integer(issueque_full_integer),
	.issueque_full_ld_st(issueque_full_ld_st),
	.issueque_full_mul(issueque_full_mul),
	.issueque_full_div(issueque_full_div),
//Inputs
	.dispatch_opcode(dispatch_opcode),
	.dispatch_en_integer(dispatch_en_integer),
	.dispatch_en_ld_st(dispatch_en_ld_st),
	.dispatch_en_mul(dispatch_en_mul),
	.dispatch_en_div(dispatch_en_div),
	.dispatch_rd_tag(dispatch_rd_tag),
	.dispatch_rs1_data(dispatch_rs1_data),
	.dispatch_rs1_tag(dispatch_rs1_tag),
	.dispatch_rs1_valid(dispatch_rs1_valid),
	.dispatch_rs2_data(dispatch_rs2_data),
	.dispatch_rs2_tag(dispatch_rs2_tag),
	.dispatch_rs2_valid(dispatch_rs2_valid),
	.dispatch_imm(dispatch_imm)
);

endmodule