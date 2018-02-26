module rotateright(out,in,num);
	
	output reg [7:0]out;
	input [7:0]in;
	input [2:0]num;
	
	always @*
	begin
		case(num)
			3'h1:
				out={in[0],in[7:1]};
			3'h2:
				out={in[1:0],in[7:2]};
			3'h3:
				out={in[2:0],in[7:3]};
			3'h4:
				out={in[3:0],in[7:4]};
			3'h5:
				out={in[4:0],in[7:5]};
			3'h6:
				out={in[5:0],in[7:6]};
			3'h7:
				out={in[6:0],in[7]};
			default:
				out=in;
		endcase
	end
	
endmodule

module rotateleft(out,in,num);
	
	output reg [7:0]out;
	input [7:0]in;
	input [2:0]num;
	
	always @*
	begin
		case(num)
			3'h1:
				out={in[6:0],in[7]};
			3'h2:
				out={in[5:0],in[7:6]};
			3'h3:
				out={in[4:0],in[7:5]};
			3'h4:
				out={in[3:0],in[7:4]};
			3'h5:
				out={in[2:0],in[7:3]};
			3'h6:
				out={in[1:0],in[7:2]};
			3'h7:
				out={in[0],in[7:1]};
			default:
				out=in;
		endcase
	end
	
endmodule

module reverse(out,in);
	
	output [7:0]out;
	input [7:0]in;
	
	assign out={in[0],in[1],in[2],in[3],in[4],in[5],in[6],in[7]};
	
endmodule

module rotateleft_rgt(out,in,num);
	
	output [7:0]out;
	input [7:0]in;
	input [2:0]num;
	
	wire [7:0]outR,outRV;
	
	reverse r1(outRV,in);
	rotateright rr(outR,outRV,num);
	reverse r2(out,outR);
	
endmodule

module modified_barrel_shift(Out,In,Num,LR);
	
	output [7:0]Out;
	input [7:0]In;
	input [2:0]Num;
	input LR;
	
	wire [7:0]OutR,OutL;
	
	rotateright RR(OutR,In,Num);
	rotateleft_rgt RL(OutL,In,Num);
	
	assign Out=LR ? OutL : OutR;
	
endmodule
