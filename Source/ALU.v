//////////////////////////////////////////////////////////////////////////////////
// Company: ITESO
// Engineer: Edgar Fabricio Barba Flogic_ores & Jorge Velazquez Maldonado
//  
// Module Name: ALU
// Module description: 
// This module ALU is capable of proccess 10 logic and arithmetic functions as 
// follows:
// Function 010b: Arithmetic signed sum.
// Function 110b: Arithmetic signed sunsigned_Bstraction.
// Function 000b: Logic AND.
// Function 001b: Logic OR.
// Function 011b: Shift Right.
// 
// This module receives 3 inputs (two operands and one control) and outputs one 
// result and two output flags (negative and zero).
// 
//////////////////////////////////////////////////////////////////////////////////

module ALU #(parameter LENGTH = 32)(
//Inputs
 input signed [LENGTH-1:0] A,
 input signed [LENGTH-1:0] B,
 input [4:0] control,
//Outputs
 //output zero_flag,
 //output negative_flag,
 output reg signed [LENGTH-1:0] result,
 output reg branch,
 output reg branch_taken
);

wire [LENGTH-1:0] suma,resta,logic_and,logic_or,logic_xor,shift_left,shift_right,shift_right_unsigned,set_less ,set_less_unsigned/*, multiplication*/;
wire unsigned [LENGTH-1:0] unsigned_A, unsigned_B;
wire branch_equal;
wire branch_not_equal;
wire branch_lesser;
wire branch_greater;
wire branch_lesser_u;
wire branch_greater_u;

//wire co;

assign unsigned_A = A;
assign unsigned_B = B;

//Set All the ALU logic into wires outside the Always statement.
assign suma = A+B;     //Current assignment for sum of two signed numbers (a, b)
assign resta = A-B;     //Current assignment for rest of two signed numbers (a, b)
assign logic_and = A&B; //Assigment for a logical AND operation of two numbers (a, b)
assign logic_or = A|B;  //Assigment for a logical OR operation of two numbers (a, b)
assign shift_left = A<<({27'b0,unsigned_B[4:0]}); //Assigment logic for shift rigth of data (a) according with (B) data
assign shift_right = A>>({27'b0,unsigned_B[4:0]});
assign shift_right_unsigned = unsigned_A>>>({27'b0,unsigned_B[4:0]});
assign logic_xor = A^B;
assign set_less  = (A<B)?1:0;
assign set_less_unsigned = (unsigned_A<unsigned_B)?1:0;
//assign multiplication = A*B;
assign branch_equal = (A == B) ? 1'b1: 1'b0;
assign branch_not_equal = (A != B) ? 1'b1: 1'b0;
assign branch_lesser = (A < B) ? 1'b1: 1'b0;
assign branch_greater = (A >= B) ? 1'b1: 1'b0;
assign branch_lesser_u = (unsigned_A < unsigned_B) ? 1'b1: 1'b0;
assign branch_greater_u = (unsigned_A >= unsigned_B) ? 1'b1: 1'b0;

//Always to Mux the output.
always @ * begin
	if(control[4] == 1'b0) begin
		//Case sentence for Muxing the output.
		case (control[3:0])
		  4'b0000:result= suma;
		  4'b1000:result= resta;
		  4'b0111:result= logic_and; 
		  4'b0110:result= logic_or;
		  4'b0100:result= logic_xor;
		  4'b0001:result= shift_left;
		  4'b0101:result= shift_right;
		  4'b1101:result= shift_right_unsigned;
		  4'b0010:result= set_less ;
		  4'b0011:result= set_less_unsigned;
		  //4'b0000:result= multiplication;	 
		  default:result= {LENGTH{1'b0}};
		endcase
		branch = 1'b0;
		branch_taken = 1'b0;
	end
	else begin
		result= {LENGTH{1'b0}};
		branch = 1'b1;
		case (control[2:0])
		  3'b000:branch_taken= branch_equal;
		  3'b001:branch_taken= branch_not_equal;
		  3'b100:branch_taken= branch_lesser;
		  3'b101:branch_taken= branch_greater;
		  3'b110:branch_taken= branch_lesser_u; 
		  3'b111:branch_taken= branch_greater_u;
		  default:branch_taken= 1'b0;
		endcase
	end
end

//assign zero_flag = (result == {LENGTH{1'b0}})?1'b1:1'b0;	//Define the Zero Flag to be the 1 if the result is 0.
//assign negative_flag = result[LENGTH-1];		//Define the Negative flag to be 1 if the MSB of result is 1.
endmodule