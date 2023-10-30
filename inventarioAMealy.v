module inventarioAMealy(input redInventario, clk1, reset1, output reg endEmptyInventario); //COMENTARIOS EN INVENTARIO B.
    parameter A0 = 2'b00, A1 = 2'b01, A2 = 2'b10, A3 = 2'b11;
    reg [1:0] state, next_state;
// nube combinacional entrada
    always @ (state or redInventario) begin
        case (state)
            A0: begin //Son 3 unidades máximo de capacidad, se usa un estado para cada unidad que se pierde.
                if (redInventario == 1) begin
                    next_state <= A1;
					endEmptyInventario <= 1'b1;
				end else begin
                    next_state <= A0; 
					endEmptyInventario <= 1'b1;
            end end 
            A1: begin //2 unidades restantes
                if (redInventario == 1) begin
                    next_state <= A2;
					endEmptyInventario <= 1'b1;
                end else begin
                    next_state <= A1;
					endEmptyInventario <= 1'b1;
            end end 
            A2: begin //1 unidad restate
                if (redInventario == 1) begin
                    next_state <= A3;
					endEmptyInventario <= 1'b1;
                end else begin
                    next_state <= A2;
					endEmptyInventario <= 1'b1;
            end end 
            A3: begin //0 unidadesÇ
                if (redInventario == 1) begin
                    next_state <= A3; //Se agotaron existencias.
					endEmptyInventario <= 1'b0;
                end else begin
                    next_state <= A3;
					endEmptyInventario <= 1'b0;
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



