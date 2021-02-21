
`ifndef GUARD_simpseq
`define GUARD_simpseq

class simpseq extends dw_vip_pcie_tlp_base_sequence;

  /** Sequence Length in Virtual Sequence, to set to the actual default sequence */
  rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }
  
  /** UVM object utility macro */
  `uvm_object_utils(simpseq)

  /** This macro is used to declare a variable p_sequencer whose type is pcie_virtual_sequencer */
  `uvm_declare_p_sequencer(dw_vip_pcie_tlp_sequencer)
  /** Class constructor */
  function new (string name = "simpseq");
    super.new(name);
  endfunction
  virtual task body();
    bit [31:0] addr;
    
    `uvm_info("body", "Entering ...",UVM_LOW)
    
    `uvm_do_with(req , { 
                          m_enType             == dw_vip_pcie_tlp_transaction::MEM_WR_32;
                          m_bvLastDWBE         == 4'b1111;
                          m_bvFirstDWBE        == 4'b1111;
                          m_bvLength           == 4;
                        }
                 )
    
    addr = req.m_bvAddr;
 
    /** wait for response from driver */
    req.print();
    get_response(rsp);
    rsp.print();
    
    `uvm_do_with(req , {
                          m_enType             == dw_vip_pcie_tlp_transaction::MEM_RD_32;
                          m_bvLastDWBE         == 4'b0011;
                          m_bvFirstDWBE        == 4'b1100;
                          m_bvLength           == 4;
                          m_bvAddr             == addr;
                        }
                ) 
     
    req.print();
    get_response(rsp);
    rsp.print();
    
    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask  

endclass : simpseq

`endif // GUARD_simpseq

