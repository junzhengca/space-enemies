module start_game_title(x, y, flush_x, flush_y, colour, enable);

	input [7:0] x;
	input [7:0] y;
	input [7:0] flush_x;
	input [7:0] flush_y;
	output [5:0] colour;
	output enable;

	wire [5:0] char_s_colour;
	wire char_s_enable;
	char_s(x, y, flush_x, flush_y, char_s_colour, char_s_enable);
	
	wire [5:0] char_t_colour;
	wire char_t_enable;
	char_t(x + 16'd10, y, flush_x, flush_y, char_t_colour, char_t_enable);
	
	wire [5:0] char_a_colour;
	wire char_a_enable;
	char_a(x + 16'd20, y, flush_x, flush_y, char_a_colour, char_a_enable);
	
	wire [5:0] char_r_colour;
	wire char_r_enable;
	char_r(x + 16'd30, y, flush_x, flush_y, char_r_colour, char_r_enable);
	
	wire [5:0] char_t2_colour;
	wire char_t2_enable;
	char_t(x + 16'd40, y, flush_x, flush_y, char_t2_colour, char_t2_enable);
	
	wire [5:0] char_g_colour;
	wire char_g_enable;
	char_g(x + 16'd60, y, flush_x, flush_y, char_g_colour, char_g_enable);
	
	wire [5:0] char_a2_colour;
	wire char_a2_enable;
	char_a(x + 16'd70, y, flush_x, flush_y, char_a2_colour, char_a2_enable);
	
	wire [5:0] char_m_colour;
	wire char_m_enable;
	char_m(x + 16'd80, y, flush_x, flush_y, char_m_colour, char_m_enable);
	
	wire [5:0] char_e_colour;
	wire char_e_enable;
	char_e(x + 16'd90, y, flush_x, flush_y, char_e_colour, char_e_enable);
	
	assign colour = char_s_colour;
	assign enable = char_s_enable || char_t_enable || char_a_enable || char_r_enable || char_t2_enable || char_g_enable || char_a2_enable || char_m_enable || char_e_enable;
	
endmodule
