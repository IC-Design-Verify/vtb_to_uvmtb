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
// LAST MODIFIED  : 2025-09-03 14:16
// ***********************************************************************
// DESCRIPTION    :
// ***********************************************************************
// $Revision: $
// $Id: $
// ***********************************************************************
module tb_top();

  logic       hclk    ;
  logic       hrst_n  ;

  logic[31:0] s_haddr ;
  logic[3 :0] s_hprot ;
  logic[31:0] s_hrdata;
  logic[0 :0] s_hready;
  logic[1 :0] s_hresp ;
  logic[0 :0] s_hsel  ;
  logic[1 :0] s_htrans;
  logic[31:0] s_hwdata;
  logic[0 :0] s_hwrite;


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
    s_hsel   = 1'b0;
    s_hwrite = 1'b0;
    s_haddr  = 32'h0;
    s_hprot  = 1'b0;
    s_hwdata = 32'h0;
    s_htrans = 2'h0;
  end

  initial begin
    #2000;
    $finish;
  end

  initial begin
    $fsdbDumpvars(0, tb_top, "+mda");
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
                  ,.s_haddr   (s_haddr )
                  ,.s_hprot   (s_hprot )
                  ,.s_hrdata  (s_hrdata)
                  ,.s_hready  (s_hready)
                  ,.s_hresp   (s_hresp )
                  ,.s_hsel    (s_hsel  )
                  ,.s_htrans  (s_htrans)
                  ,.s_hwdata  (s_hwdata)
                  ,.s_hwrite  (s_hwrite)
  );


endmodule
// ***********************************************************************
// $Log: $
// $Revision $
