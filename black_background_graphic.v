module black_background_graphic(x, y, flush_x, flush_y, colour, enable);

	input [6:0] x;
	input [6:0] y;
	input [6:0] flush_x;
	input [6:0] flush_y;
	output reg [5:0] colour;
	output reg enable;
	
	always@(*) begin
		colour <= 6'b000000;
			enable <= 1;
	end

endmodule
