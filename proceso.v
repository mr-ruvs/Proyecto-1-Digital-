module proceso(input A, B, E, E2, C, P, clk1, reset1, output reg [2:0]Q); //Variables empleadas

/*
Variables y sus significados:
A: Producto 1
B: Producto 2
E: Entrada Inventario de A (Su salida es L)
E2: Entrada Inventario de B  (Su salida es L2)
C: Cancelar orden
P: Pagar
*/

	output reg L, L2; //Salidas que dependen de Pago
	parameter A0 = 4'b0000, A1 = 4'b0001, A2 = 4'b0010, A3 = 4'b0011, A4 = 4'b0100, A5 = 4'b0101, A6 = 4'b0110, A7 = 4'b0111, A8 = 4'b1000, A9 = 4'b1001, A10 = 4'b1010, A11 = 4'b1011; //Estados
	reg [3:0] state, next_state; //Cambios de estado (estado actual y siguiente estado)

	inventarioAMealy localizar(.endEmptyInventario(E), .redInventario(L), .clk1(clk1), .reset1(reset1)); //Llamado al modulo A
	inventarioBMealy localizarB(.endEmptyInventarioB(E2), .redInventarioB(L2), .clk1(clk1), .reset1(reset1)); //Llamado al modulo B

// nube combinacional entrada
	always @ (state or A or B or E or E2 or C or P ) begin 
        case (state)
            A0: begin //Estado inicial
				if (A == 1 && B == 0)
                	next_state <= A1;
				else if (B == 1 && A == 0)
						next_state <= A2;
			end
            A1: begin //Estado 1
				if (E == 1)
					next_state <= A4; //Cuando el inventario de A aún tiene existencias (1) pasa a estado 4.
				else	
					next_state <= A3; //Si ya no hay existencias regresa al estado inicial. 
			end
			A2: begin //Estado 2
				if (E2 == 1)
					next_state <= A5; //Cuando el inventario de B aún tiene existencias (1) pasa a estado 5.
				else
					next_state <= A3; //Si ya no hay existencias regresa al estado inicial. 
			end
			A3: begin //Estado 3
				next_state <= A9; //La salida de Q marca el error "Ya no hay existencias (101)", va al estado 9 para indicar "Orden cancelada (100)" y regresa al estado incial.
			end
			A4: begin //Estado 4 incrementa FSM del inventario A.
				if (C == 0 && P == 1) //Si paga entonces pasa al siguiente estado (A6) 
					next_state <= A6;
				else if ( P == 0 && C == 1) //Si decide cancelar la orden regresa al estado incial.
						next_state <= A10;
			end
			A5: begin //Estado 5 incrementa FSM del inventario B.
				if (C == 0 && P == 1)
					next_state <= A7;
				else if ( P == 0 && C == 1)
						next_state <= A11; 
			end
			A6: begin //Estado 6
				next_state <= A8; //Va a estado 8 automáticamente
			end
			A7: begin //Estado 7
				next_state <= A8; //Va a estado 8 automáticamente
			end
			A8: begin //Estado 8
				next_state <= A0; //Gracias por su compra (110).
			end
			//Los estados siguientes simplemente permiten mostrar el codigo 100, de orden cancelada, y regresan al estado inicial.
			A9: begin //Estado 9
				next_state <= A0;
			end
			A10: begin //Estado 10
				next_state <= A0;
			end
			A11: begin //Estado 11
				next_state <= A0;
			end
		endcase
	end

// banco FF

	always @ (posedge clk1 or posedge reset1) begin
		if (reset1 == 1)
			state <= A0;
		else
			state <= next_state;
		end
		initial state <= A0; 

// nube combinacional salida

    always @ (state) begin
        case(state)
            A0: begin Q <= 3'b000; L <= 1'b0; L2 <= 1'b0; end //No pasa nada
            A1: begin Q <= 3'b001; L <= 1'b0; L2 <= 1'b0; end //Opción A
            A2: begin Q <= 3'b010; L <= 1'b0; L2 <= 1'b0; end //Opción B 
			A3: begin Q <= 3'b101; L <= 1'b0; L2 <= 1'b0; end //No hay existencias
            A4: begin Q <= 3'b111; L <= 1'b0; L2 <= 1'b0; end //No pasa nada 
            A5: begin Q <= 3'b111; L <= 1'b0; L2 <= 1'b0; end //No pasa nada
			A6: begin Q <= 3'b011; L <= 1'b1; L2 <= 1'b0; end //Pagar-Incrementa
			A7: begin Q <= 3'b011; L2 <= 1'b1; L <= 1'b0; end //Pagar-Incrementa
			A9: begin Q <= 3'b100; L <= 1'b0; L2 <= 1'b0; end //Orden cancelada
			A10: begin Q <= 3'b100; L <= 1'b0; L2 <= 1'b0; end //Orden cancelada
			A11: begin Q <= 3'b100; L <= 1'b0; L2 <= 1'b0; end //Orden cancelada
        endcase
    end
	
endmodule


