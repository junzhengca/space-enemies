module char_b_lut(x, y, out);
	input [7:0] x;
	input [7:0] y;
	output reg [6:0] out;

	always@(*)
	begin
		out[6] <= 1'b1;
		case({x, y})
			16'h0200: out[5:0] <= 6'b111111;
			16'h0300: out[5:0] <= 6'b111111;
			16'h0400: out[5:0] <= 6'b111111;
			16'h0500: out[5:0] <= 6'b111111;
			16'h0600: out[5:0] <= 6'b111111;
			
			16'h0201: out[5:0] <= 6'b111111;
			16'h0701: out[5:0] <= 6'b111111;
			
			16'h0202: out[5:0] <= 6'b111111;
			16'h0702: out[5:0] <= 6'b111111;
			
			16'h0203: out[5:0] <= 6'b111111;
			16'h0703: out[5:0] <= 6'b111111;
			
			16'h0204: out[5:0] <= 6'b111111;
			16'h0704: out[5:0] <= 6'b111111;
			
			16'h0205: out[5:0] <= 6'b111111;
			16'h0305: out[5:0] <= 6'b111111;
			16'h0405: out[5:0] <= 6'b111111;
			16'h0505: out[5:0] <= 6'b111111;
			16'h0605: out[5:0] <= 6'b111111;
			
			16'h0206: out[5:0] <= 6'b111111;
			16'h0706: out[5:0] <= 6'b111111;
			
			16'h0207: out[5:0] <= 6'b111111;
			16'h0707: out[5:0] <= 6'b111111;
			
			16'h0208: out[5:0] <= 6'b111111;
			16'h0708: out[5:0] <= 6'b111111;
			
			16'h0209: out[5:0] <= 6'b111111;
			16'h0309: out[5:0] <= 6'b111111;
			16'h0409: out[5:0] <= 6'b111111;
			16'h0509: out[5:0] <= 6'b111111;
			16'h0609: out[5:0] <= 6'b111111;
			default: out[6] <= 1'b0;
		endcase
	end
endmodule

module char_b(x, y, flush_x, flush_y, colour, enable);
	input [7:0] x;
	input [7:0] y;
	input [7:0] flush_x;
	input [7:0] flush_y;
	
	output [5:0] colour;
	output enable;
	
	wire [6:0] lut_out;
	
	char_b_lut(flush_x - x, flush_y - y, lut_out);
	
	assign colour = lut_out[5:0];
	assign enable = lut_out[6];
endmodule
