module char_i_lut(x, y, out);
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
			
			16'h0401: out[5:0] <= 6'b111111;
			16'h0402: out[5:0] <= 6'b111111;
			16'h0403: out[5:0] <= 6'b111111;
			16'h0404: out[5:0] <= 6'b111111;
			16'h0405: out[5:0] <= 6'b111111;
			16'h0406: out[5:0] <= 6'b111111;
			16'h0407: out[5:0] <= 6'b111111;
			16'h0408: out[5:0] <= 6'b111111;
			
			16'h0309: out[5:0] <= 6'b111111;
			16'h0409: out[5:0] <= 6'b111111;
			16'h0509: out[5:0] <= 6'b111111;

			default: out[6] <= 1'b0;
		endcase
	end
endmodule

module char_i(x, y, flush_x, flush_y, colour, enable);
	input [7:0] x;
	input [7:0] y;
	input [7:0] flush_x;
	input [7:0] flush_y;
	
	output [5:0] colour;
	output enable;
	
	wire [6:0] lut_out;
	
	char_i_lut(flush_x - x, flush_y - y, lut_out);
	
	assign colour = lut_out[5:0];
	assign enable = lut_out[6];
endmodule
