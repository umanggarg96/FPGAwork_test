/*
*
module BCDIncrementor(Output,Input);

	output reg [11:0]Output;
	input [11:0]Input;
	reg [3:0]part1,part2,part3;
	reg c1,c2,c3;
*/

class bcd_genertor;
	rand logic [3:0] d0, d1, d2;
	constraint valid { d0 >= 0; d0 <= 9; d1 <= 9 ; d1 >= 0; d2 >= 0; d2 <= 9;}

	function logic [11:0] get_bcd();
		assert(this.randomize())
			return {d2, d1, d0};
		else
			$fatal("Randomization Failed");
		return 12'h000;
	endfunction
endclass
function bit  bcd_digit_incrementor(logic [3:0] digit, output logic [3:0] result);
	bit overflow;
	result = digit + 4'd1;
	overflow =  (result > 4'd9);
	result = overflow ? result + 4'd6 : result;
	return overflow;
endfunction

function logic [11:0] bcd_3digit_incrementor(logic [2:0][3:0] number);
	bit overflow;
	logic [2:0][3:0] result;
	int i;
	overflow = 1;
	result = number;
	for(i = 0; overflow ; i++)
		overflow = bcd_digit_incrementor(number[i], result[i]);
	return result;
endfunction
module bcd_incrementor_test;
	
	bit overflow;	
	bcd_genertor gen;
	logic [11:0] data;
	logic [11:0] inc_a;
	int errors = 0;

	BCDIncrementor dut(.Output(inc_a), .Input(data));
	
	logic [11:0] directed_vector[] = {12'h999, 12'h000, 12'h989, 12'h899, 12'h799};
	initial
	begin
		$display("Directed Test");
		foreach(directed_vector[i])
		begin
			data = directed_vector[i];
			#1;
			assert(inc_a === bcd_3digit_incrementor(data)) else
				$display("Error(%0d) : Input : %3h, Ouput - Exp : %3h, Found : %3h", errors++, data, bcd_3digit_incrementor(data), inc_a);
		end
		$display("Directed Test Ends with %0d errors", errors);
		$display("Random Test");
		gen = new();
		repeat(10000)
		begin
			data = gen.get_bcd();
			#1;
			assert(inc_a === bcd_3digit_incrementor(data)) else
				$display("Error(%0d) : Input : %3h, Ouput - Exp : %3h, Found : %3h", errors++, data, bcd_3digit_incrementor(data), inc_a);
		end
	end
endmodule
