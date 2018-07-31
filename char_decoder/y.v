module char_y_lut(x, y, out);
	input [7:0] x;
	input [7:0] y;
	output reg [6:0] out;

	always@(*)
	begin
		out[6] <= 1'b1;
		case({x, y})
			16'h0200: out[5:0] <= 6'b111111;
			16'h0700: out[5:0] <= 6'b111111;
			
			16'h0201: out[5:0] <= 6'b111111;
			16'h0701: out[5:0] <= 6'b111111;
			
			16'h0202: out[5:0] <= 6'b111111;
			16'h0702: out[5:0] <= 6'b111111;
			
			16'h0303: out[5:0] <= 6'b111111;
			16'h0603: out[5:0] <= 6'b111111;
			
			16'h0404: out[5:0] <= 6'b111111;
			16'h0504: out[5:0] <= 6'b111111;

			16'h0405: out[5:0] <= 6'b111111;
			16'h0505: out[5:0] <= 6'b111111;
			
			16'h0406: out[5:0] <= 6'b111111;
			16'h0506: out[5:0] <= 6'b111111;

			16'h0407: out[5:0] <= 6'b111111;
			16'h0507: out[5:0] <= 6'b111111;

			16'h0408: out[5:0] <= 6'b111111;
			16'h0508: out[5:0] <= 6'b111111;

			16'h0409: out[5:0] <= 6'b111111;
			16'h0509: out[5:0] <= 6'b111111;
			default: out[6] <= 1'b0;
		endcase
	end
endmodule

module char_y(x, y, flush_x, flush_y, colour, enable);
	input [7:0] x;
	input [7:0] y;
	input [7:0] flush_x;
	input [7:0] flush_y;
	
	output [5:0] colour;
	output enable;
	
	wire [6:0] lut_out;
	
	char_y_lut(flush_x - x, flush_y - y, lut_out);
	
	assign colour = lut_out[5:0];
	assign enable = lut_out[6];
endmodule
