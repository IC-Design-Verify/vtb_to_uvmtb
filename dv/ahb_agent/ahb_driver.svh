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
// FILENAME       : ahb_driver.svh
// Author         : IC_VERIFY
// LAST MODIFIED  : 2025-09-10 13:54
// ***********************************************************************
// DESCRIPTION    :
// ***********************************************************************
// $Revision: $
// $Id: $
// ***********************************************************************
class ahb_driver extends uvm_driver;

  // UVM Factory Registration Macro
  //
  `uvm_component_utils(ahb_driver)

  // Virtual Interface
  virtual ahb_intf vif;

  //------------------------------------------
  // Component Members
  //------------------------------------------

  //------------------------------------------
  // Data Members (Outputs rand, inputs non-rand)
  //------------------------------------------

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
	extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task reset_phase(uvm_phase phase);
  extern virtual task main_phase(uvm_phase phase);

  // User_defined Methods

endclass: ahb_driver

function ahb_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction: new

function void ahb_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(virtual ahb_intf)::get(this, "", "vif", vif)) begin
    `uvm_fatal("VIF_NOT_FOUND", $sformatf("ahb vif is not set to driver"))
  end
endfunction: build_phase

function void ahb_driver::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
	uvm_top.print_topology();
endfunction

task ahb_driver::reset_phase(uvm_phase phase);
  @(posedge vif.hclk);
  vif.hsel   <= 1'b0;
  vif.hwrite <= 1'b0;
  vif.haddr  <= 32'h0;
  vif.hprot  <= 1'b0;
  vif.hwdata <= 32'h0;
  vif.htrans <= 2'h0;
endtask

task ahb_driver::main_phase(uvm_phase phase);
  bit[31:0] haddr;
  bit[31:0] wdata;
  bit[31:0] rdata;

  phase.raise_objection(this);
  while(vif.hrst_n!==1) @(posedge vif.hclk);

  haddr = 32'h00000000;
  wdata = 32'h5a5a5a5a;
  vif.ahb_write(haddr, wdata);
  vif.ahb_read (haddr, rdata);

  haddr = 32'h00000004;
  wdata = 32'hffff0000;
  vif.ahb_write(haddr, wdata);
  vif.ahb_read (haddr, rdata);

  phase.drop_objection(this);
endtask: main_phase

// ***********************************************************************
// $Log: $
// $Revision $
