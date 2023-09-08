import cocotb

from cocotb_coverage.coverage import *

ArbiterCoverage = coverage_section(
CoverPoint("top.rst",  
            vname="rst",
            bins=[0, 1]
            ),
CoverPoint("top.Req_N", 
            vname="Req_N", 
            bins=[0, 1]
            ),
CoverPoint("top.Req_E", 
            vname="Req_E", 
            bins=[0, 1]
            ),
CoverPoint("top.Req_W",
            vname="Req_W",  
            bins=[0,1]
            ),
CoverPoint("top.Req_S", 
            vname="Req_S", 
            bins=[0,1]
            ),
CoverPoint("top.Req_L",
            vname="Req_L",  
            bins=[0,1]
            ),
CoverPoint("top.DCTS",
            vname="DCTS",  
            bins=[0,1]
            ),
CoverPoint("top.Grant_N",
            vname="Grant_N",  
            bins=[0,1],
            at_least = 1
            ),
CoverPoint("top.Grant_E",
            vname="Grant_E",  
            bins=[0,1],
            at_least = 1
            ),
CoverPoint("top.Grant_W",
            vname="Grant_W",  
            bins=[0,1],
            at_least = 1
            ),
CoverPoint("top.Grant_S",
            vname="Grant_S",  
            bins=[0,1],
            at_least = 1
            ),
CoverPoint("top.Grant_L",
            vname="Grant_L",  
            bins=[0,1],
            at_least = 1
            ),
CoverPoint("top.Xbar_sel",
            vname="Xbar_sel",  
            bins=[1,2,4,8,16]
            ),
CoverPoint("top.RTS",
            vname="RTS",  
            bins=[0,1]
            ),
CoverCross("top.cross.rst",
            items=["top.rst","top.Req_N","top.Req_E","top.Req_W","top.Req_S","top.Req_L","top.DCTS"])
            
)

