`include "axi/assign.svh"
`include "axi/port.svh"

module axi_lite_xbar_simple #(
  parameter int unsigned NUM_MASTERS = 1,
  parameter int unsigned NUM_SLAVES  = 1,
  parameter int unsigned AXI_ADDR_WIDTH = 0,
  parameter int unsigned AXI_DATA_WIDTH = 0,
  parameter int unsigned AXI_STRB_WIDTH = AXI_DATA_WIDTH / 8,
  parameter int unsigned NUM_ADDR_RULES = NUM_MASTERS
) (
  input  logic                                                      clk_i,
  input  logic                                                      rst_ni,
  input  axi_pkg::xbar_rule_32_t [NUM_ADDR_RULES-1:0]               addr_map_i,
  `AXILITE_S_PORT(in, [AXI_ADDR_WIDTH-1:0], [AXI_DATA_WIDTH-1:0], [AXI_STRB_WIDTH-1:0], [NUM_SLAVES]),
  `AXILITE_M_PORT(out, [AXI_ADDR_WIDTH-1:0], [AXI_DATA_WIDTH-1:0], [AXI_STRB_WIDTH-1:0], [NUM_MASTERS])
);
  
localparam axi_pkg::xbar_cfg_t xbar_cfg = '{
  NoSlvPorts:         NUM_SLAVES,
  NoMstPorts:         NUM_MASTERS,
  MaxMstTrans:        10,
  MaxSlvTrans:        6,
  FallThrough:        1'b0,
  LatencyMode:        axi_pkg::CUT_ALL_AX,
  AxiAddrWidth:       AXI_ADDR_WIDTH,
  AxiDataWidth:       AXI_DATA_WIDTH,
  NoAddrRules:        NUM_ADDR_RULES,
  default:            '0
};

AXI_LITE #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH      )
) master [NUM_MASTERS-1:0] ();

AXI_LITE #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH     )
) slave [NUM_SLAVES-1:0] ();

axi_lite_xbar_intf #(
  .Cfg            ( xbar_cfg        ),
  .rule_t         ( axi_pkg::xbar_rule_32_t          )
) i_xbar_dut (
  .clk_i                  ( clk_i     ),
  .rst_ni                 ( rst_ni   ),
  .test_i                 ( 1'b0    ),
  .slv_ports              ( slave  ),
  .mst_ports              ( master   ),
  .addr_map_i             ( addr_map_i ),
  .en_default_mst_port_i  ( '0      ),
  .default_mst_port_i     ( '0      )
);

generate
    genvar i;
    genvar j;
    for (i = 0; i < NUM_MASTERS; i = i + 1) begin
        `AXILITE_ASSIGN_MASTER_TO_SIMPLE(out, master[i], [i])
    end
    for (j = 0; j < NUM_SLAVES; j = j + 1) begin
        `AXILITE_ASSIGN_SLAVE_TO_SIMPLE(in, slave[j], [j])
    end
endgenerate

endmodule