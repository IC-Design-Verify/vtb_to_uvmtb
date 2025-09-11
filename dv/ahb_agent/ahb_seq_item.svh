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
// FILENAME       : ahb_seq_item.svh
// Author         : yaopeng.kang
// LAST MODIFIED  : 2025-09-11 11:37
// ***********************************************************************
// DESCRIPTION    :
// ***********************************************************************
// $Revision: $
// $Id: $
// ***********************************************************************
class ahb_seq_item extends uvm_sequence_item;

  //------------------------------------------
  // Data Members (Outputs rand, inputs non-rand)
  //------------------------------------------
  rand bit[31:0] haddr;
  rand bit[31:0] hwdata;
       bit[31:0] hrdata;


  // UVM Factory Registration Macro
  //
  `uvm_object_utils_begin(ahb_seq_item)
    `uvm_field_int(haddr , UVM_ALL_ON)
    `uvm_field_int(hwdata, UVM_ALL_ON)
    `uvm_field_int(hrdata, UVM_ALL_ON)
  `uvm_object_utils_end

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
  extern function new(string name = "ahb_seq_item");

endclass: ahb_seq_item

function ahb_seq_item::new(string name = "ahb_seq_item");
  super.new(name);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: new
// ***********************************************************************
// $Log: $
// $Revision $
