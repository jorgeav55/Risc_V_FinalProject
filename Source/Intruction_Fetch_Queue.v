module Intruction_Fetch_Queue 
#(
	parameter DATA_WIDTH = 32)
(
	clk,
	reset,
	flush,
	write_enable,
	write_pointer,
	selector,
	instruction_block_in,
	instruction_block_out
);

////////////////////////////////////////////////////////////////////////////////////////////
// Inputs and Outputs definitions
////////////////////////////////////////////////////////////////////////////////////////////
input 									clk;
input 									reset;
input 									flush;
input 									write_enable;
input 		[1:0]						write_pointer;
input 		[1:0]						selector;
input			[4*DATA_WIDTH-1:0]	instruction_block_in;
output reg	[4*DATA_WIDTH-1:0]	instruction_block_out;

////////////////////////////////////////////////////////////////////////////////////////////
// regs and wires definitions
////////////////////////////////////////////////////////////////////////////////////////////
reg 	[3:0]						enable;
wire 	[4*DATA_WIDTH-1:0]	Data_out		[3:0];


//For to create a FIFO, 4 rows(128bits), i integer inidicates the number of row
//The enable for this Registers in FIFO, come for a one hot.

////////////////////////////////////////////////////////////////////////////////////////////
// To create a fifo regiters with a 128bit width
////////////////////////////////////////////////////////////////////////////////////////////

genvar i;
generate
	for (i=0;i<4;i=i+1) begin: Ins
		Register 
		#(
			.DATA_WIDTH(4*DATA_WIDTH)) R 
		(
			.data_in			(instruction_block_in),
			.dafault_data	({(4*DATA_WIDTH){1'b0}}),
			.reset			(reset),
			.enable			(enable[i] & write_enable),
			.flush			(flush),
			.clk				(clk),
			.data_out		(Data_out[i])
		);
	end
endgenerate

//This case is the selecction, basically the number of row

////////////////////////////////////////////////////////////////////////////////////////////
// Always procedural block
////////////////////////////////////////////////////////////////////////////////////////////

always @* begin
	// Internal MUX for output selection
	case (selector)
		2'b00:	instruction_block_out = Data_out[0];
		2'b01:	instruction_block_out = Data_out[1];
		2'b10:	instruction_block_out = Data_out[2];
		2'b11:	instruction_block_out = Data_out[3];
	endcase
//Write pointer, is a one hot whichs enables every row, to write data 128 bits from ROM	
	// Internal One-hot selector for enable writting.
	case (write_pointer[1:0])
		2'b00: begin
			enable[0] = 1'b1;
			enable[1] = 1'b0;
			enable[2] = 1'b0;
			enable[3] = 1'b0;
		end
		2'b01: begin
			enable[0] = 1'b0;
			enable[1] = 1'b1;
			enable[2] = 1'b0;
			enable[3] = 1'b0;
		end	
		2'b10: begin
			enable[0] = 1'b0;
			enable[1] = 1'b0;
			enable[2] = 1'b1;
			enable[3] = 1'b0;
		end	
		2'b11: begin
			enable[0] = 1'b0;
			enable[1] = 1'b0;
			enable[2] = 1'b0;
			enable[3] = 1'b1;
		end
		default: begin
			enable[0] = 1'b0;
			enable[1] = 1'b0;
			enable[2] = 1'b0;
			enable[3] = 1'b0;
		end
		
	endcase
end

endmodule
