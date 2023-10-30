module transmision(
	input [2:0]datain,
	input reset2, clk2,
	output reg sda, parareloj);

	parameter A0 = 3'b000, A1 = 3'b001, A2 = 3'b010, A3 = 3'b011, A4 = 3'b100, A5 = 3'b101, A6 = 3'b110, A7 = 3'b111;
	reg [2:0] state, next_state;

	reloj transmite(.start(parareloj), .reset3(reset2), .clk3(clk2)); 

	always @(posedge clk2 or state or posedge reset2) begin
        if (reset2) begin
            state <= A0;
            sda <= 1'b0;
        end else begin
            case (state)
                A0: begin
                    if((datain == 3'b001 || datain == 3'b010 || datain == 3'b011 || datain == 3'b100 || datain == 3'b101 || datain == 3'b110) && (parareloj == 1))begin
						sda <= datain[2]; 
                        next_state <= A1;
                    end else begin
                        next_state <= A0;
                        sda <= 1'b0;
                    end  
                end
                A1: begin
                    if(datain == 3'b001 || datain == 3'b010 || datain == 3'b011 || datain == 3'b100 || datain == 3'b101 || datain == 3'b110)begin
						sda <= datain[2]; 
                        next_state <= A2;
                    end else begin
                        next_state <= A0;
                        sda <= 1'b0;
                    end
                end
                A2: begin
					if(datain == 3'b001 || datain == 3'b010 || datain == 3'b011 || datain == 3'b100 || datain == 3'b101 || datain == 3'b110) begin
                        sda <= datain[1];  // Establece el segundo bit de la entrada en la salida
                        next_state <= A3;
                    end else begin
                        sda <= 1'b0;
                        next_state <= A0;
                    end 
                end
				A3: begin
					if(datain == 3'b001 || datain == 3'b010 || datain == 3'b011 || datain == 3'b100 || datain == 3'b101 || datain == 3'b110) begin
                        sda <= datain[1];  // Establece el segundo bit de la entrada en la salida
                        next_state <= A4;
                    end else begin
                        sda <= 1'b0;
                        next_state <= A0;
                    end 
				end
				A4: begin
					if(datain == 3'b001 || datain == 3'b010 || datain == 3'b011 || datain == 3'b100 || datain == 3'b101 || datain == 3'b110) begin
                        sda <= datain[0];  // Establece el tercer bit de la entrada en la salida
                        next_state <= A5;
						parareloj <= 1'b0;
                    end else begin
                        sda <= 1'b0;
                        next_state <= A0;
                    end 
				end
				A5: begin
					if(datain == 3'b001 || datain == 3'b010 || datain == 3'b011 || datain == 3'b100 || datain == 3'b101 || datain == 3'b110) begin
                        sda <= datain[0];  // Establece el tercer bit de la entrada en la salida
                        next_state <= A0;
						parareloj <= 1'b0;
                    end else begin
                        sda <= 1'b0;
                        next_state <= A0;
                    end 
				end

            endcase
        end
    end

// banco FF

	always @ (posedge clk2 or posedge reset2) begin
		if (reset2 == 1)
			state <= A0;
		else
			state <= next_state;
		end
		initial state <= A0; 

	always @(datain)begin
		if ((reset2 == 0)&&(datain == 3'b001 || datain == 3'b010 || datain == 3'b011 || datain == 3'b100 || datain == 3'b101 || datain == 3'b110)) begin
			parareloj <= 1'b1;
		end else if ((reset2 == 0)&&(datain == 3'b000))begin
			parareloj <= 1'b0;
		end
	end

	
endmodule


