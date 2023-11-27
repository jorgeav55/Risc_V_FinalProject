//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer:  Edgar Barba & Jorge Velazquez
// Module: Register
// Description: 
// Generic Register Definition.
// Data will be storage every clk rising edge if en is asserted.
// rst assertion will clear stored data.
//////////////////////////////////////////////////////////////////////////////////
module Register_RF #(parameter DATA_WIDTH=32)(
  input [(DATA_WIDTH-1):0] D,
  input [(DATA_WIDTH-1):0] dafault_D,
  input rst,
  input en,
  input clk,
  output reg [(DATA_WIDTH-1):0]Q
);

always @ (posedge clk, posedge rst)
begin
  if(rst==1)begin
    Q<=dafault_D;
  end
  else if (en == 1) begin
    Q<=D;
  end
  else 
	 Q<=Q;
end
endmodule