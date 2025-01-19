`include "axi/assign.svh"
`include "axi/port.svh"

module axi_xbar_simple #(
  parameter int unsigned NUM_MASTERS = 1,
  parameter int unsigned NUM_SLAVES  = 1,
  parameter int unsigned AXI_ADDR_WIDTH = 0,
  parameter int unsigned AXI_DATA_WIDTH = 0,
  parameter int unsigned AXI_MASTER_ID_WIDTH = 0,
  parameter int unsigned AXI_SLAVE_ID_WIDTH = 0,
  parameter int unsigned AXI_STRB_WIDTH = AXI_DATA_WIDTH / 8,
  parameter int unsigned AXI_USER_WIDTH = 0,
  parameter int unsigned NUM_ADDR_RULES = NUM_MASTERS
) (
  input  logic                                                      clk_i,
  input  logic                                                      rst_ni,
  input  axi_pkg::xbar_rule_32_t [NUM_ADDR_RULES-1:0]               addr_map_i,
  `AXI_S_PORT(in, [AXI_ADDR_WIDTH-1:0], [AXI_DATA_WIDTH-1:0], [AXI_STRB_WIDTH-1:0], [AXI_SLAVE_ID_WIDTH-1:0], [AXI_USER_WIDTH-1:0], [AXI_USER_WIDTH-1:0], [AXI_USER_WIDTH-1:0], [AXI_USER_WIDTH-1:0], [AXI_USER_WIDTH-1:0], [NUM_SLAVES]),
  `AXI_M_PORT(out, [AXI_ADDR_WIDTH-1:0], [AXI_DATA_WIDTH-1:0], [AXI_STRB_WIDTH-1:0], [AXI_MASTER_ID_WIDTH-1:0], [AXI_USER_WIDTH-1:0], [AXI_USER_WIDTH-1:0], [AXI_USER_WIDTH-1:0], [AXI_USER_WIDTH-1:0], [AXI_USER_WIDTH-1:0], [NUM_MASTERS])
);
  
localparam axi_pkg::xbar_cfg_t xbar_cfg = '{
  NoSlvPorts:         NUM_SLAVES,
  NoMstPorts:         NUM_MASTERS,
  MaxMstTrans:        10,
  MaxSlvTrans:        6,
  FallThrough:        1'b0,
  LatencyMode:        axi_pkg::CUT_ALL_AX,
  PipelineStages:     1,
  AxiIdWidthSlvPorts: AXI_SLAVE_ID_WIDTH,
  AxiIdUsedSlvPorts:  AXI_SLAVE_ID_WIDTH,
  UniqueIds:          0,
  AxiAddrWidth:       AXI_ADDR_WIDTH,
  AxiDataWidth:       AXI_DATA_WIDTH,
  NoAddrRules:        NUM_ADDR_RULES
};

AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH      ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH   ( AXI_MASTER_ID_WIDTH ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH      )
) master [NUM_MASTERS-1:0] ();

AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH     ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH     ),
    .AXI_ID_WIDTH   ( AXI_SLAVE_ID_WIDTH ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH     )
) slave [NUM_SLAVES-1:0] ();

axi_xbar_intf #(
  .AXI_USER_WIDTH ( 0  ),
  .Cfg            ( xbar_cfg        ),
  .ATOPS          ( 0               ),
  .rule_t         ( axi_pkg::xbar_rule_32_t   )
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
        `AXI_ASSIGN_MASTER_TO_SIMPLE(out, master[i], [i])
    end
    for (j = 0; j < NUM_SLAVES; j = j + 1) begin
        `AXI_ASSIGN_SLAVE_TO_SIMPLE(in, slave[j], [j])
    end
endgenerate

endmodule