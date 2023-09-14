import random
import sys
import cocotb
from cocotb.triggers import Timer
from cocotb_coverage.coverage import coverage_db
from lib_coverage import *

@APBCoverage
def sample_coverage(PRESETn,PSELx,PWRITE,PENABLE,PADDR,PWDATA,READ_DATA_ON_RX,ERROR,TX_EMPTY,RX_EMPTY,\
                    WR_ENA,RD_ENA,PREADY,PSLVERR,INT_RX,INT_TX): 
    pass
@cocotb.test()
async def Arbiter_test(dut):
  cov_op = 0
  ex_cov_op = 0  
  # set maximum coverage desired
  Maximum_Functional_coverage = 100
  initial_iteration = 1000
  more_steps = 1000
  rst = [1] * 50 + [0] * 50
  mostone = [1] * 50 + [0] * 50
  mostzero = [0] * 50 + [1] * 50
  PADDR = [0,4,8,12]
  random.randint(0, 4294967296)
  #set phase
  for i in range(2):
    dut.PRESETn.value = 0
    dut.PSELx.value = 0
    dut.PWRITE.value = 0
    dut.PENABLE.value = 0
    dut.PADDR.value = 0
    dut.PWDATA.value = 0
    dut.READ_DATA_ON_RX.value = 0
    dut.ERROR.value = 0
    dut.TX_EMPTY.value = 0
    dut.RX_EMPTY.value = 0
    await Timer(2,'ns')    
  while (cov_op < Maximum_Functional_coverage): 
    # chose a random seed
    seed_value = random.randrange(sys.maxsize)  
    random.seed(seed_value)
    iteration = initial_iteration
    print("-----------------------------------------------------------------------------------")
    i=0
    while(i<iteration):
      dut.PRESETn.value = random.choice(mostzero)
      dut.PSELx.value = random.choice(mostone)
      dut.PWRITE.value = random.choice(mostone)
      dut.PENABLE.value = random.choice(mostone)
      dut.PADDR.value = random.choice(PADDR)
      dut.PWDATA.value = random.randint(0, 4294967296)
      dut.READ_DATA_ON_RX.value = random.randint(0, 4294967296)
      dut.ERROR.value = random.choice(mostzero)
      dut.TX_EMPTY.value = random.choice(mostzero)
      dut.RX_EMPTY.value = random.choice(mostzero)
      await Timer(2,'ns')
      sample_coverage(dut.PRESETn,dut.PSELx,dut.PWRITE,dut.PENABLE,dut.PADDR,dut.PWDATA,dut.READ_DATA_ON_RX,dut.ERROR,dut.TX_EMPTY,dut.RX_EMPTY,\
                    dut.WR_ENA,dut.RD_ENA,dut.PREADY,dut.PSLVERR,dut.INT_RX,dut.INT_TX)  
      i = i+1     
      top_cover_item = coverage_db["top"]
      cov_op = top_cover_item.coverage*100.0/top_cover_item.size
      print("overall coverage level", cov_op)
      if(cov_op >= Maximum_Functional_coverage):
        break
      if (i == iteration):         
        if (cov_op > ex_cov_op):
            ex_cov_op = cov_op
            iteration = iteration + more_steps
    top_cover_item = coverage_db["top"]
    cov_op = top_cover_item.coverage*100.0/top_cover_item.size
    print("overall coverage level", cov_op)
    print("Total number of bins = ", top_cover_item.size)
    print("Opertions finished succesfully!")
    #coverage_db.report_coverage(log.info, bins=False)
    coverage_db.export_to_xml("results_coverage.xml")

   
