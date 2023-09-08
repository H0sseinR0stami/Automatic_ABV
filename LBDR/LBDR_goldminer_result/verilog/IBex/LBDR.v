
/********************
* Filename:    parameters.v
* Description: Parameters for Packet FLITS
* $Revision: 21 $
* $Id: parameters.v 21 2015-11-21 10:54:06Z ranga $
* $Date: 2015-11-21 12:54:06 +0200 (Sat, 21 Nov 2015) $
* $Author: ranga $
*********************/

  // defining the flit ID -- One hot encoding
  
  
  

  // Specifying the FIFO parameters
  
  
  

module ibex_LBDR(
			clk, rst,
            empty,
            Rxy_rst, Cx_rst, 
            flit_id, dst_addr, cur_addr_rst,
            Nport, Eport, Wport, Sport, Lport
            );
			
  input wire clk, rst;
  input wire empty;
  input wire [7:0] Rxy_rst;
  input wire [3:0] Cx_rst;
  input wire [2:0] flit_id;
  input wire [3:0] dst_addr, cur_addr_rst;
  
  output reg Nport = 0;
  output reg Wport = 0;
  output reg Eport = 0;
  output reg Sport = 0;
  output reg Lport = 0;
  
  // Declaring the local variables
  reg [7:0] Rxy = 'd60;
  reg [3:0] Cx = 'd15;
  reg [3:0] cur_addr = 'd5;
  
    // Assigning the Routing bits for 8 quadrants
  wire Rne = Rxy[0];
  wire Rnw = Rxy[1];
  wire Ren = Rxy[2];
  wire Res = Rxy[3];
  wire Rwn = Rxy[4];
  wire Rws = Rxy[5];
  wire Rse = Rxy[6];
  wire Rsw = Rxy[7];
  
  // Assigning the Connecting bits for 4 connections
  wire Cn = Cx[0];
  wire Ce = Cx[1];
  wire Cw = Cx[2];
  wire Cs = Cx[3];
  
  // Assigning the current and destination for XY co-ordinates
  wire [1:0] x_cur = cur_addr[1:0];
  wire [1:0] y_cur = cur_addr[3:2];
  wire [1:0] x_dst = dst_addr[1:0];
  wire [1:0] y_dst = dst_addr[3:2];
  
  always @ (posedge clk) begin
    if (rst) begin
      Rxy      <= Rxy_rst;
      Cx       <= Cx_rst;
      cur_addr <= cur_addr_rst;
      Nport <= 0;
      Eport <= 0;
      Wport <= 0;
      Sport <= 0;
      Lport <= 0;
    end
  end
  
  // reg 1 -- Comparator reg checks the XY co-ordinates for current and destination and assigns the respective direction
  wire N1 = y_dst < y_cur;
  wire E1 = x_cur < x_dst;
  wire W1 = x_dst < x_cur;
  wire S1 = y_cur < y_dst;
  
  // reg 2 -- The final output port direction based on the comparator reg and Routing, connecting bits
  // LBDR routing reg works on HEADER flit alone and it maintains the same port direction for PAYLOAD and TAIL flit of the same packet, until a new HEADER flit arrives
  
  always @ (posedge clk) begin
    if (rst || empty) begin
      {Nport, Eport, Wport, Sport, Lport} <= 0;
    end
    else if (flit_id == 3'b001) begin
      Nport <= ((N1 & ~E1 & ~W1) | (N1 & E1 & Rne) | (N1 & W1 & Rnw)) & Cn;
      Eport <= ((E1 & ~N1 & ~S1) | (E1 & N1 & Ren) | (E1 & S1 & Res)) & Ce;
      Wport <= ((W1 & ~N1 & ~S1) | (W1 & N1 & Rwn) | (W1 & S1 & Rws)) & Cw;
      Sport <= ((S1 & ~E1 & ~W1) | (S1 & E1 & Rse) | (S1 & W1 & Rsw)) & Cs;
      Lport <= ~N1 & ~ E1 & ~W1 & ~S1;
    end
  end
	
endmodule
