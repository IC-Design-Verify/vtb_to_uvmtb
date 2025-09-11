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
// FILENAME       : ahb_agent_config.svh
// Author         : yaopeng.kang
// LAST MODIFIED  : 2025-09-11 10:26
// ***********************************************************************
// DESCRIPTION    :
// ***********************************************************************
// $Revision: $
// $Id: $
// ***********************************************************************
class ahb_agent_config extends uvm_object;

  `uvm_object_utils(ahb_agent_config)

  virtual ahb_intf vif;
  uvm_active_passive_enum active = UVM_PASSIVE;

  // Standard UVM Methods:
  extern function new(string name="ahb_agent_config");

endclass: ahb_agent_config

function ahb_agent_config::new(string name="ahb_agent_config");
  super.new(name);
endfunction: new
// ***********************************************************************
// $Log: $
// $Revision $
