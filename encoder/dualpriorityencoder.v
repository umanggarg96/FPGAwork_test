module priorencoder(out,in,prior);
	
	output reg [3:0]out;
	input [11:0]in;
	input [3:0]prior;
	
	reg [11:0]inI;
	
	always @*
	begin
		case(prior)
			4'h1:
				inI={in[11:1],1'b0};
			4'h2:
				inI={in[11:2],1'b0,in[0]};
			4'h3:
				inI={in[11:3],1'b0,in[1:0]};
			4'h4:
				inI={in[11:4],1'b0,in[2:0]};
			4'h5:
				inI={in[11:5],1'b0,in[3:0]};
			4'h6:
				inI={in[11:6],1'b0,in[4:0]};
			4'h7:
				inI={in[11:7],1'b0,in[5:0]};
			4'h8:
				inI={in[11:8],1'b0,in[6:0]};
			4'h9:
				inI={in[11:9],1'b0,in[7:0]};
			4'ha:
				inI={in[11:10],1'b0,in[8:0]};
			4'hb:
				inI={in[11],1'b0,in[9:0]};
			4'hc:
				inI={1'b0,in[10:0]};
			default:
				inI=in;
		endcase
		
		casez(inI)
			12'b1???????????:
				out=4'hc;
			12'b01??????????:
				out=4'hb;
			12'b001?????????:
				out=4'ha;
			12'b0001????????:
				out=4'h9;
			12'b00001???????:
				out=4'h8;
			12'b000001??????:
				out=4'h7;
			12'b0000001?????:
				out=4'h6;
			12'b00000001????:
				out=4'h5;
			12'b000000001???:
				out=4'h4;
			12'b0000000001??:
				out=4'h3;
			12'b00000000001?:
				out=4'h2;
			12'b000000000001:
				out=4'h1;
			default:
				out=4'h0;
		endcase
	end
	
endmodule

module dualpriorenc(first,second,in);
	
	output [3:0]first,second;
	input [11:0]in;
	
	wire [3:0]prior;
	
	assign prior=first;
	
	priorencoder pe1(first,in,4'h0);
	priorencoder pe2(second,in,prior);
	
endmodule