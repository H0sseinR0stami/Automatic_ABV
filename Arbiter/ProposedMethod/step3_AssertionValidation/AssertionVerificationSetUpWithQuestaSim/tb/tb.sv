`timescale 1ns/1ps //timescale 

 
module tb();
  reg clk; 
  reg rst;
  reg Req_N;
  reg Req_E;
  reg Req_W;
  reg Req_S;
  reg Req_L;
  reg DCTS;
  
  wire Grant_N;
  wire Grant_E;
  wire Grant_W;
  wire Grant_S;
  wire Grant_L;
  wire [4:0] Xbar_sel;
  wire RTS;
  
  	integer i;
	parameter integer NumberOfIputLines = 1363;  // number of lines in  "../input/Arbiter_input.txt" file
	always  #1  clk = ~clk;
	
    reg[25:0] read_data [0:NumberOfIputLines];

	initial $readmemb("../input/Arbiter_input.txt", read_data);

initial begin
clk =  1'b1;
	
	 
	   for (i=0; i<NumberOfIputLines; i=i+1)
        begin

            {rst,Req_N,Req_E,Req_W,Req_S,Req_L,DCTS} = read_data[i]; @(posedge clk);
			

        end
$stop;	
end


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


`include "../properties_sva/Arbiter_properties.sva"


endmodule
