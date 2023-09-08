import cocotb

from cocotb_coverage.coverage import *

APBCoverage = coverage_section(
CoverPoint("top.PRESETn",  
            vname="PRESETn",
            bins=[0, 1]
            ),
CoverPoint("top.PSELx", 
            vname="PSELx", 
            bins=[0, 1]
            ),
CoverPoint("top.PWRITE", 
            vname="PWRITE", 
            bins=[0, 1]
            ),
CoverPoint("top.PENABLE",
            vname="PENABLE",  
            bins=[0,1]
            ),
CoverPoint("top.PADDR", 
            vname="PADDR", 
            bins=[0,4,8,12]
            ),
CoverPoint("top.ERROR",
            vname="ERROR",  
            bins=[0,1]
            ),
CoverPoint("top.TX_EMPTY",
            vname="TX_EMPTY",  
            bins=[0,1]
            ),
CoverPoint("top.RX_EMPTY",
            vname="RX_EMPTY",  
            bins=[0,1]
            ),
CoverPoint("top.WR_ENA",
            vname="WR_ENA",  
            bins=[0,1]
            ),
CoverPoint("top.RD_ENA",
            vname="RD_ENA",  
            bins=[0,1]
            ),
CoverPoint("top.PREADY",
            vname="PREADY",  
            bins=[0,1]
            ),
CoverPoint("top.PSLVERR",
            vname="PSLVERR",  
            bins=[0,1]
            ),
CoverPoint("top.INT_RX",
            vname="INT_RX",  
            bins=[0,1]
            ),
CoverPoint("top.INT_TX",
            vname="INT_TX",  
            bins=[0,1]
            ),
#CoverCross("top.cross.PRESETn",
#            items=["top.PRESETn","top.PSELx","top.PWRITE","top.PENABLE","top.PADDR","top.ERROR","top.TX_EMPTY","top.RX_EMPTY","top.WR_ENA",\
#                   "top.RD_ENA","top.PREADY","top.PSLVERR","top.INT_RX","top.INT_TX"]
#            )
CoverCross("top.cross.PRESETn",
            items=["top.PRESETn","top.PSELx","top.PWRITE","top.PENABLE","top.PADDR","top.ERROR","top.TX_EMPTY","top.RX_EMPTY"]
           )
            
)

