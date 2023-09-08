`timescale 1ns/1ps //timescale 

module Arbiter_wrapper(
  output reg clk,
  input wire rst,
  input wire Req_N,
  input wire Req_E,
  input wire Req_W,
  input wire Req_S,
  input wire Req_L,
  input wire DCTS,
  output wire Grant_N,
  output wire Grant_E,
  output wire Grant_W,
  output wire Grant_S,
  output wire Grant_L,
  output  logic [4:0] Xbar_sel,
  output  logic RTS
  );


Arbiter DUT_Arbiter(
  .clk(clk), 
  .rst(rst),
  .Req_N(Req_N),
  .Req_E(Req_E),
  .Req_W(Req_W),
  .Req_S(Req_S),
  .Req_L(Req_L),
  .DCTS(DCTS),  
  .Grant_N(Grant_N),
  .Grant_E(Grant_E),
  .Grant_W(Grant_W),
  .Grant_S(Grant_S),
  .Grant_L(Grant_L),
  .Xbar_sel(Xbar_sel),
  .RTS(RTS)
);

initial begin
	  $dumpfile("../gtkwave/Arbiter_wave.vcd");
	  $dumpvars(  2 , Arbiter_wrapper);
	  clk=1;
	  forever begin
		  #1 clk=~clk;
	  end
end

//print execution trace
initial begin
  integer fd;
  integer f;
  fd= $fopen("../simulation_traces/Arbiter_input_output.txt");
  f= $fopen("../simulation_traces/Arbiter_input.txt"); 
  $fwrite(fd,"rst,Req_N,Req_E,Req_W,Req_S,Req_L,DCTS,DUT_Arbiter.RTS_FF,DUT_Arbiter.RTS_FF_in,[5:0]DUT_Arbiter.state,[5:0]DUT_Arbiter.state_in Grant_N,Grant_E,Grant_W,Grant_S,Grant_L,[4:0]Xbar_sel,RTS\n");      
  forever begin
    @(posedge clk);  
        $fwrite(fd, "%b%b%b%b%b%b%b%b%b%b%b %b%b%b%b%b%b%b\n",
			Arbiter_wrapper.rst,Arbiter_wrapper.Req_N,Arbiter_wrapper.Req_E,Arbiter_wrapper.Req_W,
			Arbiter_wrapper.Req_S,Arbiter_wrapper.Req_L,Arbiter_wrapper.DCTS, 			
			DUT_Arbiter.RTS_FF,DUT_Arbiter.RTS_FF_in,DUT_Arbiter.state,DUT_Arbiter.state_in,
			Arbiter_wrapper.Grant_N,Arbiter_wrapper.Grant_E,Arbiter_wrapper.Grant_W,Arbiter_wrapper.Grant_S,
			Arbiter_wrapper.Grant_L,Arbiter_wrapper.Xbar_sel,Arbiter_wrapper.RTS);		
        $fwrite(f, "%b%b%b%b%b%b%b\n",
			Arbiter_wrapper.rst,Arbiter_wrapper.Req_N,Arbiter_wrapper.Req_E,Arbiter_wrapper.Req_W,
			Arbiter_wrapper.Req_S,Arbiter_wrapper.Req_L,Arbiter_wrapper.DCTS);	
  end 
end		
endmodule
