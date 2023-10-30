module Timer(	input start, clk, rst, 
				output done_timer);
	integer count;
	assign done_timer = (count==end_time)?1:0;
	
	//Parameter
	parameter end_time = 5; 
	
	always@(posedge clk)begin
		if(rst) count<=0;
		else if(start) count<=(count+1);
		if(count==end_time) count<=0;
	end
endmodule

