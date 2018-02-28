module tbforBCDinc;

	wire [11:0]Output;
	reg [11:0]Input;
	reg [3:0]part1,part2,part3;
	
	BCDIncrementor BCD(Output,Input);
	
	initial
	begin
			part1=4'h9;part2=4'h9;part3=4'h5;
			Input={part3,part2,part1};
		#0	$display("Input : %3h  Output : %3h",Input,Output);
		#10	part1=4'h9;part2=4'h0;part3=4'h2;
			Input={part3,part2,part1};
		#0	$display("Input : %3h  Output : %3h",Input,Output);
		#10	part1=4'h9;part2=4'h6;part3=4'h1;
			Input={part3,part2,part1};
		#0	$display("Input : %3h  Output : %3h",Input,Output);
		#10	part1=4'h9;part2=4'h8;part3=4'h7;
			Input={part3,part2,part1};
		#0	$display("Input : %3h  Output : %3h",Input,Output);
		#10	part1=4'h9;part2=4'h8;part3=4'h9;
			Input={part3,part2,part1};
		#0	$display("Input : %3h  Output : %3h",Input,Output);
		#10	part1=4'h9;part2=4'h7;part3=4'h1;
			Input={part3,part2,part1};
		#0	$display("Input : %3h  Output : %3h",Input,Output);
		#10	part1=4'h9;part2=4'h8;part3=4'h3;
			Input={part3,part2,part1};
		#0	$display("Input : %3h  Output : %3h",Input,Output);
		#10	part1=4'h9;part2=4'h5;part3=4'h3;
			Input={part3,part2,part1};
		#0	$display("Input : %3h  Output : %3h",Input,Output);
		#10	part1=4'h9;part2=4'h6;part3=4'h7;
			Input={part3,part2,part1};
		#0	$display("Input : %3h  Output : %3h",Input,Output);
		#10	part1=4'h9;part2=4'h2;part3=4'h4;
			Input={part3,part2,part1};
		#0	$display("Input : %3h  Output : %3h",Input,Output);
		#10	part1=4'h9;part2=4'h2;part3=4'h6;
			Input={part3,part2,part1};
		#0	$display("Input : %3h  Output : %3h",Input,Output);
		#10	part1=4'h9;part2=4'h3;part3=4'h4;
			Input={part3,part2,part1};
		#0	$display("Input : %3h  Output : %3h",Input,Output);
	end
	
endmodule
