
`ifndef MEM_IO_RAND_SV
  `define MEM_IO_RAND_SV

class mem_io_rand_seq_item extends dw_vip_pcie_tlp_transaction;

  `uvm_object_utils(mem_io_rand_seq_item)
  
  constraint  valid_tlp_memory_requests 
  {
    m_enType inside {MEM_RD_32, MEM_RD_64, MEM_WR_32, MEM_WR_64};
    m_bvRequesterId == 16'h0100;
    m_bvLength inside {[1:64]};
    
    if (m_enType == MEM_RD_32 || MEM_WR_32) 
    {
      m_bvAddr inside { [32'h0100_0000 : 32'h01FF_F000] };
    }
    else if (m_enType == MEM_RD_64 || m_enType == MEM_WR_64) 
    {
      m_bvAddr inside { [64'h0100_0000_0000_0000 : 64'h01FF_F000_0000_0000] };
    }
  }

function new(string name = "mem_io_rand_seq_item");
    super.new(name);
endfunction

endclass : mem_io_rand_seq_item
      
`endif /* MEM_IO_RAND_SV */
