`timescale 1ns/1ps //timescale 

module LBDR_wrapper(
  output reg clk,
  input wire rst,
  input wire empty,
  input wire [7:0] Rxy_rst,
  input wire [3:0] Cx_rst,
  input wire [2:0] flit_id,
  input wire [3:0] dst_addr,
  input wire [3:0] cur_addr_rst,
  output wire Nport,
  output wire Wport,
  output wire Eport,
  output wire Sport,
  output wire Lport
  );


LBDR DUT_LBDR(
  .clk(clk), 
  .rst(rst),
  .empty(empty),
  .Rxy_rst(Rxy_rst),
  .Cx_rst(Cx_rst),
  .flit_id(flit_id),
  .dst_addr(dst_addr),
  .cur_addr_rst(cur_addr_rst),
  .Nport(Nport),
  .Wport(Wport),
  .Eport(Eport),
  .Sport(Sport),
  .Lport(Lport)
);

initial begin
	  $dumpfile("../gtkwave/LBDR_wave.vcd");
	  $dumpvars;
	  clk=1;
	  forever begin
		  #1 clk=~clk;
	  end
end
//print execution trace
initial begin
  integer fd;
  integer f;
  integer g;
  fd= $fopen("../simulation_traces/LBDR_input_output.txt");
  f= $fopen("../simulation_traces/LBDR_input.txt"); 
  $fwrite(fd,"rst,empty,[8bits]DUT_LBDR.Rxy,[4bits]DUT_LBDR.Cx,[3bits]flit_id,[4bits]dst_addr,[4bits]DUT_LBDR.cur_addr,DUT_LBDR.Rne,DUT_LBDR.Rnw,DUT_LBDR.Ren,DUT_LBDR.Res,DUT_LBDR.Rwn,DUT_LBDR.Rws,DUT_LBDR.Rse,DUT_LBDR.Rsw,DUT_LBDR.Cn,DUT_LBDR.Ce,DUT_LBDR.Cw,DUT_LBDR.Cs,DUT_LBDR.N1,DUT_LBDR.E1,DUT_LBDR.W1,DUT_LBDR.S1,[2bits]DUT_LBDR.x_cur,[2bits]DUT_LBDR.y_cur,[2bits]DUT_LBDR.x_dst,[2bits]DUT_LBDR.y_dst Nport,Eport,Wport,Sport,Lport\n");
  forever begin
    @(posedge clk);   
    $fwrite(fd, "%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b %b%b%b%b%b\n",
			LBDR_wrapper.rst,LBDR_wrapper.empty,DUT_LBDR.Rxy,DUT_LBDR.Cx,
			LBDR_wrapper.flit_id,LBDR_wrapper.dst_addr,DUT_LBDR.cur_addr, 
			DUT_LBDR.Rne,DUT_LBDR.Rnw,DUT_LBDR.Ren,DUT_LBDR.Res,DUT_LBDR.Rwn,DUT_LBDR.Rws,DUT_LBDR.Rse,DUT_LBDR.Rsw,
			DUT_LBDR.Cn,DUT_LBDR.Ce,DUT_LBDR.Cw,DUT_LBDR.Cs,DUT_LBDR.N1,DUT_LBDR.E1,DUT_LBDR.W1,DUT_LBDR.S1,
			DUT_LBDR.x_cur,DUT_LBDR.y_cur,DUT_LBDR.x_dst,DUT_LBDR.y_dst,
			LBDR_wrapper.Nport,LBDR_wrapper.Eport,LBDR_wrapper.Wport,LBDR_wrapper.Sport,LBDR_wrapper.Lport); 		
    $fwrite(f, "%b%b%b%b%b%b%b\n",
			LBDR_wrapper.rst,LBDR_wrapper.empty,LBDR_wrapper.Rxy_rst,LBDR_wrapper.Cx_rst,
			LBDR_wrapper.flit_id,LBDR_wrapper.dst_addr,LBDR_wrapper.cur_addr_rst);		
  end
end
endmodule



