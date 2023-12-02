//////////////////////////////////////////////////////////////////////////////////
// Quartus II Verilog Template
// Single port RAM with single read/write address 
//
// Company: ITESO
// Engineer:  Edgar Barba & Jorge Velazquez
// Module: single_port_ram
// Description:
// RAM Module. It is defined as 2^Addres_Width Words of data.
// There is only one Output Data Port and one of each input Address and Input Data
// port.  
//////////////////////////////////////////////////////////////////////////////////
module Single_Port_RAM
#(parameter DATA_WIDTH = 32, parameter ADDRESS_WIDTH = 32)
(	
	input write_enable, read_enable, clock,
	input [(DATA_WIDTH-1):0] data,
	input [(ADDRESS_WIDTH-1):0] address,
	output [(DATA_WIDTH-1):0] Q );

// Declare the RAM array
reg [DATA_WIDTH-1:0] RAM[63:0];
wire [(ADDRESS_WIDTH-3):0] current_address;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
assign current_address=address[(ADDRESS_WIDTH-1):2];
always @ (posedge clock)
	begin
		// Write
		if (write_enable)
			RAM[current_address] <= data;
	end
// Reading continuously
assign Q = (read_enable)?RAM[current_address]:32'b0;

initial begin
	$readmemh("../Source/RadonNum.dat", RAM, 0, 19);
end

endmodule
