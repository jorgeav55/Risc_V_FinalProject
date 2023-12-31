`timescale 1ns / 1ps
module risc_core_tb();

reg clk;
reg rst;

risc_core riscv_core(
.reset(rst),
.clk(clk)
);

initial begin
	clk = 1'b0;
	rst = 1'b0;
	#1;
	rst = 1'b1;
	#1;
	rst = 1'b0;	
end

initial forever begin
	#1
	clk = ~clk;
end 

endmodule