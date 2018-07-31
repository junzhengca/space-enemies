module target(x, clk, flush_x, flush_y, bullet_x, bullet_y, colour, enable, bullet_reset, target_reach, game_started);
	input [6:0] x;
	input clk;
	input [6:0] flush_x;
	input [6:0] flush_y;
	input [6:0] bullet_x;
	input game_started;
	input [6:0] bullet_y;
	output [5:0] colour;
	output enable;
	output reg bullet_reset;
	output reg target_reach;

	reg [6:0] y = 0;
	
	reg [21:0] divider_val = 22'd60;
	
	wire actual_clk;

	rate_divider frame_divider(divider_val, 1'b0, clk, 1'b1, 1'b1, actual_clk);

	wire enable_out;
	assign enable = enable_out;
	
	target_graphic(x, y, flush_x, flush_y, colour, enable_out);
	
	always@(posedge clk) begin
		if(actual_clk) begin
			y <= y + 1;
			bullet_reset <= 0;
		end
		target_reach <= 0;
		if(bullet_x > x - 2 && bullet_x < x + 7'd11 && bullet_y > y - 2 && bullet_y < y + 7'd11) begin
			y <= 7'd0;
			if(divider_val != 0)
				divider_val <= divider_val - 22'd5;
			bullet_reset <= 1;
		end
		if(y > 7'd83) begin
			y <= 7'd0;
			target_reach <= 1;
		end
		if(~game_started) begin
			y <= 7'd0;
			divider_val <= 22'd60;
		end
	end
endmodule

