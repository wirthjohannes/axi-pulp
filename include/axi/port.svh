// Copyright (c) 2014-2023 ETH Zurich, University of Bologna
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
// - Thomas Benz <tbenz@iis.ee.ethz.ch>

// Macros to add AXI ports

`ifndef AXI_PORT_SVH_
`define AXI_PORT_SVH_

////////////////////////////////////////////////////////////////////////////////////////////////////
// Macros creating flat AXI ports
// `AXI_M_PORT(__name, __addr_t, __data_t, __strb_t, __id_t, __aw_user_t, __w_user_t, __b_user_t, __ar_user_t, __r_user_t)
`define AXI_M_PORT(__name, __addr_t, __data_t, __strb_t, __id_t, __aw_user_t, __w_user_t, __b_user_t, __ar_user_t, __r_user_t, __more) \
  output logic             m_axi_``__name``_awvalid``__more``,   \
  output __id_t            m_axi_``__name``_awid``__more``,      \
  output __addr_t          m_axi_``__name``_awaddr``__more``,    \
  output axi_pkg::len_t    m_axi_``__name``_awlen``__more``,     \
  output axi_pkg::size_t   m_axi_``__name``_awsize``__more``,    \
  output axi_pkg::burst_t  m_axi_``__name``_awburst``__more``,   \
  output logic             m_axi_``__name``_awlock``__more``,    \
  output axi_pkg::cache_t  m_axi_``__name``_awcache``__more``,   \
  output axi_pkg::prot_t   m_axi_``__name``_awprot``__more``,    \
  output axi_pkg::qos_t    m_axi_``__name``_awqos``__more``,     \
  output axi_pkg::region_t m_axi_``__name``_awregion``__more``,  \
  output __aw_user_t       m_axi_``__name``_awuser``__more``,    \
  output logic             m_axi_``__name``_wvalid``__more``,    \
  output __data_t          m_axi_``__name``_wdata``__more``,     \
  output __strb_t          m_axi_``__name``_wstrb``__more``,     \
  output logic             m_axi_``__name``_wlast``__more``,     \
  output __w_user_t        m_axi_``__name``_wuser``__more``,     \
  output logic             m_axi_``__name``_bready``__more``,    \
  output logic             m_axi_``__name``_arvalid``__more``,   \
  output __id_t            m_axi_``__name``_arid``__more``,      \
  output __addr_t          m_axi_``__name``_araddr``__more``,    \
  output axi_pkg::len_t    m_axi_``__name``_arlen``__more``,     \
  output axi_pkg::size_t   m_axi_``__name``_arsize``__more``,    \
  output axi_pkg::burst_t  m_axi_``__name``_arburst``__more``,   \
  output logic             m_axi_``__name``_arlock``__more``,    \
  output axi_pkg::cache_t  m_axi_``__name``_arcache``__more``,   \
  output axi_pkg::prot_t   m_axi_``__name``_arprot``__more``,    \
  output axi_pkg::qos_t    m_axi_``__name``_arqos``__more``,     \
  output axi_pkg::region_t m_axi_``__name``_arregion``__more``,  \
  output __ar_user_t       m_axi_``__name``_aruser``__more``,    \
  output logic             m_axi_``__name``_rready``__more``,    \
  input  logic             m_axi_``__name``_awready``__more``,   \
  input  logic             m_axi_``__name``_arready``__more``,   \
  input  logic             m_axi_``__name``_wready``__more``,    \
  input  logic             m_axi_``__name``_bvalid``__more``,    \
  input  __id_t            m_axi_``__name``_bid``__more``,       \
  input  axi_pkg::resp_t   m_axi_``__name``_bresp``__more``,     \
  input  __b_user_t        m_axi_``__name``_buser``__more``,     \
  input  logic             m_axi_``__name``_rvalid``__more``,    \
  input  __id_t            m_axi_``__name``_rid``__more``,       \
  input  __data_t          m_axi_``__name``_rdata``__more``,     \
  input  axi_pkg::resp_t   m_axi_``__name``_rresp``__more``,     \
  input  logic             m_axi_``__name``_rlast``__more``,     \
  input  __r_user_t        m_axi_``__name``_ruser``__more``      \
////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////
// Macros creating flat AXI ports
// `AXI_S_PORT(__name, __addr_t, __data_t, __strb_t, __id_t, __aw_user_t, __w_user_t, __b_user_t, __ar_user_t, __r_user_t)
`define AXI_S_PORT(__name, __addr_t, __data_t, __strb_t, __id_t, __aw_user_t, __w_user_t, __b_user_t, __ar_user_t, __r_user_t, __more) \
  input  logic             s_axi_``__name``_awvalid``__more``,   \
  input  __id_t            s_axi_``__name``_awid``__more``,      \
  input  __addr_t          s_axi_``__name``_awaddr``__more``,    \
  input  axi_pkg::len_t    s_axi_``__name``_awlen``__more``,     \
  input  axi_pkg::size_t   s_axi_``__name``_awsize``__more``,    \
  input  axi_pkg::burst_t  s_axi_``__name``_awburst``__more``,   \
  input  logic             s_axi_``__name``_awlock``__more``,    \
  input  axi_pkg::cache_t  s_axi_``__name``_awcache``__more``,   \
  input  axi_pkg::prot_t   s_axi_``__name``_awprot``__more``,    \
  input  axi_pkg::qos_t    s_axi_``__name``_awqos``__more``,     \
  input  axi_pkg::region_t s_axi_``__name``_awregion``__more``,  \
  input  __aw_user_t       s_axi_``__name``_awuser``__more``,    \
  input  logic             s_axi_``__name``_wvalid``__more``,    \
  input  __data_t          s_axi_``__name``_wdata``__more``,     \
  input  __strb_t          s_axi_``__name``_wstrb``__more``,     \
  input  logic             s_axi_``__name``_wlast``__more``,     \
  input  __w_user_t        s_axi_``__name``_wuser``__more``,     \
  input  logic             s_axi_``__name``_bready``__more``,    \
  input  logic             s_axi_``__name``_arvalid``__more``,   \
  input  __id_t            s_axi_``__name``_arid``__more``,      \
  input  __addr_t          s_axi_``__name``_araddr``__more``,    \
  input  axi_pkg::len_t    s_axi_``__name``_arlen``__more``,     \
  input  axi_pkg::size_t   s_axi_``__name``_arsize``__more``,    \
  input  axi_pkg::burst_t  s_axi_``__name``_arburst``__more``,   \
  input  logic             s_axi_``__name``_arlock``__more``,    \
  input  axi_pkg::cache_t  s_axi_``__name``_arcache``__more``,   \
  input  axi_pkg::prot_t   s_axi_``__name``_arprot``__more``,    \
  input  axi_pkg::qos_t    s_axi_``__name``_arqos``__more``,     \
  input  axi_pkg::region_t s_axi_``__name``_arregion``__more``,  \
  input  __ar_user_t       s_axi_``__name``_aruser``__more``,    \
  input  logic             s_axi_``__name``_rready``__more``,    \
  output logic             s_axi_``__name``_awready``__more``,   \
  output logic             s_axi_``__name``_arready``__more``,   \
  output logic             s_axi_``__name``_wready``__more``,    \
  output logic             s_axi_``__name``_bvalid``__more``,    \
  output __id_t            s_axi_``__name``_bid``__more``,       \
  output axi_pkg::resp_t   s_axi_``__name``_bresp``__more``,     \
  output __b_user_t        s_axi_``__name``_buser``__more``,     \
  output logic             s_axi_``__name``_rvalid``__more``,    \
  output __id_t            s_axi_``__name``_rid``__more``,       \
  output __data_t          s_axi_``__name``_rdata``__more``,     \
  output axi_pkg::resp_t   s_axi_``__name``_rresp``__more``,     \
  output logic             s_axi_``__name``_rlast``__more``,     \
  output __r_user_t        s_axi_``__name``_ruser``__more``      \
////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////
// Macros creating flat AXILite ports
// `AXILITE_M_PORT(__name, __addr_t, __data_t, __strb_t)
`define AXILITE_M_PORT(__name, __addr_t, __data_t, __strb_t, __more) \
  output logic             m_axi_``__name``_awvalid``__more``,   \
  output __addr_t          m_axi_``__name``_awaddr``__more``,    \
  output axi_pkg::prot_t   m_axi_``__name``_awprot``__more``,    \
  output logic             m_axi_``__name``_wvalid``__more``,    \
  output __data_t          m_axi_``__name``_wdata``__more``,     \
  output __strb_t          m_axi_``__name``_wstrb``__more``,     \
  output logic             m_axi_``__name``_bready``__more``,    \
  output logic             m_axi_``__name``_arvalid``__more``,   \
  output __addr_t          m_axi_``__name``_araddr``__more``,    \
  output axi_pkg::prot_t   m_axi_``__name``_arprot``__more``,    \
  output logic             m_axi_``__name``_rready``__more``,    \
  input  logic             m_axi_``__name``_awready``__more``,   \
  input  logic             m_axi_``__name``_arready``__more``,   \
  input  logic             m_axi_``__name``_wready``__more``,    \
  input  logic             m_axi_``__name``_bvalid``__more``,    \
  input  axi_pkg::resp_t   m_axi_``__name``_bresp``__more``,     \
  input  logic             m_axi_``__name``_rvalid``__more``,    \
  input  __data_t          m_axi_``__name``_rdata``__more``,     \
  input  axi_pkg::resp_t   m_axi_``__name``_rresp``__more``      \
////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////
// Macros creating flat AXILITE ports
// `AXI_S_PORT(__name, __addr_t, __data_t, __strb_t)
`define AXILITE_S_PORT(__name, __addr_t, __data_t, __strb_t, __more) \
  input  logic             s_axi_``__name``_awvalid``__more``,   \
  input  __addr_t          s_axi_``__name``_awaddr``__more``,    \
  input  axi_pkg::prot_t   s_axi_``__name``_awprot``__more``,    \
  input  logic             s_axi_``__name``_wvalid``__more``,    \
  input  __data_t          s_axi_``__name``_wdata``__more``,     \
  input  __strb_t          s_axi_``__name``_wstrb``__more``,     \
  input  logic             s_axi_``__name``_bready``__more``,    \
  input  logic             s_axi_``__name``_arvalid``__more``,   \
  input  __addr_t          s_axi_``__name``_araddr``__more``,    \
  input  axi_pkg::prot_t   s_axi_``__name``_arprot``__more``,    \
  input  logic             s_axi_``__name``_rready``__more``,    \
  output logic             s_axi_``__name``_awready``__more``,   \
  output logic             s_axi_``__name``_arready``__more``,   \
  output logic             s_axi_``__name``_wready``__more``,    \
  output logic             s_axi_``__name``_bvalid``__more``,    \
  output axi_pkg::resp_t   s_axi_``__name``_bresp``__more``,     \
  output logic             s_axi_``__name``_rvalid``__more``,    \
  output __data_t          s_axi_``__name``_rdata``__more``,     \
  output axi_pkg::resp_t   s_axi_``__name``_rresp``__more``      \
////////////////////////////////////////////////////////////////////////////////////////////////////

`endif
