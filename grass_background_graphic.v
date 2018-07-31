module grass_background_graphic(x, y, flush_x, flush_y, colour, enable);

	input [6:0] x;
	input [6:0] y;
	input [6:0] flush_x;
	input [6:0] flush_y;
	output reg [5:0] colour;
	output reg enable;
	
	always@(*) begin
		if(flush_y < 7'd30) begin
			colour <= 6'b110100;
			enable <= 1;
		end
		else begin
			colour <= 6'b000000;
			enable <= 1;
		end
	end

endmodule
