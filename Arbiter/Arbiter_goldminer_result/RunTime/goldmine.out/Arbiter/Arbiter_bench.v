`timescale 1ns/1ps

module Arbiter_bench();

reg DEFAULT_RESET;
reg Req_S;
reg Req_E;
reg Req_W;
reg rst;
reg DCTS;
reg clk;
reg Req_L;
reg Req_N;

wire Grant_L;
wire Grant_N;
wire RTS;
wire Grant_E;
wire [4:0] Xbar_sel;
wire Grant_W;
wire Grant_S;

Arbiter Arbiter_ (
	.Req_S(Req_S),
	.Req_E(Req_E),
	.Req_W(Req_W),
	.rst(rst),
	.DCTS(DCTS),
	.clk(clk),
	.Req_L(Req_L),
	.Req_N(Req_N),
	.Grant_L(Grant_L),
	.Grant_N(Grant_N),
	.RTS(RTS),
	.Grant_E(Grant_E),
	.Xbar_sel(Xbar_sel),
	.Grant_W(Grant_W),
	.Grant_S(Grant_S));

	initial begin
		$dumpfile("/home/hrostami/Arbiter_goldminer/goldminer/RunTime/goldmine.out/Arbiter/Arbiter.vcd");
		$dumpvars(0, Arbiter_bench.Arbiter_);
		clk = 1;
		DEFAULT_RESET = 1;
		#26;
		DEFAULT_RESET = 0;
		#68300 $finish;
	end

	always begin
		#25 clk = ~clk;
	end

	always begin
		#24;
		Req_S = $random;
		Req_E = $random;
		Req_W = $random;
		rst = $random;
		DCTS = $random;
		Req_L = $random;
		Req_N = $random;
		#26;
	end

endmodule