module char_j_lut(x, y, out);
	input [7:0] x;
	input [7:0] y;
	output reg [6:0] out;

	always@(*)
	begin
		out[6] <= 1'b1;
		case({x, y})
			16'h0500: out[5:0] <= 6'b111111;
			16'h0600: out[5:0] <= 6'b111111;
			16'h0700: out[5:0] <= 6'b111111;
			
			16'h0601: out[5:0] <= 6'b111111;
			16'h0602: out[5:0] <= 6'b111111;
			16'h0603: out[5:0] <= 6'b111111;
			16'h0604: out[5:0] <= 6'b111111;
			16'h0605: out[5:0] <= 6'b111111;
			16'h0606: out[5:0] <= 6'b111111;
			
			16'h0207: out[5:0] <= 6'b111111;
			16'h0307: out[5:0] <= 6'b111111;
			16'h0607: out[5:0] <= 6'b111111;
			
			16'h0308: out[5:0] <= 6'b111111;
			16'h0608: out[5:0] <= 6'b111111;
			
			16'h0309: out[5:0] <= 6'b111111;
			16'h0409: out[5:0] <= 6'b111111;
			16'h0509: out[5:0] <= 6'b111111;
			default: out[6] <= 1'b0;
		endcase
	end
endmodule

module char_j(x, y, flush_x, flush_y, colour, enable);
	input [7:0] x;
	input [7:0] y;
	input [7:0] flush_x;
	input [7:0] flush_y;
	
	output [5:0] colour;
	output enable;
	
	wire [6:0] lut_out;
	
	char_j_lut(flush_x - x, flush_y - y, lut_out);
	
	assign colour = lut_out[5:0];
	assign enable = lut_out[6];
endmodule
