module Queue_Shift_Register (
	reset,
	clk,
	enable_rs1_valid,
	enable_rs2_valid,
	enable_valid,
	enable_opcode,
	enable_rd_tag,
	enable_rs1_tag,
	enable_rs2_tag,
	enable_rs1_data,
	enable_rs2_data,
	sel_rs1,
	sel_rs2,
	data_sel,
	valid_clear,
	CDB_data,
	dispatch_rs1_data,
	dispatch_rs1_tag,
	dispatch_rs1_data_val,
	dispatch_rs2_data,
	dispatch_rs2_tag,
	dispatch_rs2_data_val,
	dispatch_opcode,
	dispatch_rd_tag,
	dispatch_enable,
	//issueque_full,
	shift_rs1_tag0,
	shift_rs1_tag1,
	shift_rs1_tag2,
	shift_rs1_tag3,
	shift_rs2_tag0,
	shift_rs2_tag1,
	shift_rs2_tag2,
	shift_rs2_tag3,
	shift_valid0,
	shift_valid1,
	shift_valid2,
	shift_valid3,
	shift_rs1_valid0,
	shift_rs1_valid1,
	shift_rs1_valid2,
	shift_rs1_valid3,
	shift_rs2_valid0,
	shift_rs2_valid1,
	shift_rs2_valid2,
	shift_rs2_valid3,
	issueque_rs1_data,
	issueque_rs2_data,
	issueque_rd_tag,
	issueque_opcode
);

//Input and Output declaration.
input reset;
input clk;
input [3:0] enable_rs1_valid;
input [3:0] enable_rs2_valid;
input [3:0] enable_valid;
input [3:0] enable_opcode;
input [3:0] enable_rd_tag;
input [3:0] enable_rs1_tag;
input [3:0] enable_rs2_tag;
input [3:0] enable_rs1_data;
input [3:0] enable_rs2_data;
input [3:0] sel_rs1;
input [3:0] sel_rs2;
input [1:0] data_sel;
input [3:0] valid_clear;
input [31:0] CDB_data;
input [31:0] dispatch_rs1_data;
input [5:0] dispatch_rs1_tag;
input dispatch_rs1_data_val;
input [31:0] dispatch_rs2_data;
input [5:0] dispatch_rs2_tag;
input dispatch_rs2_data_val;
input [3:0] dispatch_opcode;
input [5:0] dispatch_rd_tag;
input dispatch_enable;
//output issueque_full;
output [5:0] shift_rs1_tag0;
output [5:0] shift_rs1_tag1;
output [5:0] shift_rs1_tag2;
output [5:0] shift_rs1_tag3;
output [5:0] shift_rs2_tag0;
output [5:0] shift_rs2_tag1;
output [5:0] shift_rs2_tag2;
output [5:0] shift_rs2_tag3;
output shift_valid0;
output shift_valid1;
output shift_valid2;
output shift_valid3;
output shift_rs1_valid0;
output shift_rs1_valid1;
output shift_rs1_valid2;
output shift_rs1_valid3;
output shift_rs2_valid0;
output shift_rs2_valid1;
output shift_rs2_valid2;
output shift_rs2_valid3;
output reg [31:0] issueque_rs1_data;
output reg [31:0] issueque_rs2_data;
output reg [5:0] issueque_rd_tag;
output reg [3:0] issueque_opcode;

//Wires definition:
wire rs1_valid_input [3:0];
wire rs1_valid_reg [4:0];
wire rs2_valid_input [3:0];
wire rs2_valid_reg [4:0];
wire valid_input [3:0];
wire valid_reg [4:0];
wire [3:0] opcode_reg [4:0];
wire [5:0] rd_tag_reg [4:0];
wire [5:0] rs1_tag_reg [4:0];
wire [5:0] rs2_tag_reg [4:0];
wire [31:0] rs1_data_input [3:0];
wire [31:0] rs1_data_reg [4:0];
wire [31:0] rs2_data_input [3:0];
wire [31:0] rs2_data_reg [4:0];

//Define general assigns
assign rs1_valid_reg[0] = dispatch_rs1_data_val;
assign rs2_valid_reg[0] = dispatch_rs2_data_val;
assign rs1_data_reg[0] = dispatch_rs1_data;
assign rs2_data_reg[0] = dispatch_rs2_data;
assign rs1_tag_reg[0] = dispatch_rs1_tag;
assign rs2_tag_reg[0] = dispatch_rs2_tag;
assign rd_tag_reg[0] = dispatch_rd_tag;
assign opcode_reg[0] = dispatch_opcode;
assign valid_reg[0] = dispatch_enable;
//assign issueque_full = valid_reg[1] & valid_reg[2] & valid_reg[3] & valid_reg[4];
assign shift_rs1_tag0 = rs1_tag_reg[1];
assign shift_rs1_tag1 = rs1_tag_reg[2];
assign shift_rs1_tag2 = rs1_tag_reg[3];
assign shift_rs1_tag3 = rs1_tag_reg[4];
assign shift_rs2_tag0 = rs2_tag_reg[1];
assign shift_rs2_tag1 = rs2_tag_reg[2];
assign shift_rs2_tag2 = rs2_tag_reg[3];
assign shift_rs2_tag3 = rs2_tag_reg[4];
assign shift_valid0 = valid_reg[1];
assign shift_valid1 = valid_reg[2];
assign shift_valid2 = valid_reg[3];
assign shift_valid3 = valid_reg[4];
assign shift_rs1_valid0 = rs1_valid_reg[1];
assign shift_rs1_valid1 = rs1_valid_reg[2];
assign shift_rs1_valid2 = rs1_valid_reg[3];
assign shift_rs1_valid3 = rs1_valid_reg[4];
assign shift_rs2_valid0 = rs2_valid_reg[1];
assign shift_rs2_valid1 = rs2_valid_reg[2];
assign shift_rs2_valid2 = rs2_valid_reg[3];
assign shift_rs2_valid3 = rs2_valid_reg[4];

genvar i;
generate
//i empieza con cero, pero los enables de abajo solo seleccionan del 1 en adelante
	for (i=0;i<4;i=i+1) begin: ShtReg
		Register 
		#(
			.DATA_WIDTH(4)) Opcode
		(
			.data_in			(opcode_reg[i]),
			.dafault_data	(4'b0),
			.reset			(reset),
			.enable			(enable_opcode[i]),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(opcode_reg[i+1])
		);
		Register 
		#(
			.DATA_WIDTH(6)) Rd_tag
		(
			.data_in			(rd_tag_reg[i]),
			.dafault_data	(6'b0),
			.reset			(reset),
			.enable			(enable_rd_tag[i]),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(rd_tag_reg[i+1])
		);
		Register 
		#(
			.DATA_WIDTH(6)) Rs1_tag
		(
			.data_in			(rs1_tag_reg[i]),
			.dafault_data	(6'b0),
			.reset			(reset),
			.enable			(enable_rs1_tag[i]),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(rs1_tag_reg[i+1])
		);
		Register 
		#(
			.DATA_WIDTH(6)) Rs2_tag
		(
			.data_in			(rs2_tag_reg[i]),
			.dafault_data	(6'b0),
			.reset			(reset),
			.enable			(enable_rs2_tag[i]),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(rs2_tag_reg[i+1])
		);
		Register 
		#(
			.DATA_WIDTH(32)) Rs1_data
		(
			.data_in			(rs1_data_input[i]),
			.dafault_data	(32'b0),
			.reset			(reset),
			.enable			(enable_rs1_data[i]),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(rs1_data_reg[i+1])
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
			.data_out		(rs2_data_reg[i+1])
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
			.data_out		(rs1_valid_reg[i+1])
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
			.data_out		(rs2_valid_reg[i+1])
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
			.data_out		(valid_reg[i+1])
		);
		assign {rs1_valid_input[i], rs1_data_input[i]} = (sel_rs1[i] == 1'b1) ? {1'b1, CDB_data} : {rs1_valid_reg[i], rs1_data_reg[i]};
		assign {rs2_valid_input[i], rs2_data_input[i]} = (sel_rs2[i] == 1'b1) ? {1'b1, CDB_data} : {rs2_valid_reg[i], rs2_data_reg[i]};
		assign valid_input[i] = (valid_clear[i] == 1'b1) ? 1'b0 : valid_reg[i];
	end
endgenerate

always @* begin
	case (data_sel)
		2'b11: begin
			issueque_rs1_data = rs1_data_reg[4];
			issueque_rs2_data = rs2_data_reg[4];
			issueque_rd_tag = rd_tag_reg[4];
			issueque_opcode = opcode_reg[4];
		end
		2'b10: begin
			issueque_rs1_data = rs1_data_reg[3];
			issueque_rs2_data = rs2_data_reg[3];
			issueque_rd_tag = rd_tag_reg[3];
			issueque_opcode = opcode_reg[3];
		end
		2'b01: begin
			issueque_rs1_data = rs1_data_reg[2];
			issueque_rs2_data = rs2_data_reg[2];
			issueque_rd_tag = rd_tag_reg[2];
			issueque_opcode = opcode_reg[2];
		end
		2'b00: begin
			issueque_rs1_data = rs1_data_reg[1];
			issueque_rs2_data = rs2_data_reg[1];
			issueque_rd_tag = rd_tag_reg[1];
			issueque_opcode = opcode_reg[1];
		end
		default: begin
			issueque_rs1_data = 32'b0;
			issueque_rs2_data = 32'b0;
			issueque_rd_tag = 6'b0;
			issueque_opcode = 4'b0;
		end
	endcase
end
endmodule