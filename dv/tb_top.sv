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
// FILENAME       : tb_top.sv
// Author         : yaopeng.kang
// LAST MODIFIED  : 2025-09-03 19:26
// ***********************************************************************
// DESCRIPTION    :
// ***********************************************************************
// $Revision: $
// $Id: $
// ***********************************************************************
module tb_top();
  import uvm_pkg::*;
  import ahb_agent_pkg::*;

  logic       hclk    ;
  logic       hrst_n  ;

  ahb_intf ahb_if(hclk, hrst_n);


  initial begin
    hclk = 0;
    forever #10 hclk = ~hclk;
  end

  initial begin
    hrst_n = 0;
    #200;
    hrst_n = 1;
  end

  initial begin
    $fsdbDumpvars(0, tb_top, "+mda");
  end

  initial begin
    uvm_config_db#(virtual ahb_intf)::set(uvm_root::get(), "", "vif", ahb_if);
    run_test("ahb_agent");
  end

  // DUT instance
  dmac_top u_dut(
                   .hclk      (hclk  )
                  ,.hrst_n    (hrst_n)
                  //,.m_haddr   ()
                  //,.m_hburst  ()
                  //,.m_hbusreq ()
                  //,.m_hgrant  ()
                  //,.m_hlock   ()
                  //,.m_hprot   ()
                  //,.m_hrdata  ()
                  //,.m_hready  ()
                  //,.m_hresp   ()
                  //,.m_hsize   ()
                  //,.m_htrans  ()
                  //,.m_hwdata  ()
                  //,.m_hwrite  ()
                  ,.s_haddr   (ahb_if.haddr )
                  ,.s_hprot   (ahb_if.hprot )
                  ,.s_hrdata  (ahb_if.hrdata)
                  ,.s_hready  (ahb_if.hready)
                  ,.s_hresp   (ahb_if.hresp )
                  ,.s_hsel    (ahb_if.hsel  )
                  ,.s_htrans  (ahb_if.htrans)
                  ,.s_hwdata  (ahb_if.hwdata)
                  ,.s_hwrite  (ahb_if.hwrite)
  );


endmodule
// ***********************************************************************
// $Log: $
// $Revision $
