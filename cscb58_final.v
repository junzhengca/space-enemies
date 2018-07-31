module cscb58_final(CLOCK_50, KEY, SW,
HEX7,
HEX3, HEX2, HEX1, HEX0,
VGA_CLK,   						//	VGA Clock
VGA_HS,							//	VGA H_SYNC
VGA_VS,							//	VGA V_SYNC
VGA_BLANK_N,						//	VGA BLANK
VGA_SYNC_N,						//	VGA SYNC
VGA_R,   						//	VGA Red[9:0]
VGA_G,	 						//	VGA Green[9:0]
VGA_B,
LEDR
);
	reg [6:0] x = 7'b1000000;
	reg [6:0] y = 7'b1100000;
	reg [1:0] direction = 2'b11;
	reg game_started = 1'b0;
	reg game_over = 1'b0;
	reg [7:0] game_over_counter;
	reg [1:0] lives = 2'd3;
	reg [15:0] score;
	reg [15:0] high_score;
	reg [17:0] hs_out;
	input [3:0] KEY;
	input [17:0] SW;
	output [6:0] HEX7, HEX3, HEX2, HEX1, HEX0;
	input CLOCK_50;
	output [17:0] LEDR;
	
	assign LEDR = hs_out;
	
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;
	wire resetn;
	
	wire frame_clock;
	
	wire bullet_display;
	wire [6:0] bullet_x, bullet_y;
	
	hex_decoder(lives, HEX7);
	
	reg [15:0] display_score;

	always@(*) begin
		if(~game_started)
			display_score <= high_score;
		else
			display_score <= score;
	end
	
	hex_decoder(display_score[15:11], HEX3);
	hex_decoder(display_score[11:8], HEX2);
	hex_decoder(display_score[7:4], HEX1);
	hex_decoder(display_score[3:0], HEX0);
	
	rate_divider frame_divider(22'b0001101101110011010101, 1'b0, CLOCK_50, 1'b1, 1'b1, frame_clock);
	
	bullet the_bullet(
		.clk(frame_clock),
		.shoot(~KEY[2]),
		.tank_x(x),
		.tank_y(y),
		.bullet_display(bullet_display),
		.bullet_x(bullet_x),
		.bullet_y(bullet_y),
		.direction(direction),
		.reset(target_1_breset || target_2_breset || target_3_breset)
	);


	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	reg [5:0] colour;
	reg [7:0] vga_x;
	reg [6:0] vga_y;
//	wire writeEn;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(1'b1),
			.clock(CLOCK_50),
			.colour(colour),
			.x(vga_x),
			.y(vga_y),
			.plot(SW[17]),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 2;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
		
	reg [13:0] vga_counter;
	
	
	wire [5:0] black_background_colour;
	wire black_background_enable;
	black_background_graphic(0, 0, vga_x, vga_y, black_background_colour, black_background_enable);
	
	wire [5:0] tank_colour;
	wire tank_enable;
	tank_graphic tank_g(x, y, vga_x, vga_y, direction, tank_colour, tank_enable);
	
	wire [5:0] bullet_colour;
	wire bullet_enable;
	bullet_graphic bullet_g(bullet_x, bullet_y, vga_x, vga_y, bullet_colour, bullet_enable);
	
	wire [5:0] grass_colour;
	wire grass_enable;
	grass_background_graphic grass_g(0, 0, vga_x, vga_y, grass_colour, grass_enable);

	wire [5:0] wall_colour;
	wire wall_enable;
	wall_graphic(0, 0, vga_x, vga_y, wall_colour, wall_enable);
	
	wire [5:0] start_game_title_colour;
	wire start_game_title_enable;
	start_game_title(8'd10, 8'd10, vga_x, vga_y, start_game_title_colour, start_game_title_enable);
	
	// All the targets
	
	wire [5:0] target_1_colour;
	wire target_1_enable;
	wire target_1_breset;
	wire target_1_reach;
	target(7'd10, frame_clock, vga_x, vga_y, bullet_x, bullet_y, target_1_colour, target_1_enable, target_1_breset, target_1_reach, game_started);
	
	wire [5:0] target_2_colour;
	wire target_2_enable;
	wire target_2_breset;
	wire target_2_reach;
	target(7'd50, frame_clock, vga_x, vga_y, bullet_x, bullet_y, target_2_colour, target_2_enable, target_2_breset, target_2_reach, game_started);
	
	wire [5:0] target_3_colour;
	wire target_3_enable;
	wire target_3_breset;
	wire target_3_reach;
	target(7'd90, frame_clock, vga_x, vga_y, bullet_x, bullet_y, target_3_colour, target_3_enable, target_3_breset, target_3_reach, game_started);
	
	wire [5:0] game_over_title_colour;
	wire game_over_title_enable;
	game_over_title(8'd20, 8'd20, vga_x, vga_y, game_over_title_colour, game_over_title_enable);
	
	
	always@(posedge CLOCK_50)
	begin
		vga_x <= vga_counter[13:7];
		vga_y <= vga_counter[6:0];
		if(tank_enable == 1)
			colour <= tank_colour;
		else if(bullet_enable == 1)
			colour <= bullet_colour;
		else if(start_game_title_enable && ~game_started)
			colour <= start_game_title_colour;
		else if(grass_enable && ~game_started)
			colour <= grass_colour;
		// Only display if gameover
		else if(game_over_title_enable && game_over)
			colour <= 6'b110000;
		// Game started:
		else if(target_1_enable && game_started)
			colour <= target_1_colour;
		else if(target_2_enable && game_started)
			colour <= target_2_colour;
		else if(target_3_enable && game_started)
			colour <= target_3_colour;
		else if(wall_enable && game_started)
			colour <= wall_colour;
		else if(black_background_enable && game_started)
			colour <= black_background_colour;
		else
			colour <= 6'b000000;
		vga_counter <= vga_counter + 1;
	end
	
	always@(posedge frame_clock)
	begin
		if((target_1_reach || target_2_reach || target_3_reach) && ~game_over)
				lives <= lives - 1;
		if(lives == 2'd0)
				game_over <= 1'b1;
		if(game_over) begin
			game_over_counter <= game_over_counter + 1;
			if(score > high_score) begin
				hs_out <= 18'b111111111111111111;
			end
		end
		if(game_over && game_over_counter == 8'b11111111) begin
			lives <= 2'd3;
			game_over_counter <= 8'b00000000;
			game_over <= 1'b0;
			game_started <= 1'b0;
			if(score > high_score) begin
				high_score <= score;
			end
			score <= 24'd0;
			hs_out <= 18'd0;
		end
		// If we shoot the start game button, start game
		if(~game_started && bullet_y < 7'd30 && bullet_x != 0 && bullet_y != 0) begin
			game_started <= 1'b1;
		end
		if(game_started && ~game_over) begin
			score <= score + 1;
		end
		if(~KEY[0]) begin
			x <= x + 1;
		end
		else if(~KEY[3]) begin
			x <= x - 1;
		end
	end
	
endmodule
