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
// FILENAME       : ahb_intf.sv
// Author         : yaopeng.kang
// LAST MODIFIED  : 2025-09-06 16:37
// ***********************************************************************
// DESCRIPTION    :
// ***********************************************************************
// $Revision: $
// $Id: $
// ***********************************************************************
interface ahb_intf(input bit hclk, 
                   input bit hrst_n);

  logic[31:0] haddr ;
  logic[3 :0] hprot ;
  logic[31:0] hrdata;
  logic[0 :0] hready;
  logic[1 :0] hresp ;
  logic[0 :0] hsel  ;
  logic[1 :0] htrans;
  logic[31:0] hwdata;
  logic[0 :0] hwrite;

  task reset();
    @(posedge hclk);
    hsel   <= 1'b0;
    hwrite <= 1'b0;
    haddr  <= 32'h0;
    hprot  <= 1'b0;
    hwdata <= 32'h0;
    htrans <= 2'h0;
  endtask   

  task ahb_write( input  logic[31:0] _haddr, 
                  input  logic[31:0] _hwdata);
    $display($realtime, ", start write, addr=%h, wdata=%0h", _haddr, _hwdata);
    @(posedge hclk);
    hsel   <= 1'b1;
    hwrite <= 1'b1;
    haddr  <= _haddr;
    hprot  <= 1'b0;
    htrans <= 2'h2;
    @(posedge hclk);
    hsel   <= 1'b0;
    hwrite <= 1'b0;
    hwdata <= _hwdata;
    while(hready==1'b0) begin
      @(posedge hclk);
    end
    $display($realtime, ", write done, addr=%h", _haddr);
  endtask

  task ahb_read( input  logic[31:0] _haddr, 
                 output logic[31:0] _hrdata);
    $display($realtime, ", start read, addr=%h", haddr);
    @(posedge hclk);
    hsel   <= 1'b1;
    hwrite <= 1'b0;
    haddr  <= _haddr;
    hprot  <= 1'b0;
    htrans <= 2'h2;
    @(posedge hclk);
    hsel <= 1'b0;
    while(hready==1'b0) begin
      @(posedge hclk);
    end
    @(posedge hclk);
    _hrdata = hrdata;
    $display($realtime, ", read done, addr=%h, rdata=%0h", _haddr, _hrdata);
  endtask
  

endinterface
// ***********************************************************************
// $Log: $
// $Revision $
