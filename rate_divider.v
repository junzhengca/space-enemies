module rate_divider(value, load, clock, clear, enable, enable_out);
	input [27:0] value;
	input load, clock, clear, enable;
	reg [27:0] store;
	output enable_out;
	
	always @(posedge clock)
	begin
		if(clear == 1'b0)
			store <= 0;
		else if(load == 1'b1)
			store <= value;
		else if(store == 0)
			store <= value;
		else if(enable == 1'b1)
			store <= store - 1'b1;
	end
	
	assign enable_out = (store == 0) ? 1 : 0;
endmodule

