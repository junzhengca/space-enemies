module bullet_graphic(x, y, flush_x, flush_y, colour, enable);

	input [6:0] x;
	input [6:0] y;
	input [6:0] flush_x;
	input [6:0] flush_y;
	output reg [5:0] colour;
	output reg enable;
	
	always@(*) begin
		if(flush_x == x && flush_y == y || flush_x == x && flush_y == y + 1 || flush_x == x + 1 && flush_y == y || flush_x == x + 1 && flush_y == y + 1) begin
			colour <= 6'b101100;
			enable <= 1;
		end
		else begin
			enable <= 0;
		end
	end

endmodule
