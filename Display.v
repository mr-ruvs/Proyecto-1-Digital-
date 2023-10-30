
module Display_7_segmentos (
    input clk, rst,
    input [2:0] entrada,
    input timer_done,
    output reg [7:0] display,
    output reg start_timer);
    reg [2:0] state, nst;

    Timer Temporizador(.start(start_timer), .clk(clk), .rst(rst), .done_timer(timer_done));
    /////ahhhh preguntar a ruben otra vez esto

    parameter OA = 3'b001, OB = 3'b010, OP = 3'b011, OC = 3'b100, OE = 3'b101, OG = 3'b110;  //parametros de entrada
    parameter S0 = 3'b000, S1 = 3'b001, S2= 3'b010, S3 = 3'b011, S4 =  3'b100, S5 = 3'b101, S6 = 3'b110; ///parametro de estados
    parameter LetraA = 8'b11101110, LetraB = 8'b11111110, LetraP = 8'b11001110, LetraC = 8'b10011100, LetraG = 8'b10111110, LetraH = 8'b01101110, LetraDP = 8'b00000001;///parametros de salida

    always @ (entrada or state or timer_done) begin
        case(state)
            S0: begin
                if (entrada == OA) begin
                    nst <= S1;
                end else if (entrada == OB)begin
                    nst <= S2;
                end else begin
                    nst <= S0;
                end
            end
            S1: begin
                if (entrada == OP)begin
                    nst <= S5;
                end else if (entrada == OC)begin
                    nst <= S3;
                end else if (entrada == OE)begin
                    nst <= S4;
                end else begin
                    nst <= S1;
                end
            end
             S2: begin
                if (entrada == OP)begin
                    nst <= S5;
                end else if (entrada == OC)begin
                    nst <= S3;
                end else if (entrada == OE)begin
                    nst <= S4;
                end
            end
            S3: begin

                if (timer_done == 1)begin
                    nst <= S0;
                end else begin
                    nst <= S3;
                end
            end
            S4: begin
                if (timer_done == 1)begin
                    nst <= S0;
                end else begin
                    nst <= S4;
                end;
            end
            S5: begin
                if (timer_done == 1)begin
                    nst <= S6;
                end else  begin
                    nst <= S5;
                end
            end
            S6: begin
                if (timer_done == 1)begin
                    nst <= S0;
                end else  begin
                    nst <= S6;
                end
            end
        default: nst <= S0;
        endcase

    end
///// Banco de Flip Flops//
    always @ (posedge clk or posedge rst)begin
        if (rst == 1)
            state <= S0;
        else
            state <= nst;
        end

/// Nube combinacional de salida///

    always @ (state) begin
        case(state)
            S0: begin display <= LetraH; start_timer <= 1'b0; end
            S1: begin display <= LetraA; start_timer <= 1'b0; end
            S2: begin display <= LetraB; start_timer <= 1'b0; end
            S3: begin display <= LetraP; start_timer <= 1'b1; end
            S4: begin display <= LetraC; start_timer <= 1'b1; end
            S5: begin display <= LetraDP; start_timer <= 1'b1; end
            S6: begin display <= LetraG; start_timer <= 1'b1; end
        endcase
    end

endmodule
