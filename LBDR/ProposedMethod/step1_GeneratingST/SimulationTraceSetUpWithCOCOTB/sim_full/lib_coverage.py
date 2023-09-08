import cocotb

from cocotb_coverage.coverage import *

LBDRCoverage = coverage_section(
CoverPoint("top.rst",  
            vname="rst",
            bins=[0, 1]
            ),
CoverPoint("top.empty", 
            vname="empty", 
            bins=[0, 1]
            ),
CoverPoint("top.flit_id", 
            vname="flit_id", 
            bins=[1, 2]
            ),
CoverPoint("top.dst_addr",
            vname="dst_addr",  
            bins=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
            ),
CoverPoint("top.Rxy_rst", 
            vname="Rxy_rst", 
            bins=[60, 195]
            ),
CoverPoint("top.Cx_rst",
            vname="Cx_rst",  
            bins=[15]
            ),
CoverPoint("top.cur_addr_rst",
            vname="cur_addr_rst",  
            bins=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
            ),
CoverPoint("top.Nport",
            vname="Nport",  
            bins=[0,1]
            ),
CoverPoint("top.Eport",
            vname="Eport",  
            bins=[0,1]
            ),
CoverPoint("top.Wport",
            vname="Wport",  
            bins=[0,1]
            ),
CoverPoint("top.Sport",
            vname="Sport",  
            bins=[0,1]
            ),
CoverPoint("top.Lport",
            vname="Lport",  
            bins=[0,1]
            ),
CoverCross("top.cross.Rx_dst_cur",
            items=["top.Rxy_rst","top.dst_addr","top.cur_addr_rst","top.flit_id","top.rst","top.empty"]
            )
            
)

