
import random
import sys
import cocotb
from cocotb.triggers import Timer, RisingEdge, ReadOnly, NextTimeStep, FallingEdge
from cocotb_bus.drivers import BusDriver
from cocotb_coverage.coverage import CoverCross, CoverPoint, coverage_db
from cocotb_bus.monitors import BusMonitor
import os
from lib_coverage import *
from lib_calculator import *
from datetime import datetime

@LBDRCoverage
def sample_coverage(rst,empty,flit_id,dst_addr,Rxy_rst,Cx_rst,cur_addr_rst,Nport,Eport,Wport,Sport,Lport): 
    pass
#----------------------------------------------------------------------- 
@cocotb.test()

async def LBDR_test(dut):
  log = cocotb.logging.getLogger("cocotb.test")
  log.info("Test started!")
  # remove previous run seeds
  if os.path.exists("random_seeds.txt"):
    os.remove("random_seeds.txt")
  # set maximum coverage desired
  Maximum_Functional_coverage = 100
  initial_iteration = 1000
  more_steps = 1000
  good_seeds = []
  #initial phase    
  Rxy_rst_value = 60
  Cx_rst_value = 15
  cur_addr_rst_value = 0
  flit_id_value = 1
  dst_addr_value = 0
  rst_value = 1
  empty_value = 0
  Cx_rst = [15]
  Rxy_rst_sequence = [60,195]   
  cov_op = 0
  ex_cov_op = 0  

  dut.rst.value = rst_value
  dut.empty.value = empty_value
  dut.flit_id.value = flit_id_value
  dut.dst_addr.value = dst_addr_value
  dut.Rxy_rst.value = Rxy_rst_value
  dut.Cx_rst.value = Cx_rst_value
  dut.cur_addr_rst.value = cur_addr_rst_value    
  await Timer(2,'ns')
  calculated_result = (0,0,0,0,0)
   
  while (cov_op < Maximum_Functional_coverage): 
    # chose a random seed
    seed_value = random.randrange(sys.maxsize)  
    random.seed(seed_value)
    iteration = initial_iteration
    print("-----------------------------------------------------------------------------------")
    i=0
    while(i<iteration):
      # set input values
      rst_value = random.randint(0, 1)
      empty_value = random.randint(0, 1)
      flit_id_value = random.randint(1, 2)          
      if (rst_value): 
        Rxy_rst_value = random.choice(Rxy_rst_sequence)
        Cx_rst_value = random.choice(Cx_rst)
        cur_addr_rst_value = random.randint(0, 15)             
        dut.rst.value = rst_value
        dut.empty.value = empty_value
        dut.flit_id.value = flit_id_value
        dut.dst_addr.value = dst_addr_value
        dut.Rxy_rst.value = Rxy_rst_value
        dut.Cx_rst.value = Cx_rst_value
        #dut.Cx_rst.value = random.randint(0, 15)
        dut.cur_addr_rst.value = cur_addr_rst_value
        await Timer(2,'ns')
        sim_result = (dut.Nport.value,dut.Eport.value,dut.Wport.value,dut.Sport.value,dut.Lport.value)

        assert calculated_result == sim_result , f"Error reset phase Miss Match !"
        calculated_result = (0,0,0,0,0)       
        sample_coverage(dut.rst.value,dut.empty.value,dut.flit_id.value,
                    dut.dst_addr.value,dut.Rxy_rst.value,dut.Cx_rst.value,dut.cur_addr_rst.value,
                    dut.Nport.value,dut.Eport.value,dut.Wport.value,dut.Sport.value,dut.Lport.value)
        
      elif(empty_value ):
        dut.rst.value = rst_value
        dut.empty.value = empty_value
        dut.flit_id.value = flit_id_value
        dut.dst_addr.value = dst_addr_value
        dut.Rxy_rst.value = Rxy_rst_value
        dut.Cx_rst.value = Cx_rst_value
        #dut.Cx_rst.value = random.randint(0, 15)
        dut.cur_addr_rst.value = cur_addr_rst_value
        await Timer(2,'ns')
        sim_result = (dut.Nport.value,dut.Eport.value,dut.Wport.value,dut.Sport.value,dut.Lport.value)
        assert calculated_result == sim_result , f"Error emplty phase Miss Match !"
        calculated_result = (0,0,0,0,0)        
        sample_coverage(dut.rst.value,dut.empty.value,dut.flit_id.value,
                    dut.dst_addr.value,dut.Rxy_rst.value,dut.Cx_rst.value,dut.cur_addr_rst.value,
                    dut.Nport.value,dut.Eport.value,dut.Wport.value,dut.Sport.value,dut.Lport.value)
        
      elif(flit_id_value == 1):
        dst_addr_value = random.randint(0, 15)
        
        dut.rst.value = rst_value
        dut.empty.value = empty_value
        dut.flit_id.value = flit_id_value
        dut.dst_addr.value = dst_addr_value
        dut.Rxy_rst.value = Rxy_rst_value
        dut.Cx_rst.value = Cx_rst_value
        #dut.Cx_rst.value = random.randint(0, 15)
        dut.cur_addr_rst.value = cur_addr_rst_value 
        await Timer(2,'ns')      
        sim_result = (dut.Nport.value,dut.Eport.value,dut.Wport.value,dut.Sport.value,dut.Lport.value)
        assert calculated_result == sim_result , f"Error flit_id = 1 phase Miss Match !"
        calculated_result = calculated_outputs(dut.Rxy_rst.value,dut.Cx_rst.value,dut.dst_addr.value,dut.cur_addr_rst.value)       
        sample_coverage(dut.rst.value,dut.empty.value,dut.flit_id.value,
                    dut.dst_addr.value,dut.Rxy_rst.value,dut.Cx_rst.value,dut.cur_addr_rst.value,
                    dut.Nport.value,dut.Eport.value,dut.Wport.value,dut.Sport.value,dut.Lport.value)                           
        
      else:
        dut.rst.value = rst_value
        dut.empty.value = empty_value
        dut.flit_id.value = flit_id_value 
        dut.dst_addr.value = dst_addr_value              
        dut.Rxy_rst.value = Rxy_rst_value
        dut.Cx_rst.value = Cx_rst_value
        #dut.Cx_rst.value = random.randint(0, 15)
        dut.cur_addr_rst.value = cur_addr_rst_value 
        await Timer(2,'ns') 
        sim_result = (dut.Nport.value,dut.Eport.value,dut.Wport.value,dut.Sport.value,dut.Lport.value)
        assert calculated_result == sim_result , f"Error flit_id != 1 phase Miss Match !"
        calculated_result = sim_result        
        sample_coverage(dut.rst.value,dut.empty.value,dut.flit_id.value,
                    dut.dst_addr.value,dut.Rxy_rst.value,dut.Cx_rst.value,dut.cur_addr_rst.value,
                    dut.Nport.value,dut.Eport.value,dut.Wport.value,dut.Sport.value,dut.Lport.value)
                    
      i = i+1
      top_cover_item = coverage_db["top"]
      #print("top_cover_item.coverage",top_cover_item.coverage)
      #print("top_cover_item.size",top_cover_item.size)
      cov_op = top_cover_item.coverage*100.0/top_cover_item.size
      #log.info("Current overall coverage level = %f %%", cov_op)

      if(cov_op >= Maximum_Functional_coverage):
         if seed_value not in good_seeds:
            good_seeds.append(seed_value)
            with open("random_seeds.txt", "a") as f:
               f.write(f'{seed_value}\n')
         break

      if (i >= iteration):         
        if (cov_op > ex_cov_op):
            ex_cov_op = cov_op
            iteration = iteration + more_steps
            # save improving seed
            if seed_value not in good_seeds:
                good_seeds.append(seed_value)

                with open("random_seeds.txt", "a") as f:
                  f.write(f'{seed_value}\n')
                
            print("Improving functional coverage","iteration=",i)
            print("seed_value=", seed_value)
            print("total coverage=",cov_op)
        else:
            print("Not improving functional coverage!","iteration=",i)
            print("seed_value=", seed_value)
             
    # end of minulation
    dut.rst.value = rst_value
    dut.empty.value = empty_value
    dut.Rxy_rst.value = Rxy_rst_value
    dut.Cx_rst.value = Cx_rst_value
    dut.flit_id.value = flit_id_value
    dut.dst_addr.value = dst_addr_value
    dut.cur_addr_rst.value = cur_addr_rst_value
    await Timer(2,'ns')
    sim_result = (dut.Nport.value,dut.Eport.value,dut.Wport.value,dut.Sport.value,dut.Lport.value)
    assert calculated_result == sim_result , f"Error final missmatch"
    
    sample_coverage(dut.rst.value,dut.empty.value,dut.flit_id.value,
                    dut.dst_addr.value,dut.Rxy_rst.value,dut.Cx_rst.value,dut.cur_addr_rst.value,
                    dut.Nport.value,dut.Eport.value,dut.Wport.value,dut.Sport.value,dut.Lport.value)
                    
    #------------------------------------to get the report of coverage----------------------------  

    top_cover_item = coverage_db["top"]
    print("top_cover_item.coverage",top_cover_item.coverage)
    #print("top_cover_item.size",top_cover_item.size)
    cov_op = top_cover_item.coverage*100.0/top_cover_item.size
    #log.info("Current overall coverage level = %f %%", cov_op)

  
  log.info("Opertions finished succesfully!")
  
  log.info("Functional coverage details:")
  log.info("Overall coverage level = %f %%", cov_op)
  log.info("Number of covered bins = %d ",top_cover_item.coverage)
  #coverage_db.report_coverage(log.info, bins=True)
  coverage_db.export_to_xml("results_coverage.xml")
  #print(good_seeds)
  



   