// ***********************************************************************
// *****************                                                       
// ***** ***********                                                       
// *****   *********                                                       
// *****     *******      Copyright (c) 2025  Kang Yaopeng  
// *****       *****                                                       
// *****     *******             All rights reserved                       
// *****   *********                                                       
// ***** ***********                                                       
// *****************                                                       
// ***********************************************************************
// PROJECT        : 
// FILENAME       : ahb_agent.svh
// Author         : yaopeng.kang
// LAST MODIFIED  : 2025-09-11 10:15
// ***********************************************************************
// DESCRIPTION    :
// ***********************************************************************
// $Revision: $
// $Id: $
// ***********************************************************************
class ahb_agent extends uvm_agent;

  `uvm_component_utils(ahb_agent)

  ahb_driver drv;

  ahb_agent_config agt_cfg;

  // Standard UVM Methods:
  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);

endclass: ahb_agent

function ahb_agent::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction: new

function void ahb_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(ahb_agent_config)::get(this, "", "config", agt_cfg)) begin
    `uvm_warning("build_phase",$sformatf("agent config not found, create in agent."))
    agt_cfg = ahb_agent_config::type_id::create("agt_cfg", this);
    agt_cfg.active = UVM_ACTIVE;
  end

  // 可以使用指针或者config_db其中之一的方式获取virtual interface
  if(!uvm_config_db#(virtual ahb_intf)::get(this, "", "vif", agt_cfg.vif) || agt_cfg.vif==null) begin
    `uvm_fatal("CFGERR",$sformatf("Interface for Agent not set"))
  end
  else begin
    uvm_config_db#(virtual ahb_intf)::set(this, "*", "vif", agt_cfg.vif);
  end

  if(agt_cfg.active == UVM_ACTIVE) begin
    drv = ahb_driver::type_id::create("drv", this);
  end

endfunction: build_phase

function void ahb_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

endfunction: connect_phase

function void ahb_agent::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
	uvm_top.print_topology();
endfunction: end_of_elaboration_phase
// ***********************************************************************
// $Log: $
// $Revision $
