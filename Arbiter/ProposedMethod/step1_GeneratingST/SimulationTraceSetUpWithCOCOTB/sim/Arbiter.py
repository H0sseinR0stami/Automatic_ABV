import sys
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge
import random
from lib_coverage import *

@ArbiterCoverage
def sample_coverage(rst,Req_N,Req_E,Req_W,Req_S,Req_L,DCTS,\
                    Grant_N,Grant_E,Grant_W,Grant_S,Grant_L,Xbar_sel,RTS): 
    pass

@cocotb.test()
async def test_arbiter(dut):
    cov_op = 0
    ex_cov_op = 0
    # set maximum coverage desired
    Maximum_Functional_coverage = 100
    initial_iteration = 100
    more_steps = 100
    reqs = ["Req_N", "Req_E", "Req_W", "Req_S", "Req_L"]
    # Create a 1ns period clock
    cocotb.fork(Clock(dut.clk, 1000).start())
    # Reset the dut
    dut.rst.value= 1
    await Timer(1, units="ns")
    dut.rst.value= 0
    await Timer(1, units="ns")
    # Initialize inputs
    dut.Req_N.value= 0
    dut.Req_E.value= 0
    dut.Req_W.value= 0
    dut.Req_S.value= 0
    dut.Req_L.value= 0
    dut.DCTS.value= 0
    await Timer(2, units="ns")
    while (cov_op < Maximum_Functional_coverage): 
        # chose a random seed
        seed_value = random.randrange(sys.maxsize)  
        random.seed(seed_value)
        iteration = initial_iteration
        print("-----------------------------------------------------------------------------------")
        i=0
        while(i<iteration):
                # Randomize inputs 
                random.shuffle(reqs)
                for j in range(random.randint(0,5)):
                    setattr(dut, reqs[j], 1)
                dut.DCTS.value = random.randint(0,1)
                dut.rst.value = random.randint(0,1)
                # Wait for one clock cycle
                await RisingEdge(dut.clk)
                sample_coverage(dut.rst.value,dut.Req_N.value,dut.Req_E.value,dut.Req_W.value,dut.Req_S.value,dut.Req_L.value,\
                    dut.DCTS.value, dut.Grant_N.value,dut.Grant_E.value,dut.Grant_W.value,dut.Grant_S.value,\
                        dut.Grant_L.value,dut.Xbar_sel.value,dut.RTS.value)     
                # Reset inputs
                for j in range(5):
                    setattr(dut, reqs[j], 0)
                dut.DCTS.value= 0
                i = i+1 
                top_cover_item = coverage_db["top"]
                cov_op = top_cover_item.coverage*100.0/top_cover_item.size
                print("overall coverage level", cov_op)
                if(cov_op >= Maximum_Functional_coverage):
                    break
                if (i >= iteration):         
                    if (cov_op > ex_cov_op):
                        ex_cov_op = cov_op
                        ex_cov_op = cov_op
                        iteration = iteration + more_steps
        top_cover_item = coverage_db["top"]
        cov_op = top_cover_item.coverage*100.0/top_cover_item.size
        print("overall coverage level", cov_op)
        print("Total number of bins = ", top_cover_item.size)
    print("Opertions finished succesfully!")
    #coverage_db.report_coverage(log.info, bins=False)
    coverage_db.export_to_xml("results_coverage.xml")

