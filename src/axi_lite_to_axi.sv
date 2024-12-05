// Copyright (c) 2014-2018 ETH Zurich, University of Bologna
//
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Authors:
// - Fabian Schuiki <fschuiki@iis.ee.ethz.ch>
// - Wolfgang Roenninger <wroennin@iis.ee.ethz.ch>
// - Andreas Kurth <akurth@iis.ee.ethz.ch>

/// An AXI4-Lite to AXI4 adapter.
module axi_lite_to_axi #(
  parameter int unsigned AxiDataWidth = 32'd0,
  // LITE AXI structs
  parameter type  req_lite_t = logic,
  parameter type resp_lite_t = logic,
  // FULL AXI structs
  parameter type   axi_req_t = logic,
  parameter type  axi_resp_t = logic
) (
  // Slave AXI LITE port
  input  req_lite_t       slv_req_lite_i,
  output resp_lite_t      slv_resp_lite_o,
  input  axi_pkg::cache_t slv_aw_cache_i,
  input  axi_pkg::cache_t slv_ar_cache_i,
  // Master AXI port
  output axi_req_t        mst_req_o,
  input  axi_resp_t       mst_resp_i
);
  localparam int unsigned AxiSize = axi_pkg::size_t'($unsigned($clog2(AxiDataWidth/8)));

  // request assign
  assign mst_req_o = '{
    aw: '{
      addr:  slv_req_lite_i.aw.addr,
      prot:  slv_req_lite_i.aw.prot,
      size:  AxiSize,
      burst: axi_pkg::BURST_FIXED,
      cache: slv_aw_cache_i,
      default: '0
    },
    aw_valid: slv_req_lite_i.aw_valid,
    w: '{
      data: slv_req_lite_i.w.data,
      strb: slv_req_lite_i.w.strb,
      last: 1'b1,
      default: '0
    },
    w_valid: slv_req_lite_i.w_valid,
    b_ready: slv_req_lite_i.b_ready,
    ar: '{
      addr:  slv_req_lite_i.ar.addr,
      prot:  slv_req_lite_i.ar.prot,
      size:  AxiSize,
      burst: axi_pkg::BURST_FIXED,
      cache: slv_ar_cache_i,
      default: '0
    },
    ar_valid: slv_req_lite_i.ar_valid,
    r_ready:  slv_req_lite_i.r_ready,
    default:   '0
  };
  // response assign
  assign slv_resp_lite_o = '{
    aw_ready: mst_resp_i.aw_ready,
    w_ready:  mst_resp_i.w_ready,
    b: '{
      resp: mst_resp_i.b.resp,
      default: '0
    },
    b_valid:  mst_resp_i.b_valid,
    ar_ready: mst_resp_i.ar_ready,
    r: '{
      data: mst_resp_i.r.data,
      resp: mst_resp_i.r.resp,
      default: '0
    },
    r_valid: mst_resp_i.r_valid,
    default: '0
  };

  // pragma translate_off
  `ifndef VERILATOR
  initial begin
    assert (AxiDataWidth > 0) else $fatal(1, "Data width must be non-zero!");
  end
  `endif
  // pragma translate_on
endmodule

module axi_lite_to_axi_simple #(
  parameter int unsigned AXI_ADDR_WIDTH = 0,
  parameter int unsigned AXI_DATA_WIDTH = 0,
  parameter int unsigned AXI_ID_WIDTH   = 0,
  parameter int unsigned AXI_STRB_WIDTH = AXI_DATA_WIDTH / 8,
  parameter int unsigned AXI_USER_WIDTH = 0
) (
  /*AUTOINOUTMODPORT("AXI_LITE", "Slave", ".*", "in_")*/
  // Beginning of automatic in/out/inouts (from modport)
  output		in_aw_ready,
  output		in_w_ready,
  output [1:0]		in_b_resp,
  output		in_b_valid,
  output		in_ar_ready,
  output [AXI_DATA_WIDTH-1:0] in_r_data,
  output [1:0]		in_r_resp,
  output		in_r_valid,
  input [AXI_ADDR_WIDTH-1:0] in_aw_addr,
  input [2:0]		in_aw_prot,
  input			in_aw_valid,
  input [AXI_DATA_WIDTH-1:0] in_w_data,
  input [AXI_STRB_WIDTH-1:0] in_w_strb,
  input			in_w_valid,
  input			in_b_ready,
  input [AXI_ADDR_WIDTH-1:0] in_ar_addr,
  input [2:0]		in_ar_prot,
  input			in_ar_valid,
  input			in_r_ready,
  // End of automatics
  /*AUTOINOUTMODPORT("AXI_BUS", "Master", ".*", "out_")*/
  // Beginning of automatic in/out/inouts (from modport)
  output [AXI_ID_WIDTH-1:0] out_aw_id,
  output [AXI_ADDR_WIDTH-1:0] out_aw_addr,
  output [7:0]		out_aw_len,
  output [2:0]		out_aw_size,
  output [1:0]		out_aw_burst,
  output		out_aw_lock,
  output [3:0]		out_aw_cache,
  output [2:0]		out_aw_prot,
  output [3:0]		out_aw_qos,
  output [3:0]		out_aw_region,
  output [AXI_USER_WIDTH-1:0] out_aw_user,
  output		out_aw_valid,
  output [AXI_DATA_WIDTH-1:0] out_w_data,
  output [AXI_STRB_WIDTH-1:0] out_w_strb,
  output		out_w_last,
  output [AXI_USER_WIDTH-1:0] out_w_user,
  output		out_w_valid,
  output		out_b_ready,
  output [AXI_ID_WIDTH-1:0] out_ar_id,
  output [AXI_ADDR_WIDTH-1:0] out_ar_addr,
  output [7:0]		out_ar_len,
  output [2:0]		out_ar_size,
  output [1:0]		out_ar_burst,
  output		out_ar_lock,
  output [3:0]		out_ar_cache,
  output [2:0]		out_ar_prot,
  output [3:0]		out_ar_qos,
  output [3:0]		out_ar_region,
  output [AXI_USER_WIDTH-1:0] out_ar_user,
  output		out_ar_valid,
  output		out_r_ready,
  input			out_aw_ready,
  input			out_w_ready,
  input [AXI_ID_WIDTH-1:0] out_b_id,
  input [1:0]		out_b_resp,
  input [AXI_USER_WIDTH-1:0] out_b_user,
  input			out_b_valid,
  input			out_ar_ready,
  input [AXI_ID_WIDTH-1:0] out_r_id,
  input [AXI_DATA_WIDTH-1:0] out_r_data,
  input [1:0]		out_r_resp,
  input			out_r_last,
  input [AXI_USER_WIDTH-1:0] out_r_user,
  input			out_r_valid
  // End of automatics
);

AXI_LITE#(
  .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
  .AXI_DATA_WIDTH(AXI_DATA_WIDTH)
) lite();
/*AUTOASSIGNMODPORT("AXI_LITE", "Slave", "lite", ".*", "in_")*/
// Beginning of automatic assignments from modport
assign in_ar_ready = lite.ar_ready;
assign in_aw_ready = lite.aw_ready;
assign in_b_resp = lite.b_resp;
assign in_b_valid = lite.b_valid;
assign in_r_data = lite.r_data;
assign in_r_resp = lite.r_resp;
assign in_r_valid = lite.r_valid;
assign in_w_ready = lite.w_ready;
assign lite.ar_addr = in_ar_addr;
assign lite.ar_prot = in_ar_prot;
assign lite.ar_valid = in_ar_valid;
assign lite.aw_addr = in_aw_addr;
assign lite.aw_prot = in_aw_prot;
assign lite.aw_valid = in_aw_valid;
assign lite.b_ready = in_b_ready;
assign lite.r_ready = in_r_ready;
assign lite.w_data = in_w_data;
assign lite.w_strb = in_w_strb;
assign lite.w_valid = in_w_valid;
// End of automatics

AXI_BUS#(
  .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
  .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
  .AXI_ID_WIDTH(AXI_ID_WIDTH),
  .AXI_USER_WIDTH(0)
) full();
/*AUTOASSIGNMODPORT("AXI_BUS", "Master", "full", ".*", "out_")*/
// Beginning of automatic assignments from modport
assign out_ar_addr = full.ar_addr;
assign out_ar_burst = full.ar_burst;
assign out_ar_cache = full.ar_cache;
assign out_ar_id = full.ar_id;
assign out_ar_len = full.ar_len;
assign out_ar_lock = full.ar_lock;
assign out_ar_prot = full.ar_prot;
assign out_ar_qos = full.ar_qos;
assign out_ar_region = full.ar_region;
assign out_ar_size = full.ar_size;
assign out_ar_user = full.ar_user;
assign out_ar_valid = full.ar_valid;
assign out_aw_addr = full.aw_addr;
assign out_aw_burst = full.aw_burst;
assign out_aw_cache = full.aw_cache;
assign out_aw_id = full.aw_id;
assign out_aw_len = full.aw_len;
assign out_aw_lock = full.aw_lock;
assign out_aw_prot = full.aw_prot;
assign out_aw_qos = full.aw_qos;
assign out_aw_region = full.aw_region;
assign out_aw_size = full.aw_size;
assign out_aw_user = full.aw_user;
assign out_aw_valid = full.aw_valid;
assign out_b_ready = full.b_ready;
assign out_r_ready = full.r_ready;
assign out_w_data = full.w_data;
assign out_w_last = full.w_last;
assign out_w_strb = full.w_strb;
assign out_w_user = full.w_user;
assign out_w_valid = full.w_valid;
assign full.ar_ready = out_ar_ready;
assign full.aw_ready = out_aw_ready;
assign full.b_id = out_b_id;
assign full.b_resp = out_b_resp;
assign full.b_user = out_b_user;
assign full.b_valid = out_b_valid;
assign full.r_data = out_r_data;
assign full.r_id = out_r_id;
assign full.r_last = out_r_last;
assign full.r_resp = out_r_resp;
assign full.r_user = out_r_user;
assign full.r_valid = out_r_valid;
assign full.w_ready = out_w_ready;
// End of automatics

axi_lite_to_axi_intf #(
  .AXI_DATA_WIDTH(AXI_DATA_WIDTH)
) intf (
  .in(lite),
  .out(full)
);

endmodule

module axi_lite_to_axi_intf #(
  parameter int unsigned AXI_DATA_WIDTH = 32'd0
) (
  AXI_LITE.Slave  in,
  input axi_pkg::cache_t slv_aw_cache_i,
  input axi_pkg::cache_t slv_ar_cache_i,
  AXI_BUS.Master  out
);
  localparam int unsigned AxiSize = axi_pkg::size_t'($unsigned($clog2(AXI_DATA_WIDTH/8)));

// pragma translate_off
  initial begin
    assert(in.AXI_ADDR_WIDTH == out.AXI_ADDR_WIDTH);
    assert(in.AXI_DATA_WIDTH == out.AXI_DATA_WIDTH);
    assert(AXI_DATA_WIDTH    == out.AXI_DATA_WIDTH);
  end
// pragma translate_on

  assign out.aw_id     = '0;
  assign out.aw_addr   = in.aw_addr;
  assign out.aw_len    = '0;
  assign out.aw_size   = AxiSize;
  assign out.aw_burst  = axi_pkg::BURST_FIXED;
  assign out.aw_lock   = '0;
  assign out.aw_cache  = slv_aw_cache_i;
  assign out.aw_prot   = '0;
  assign out.aw_qos    = '0;
  assign out.aw_region = '0;
  assign out.aw_atop   = '0;
  assign out.aw_user   = '0;
  assign out.aw_valid  = in.aw_valid;
  assign in.aw_ready   = out.aw_ready;

  assign out.w_data    = in.w_data;
  assign out.w_strb    = in.w_strb;
  assign out.w_last    = '1;
  assign out.w_user    = '0;
  assign out.w_valid   = in.w_valid;
  assign in.w_ready    = out.w_ready;

  assign in.b_resp     = out.b_resp;
  assign in.b_valid    = out.b_valid;
  assign out.b_ready   = in.b_ready;

  assign out.ar_id     = '0;
  assign out.ar_addr   = in.ar_addr;
  assign out.ar_len    = '0;
  assign out.ar_size   = AxiSize;
  assign out.ar_burst  = axi_pkg::BURST_FIXED;
  assign out.ar_lock   = '0;
  assign out.ar_cache  = slv_ar_cache_i;
  assign out.ar_prot   = '0;
  assign out.ar_qos    = '0;
  assign out.ar_region = '0;
  assign out.ar_user   = '0;
  assign out.ar_valid  = in.ar_valid;
  assign in.ar_ready   = out.ar_ready;

  assign in.r_data     = out.r_data;
  assign in.r_resp     = out.r_resp;
  assign in.r_valid    = out.r_valid;
  assign out.r_ready   = in.r_ready;

endmodule
