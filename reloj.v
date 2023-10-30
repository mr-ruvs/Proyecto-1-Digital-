module reloj(input start, clk3, reset3, output reg scl);

	parameter A0 = 3'b000, A1 = 3'b001, A2 = 3'b010, A3 = 3'b011, A4 = 3'b100, A5 = 3'b101;
	reg [2:0] state, next_state;

// nube combinacional entrada
	always @ (state or start) begin
        case (state)
            A0: begin 
				if (start == 1)
                	next_state <= A1;
				else 
					next_state <= A0; 
			end
            A1: begin 
				next_state <= A2;
			end
			A2: begin 
				next_state <= A3;
			end
			A3: begin 
				next_state <= A4;
			end
			A4: begin 
				next_state <= A5;
			end
			A5: begin 
				next_state <= A0;
			end
		endcase
	end

// banco FF

	always @ (posedge clk3 or posedge reset3) begin
		if (reset3 == 1)
			state <= A0;
		else
			state <= next_state;
		end
		initial state <= A0; 

// nube combinacional salida

    always @ (state) begin
        case(state)
            A0: scl <= 1'b1;
            A1: scl <= 1'b0;
            A2: scl <= 1'b1;
            A3: scl <= 1'b0;
			A4: scl <= 1'b1;
            A5: scl <= 1'b0;
        endcase
    end
	
endmodule


