module target_graphic_lut(x, y, out);
	input [7:0] x;
	input [7:0] y;
	output reg [6:0] out;

	always@(*)
	begin
		out[6] <= 1'b1;
		case({x, y})
			16'h0200: out[5:0] <= 6'b111111;
			16'h0800: out[5:0] <= 6'b111111;
			16'h0301: out[5:0] <= 6'b111111;
			16'h0701: out[5:0] <= 6'b111111;
			
			16'h0202: out[5:0] <= 6'b111111;
			16'h0302: out[5:0] <= 6'b111111;
			16'h0402: out[5:0] <= 6'b111111;
			16'h0502: out[5:0] <= 6'b111111;
			16'h0602: out[5:0] <= 6'b111111;
			16'h0702: out[5:0] <= 6'b111111;
			16'h0802: out[5:0] <= 6'b111111;
			
			16'h0103: out[5:0] <= 6'b111111;
			16'h0203: out[5:0] <= 6'b111111;
			16'h0403: out[5:0] <= 6'b111111;
			16'h0503: out[5:0] <= 6'b111111;
			16'h0603: out[5:0] <= 6'b111111;
			16'h0803: out[5:0] <= 6'b111111;
			16'h0903: out[5:0] <= 6'b111111;
			
			16'h0004: out[5:0] <= 6'b111111;
			16'h0104: out[5:0] <= 6'b111111;
			16'h0204: out[5:0] <= 6'b111111;
			16'h0304: out[5:0] <= 6'b111111;
			16'h0404: out[5:0] <= 6'b111111;
			16'h0504: out[5:0] <= 6'b111111;
			16'h0604: out[5:0] <= 6'b111111;
			16'h0704: out[5:0] <= 6'b111111;
			16'h0804: out[5:0] <= 6'b111111;
			16'h0904: out[5:0] <= 6'b111111;
			16'h0A04: out[5:0] <= 6'b111111;
			
			16'h0005: out[5:0] <= 6'b111111;
			16'h0205: out[5:0] <= 6'b111111;
			16'h0305: out[5:0] <= 6'b111111;
			16'h0405: out[5:0] <= 6'b111111;
			16'h0505: out[5:0] <= 6'b111111;
			16'h0605: out[5:0] <= 6'b111111;
			16'h0705: out[5:0] <= 6'b111111;
			16'h0805: out[5:0] <= 6'b111111;
			16'h0A05: out[5:0] <= 6'b111111;
			
			16'h0006: out[5:0] <= 6'b111111;
			16'h0206: out[5:0] <= 6'b111111;
			16'h0806: out[5:0] <= 6'b111111;
			16'h0A06: out[5:0] <= 6'b111111;
			
			16'h0307: out[5:0] <= 6'b111111;
			16'h0407: out[5:0] <= 6'b111111;
			16'h0607: out[5:0] <= 6'b111111;
			16'h0707: out[5:0] <= 6'b111111;
			
			
			default: out[6] <= 1'b0;
		endcase
	end
endmodule

module target_graphic(x, y, flush_x, flush_y, colour, enable);

	input [7:0] x;
	input [7:0] y;
	input [7:0] flush_x;
	input [7:0] flush_y;
	output [5:0] colour;
	output enable;
	
	wire [6:0] lut_out;
	
	target_graphic_lut(flush_x - x, flush_y - y, lut_out);
	
	assign colour = lut_out[5:0];
	assign enable = lut_out[6];
	
endmodule
