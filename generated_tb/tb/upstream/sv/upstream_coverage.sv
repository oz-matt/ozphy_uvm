// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: upstream_coverage.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Wed Feb 17 10:05:16 2021
//=============================================================================
// Description: Coverage for agent upstream
//=============================================================================

`ifndef UPSTREAM_COVERAGE_SV
`define UPSTREAM_COVERAGE_SV

// You can insert code here by setting agent_cover_inc_before_class in file upstream.tpl

class upstream_coverage extends uvm_subscriber #(ustream_trans);

  `uvm_component_utils(upstream_coverage)

  upstream_config m_config;    
  bit             m_is_covered;
  ustream_trans   m_item;
     
  // You can replace covergroup m_cov by setting agent_cover_inc in file upstream.tpl
  // or remove covergroup m_cov by setting agent_cover_generate_methods_inside_class = no in file upstream.tpl

  covergroup m_cov;
    option.per_instance = 1;
    // You may insert additional coverpoints here ...

    cp_rand_instruction: coverpoint m_item.rand_instruction;
    //  Add bins here if required

    cp_adc_data: coverpoint m_item.adc_data;
    //  Add bins here if required

  endgroup

  // You can remove new, write, and report_phase by setting agent_cover_generate_methods_inside_class = no in file upstream.tpl

  extern function new(string name, uvm_component parent);
  extern function void write(input ustream_trans t);
  extern function void build_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);

  // You can insert code here by setting agent_cover_inc_inside_class in file upstream.tpl

endclass : upstream_coverage 


// You can remove new, write, and report_phase by setting agent_cover_generate_methods_after_class = no in file upstream.tpl

function upstream_coverage::new(string name, uvm_component parent);
  super.new(name, parent);
  m_is_covered = 0;
  m_cov = new();
endfunction : new


function void upstream_coverage::write(input ustream_trans t);
  if (m_config.coverage_enable)
  begin
    m_item = t;
    m_cov.sample();
    // Check coverage - could use m_cov.option.goal instead of 100 if your simulator supports it
    if (m_cov.get_inst_coverage() >= 100) m_is_covered = 1;
  end
endfunction : write


function void upstream_coverage::build_phase(uvm_phase phase);
  if (!uvm_config_db #(upstream_config)::get(this, "", "config", m_config))
    `uvm_error(get_type_name(), "upstream config not found")
endfunction : build_phase


function void upstream_coverage::report_phase(uvm_phase phase);
  if (m_config.coverage_enable)
    `uvm_info(get_type_name(), $sformatf("Coverage score = %3.1f%%", m_cov.get_inst_coverage()), UVM_MEDIUM)
  else
    `uvm_info(get_type_name(), "Coverage disabled for this agent", UVM_MEDIUM)
endfunction : report_phase


// You can insert code here by setting agent_cover_inc_after_class in file upstream.tpl

`endif // UPSTREAM_COVERAGE_SV

