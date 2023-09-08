


`timescale 1ns/1ps //timescale 

module tb();
	    	reg PCLK;
			reg PRESETn;
			reg PSELx;
			reg PWRITE;
			reg PENABLE;
			reg [31:0] PADDR;
			reg [31:0] PWDATA;

			//internal pin
			reg [31:0] READ_DATA_ON_RX;
			reg ERROR;
			reg TX_EMPTY;
			reg RX_EMPTY;
			
			//external pin
			wire [31:0] PRDATA;

			//internal pin 
			wire [13:0] INTERNAL_I2C_REGISTER_CONFIG;
			wire [13:0] INTERNAL_I2C_REGISTER_TIMEOUT;
			wire [31:0] WRITE_DATA_ON_TX;
			wire  WR_ENA;
			wire  RD_ENA;
			
			//outside port 
			wire PREADY;
			wire PSLVERR;

			//interruption
			wire INT_RX;
			wire INT_TX;
		
	integer i;
	parameter integer NumberOfIputLines = 3726;  // number of lines in  "../input/apb_input.txt" file
	always  #1  PCLK = ~PCLK;
    reg[102:0] read_data [0:NumberOfIputLines];
	initial $readmemb("../input/apb_input.txt", read_data);
 
initial begin
PCLK =  1'b1;	 
	   for (i=0; i<NumberOfIputLines; i=i+1)
        begin
            {PRESETn,PSELx,PWRITE,PENABLE,PADDR,PWDATA,READ_DATA_ON_RX,ERROR,TX_EMPTY,RX_EMPTY} = read_data[i]; @(posedge PCLK);
        end
$stop;	
end

	apb DUT_apb(
	    	.PCLK(PCLK),
			.PRESETn(PRESETn),
			.PSELx(PSELx),
			.PWRITE(PWRITE),
			.PENABLE(PENABLE),
			.PADDR(PADDR),
			.PWDATA(PWDATA),

			//internal pin
			.READ_DATA_ON_RX(READ_DATA_ON_RX),
			.ERROR(ERROR),
			.TX_EMPTY(TX_EMPTY),
			.RX_EMPTY(RX_EMPTY),
			
			//external pin
			.PRDATA(PRDATA),

			//internal pin 
			.INTERNAL_I2C_REGISTER_CONFIG(INTERNAL_I2C_REGISTER_CONFIG),
			.INTERNAL_I2C_REGISTER_TIMEOUT(INTERNAL_I2C_REGISTER_TIMEOUT),
			.WRITE_DATA_ON_TX(WRITE_DATA_ON_TX),
			.WR_ENA(WR_ENA),
			.RD_ENA(RD_ENA),
			
			//outside port 
			.PREADY(PREADY),
			.PSLVERR(PSLVERR),

			//interruption
			.INT_RX(INT_RX),
			.INT_TX(INT_TX)
	  );	  

`include "../properties_sva/Apb_properties.sva"

endmodule	  