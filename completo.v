module completo(input A, B, C, P, clk1, reset1, clk2, reset2, 
input [2:0]datain,
input start,
output reg [2:0]Q,
output reg sda, parareloj, scl
);
	wire W1, W2;

	proceso todasentradas(.clk1(clk1), .reset1(reset1), .A(A), .B(B), .C(C), .P(P), .Q(W1));
	transmision enviaSDA(.clk2(clk2), .reset2(reset2), .datain(W1), .sda(sda), .parareloj(W2));
	reloj enviaSCL(.clk3(clk3), .reset3(reset3), .start(W2), .scl(scl));


endmodule


