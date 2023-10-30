
module top_tb();

    reg A, B, C, P, start, clk1, reset1, clk2, reset2; 
    reg [2:0]datain;
    wire [2:0]Q;
    wire parareloj;
    reg sda, scl;

    completo completo(A, B, C, P, start, clk1, reset1, clk2, reset2, datain, Q, parareloj, sda, scl);

    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);
    end

    initial
        #500 $finish;

    always
        #5 clk1 = ~clk1;
    always
        #5 clk2 = ~clk2;

    initial begin 
        clk1 = 0; clk2 = 0; reset1 = 0; reset2 = 0; A = 0; B = 0; C = 0; P = 0;
        #15
        B = 1;
        #10
        B = 0;
        #40
        P = 1;
        #15
        P = 0;

    end
endmodule