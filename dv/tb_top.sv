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
    ahb_if.hsel   = 1'b0;
    ahb_if.hwrite = 1'b0;
    ahb_if.haddr  = 32'h0;
    ahb_if.hprot  = 1'b0;
    ahb_if.hwdata = 32'h0;
    ahb_if.htrans = 2'h0;
  end

  initial begin
    #2000;
    $finish;
  end

  initial begin
    $fsdbDumpvars(0, tb_top, "+mda");
  end

  task ahb_write( input  logic[31:0] haddr, 
                  input  logic[31:0] hwdata);
    $display($realtime, ", start write, addr=%h, wdata=%0h", haddr, hwdata);
    @(posedge hclk);
    ahb_if.hsel   <= 1'b1;
    ahb_if.hwrite <= 1'b1;
    ahb_if.haddr  <= haddr;
    ahb_if.hprot  <= 1'b0;
    ahb_if.htrans <= 2'h2;
    @(posedge hclk);
    ahb_if.hsel   <= 1'b0;
    ahb_if.hwrite <= 1'b0;
    ahb_if.hwdata <= hwdata;
    while(ahb_if.hready==1'b0) begin
      @(posedge hclk);
    end
    $display($realtime, ", write done, addr=%h", haddr);
  endtask

  task ahb_read( input  logic[31:0] haddr, 
                 output logic[31:0] hrdata);
    $display($realtime, ", start read, addr=%h", haddr);
    @(posedge hclk);
    ahb_if.hsel   <= 1'b1;
    ahb_if.hwrite <= 1'b0;
    ahb_if.haddr  <= haddr;
    ahb_if.hprot  <= 1'b0;
    ahb_if.htrans <= 2'h2;
    @(posedge hclk);
    ahb_if.hsel <= 1'b0;
    while(ahb_if.hready==1'b0) begin
      @(posedge hclk);
    end
    @(posedge hclk);
    hrdata = ahb_if.hrdata;
    $display($realtime, ", read done, addr=%h, rdata=%0h", haddr, hrdata);
  endtask

  function bit check_data(input bit[31:0] golden_data, 
                          input bit[31:0] actual_data);
    if (golden_data == actual_data)
      return 1'b1;
    else
      return 1'b0;
  endfunction

  initial begin
    bit[31:0] haddr;
    bit[31:0] wdata;
    bit[31:0] rdata;
    wait(hrst_n==1);
    haddr = 32'h00000000;
    wdata = 32'h5a5a5a5a;
    ahb_write(haddr, wdata);
    ahb_read (haddr, rdata);
    if(!check_data(wdata, rdata)) begin
      $error($sformatf("address 32'h<%0h> has wrong read data 32'h%0h, expect data is 32'h%0h", haddr, rdata, wdata));
    end
    else begin
      $display($sformatf("address 32'h<%0h> write/read passed!", haddr));
    end

    haddr = 32'h00000004;
    wdata = 32'hffff0000;
    ahb_write(haddr, wdata);
    ahb_read (haddr, rdata);
    if(!check_data(wdata, rdata)) begin
      $error($sformatf("address 32'h<%0h> has wrong read data 32'h%0h, expect data is 32'h%0h", haddr, rdata, wdata));
    end
    else begin
      $display($sformatf("address 32'h<%0h> write/read passed!", haddr));
    end
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
