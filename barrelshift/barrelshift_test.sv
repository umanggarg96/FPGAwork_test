/*

module modified_barrel_shift(Out,In,Num,LR);
	
	output [7:0]Out;
	input [7:0]In;
	input [2:0]Num;
	input LR;


	Module : modified_barrel_shift
	- Input signals
		# In - 8 bit signal on which shift has to be performed
		# Num - 3 bit signal, telling the amount of shift required
		# LR - 1 bit signal telling whether to perform right or left shift. (0-right 1-left)
		
	- Output signals
		# Out - 8 bit signal storing the shifted result
		
	- Intermediate signals
		# OutR - 8 bit signal storing right shifted signal
		# OutL - 8 bit signal storing right shifted signal
*/
`define N 8
`define M 3
function logic [`N-1:0] right_shift(logic [`N-1:0] data, logic [`M-1:0] ammount);
	for(int i = 0; i < ammount; i++)
		data = {data[0], data[`N-1:1]};
	//return {data[ammount-1:0], data[`N-1:ammount]};
	return data;
endfunction


function logic [`N-1:0] left_shift(logic [`N-1:0] data, logic [`M-1:0] ammount);
	for(int i = 0; i < ammount; i++)
		data = {data[`N-2:0], data[`N-1]};
	return data;
endfunction

module barrelshift_test;

	logic [`N-1:0] 	data;
	logic [`M-1:0] 	ammount;
	logic 		dir;
	wire  [`N-1:0]  out_a;

	logic [`N-1:0] 	expt;

	int		random_errors = 0;
	int		right_errors = 0;
	int		left_errors  = 0;

	modified_barrel_shift dut(.Out(out_a), .In(data), .Num(ammount), .LR(dir));

	initial
	begin
		$display("TEST 1: RIGHT SHIFT");
		dir = 1'b0;
		for(int i = 0; i < 20; i++)
		begin
			data = $random;
			for(int j = 0; j < 8; j++)
			begin
				ammount = j;
				#1;
				expt = right_shift(data, ammount);
				assert(out_a === expt)
				else
				begin
					right_errors++;
					$display("Error (RIGHT SHIFT by %0d) : data = %8h, exp : %8b found : %8b", ammount, data, out_a, expt);
				end
			end
		end
		$display("RIGHT TEST COMPLETE with %0d errors", right_errors);
		$display("TEST 2: LEFT  SHIFT");
		dir = 1'b1;
		for(int i = 0; i < 20; i++)
		for(int i = 0; i < 20; i++)
		begin
			data = $random;
			for(int j = 0; j < 8; j++)
			begin
				ammount = j;
				#1;
				expt = left_shift(data, ammount);
				assert(out_a === expt)
				else
				begin
					left_errors++;
					$display("Error (LEFT SHIFT by %0d) : data = %8h, exp : %8b found : %8b", ammount, data, out_a, expt);
				end
			end
		end
		$display("LEFT TEST COMPLETE with %0d errors", left_errors);
		for(int i = 0; i < 200; i++)
		begin
			data = $random;
			for(int j = 0; j < 8; j++)
			begin
				ammount = i;
				dir = $random;
				#1;
				expt = dir ? left_shift(data, ammount) : right_shift(data, ammount);
				assert(out_a === expt)
				else
				begin
					random_errors++;
					$display("Error (%s SHIFT by %0d) : data = %8h, exp : %8b found : %8b",dir?"LEFT":"RIGHT", ammount, data, out_a, expt);
				end
			end
		end
		$display("TEST 3: RANDOM SHIFT");
		$display("RANDOM TEST COMPLETE with %0d errors", random_errors);
	end	
endmodule
