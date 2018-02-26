/*
 * Functional Description -
 * 	
 * 	N : number of bits in input req signal
 * 	M : number of bits in output first and second signals
 * 	M >= log2(N)
 *	
 *	Convention for priority : 
 *	8 - bit req vector
 *		v	v	v	v	v	v	v	v
 *		highest priority			  lowest priority
 *	code :  8	7	6	5	4	3	2	1
 *	Note : incase of an invlid signal output will be 0.
 * 	Pseudo-code : 
 * 		
 * 		first = M'b0;
 * 		second = M'b0;
 *		int i;
 *		for(i = N; i >= 0; i--)
 *			if(req[i] === 1'b1)
 *			{
 *				first = i + 1;
 *				break;
 *			}
 *		for(i = i - 1; i >= 0; i--)
 *			if(arr[i] === 1'b1)
 *			{
 *				second = i + 1;
 *				break;
 *			}
 *
 */

`define N 12
`define M 4

function void dual_encode(input [`N-1:0] req, output [`M-1:0] first, second);
	int i;
	first = '0;
	second = '0;
	for(i = `N-1; i >= 0 ; i--)
		if(req[i] === 1'b1)
		begin
			first = i + 1;
			break;
		end
	for(i = i - 1; i >= 0; i--)
		if(req[i] === 1'b1)
		begin
			second = i + 1;
			break;
		end
endfunction 

module encoder_test;
	
	reg  [`N-1:0] req;
	reg  [`M-1:0] first, second;
	wire [`M-1:0] first_a, second_a;
	int errors = 0;
/*
module dualpriorenc(first,second,in);
	output [3:0]first,second;
	input [11:0]in;
*/	
	dualpriorenc dut(.first(first_a), .second(second_a), .in(req));
	initial
	begin	
		$display("Starting Test");
		for(int i = 0; i < 2**`N - 1; i++)
		begin
			req = i;
			#1;
			dual_encode(req, first, second);
			assert(second === second_a)
			else
				$display("(%5d)req = %12b - second = exp : %4b found : %4b",errors++, req, second, second_a);
			assert(first === first_a)
			else
				$display("(%5d)req = %12b - first = exp : %4b found : %4b",errors++, req, first, first_a);
			//$display("%4b | %2b %2b", req, first, second);
		end
		$display("Found %0d errors", errors);
		$display("Ending Test");
	end

endmodule
