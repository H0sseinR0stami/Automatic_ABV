`timescale 1ns/1ps

module LBDR_bench();

reg DEFAULT_RESET;
reg [2:0] flit_id;
reg [3:0] Cx_rst;
reg [3:0] cur_addr_rst;
reg clk;
reg rst;
reg [7:0] Rxy_rst;
reg [3:0] dst_addr;
reg empty;

wire Lport;
wire Nport;
wire Sport;
wire Eport;
wire Wport;

LBDR LBDR_ (
	.flit_id(flit_id),
	.Cx_rst(Cx_rst),
	.cur_addr_rst(cur_addr_rst),
	.clk(clk),
	.rst(rst),
	.Rxy_rst(Rxy_rst),
	.dst_addr(dst_addr),
	.empty(empty),
	.Lport(Lport),
	.Nport(Nport),
	.Sport(Sport),
	.Eport(Eport),
	.Wport(Wport));

	initial begin
		$dumpfile("/home/hrostami/goldminer/RunTime/goldmine.out/LBDR/LBDR.vcd");
		$dumpvars(0, LBDR_bench.LBDR_);
		clk = 1;
		DEFAULT_RESET = 1;
		#26;
		DEFAULT_RESET = 0;
		#1800000 $finish;
	end

	always begin
		#25 clk = ~clk;
	end

	always begin
		#24;
		flit_id = $random;
		Cx_rst = $random;
		cur_addr_rst = $random;
		rst = $random;
		Rxy_rst = $random;
		dst_addr = $random;
		empty = $random;
		#26;
	end

endmodule