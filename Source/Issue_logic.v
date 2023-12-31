module Issue_logic(
	reset,
	clk,
	ready_int,
	ready_mult,
	ready_div,
	ready_ld_buf,
	div_exec_ready,
	issue_int,
	issue_mult,
	issue_div,
	issue_ls_buf,
	ins_issued
);

//
input reset;
input clk;
input ready_int;
input ready_mult;
input ready_div;
input ready_ld_buf;
input div_exec_ready;
output reg issue_int;
output reg issue_mult;
output reg issue_div;
output reg issue_ls_buf;
output ins_issued;
	
//
wire [6:0] bit_in;
wire [7:0] bit_out;
reg current_LRU;
//reg next_LRU;

//
assign bit_out[7] = div_exec_ready & ready_div;
assign ins_issued = bit_out[0];

genvar i;
generate
	for (i=0;i<7;i=i+1) begin : Res_Table
		Register 
		#(
			.DATA_WIDTH(1)) bit_
		(
			.data_in			(bit_in[i]),
			.dafault_data	(1'b0),
			.reset			(reset),
			.enable			(1'b1),
			.flush			(1'b0),
			.clk				(clk),
			.data_out		(bit_out[i])
		);
		if(i == 0) begin
			assign bit_in[i] = bit_out[i+1] | ready_int | ready_ld_buf;
		end
		else if(i == 4) begin
			assign bit_in[i] = bit_out[i+1] | ready_mult;			
		end
		else begin
			assign bit_in[i] = bit_out[i+1];
		end
	end
endgenerate

always @* begin
	if(bit_out[1] == 1'b0 /*&& (ready_int == 1'b1 || ready_ld_buf == 1'b1)*/) begin
		if(ready_int == 1'b1 && ready_ld_buf == 1'b1) begin
			issue_int = current_LRU;
			issue_ls_buf = ~current_LRU;			
		end
		else begin
			issue_int = ready_int;
			issue_ls_buf = ready_ld_buf;
		end
	end
	else begin
		issue_int = 1'b0;
		issue_ls_buf =1'b0;
	end
	if(bit_out[4] == 1'b0 && ready_mult == 1'b1) begin
		issue_mult = 1'b1;
	end
	else begin
		issue_mult =1'b0;
	end
	if(div_exec_ready == 1'b1 && ready_div == 1'b1) begin
		issue_div = 1'b1;
	end
	else begin
		issue_div =1'b0;
	end
	/*
	if(issue_int == 1'b1) begin
		next_LRU = 1'b0;
	end
	else if (issue_ls_buf == 1'b1) begin
		next_LRU = 1'b1;
	end
	else begin
		next_LRU = current_LRU;
	end*/
end

/*Register 
#(
	.DATA_WIDTH(1)) LRU
(
	.data_in			(next_LRU),
	.dafault_data	(1'b0),
	.reset			(reset),
	.enable			(ready_int | ready_ld_buf),
	.flush			(flush),
	.clk				(clk),
	.data_out		(current_LRU)
);*/
always @(posedge clk, posedge reset) begin
	if(reset == 1'b1) begin
		current_LRU <= 1'b1;
	end
	else begin
		if(issue_int == 1'b1) begin
			current_LRU <= 1'b0;
		end
		else if (issue_ls_buf == 1'b1) begin
			current_LRU <= 1'b1;
		end
		else begin
			current_LRU <= current_LRU;		
		end
	end
end
endmodule