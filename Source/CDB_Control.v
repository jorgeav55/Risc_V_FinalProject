module CDB_Control(
	reset,
	clk,
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
	//CDB_valid,
	//CDB_branch,
	//CDB_branch_taken
	issue_int,
	issue_mult,
	issue_div,
	issue_ls_buf
);

//
input 			reset;
input 			clk;
input  [31:0]	int_data;
input  [5:0]	int_tag;
input  [31:0]	mult_data;
input  [5:0]	mult_tag;
input  [31:0]	div_data;
input  [5:0]	div_tag;
input  [31:0]	ld_buf_data;
input  [5:0]	ld_buf_tag;
input 			issue_int;
input 			issue_mult;
input 			issue_div;
input 			issue_ls_buf;
output [31:0] 	CDB_data;
output [5:0] 	CDB_tag;

//
wire [4:0] mult_bit;
wire [7:0] div_bit;
wire int_cdb_ctrl;
wire mult_cdb_ctrl;
wire div_cdb_ctrl;
wire ld_buf_cdb_ctrl;
reg [31:0] next_CDB_data;
reg [5:0]  next_CDB_tag;

//
assign mult_bit[0] = issue_mult;
assign div_bit[0] = issue_div;
assign int_cdb_ctrl = issue_int;
assign mult_cdb_ctrl = mult_bit[4];
assign div_cdb_ctrl = div_bit[7];
assign ld_buf_cdb_ctrl = issue_ls_buf;

genvar i;
generate
	for (i=0;i<7;i=i+1) begin : div_
		Register 
		#(
			.DATA_WIDTH(1)) bit_
		(
			.data_in			(div_bit[i]),
			.dafault_data	(1'b0),
			.reset			(reset),
			.enable			(1'b1),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(div_bit[i+1])
		);
	end
	for (i=0;i<4;i=i+1) begin : mult_
		Register 
		#(
			.DATA_WIDTH(1)) bit_
		(
			.data_in			(mult_bit[i]),
			.dafault_data	(1'b0),
			.reset			(reset),
			.enable			(1'b1),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(mult_bit[i+1])
		);
	end
endgenerate

always @* begin
	case({int_cdb_ctrl, mult_cdb_ctrl, div_cdb_ctrl, ld_buf_cdb_ctrl})
		4'b0001: begin
			next_CDB_data = ld_buf_data;
			next_CDB_tag  = ld_buf_tag;
		end
		4'b0010: begin
			next_CDB_data = div_data;
			next_CDB_tag  = div_tag;
		end
		4'b0100: begin
			next_CDB_data = mult_data;
			next_CDB_tag  = mult_tag;			
		end
		4'b1000: begin
			next_CDB_data = int_data;
			next_CDB_tag  = int_tag;
		end
		default: begin 
			next_CDB_data = 32'b0;
			next_CDB_tag  = 6'b0;
		end
	endcase
end


Register 
#(
	.DATA_WIDTH(32)) CDB_data_reg
(
	.data_in			(next_CDB_data),
	.dafault_data	(32'b0),
	.reset			(reset),
	.enable			(1'b1),
	.flush			(1'b0),
	.clk				(clk),
	.data_out		(CDB_data)
);

Register 
#(
	.DATA_WIDTH(6)) CDB_tag_reg
(
	.data_in			(next_CDB_tag),
	.dafault_data	(6'b0),
	.reset			(reset),
	.enable			(1'b1),
	.flush			(1'b0),
	.clk				(clk),
	.data_out		(CDB_tag)
);

endmodule