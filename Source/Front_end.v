module Front_end(	
//Inputs
	reset,
	clk,
	CDB_tag,
	CDB_valid,
	CDB_data,
	CDB_branch,
	CDB_branch_taken,
	issueque_full_integer,
	issueque_full_ld_st,
	issueque_full_mul,
	issueque_full_div,
//Outputs
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
input	[5:0]						CDB_tag;
input								CDB_valid;
input	[31:0]					CDB_data;
input								CDB_branch;
input								CDB_branch_taken;
input								issueque_full_integer;
input								issueque_full_ld_st;
input								issueque_full_mul;
input								issueque_full_div;

output	[4:0]					dispatch_opcode;
output							dispatch_en_integer;
output							dispatch_en_ld_st;
output							dispatch_en_mul;
output							dispatch_en_div;
output	[5:0]					dispatch_rd_tag;
output	[31:0]				dispatch_rs1_data;
output	[5:0]					dispatch_rs1_tag;
output							dispatch_rs1_valid;
output	[31:0]				dispatch_rs2_data;
output	[5:0]					dispatch_rs2_tag;
output							dispatch_rs2_valid;
output	[31:0]				dispatch_imm;

//
wire Read_enable;
wire [31:0] instruction;
wire jump_branch_valid;
wire [31:0] jump_branch_address;
wire [31:0] Program_counter;

I_Fetch
#(
.DATA_WIDTH(32), 
.ADDRESS_WIDTH(32)) 
Fetch_stage(
	.clk(clk),
	.reset(reset),
	.Read_enable(Read_enable),
	.jump_branch_valid(jump_branch_valid),
	.jump_branch_address(jump_branch_address),
	//.empty(),
	.instruction(instruction),
	.PC_out(Program_counter)
);

Dispatch_Unit
#(
.DATA_WIDTH(32), 
.REGISTER_WIDTH(7))
Decode_stage(
//Inputs
	.clk(clk),
	.reset(reset),
//	.empty(empty),
	.Instruction(instruction),
	.PC_out(Program_counter),
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
	.Read_enable(Read_enable),
	.jump_branch_valid(jump_branch_valid),
	.jump_branch_address(jump_branch_address),
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