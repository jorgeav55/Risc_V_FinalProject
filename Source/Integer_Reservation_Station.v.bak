module Integer_Reservation_Station(
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
input [3:0] dispatch_opcode;
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
output [3:0] issueque_opcode;
input issueblk_done;

//Wires
wire [5:0] shift_rs1_tag0;
wire [5:0] shift_rs1_tag1;
wire [5:0] shift_rs1_tag2;
wire [5:0] shift_rs1_tag3;
wire [5:0] shift_rs2_tag0;
wire [5:0] shift_rs2_tag1;
wire [5:0] shift_rs2_tag2;
wire [5:0] shift_rs2_tag3;
wire shift_valid0;
wire shift_valid1;
wire shift_valid2;
wire shift_valid3;
wire shift_rs1_valid0;
wire shift_rs1_valid1;
wire shift_rs1_valid2;
wire shift_rs1_valid3;
wire shift_rs2_valid0;
wire shift_rs2_valid1;
wire shift_rs2_valid2;
wire shift_rs2_valid3;
wire [3:0] sel_rs1;
wire [3:0] sel_rs2;
wire [3:0] valid_clear;
wire [3:0] enable_rs1_valid;
wire [3:0] enable_rs2_valid;
wire [3:0] enable_valid;
wire [3:0] enable_opcode;
wire [3:0] enable_rd_tag;
wire [3:0] enable_rs1_tag;
wire [3:0] enable_rs2_tag;
wire [3:0] enable_rs1_data;
wire [3:0] enable_rs2_data;
wire [1:0] data_sel;

Queue_Shift_Register Int_Res_Stat(
	.reset(reset),
	.clk(clk),
	.enable_rs1_valid(enable_rs1_valid),
	.enable_rs2_valid(enable_rs2_valid),
	.enable_valid(enable_valid),
	.enable_opcode(enable_opcode),
	.enable_rd_tag(enable_rd_tag),
	.enable_rs1_tag(enable_rs1_tag),
	.enable_rs2_tag(enable_rs2_tag),
	.enable_rs1_data(enable_rs1_data),
	.enable_rs2_data(enable_rs2_data),
	.sel_rs1(sel_rs1),
	.sel_rs2(sel_rs2),
	.data_sel(data_sel),
	.valid_clear(valid_clear),
	.CDB_data(cdb_data),
	.dispatch_rs1_data(dispatch_rs1_data),
	.dispatch_rs1_tag(dispatch_rs1_tag),
	.dispatch_rs1_data_val(dispatch_rs1_data_val),
	.dispatch_rs2_data(dispatch_rs2_data),
	.dispatch_rs2_tag(dispatch_rs2_tag),
	.dispatch_rs2_data_val(dispatch_rs2_data_val),
	.dispatch_opcode(dispatch_opcode),
	.dispatch_rd_tag(dispatch_rd_tag),
	.dispatch_enable(dispatch_enable),
	//.issueque_full(issueque_full)
	.shift_rs1_tag0(shift_rs1_tag0),
	.shift_rs1_tag1(shift_rs1_tag1),
	.shift_rs1_tag2(shift_rs1_tag2),
	.shift_rs1_tag3(shift_rs1_tag3),
	.shift_rs2_tag0(shift_rs2_tag0),
	.shift_rs2_tag1(shift_rs2_tag1),
	.shift_rs2_tag2(shift_rs2_tag2),
	.shift_rs2_tag3(shift_rs2_tag3),
	.shift_valid0(shift_valid0),
	.shift_valid1(shift_valid1),
	.shift_valid2(shift_valid2),
	.shift_valid3(shift_valid3),
	.shift_rs1_valid0(shift_rs1_valid0),
	.shift_rs1_valid1(shift_rs1_valid1),
	.shift_rs1_valid2(shift_rs1_valid2),
	.shift_rs1_valid3(shift_rs1_valid3),
	.shift_rs2_valid0(shift_rs2_valid0),
	.shift_rs2_valid1(shift_rs2_valid1),
	.shift_rs2_valid2(shift_rs2_valid2),
	.shift_rs2_valid3(shift_rs2_valid3),
	.issueque_rs1_data(issueque_rs1_data),
	.issueque_rs2_data(issueque_rs2_data),
	.issueque_rd_tag(issueque_rd_tag),
	.issueque_opcode(issueque_opcode)
);

Shift_update_control Shift_control(
	.shift_rs1_tag0(shift_rs1_tag0),
	.shift_rs1_tag1(shift_rs1_tag1),
	.shift_rs1_tag2(shift_rs1_tag2),
	.shift_rs1_tag3(shift_rs1_tag3),
	.shift_rs2_tag0(shift_rs2_tag0),
	.shift_rs2_tag1(shift_rs2_tag1),
	.shift_rs2_tag2(shift_rs2_tag2),
	.shift_rs2_tag3(shift_rs2_tag3),
	.dispatch_rs1_tag(dispatch_rs1_tag),
	.dispatch_rs1_data_val(dispatch_rs1_data_val),
	.dispatch_rs2_tag(dispatch_rs2_tag),
	.dispatch_rs2_data_val(dispatch_rs2_data_val),
	.dispatch_enable(dispatch_enable),
	.CDB_tag(cdb_tag),
	.CDB_valid(cdb_valid),
	.shift_valid0(shift_valid0),
	.shift_valid1(shift_valid1),
	.shift_valid2(shift_valid2),
	.shift_valid3(shift_valid3),
	.shift_rs1_valid0(shift_rs1_valid0),
	.shift_rs1_valid1(shift_rs1_valid1),
	.shift_rs1_valid2(shift_rs1_valid2),
	.shift_rs1_valid3(shift_rs1_valid3),
	.shift_rs2_valid0(shift_rs2_valid0),
	.shift_rs2_valid1(shift_rs2_valid1),
	.shift_rs2_valid2(shift_rs2_valid2),
	.shift_rs2_valid3(shift_rs2_valid3),
	.sel_rs1(sel_rs1),
	.sel_rs2(sel_rs2),
	.enable_rs1_valid(enable_rs1_valid),
	.enable_rs2_valid(enable_rs2_valid),
	.enable_valid(enable_valid),
	.enable_opcode(enable_opcode),
	.enable_rd_tag(enable_rd_tag),
	.enable_rs1_tag(enable_rs1_tag),
	.enable_rs2_tag(enable_rs2_tag),
	.enable_rs1_data(enable_rs1_data),
	.enable_rs2_data(enable_rs2_data),
	.data_sel(data_sel),
	.valid_clear(valid_clear),
	.issueque_full(issueque_full),
	.issueque_ready(issueque_ready),
	.issueblk_done(issueblk_done)
);
endmodule