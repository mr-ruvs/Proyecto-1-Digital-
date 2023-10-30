module receptor(
	input sdain, sclin, reset,
	output reg [2:0]data);

	parameter A0 = 4'b0000, A1 = 4'b0001, A2 = 4'b0010, A3 = 4'b0011, A4 = 4'b0100, A5 = 4'b0101, A6 = 4'b0110, A7 = 4'b0111, A8 = 4'b1000, A9 = 4'b1001, A10 = 4'b1010, A11 = 4'b1011, A12 = 4'b1100;
	reg [3:0] state, next_state;


// nube combinacional entrada
	always @ (state or sdain) begin
        case (state)
            A0: begin 
				if (sdain == 0)begin
					next_state <= A1;
				end else if (sdain == 1) begin
					next_state <= A7;
				end else
					next_state <= A0;
			end
			A1: begin 
				if (sdain == 0)
					next_state <= A2;
				else
					next_state <= A4;
			end
			A2: begin 
				if (sdain == 1)
					next_state <= A3;
			end
			A3: begin 
				next_state <= A0;
			end
			A4: begin 
				if (sdain == 0)
					next_state <= A5;
				else 
					next_state <= A6;
			end
			A5: begin 
				next_state <= A0;
			end
			A6: begin 
				next_state <= A0;
			end
			A7: begin 
				if (sdain == 1)
					next_state <= A11;
				else
					next_state <= A8;
			end
			A8: begin 
				if (sdain == 0)
					next_state <= A9;
				else
					next_state <= A10;
			end
			A9: begin 
				next_state <= A0;
			end
			A10: begin 
				next_state <= A0;
			end
			A11: begin 
				if (sdain == 0)
					next_state <= A12;
			end
			A12: begin 
				next_state <= A0;
			end
		default: next_state <= A0;

		endcase
	end

// banco FF

	always @ (posedge sclin or posedge reset) begin
		if (reset == 1)
			state <= A0;
		else
			state <= next_state;
		end
		initial state <= A0; 

// nube combinacional salida

    always @ (state) begin
        case(state)
            A0: begin data <= 3'b000; end
			A1: begin data <= 3'b000; end
			A2: begin data <= 3'b000; end
			A3: begin data <= 3'b001; end	// opcion A
			A4: begin data <= 3'b000; end
			A5: begin data <= 3'b010; end	// opcion B
			A6: begin data <= 3'b011; end	// Pagar
			A7: begin data <= 3'b000; end
			A8: begin data <= 3'b000; end
			A9: begin data <= 3'b100; end	//Cancelar
			A10: begin data <= 3'b101; end	//No existencias
			A11: begin data <= 3'b000; end
			A12: begin data <= 3'b110; end	//Gracias

        endcase
    end
	
endmodule


