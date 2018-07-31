module char_q_lut(x, y, out);
	input [7:0] x;
	input [7:0] y;
	output reg [6:0] out;

	always@(*)
	begin
		out[6] <= 1'b1;
		case({x, y})
			16'h0300: out[5:0] <= 6'b111111;
			16'h0400: out[5:0] <= 6'b111111;
			16'h0500: out[5:0] <= 6'b111111;
			16'h0600: out[5:0] <= 6'b111111;
			
			16'h0201: out[5:0] <= 6'b111111;
			16'h0601: out[5:0] <= 6'b111111;
			
			16'h0202: out[5:0] <= 6'b111111;
			16'h0702: out[5:0] <= 6'b111111;
			
			16'h0203: out[5:0] <= 6'b111111;
			16'h0703: out[5:0] <= 6'b111111;
			
			16'h0204: out[5:0] <= 6'b111111;
			16'h0704: out[5:0] <= 6'b111111;
			
			16'h0205: out[5:0] <= 6'b111111;
			16'h0705: out[5:0] <= 6'b111111;
			
			16'h0306: out[5:0] <= 6'b111111;
			16'h0406: out[5:0] <= 6'b111111;
			16'h0506: out[5:0] <= 6'b111111;
			16'h0606: out[5:0] <= 6'b111111;
			
			16'h0407: out[5:0] <= 6'b111111;
			16'h0507: out[5:0] <= 6'b111111;
			
			16'h0608: out[5:0] <= 6'b111111;
			16'h0709: out[5:0] <= 6'b111111;
			default: out[6] <= 1'b0;
		endcase
	end
endmodule

module char_q(x, y, flush_x, flush_y, colour, enable);
	input [7:0] x;
	input [7:0] y;
	input [7:0] flush_x;
	input [7:0] flush_y;
	
	output [5:0] colour;
	output enable;
	
	wire [6:0] lut_out;
	
	char_q_lut(flush_x - x, flush_y - y, lut_out);
	
	assign colour = lut_out[5:0];
	assign enable = lut_out[6];
endmodule
