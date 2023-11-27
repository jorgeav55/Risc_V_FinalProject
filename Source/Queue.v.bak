module Queue ( 
	clk,
	reset,
	flush,
	write_enable,
	write_pointer,
	read_pointer,	
	dispatch_rs1_data,
	dispatch_rs1_tag,
	dispatch_rs1_data_val,
	dispatch_rs2_data,
	dispatch_rs2_tag,
	dispatch_rs2_data_val,
	dispatch_opcode,
	dispatch_rd_tag,
	CDB_tag,
	CDB_data,
	CDB_valid,
	issueque_ready,
	issueque_rs1_data,
	issueque_rs2_data,
	issueque_rd_tag,
	issueque_opcode,
	issueblk_done
	//instruction_in,
	//instruction_out
);

input 									clk;
input 									reset;
input 									flush;
input 									write_enable;
input 		[1:0]						write_pointer;
input 		[1:0]						read_pointer;
//input			[DATA_WIDTH-1:0]	instruction_in;
//output reg	[DATA_WIDTH-1:0]	instruction_out;
input [31:0] dispatch_rs1_data;
input [5:0] dispatch_rs1_tag;
input dispatch_rs1_data_val;
input [31:0] dispatch_rs2_data;
input [5:0] dispatch_rs2_tag;
input dispatch_rs2_data_val;
input [1:0] dispatch_opcode;
input [5:0] dispatch_rd_tag;
input [5:0] CDB_tag;
input [31:0] CDB_data;
input CDB_valid;
output reg issueque_ready;
output reg [31:0] issueque_rs1_data;
output reg [31:0] issueque_rs2_data;
output reg [5:0] issueque_rd_tag;
output reg [1:0] issueque_opcode;
input issueblk_done;

//reg 	[3:0]						enable;
//wire 	[4*DATA_WIDTH-1:0]	Data_out		[3:0];
reg	[3:0] 	opcode_en;
reg	[3:0] 	enable_rd_tag;
reg	[3:0] 	enable_rs1_tag;
reg	[3:0] 	enable_rs2_tag;
reg	[3:0] 	enable_rs1_data;
reg	[3:0] 	enable_rs2_data;
reg	[3:0] 	enable_rs1_valid;
reg	[3:0] 	enable_rs2_valid;
wire	[3:0] 	enable_valid;
reg 	[3:0] 	clear_valid;
reg 	[3:0] 	set_valid;
wire 	[3:0] 	CDB_tag_rs1_comp;
wire 	[3:0] 	CDB_tag_rs2_comp;
wire	[1:0] 	opcode_reg  [3:0];
wire 	[5:0] 	rd_tag_reg  [3:0];
wire 	[5:0] 	rs1_tag_reg [3:0];
wire 	[5:0] 	rs2_tag_reg [3:0];
wire 	[31:0] 	rs1_data_input [3:0];
wire 	[31:0] 	rs1_data_reg [3:0];
wire rs1_valid_input [3:0];
wire rs1_valid_reg [3:0];
wire 	[31:0] 	rs2_data_input [3:0];
wire 	[31:0] 	rs2_data_reg [3:0];
wire rs2_valid_input [3:0];
wire rs2_valid_reg [3:0];
reg  [3:0] valid_input;
wire valid_reg [3:0];

assign 	enable_valid = (issueblk_done == 1'b1) && (issueque_ready == 1'b1) ? clear_valid | set_valid : set_valid;
/*assign opcode_reg[0]  = dispatch_opcode;
assign rd_tag_reg[0]  = dispatch_rd_tag;
assign rs1_tag_reg[0] = dispatch_rs1_tag;
assign rs1_data_reg[0] = dispatch_rs1_data;
assign rs2_tag_reg[0] = dispatch_rs2_tag;
assign rs2_data_reg[0] = dispatch_rs2_data;*/

genvar i;
generate
	for (i=0;i<4;i=i+1) begin: Ins
		Register 
		#(
			.DATA_WIDTH(2)) Opcode_
		(
			.data_in			(dispatch_opcode),
			.dafault_data	(2'b0),
			.reset			(reset),
			.enable			(opcode_en[i]),
			.flush			(flush),
			.clk				(clk),
			.data_out		(opcode_reg[i])
		);Register 
		#(
			.DATA_WIDTH(6)) Rd_tag
		(
			.data_in			(dispatch_rd_tag),
			.dafault_data	(6'b0),
			.reset			(reset),
			.enable			(enable_rd_tag[i]),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(rd_tag_reg[i])
		);
		Register 
		#(
			.DATA_WIDTH(6)) Rs1_tag
		(
			.data_in			(dispatch_rs1_tag),
			.dafault_data	(6'b0),
			.reset			(reset),
			.enable			(enable_rs1_tag[i]),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(rs1_tag_reg[i])
		);
		Register 
		#(
			.DATA_WIDTH(6)) Rs2_tag
		(
			.data_in			(dispatch_rs2_tag),
			.dafault_data	(6'b0),
			.reset			(reset),
			.enable			(enable_rs2_tag[i]),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(rs2_tag_reg[i])
		);Register 
		#(
			.DATA_WIDTH(32)) Rs1_data
		(
			.data_in			(rs1_data_input[i]),
			.dafault_data	(32'b0),
			.reset			(reset),
			.enable			(enable_rs1_data[i]),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(rs1_data_reg[i])
		);
		Register 
		#(
			.DATA_WIDTH(32)) Rs2_data
		(
			.data_in			(rs2_data_input[i]),
			.dafault_data	(32'b0),
			.reset			(reset),
			.enable			(enable_rs2_data[i]),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(rs2_data_reg[i])
		);
		Register 
		#(
			.DATA_WIDTH(1)) Rs1_valid
		(
			.data_in			(rs1_valid_input[i]),
			.dafault_data	(1'b0),
			.reset			(reset),
			.enable			(enable_rs1_valid[i]),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(rs1_valid_reg[i])
		);
		Register 
		#(
			.DATA_WIDTH(1)) Rs2_valid
		(
			.data_in			(rs2_valid_input[i]),
			.dafault_data	(1'b0),
			.reset			(reset),
			.enable			(enable_rs2_valid[i]),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(rs2_valid_reg[i])
		);
		Register 
		#(
			.DATA_WIDTH(1)) Reg_valid
		(
			.data_in			(valid_input[i]),
			.dafault_data	(1'b0),
			.reset			(reset),
			.enable			(enable_valid[i]),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(valid_reg[i])
		);
		assign CDB_tag_rs1_comp[i] = ((CDB_tag == rs1_tag_reg[i] && rs1_valid_reg[i] == 1'b0) || (CDB_tag == dispatch_rs1_tag)) && (CDB_valid == 1'b1) ? 1'b1 : 1'b0 ;
		assign CDB_tag_rs2_comp[i] = ((CDB_tag == rs2_tag_reg[i] && rs2_valid_reg[i] == 1'b0) || (CDB_tag == dispatch_rs2_tag)) && (CDB_valid == 1'b1) ? 1'b1 : 1'b0 ;
		assign {rs1_valid_input[i], rs1_data_input[i]} = CDB_tag_rs1_comp[i] ? {1'b1, CDB_data} : {dispatch_rs1_data_val, dispatch_rs1_data};
		assign {rs2_valid_input[i], rs2_data_input[i]} = CDB_tag_rs2_comp[i] ? {1'b1, CDB_data} : {dispatch_rs2_data_val, dispatch_rs2_data};
		//assign valid_input[i] = (valid_clear[i] == 1'b1) ? 1'b0 : valid_reg[i];
	end
endgenerate

always @* begin
	case (read_pointer)
		2'b00: begin
			issueque_opcode = opcode_reg[0];
			issueque_rd_tag = rd_tag_reg[0];
			issueque_rs1_data = rs1_data_reg[0];
			issueque_rs2_data = rs2_data_reg[0];
			clear_valid = 4'b0001;
			issueque_ready = valid_reg[0] & rs2_valid_reg[0] & rs1_valid_reg[0];
		end
		2'b01: begin
			issueque_opcode = opcode_reg[1];
			issueque_rd_tag = rd_tag_reg[1];
			issueque_rs1_data = rs1_data_reg[1];
			issueque_rs2_data = rs2_data_reg[1];
			clear_valid = 4'b0010;
			issueque_ready = valid_reg[1] & rs2_valid_reg[1] & rs1_valid_reg[1];
		end
		2'b10: begin
			issueque_opcode = opcode_reg[2];
			issueque_rd_tag = rd_tag_reg[2];
			issueque_rs1_data = rs1_data_reg[2];
			issueque_rs2_data = rs2_data_reg[2];
			clear_valid = 4'b0100;
			issueque_ready = valid_reg[2] & rs2_valid_reg[2] & rs1_valid_reg[2];
		end
		2'b11: begin
			issueque_opcode = opcode_reg[3];
			issueque_rd_tag = rd_tag_reg[3];
			issueque_rs1_data = rs1_data_reg[3];
			issueque_rs2_data = rs2_data_reg[3];
			clear_valid = 4'b1000;
			issueque_ready = valid_reg[3] & rs2_valid_reg[3] & rs1_valid_reg[3];
		end
		default: begin
			issueque_opcode = 2'b00;
			issueque_rd_tag = 6'b0;
			issueque_rs1_data = 32'b0;
			issueque_rs2_data = 32'b0;	
			clear_valid = 4'b0000;
			issueque_ready = 1'b0;		
		end
	endcase
	if(write_enable) begin
		case (write_pointer[1:0])
			2'b00: begin
				opcode_en = 4'b0001;
				enable_rd_tag = 4'b0001;
				enable_rs1_tag = 4'b0001;
				enable_rs2_tag = 4'b0001;
				enable_rs1_data = 4'b0001 | CDB_tag_rs1_comp;
				enable_rs2_data = 4'b0001 | CDB_tag_rs2_comp;
				enable_rs1_valid = 4'b0001 | CDB_tag_rs1_comp;
				enable_rs2_valid = 4'b0001 | CDB_tag_rs2_comp;
				set_valid = 4'b0001;
				valid_input = 4'b0001;
			end
			2'b01: begin
				opcode_en = 4'b0010;
				enable_rd_tag = 4'b0010;
				enable_rs1_tag = 4'b0010;
				enable_rs2_tag = 4'b0010;
				enable_rs1_data = 4'b0010 | CDB_tag_rs1_comp;
				enable_rs2_data = 4'b0010 | CDB_tag_rs2_comp;
				enable_rs1_valid = 4'b0010 | CDB_tag_rs1_comp;
				enable_rs2_valid = 4'b0010 | CDB_tag_rs2_comp;
				set_valid = 4'b0010;
				valid_input = 4'b0010;
			end	
			2'b10: begin
				opcode_en = 4'b0100;
				enable_rd_tag = 4'b0100;
				enable_rs1_tag = 4'b0100;
				enable_rs2_tag = 4'b0100;
				enable_rs1_data = 4'b0100 | CDB_tag_rs1_comp;
				enable_rs2_data = 4'b0100 | CDB_tag_rs2_comp;
				enable_rs1_valid = 4'b0100 | CDB_tag_rs1_comp;
				enable_rs2_valid = 4'b0100 | CDB_tag_rs2_comp;
				set_valid = 4'b0100;
				valid_input = 4'b0100;
			end	
			2'b11: begin
				opcode_en = 4'b1000;
				enable_rd_tag = 4'b1000;
				enable_rs1_tag = 4'b1000;
				enable_rs2_tag = 4'b1000;
				enable_rs1_data = 4'b1000 | CDB_tag_rs1_comp;
				enable_rs2_data = 4'b1000 | CDB_tag_rs2_comp;
				enable_rs1_valid = 4'b1000 | CDB_tag_rs1_comp;
				enable_rs2_valid = 4'b1000 | CDB_tag_rs2_comp;
				set_valid = 4'b1000;
				valid_input = 4'b1000;
			end
			default: begin
				opcode_en = 4'b0000;
				enable_rd_tag = 4'b0000;
				enable_rs1_tag = 4'b0000;
				enable_rs2_tag = 4'b0000;
				enable_rs1_data = 4'b0000;
				enable_rs2_data = 4'b0000;
				enable_rs1_valid = 4'b0000;
				enable_rs2_valid = 4'b0000;
				set_valid = 4'b0000;
				valid_input = 4'b0000;
			end
		endcase
	end
	else begin
		opcode_en = 4'b0000;
		enable_rd_tag = 4'b0000;
		enable_rs1_tag = 4'b0000;
		enable_rs2_tag = 4'b0000;
		enable_rs1_data = CDB_tag_rs1_comp;
		enable_rs2_data = CDB_tag_rs2_comp;
		enable_rs1_valid = CDB_tag_rs1_comp;
		enable_rs2_valid = CDB_tag_rs2_comp;
		set_valid = 4'b0000;
		valid_input = 4'b0000;
	end
end

endmodule