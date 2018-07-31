module tank_graphic_lut(x, y, out);
	input [7:0] x;
	input [7:0] y;
	output reg [6:0] out;

	always@(*)
	begin
		out[6] <= 1'b1;
		case({x, y})
			16'h0401: out[5:0] <= 6'b111111;
			16'h0501: out[5:0] <= 6'b111111;
			
			16'h0402: out[5:0] <= 6'b111111;
			16'h0502: out[5:0] <= 6'b111111;
			
			16'h0103: out[5:0] <= 6'b111000;
			16'h0203: out[5:0] <= 6'b111100;
			16'h0303: out[5:0] <= 6'b111100;
			16'h0403: out[5:0] <= 6'b111111;
			16'h0503: out[5:0] <= 6'b111111;
			16'h0603: out[5:0] <= 6'b111100;
			16'h0703: out[5:0] <= 6'b111100;
			16'h0803: out[5:0] <= 6'b111000;
			
			16'h0104: out[5:0] <= 6'b111000;
			16'h0204: out[5:0] <= 6'b111100;
			16'h0304: out[5:0] <= 6'b111100;
			16'h0404: out[5:0] <= 6'b101010;
			16'h0504: out[5:0] <= 6'b101010;
			16'h0604: out[5:0] <= 6'b111100;
			16'h0704: out[5:0] <= 6'b111100;
			16'h0804: out[5:0] <= 6'b111000;
			
			16'h0105: out[5:0] <= 6'b111000;
			16'h0205: out[5:0] <= 6'b111100;
			16'h0305: out[5:0] <= 6'b111100;
			16'h0405: out[5:0] <= 6'b101010;
			16'h0505: out[5:0] <= 6'b101010;
			16'h0605: out[5:0] <= 6'b111100;
			16'h0705: out[5:0] <= 6'b111100;
			16'h0805: out[5:0] <= 6'b111000;
			
			16'h0106: out[5:0] <= 6'b111000;
			16'h0206: out[5:0] <= 6'b111100;
			16'h0306: out[5:0] <= 6'b111100;
			16'h0406: out[5:0] <= 6'b111100;
			16'h0506: out[5:0] <= 6'b111100;
			16'h0606: out[5:0] <= 6'b111100;
			16'h0706: out[5:0] <= 6'b111100;
			16'h0806: out[5:0] <= 6'b111000;
			
			16'h0107: out[5:0] <= 6'b111000;
			16'h0207: out[5:0] <= 6'b111100;
			16'h0307: out[5:0] <= 6'b111100;
			16'h0407: out[5:0] <= 6'b111100;
			16'h0507: out[5:0] <= 6'b111100;
			16'h0607: out[5:0] <= 6'b111100;
			16'h0707: out[5:0] <= 6'b111100;
			16'h0807: out[5:0] <= 6'b111000;
			
			16'h0108: out[5:0] <= 6'b100100;
			16'h0208: out[5:0] <= 6'b100100;
			16'h0708: out[5:0] <= 6'b100100;
			16'h0808: out[5:0] <= 6'b100100;
			
			default: out[6] <= 1'b0;
		endcase
	end
endmodule

module tank_graphic(x, y, flush_x, flush_y, direction, colour, enable);

	input [7:0] x;
	input [7:0] y;
	input [7:0] flush_x;
	input [7:0] flush_y;
	input [1:0] direction;
	output [5:0] colour;
	output enable;
	
	wire [6:0] lut_out;
	
	tank_graphic_lut(flush_x - x, flush_y - y, lut_out);
	
	assign colour = lut_out[5:0];
	assign enable = lut_out[6];
	
endmodule
