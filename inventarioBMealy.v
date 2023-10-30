module inventarioBMealy(input redInventarioB, clk1, reset1, output reg endEmptyInventarioB);
    parameter A0 = 2'b00, A1 = 2'b01, A2 = 2'b10, A3 = 2'b11; //Estados
    reg [1:0] state, next_state;
// nube combinacional entrada
    always @ (state or redInventarioB) begin
        case (state)
            A0: begin //Son 3 unidades máximo de capacidad, se usa un estado para cada unidad que se pierde.
                if (redInventarioB == 1) begin //Si el inventario aún cuenta con existencias, entonces pasa al siguiente estado.
                    next_state <= A1;
					endEmptyInventarioB <= 1'b1; //La salida que indica cuando esté vacío toma es (1) cuando aún hay existencias.
				end else begin
                    next_state <= A0; //Si no hay existencias (== 0) se mantiene en el estado actual (S0).
					endEmptyInventarioB <= 1'b1; //(1) aún hay existencias restantes.
            end end 
            A1: begin //2 unidades restantes
                if (redInventarioB == 1) begin
                    next_state <= A2;
					endEmptyInventarioB <= 1'b1; //(1) aún hay existencias restantes.
                end else begin
                    next_state <= A1; //Si no hay existencias (== 0) se mantiene en el estado actual (S1).
					endEmptyInventarioB <= 1'b1;
            end end 
            A2: begin //1 unidad restate
                if (redInventarioB == 1) begin
                    next_state <= A3;
					endEmptyInventarioB <= 1'b1; //(1) aún hay existencias restantes.
                end else begin
                    next_state <= A2; //Si no hay existencias (== 0) se mantiene en el estado actual (S2).
					endEmptyInventarioB <= 1'b1;
            end end 
            A3: begin //0 unidadesÇ
                if (redInventarioB == 1) begin
                    next_state <= A3; //Se agotaron existencias.
					endEmptyInventarioB <= 1'b0; //(0) Ya no hay existencias restantes.
                end else begin
                    next_state <= A3; //Si no hay existencias (== 0) se mantiene en el estado actual (S3).
					endEmptyInventarioB <= 1'b0; //(0) Ya no hay existencias restantes.
            end end 
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
    
endmodule



