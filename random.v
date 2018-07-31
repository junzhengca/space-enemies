module random_count(clk, divider_in, number);
	output [6:0] number;
	reg [6:0] store;
	input [2:0] divider_in;
	reg [2:0] divider_count;
	input clk;
	always @(posedge clk)
	begin
		divider_count <= divider_count + 1;
		if(divider_count == divider_in)
			store <= store + 1;
	end
	
	assign number = store;
endmodule

module random(clk, divider_in, out);
	input clk;
	input [2:0] divider_in;
	output reg [6:0] out;

	wire [6:0] number;
	random_count(clk, divider_in, number);
	
	always @(*)
	begin
		if(number < 7'b0001000)
			out <= 7'b0001000;
		else if(number > 7'b1110111)
			out <= 7'b1110111;
		else
			out <= number;
	end
endmodule
