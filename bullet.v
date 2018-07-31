module bullet(clk, shoot, tank_x, tank_y, direction, bullet_display, bullet_x, bullet_y, reset);
		input clk, shoot, reset;
		input [1:0] direction;
		input [6:0] tank_x, tank_y;
		
		reg [1:0] current_direction;

		localparam BULLET_IDLE = 1'b0,
				     BULLET_SHOOTING = 1'b1;
		
		output reg bullet_display;
		output reg [6:0] bullet_x, bullet_y;
		
		reg done;
		reg current_state, next_state;
		
		always@(*)
		begin: state_table
			case(current_state)
				BULLET_IDLE: next_state = shoot ? BULLET_SHOOTING : BULLET_IDLE;
				BULLET_SHOOTING: next_state = done ? BULLET_IDLE : BULLET_SHOOTING;
				default: next_state = BULLET_IDLE;
			endcase
		end
		
		always@(*)
		begin: enable_signals
			case(current_state)
				BULLET_IDLE: begin
					bullet_display <= 0;
				end
				BULLET_SHOOTING: begin
					bullet_display <= 1;
				end
			endcase
		end
		
		always@(posedge clk)
		begin
			case(current_state)
				BULLET_IDLE: begin
					// Sync bullet position with tank
					bullet_x <= tank_x + 4;
					bullet_y <= tank_y + 4;
					current_direction <= direction;
				end
				BULLET_SHOOTING: begin
					if(current_direction == 2'b00)
						bullet_x <= bullet_x + 1;
					else if(current_direction == 2'b01)
						bullet_x <= bullet_x - 1;
					else if(current_direction == 2'b10)
						bullet_y <= bullet_y + 1;
					else if(current_direction == 2'b11)
						bullet_y <= bullet_y - 1;
					if(bullet_y == 7'b0000010 || bullet_x == 7'b0000010 || bullet_y == 7'b1111101 || bullet_x == 7'b1111101 || reset)
						done = 1;
					else
						done = 0;
				end
			endcase
		end
		
		always@(posedge clk)
		begin
			current_state <= next_state;
		end
endmodule
