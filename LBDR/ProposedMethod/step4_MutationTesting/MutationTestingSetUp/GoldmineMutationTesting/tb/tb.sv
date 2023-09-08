`timescale 1ns/1ps //timescale 

module tb();
  reg clk; 
  reg rst;
  reg empty;
  reg [7:0] Rxy_rst;
  reg [3:0] Cx_rst;
  reg [2:0] flit_id;
  reg [3:0] dst_addr;
  reg [3:0] cur_addr_rst;
  wire Nport;
  wire Wport;
  wire Eport;
  wire Sport;
  wire Lport;
  integer i;
  parameter integer NumberOfIputLines = 36767; // number of lines in  "../input/LBDR_input.txt" file
  always  #1  clk = ~clk;	
  reg[25:0] read_data [0:NumberOfIputLines];
  initial $readmemb("../input/LBDR_input.txt", read_data);
  initial begin
	clk =  1'b1;	 
	for (i=0; i<NumberOfIputLines; i=i+1)
      begin
        {rst,empty, Rxy_rst, Cx_rst, flit_id, dst_addr, cur_addr_rst} = read_data[i]; @(posedge clk);
      end
   $stop;	
  end
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
  `include "../properties_sva/LBDR_properties.sva"
endmodule
