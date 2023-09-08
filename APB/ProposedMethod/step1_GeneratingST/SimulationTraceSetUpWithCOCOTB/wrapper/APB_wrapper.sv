`timescale 1ns/1ps //timescale 

module APB_wrapper(
  output reg PCLK,
  input wire PRESETn,
  input wire PSELx,
  input wire PWRITE,
  input wire PENABLE,
  input wire [31:0] PADDR,
  input wire [31:0] PWDATA,
  input wire [31:0] READ_DATA_ON_RX,
  input wire ERROR,
  input wire TX_EMPTY,
  input wire RX_EMPTY,
  output wire [31:0] PRDATA,
  output wire [13:0] INTERNAL_I2C_REGISTER_CONFIG,
  output wire [13:0] INTERNAL_I2C_REGISTER_TIMEOUT,
  output wire [31:0] WRITE_DATA_ON_TX,
  output wire WR_ENA,
  output wire RD_ENA,
  output wire PREADY,
  output wire PSLVERR,
  output wire INT_RX,
  output wire INT_TX
  );

APB DUT_APB(
  .PCLK(PCLK), 
  .PRESETn(PRESETn),
  .PSELx(PSELx),
  .PWRITE(PWRITE),
  .PENABLE(PENABLE),
  .PADDR(PADDR),
  .PWDATA(PWDATA),
  .READ_DATA_ON_RX(READ_DATA_ON_RX),
  .ERROR(ERROR),
  .TX_EMPTY(TX_EMPTY),
  .RX_EMPTY(RX_EMPTY),  
  .PRDATA(PRDATA),
  .INTERNAL_I2C_REGISTER_CONFIG(INTERNAL_I2C_REGISTER_CONFIG),
  .INTERNAL_I2C_REGISTER_TIMEOUT(INTERNAL_I2C_REGISTER_TIMEOUT),
  .WRITE_DATA_ON_TX(WRITE_DATA_ON_TX),
  .WR_ENA(WR_ENA),
  .RD_ENA(RD_ENA),
  .PREADY(PREADY),
  .PSLVERR(PSLVERR),
  .INT_RX(INT_RX),
  .INT_TX(INT_TX)
);

initial begin
	  $dumpfile("../gtkwave/APB_wave.vcd");
	  $dumpvars(  2 , APB_wrapper);
	  PCLK=1;
	  forever begin
		  #1 PCLK=~PCLK;
	  end
end

//print execution trace
initial begin
  integer fd;
  integer f;
  integer g;
  fd= $fopen("../simulation_traces/APB_input_output.txt");
  f= $fopen("../simulation_traces/APB_input.txt"); 

  $fwrite(fd,"PRESETn,PSELx,PWRITE,PENABLE,ERROR,TX_EMPTY,RX_EMPTY  WR_ENA,RD_ENA,PREADY,PSLVERR,INT_RX,INT_TX\n");
  forever begin
    @(posedge PCLK);
    
        $fwrite(fd, "%b%b%b%b%b%b%b %b%b%b%b%b%b\n",
			APB_wrapper.PRESETn, APB_wrapper.PSELx, APB_wrapper.PWRITE, APB_wrapper.PENABLE,
			APB_wrapper.ERROR, APB_wrapper.TX_EMPTY, APB_wrapper.RX_EMPTY,
			 
			APB_wrapper.WR_ENA, APB_wrapper.RD_ENA, APB_wrapper.PREADY, APB_wrapper.PSLVERR, APB_wrapper.INT_RX, APB_wrapper.INT_TX);
 		
        $fwrite(f, "%b%b%b%b%b%b%b%b%b%b\n",
			APB_wrapper.PRESETn, APB_wrapper.PSELx, APB_wrapper.PWRITE, APB_wrapper.PENABLE,
			APB_wrapper.PADDR, APB_wrapper.PWDATA, APB_wrapper.READ_DATA_ON_RX, APB_wrapper.ERROR, APB_wrapper.TX_EMPTY, APB_wrapper.RX_EMPTY);
  end
end	
endmodule
