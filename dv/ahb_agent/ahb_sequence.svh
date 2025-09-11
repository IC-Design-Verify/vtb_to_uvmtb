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
// FILENAME       : ahb_sequence.svh
// Author         : yaopeng.kang
// LAST MODIFIED  : 2025-09-11 11:39
// ***********************************************************************
// DESCRIPTION    :
// ***********************************************************************
// $Revision: $
// $Id: $
// ***********************************************************************
class ahb_seq_base extends uvm_sequence #(ahb_seq_item);

  // UVM Factory Registration Macro
  //
  `uvm_object_utils_begin(ahb_seq_base)
  `uvm_object_utils_end

  //------------------------------------------
  // Data Members
  //------------------------------------------
  rand bit[31:0] haddr;
  rand bit[31:0] hwdata;

  //------------------------------------------
  // Constraints
  //------------------------------------------
  constraint valid{
  }

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name = "ahb_seq_base");
  extern function void pre_randomize();
  extern task pre_body();
  extern task post_body();

endclass: ahb_seq_base

function ahb_seq_base::new(string name = "ahb_seq_base");
  super.new(name);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: new

function void ahb_seq_base::pre_randomize();
  
endfunction

task ahb_seq_base::pre_body();
  uvm_objection objection;
  uvm_phase starting_phase = get_starting_phase();
  if(starting_phase != null) begin
      starting_phase.raise_objection(this);
  end
  objection = starting_phase.get_objection();
  objection.set_drain_time(this,10ns);
endtask

task ahb_seq_base::post_body();
  uvm_phase starting_phase = get_starting_phase();
  if(get_parent_sequence() == null) begin 
    starting_phase.drop_objection(this);
  end
endtask


class ahb_seq extends ahb_seq_base;

  // UVM Factory Registration Macro
  //
  `uvm_object_utils(ahb_seq)

  //------------------------------------------
  // Data Members
  //------------------------------------------

  //------------------------------------------
  // Constraints
  //------------------------------------------
  constraint valid{
    haddr % 4 == 0;
  }

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name = "ahb_seq");
  extern virtual task body();

endclass: ahb_seq

function ahb_seq::new(string name = "ahb_seq");
  super.new(name);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: new

task ahb_seq::body();
    
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
  `uvm_do_with(req, {req.haddr  == local::haddr;
                     req.hwdata == local::hwdata;
                    })
endtask
// ***********************************************************************
// $Log: $
// $Revision $
