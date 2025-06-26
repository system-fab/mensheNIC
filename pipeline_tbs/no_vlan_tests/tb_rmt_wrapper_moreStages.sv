
`timescale 1ns / 1ps

module tb_rmt_wrapper_moreStages #(
    // Slave AXI parameters
	parameter C_S_AXI_DATA_WIDTH = 32,
	parameter C_S_AXI_ADDR_WIDTH = 12,
	parameter C_BASEADDR = 32'h80000000,
	// AXI Stream parameters
	// Slave
	parameter C_S_AXIS_DATA_WIDTH = 512,
	parameter C_S_AXIS_TUSER_WIDTH = 128,
	// Master
	parameter C_M_AXIS_DATA_WIDTH = 512,
	// self-defined
	parameter PHV_ADDR_WIDTH = 4
)();

reg                                 clk;
reg                                 aresetn;

reg [C_S_AXIS_DATA_WIDTH-1:0]		s_axis_tdata;
reg [((C_S_AXIS_DATA_WIDTH/8))-1:0]	s_axis_tkeep;
reg [C_S_AXIS_TUSER_WIDTH-1:0]		s_axis_tuser;
reg									s_axis_tvalid;
wire								s_axis_tready;
reg									s_axis_tlast;

wire [C_S_AXIS_DATA_WIDTH-1:0]		    m_axis_tdata;
wire [((C_S_AXIS_DATA_WIDTH/8))-1:0]    m_axis_tkeep;
wire [C_S_AXIS_TUSER_WIDTH-1:0]		    m_axis_tuser;
wire								    m_axis_tvalid;
reg										m_axis_tready;
wire									m_axis_tlast;


localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_STAGES= 512'h00000000100000000c000000040000000100000000004c4d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;
//clk signal
localparam CYCLE = 4;

always begin
    #(CYCLE/2) clk = ~clk;
end

//reset signal
initial begin
    clk = 0;
    aresetn = 1;
    #(10);
    aresetn = 0; //reset all the values
    #(10);
    aresetn = 1;
end


initial begin
    #(3*CYCLE+CYCLE/2);
    #(40* CYCLE)
    m_axis_tready <= 1'b1;
    s_axis_tdata <= 512'b0; 
    s_axis_tkeep <= 64'h0;
    s_axis_tuser <= 128'h0;
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(3*CYCLE)
    while(~s_axis_tready)
        #(CYCLE);
    // conf1.txt:
    s_axis_tdata <= 512'h00000000000000000000000000000001000000000000882f3200f2f1d204dededede6f6f6f6f0ade1140000001004600004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000270e250d230c910ba108;
    s_axis_tkeep <= 64'h00000000000fffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000001000500000000882a3200f2f1d204dededede6f6f6f6f0ade1140000001004600004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000270e250d230c910ba108;
    s_axis_tkeep <= 64'h00000000000fffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000001000100000000475e2300f2f1d204dededede6f6f6f6f19de1140000001003700004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c0000;
    s_axis_tkeep <= 64'h000000000000001f;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010f01000000000fea3700f2f1d204dededede6f6f6f6f05de1140000001004b00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000080ffff0000ffffffffffffffffffffffffffffffffffffffff;
    s_axis_tkeep <= 64'h0000000001ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000000000200000000ed693800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000000f0200000000e03c6d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007808c0200001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00000e00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000001000200000000fd683800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010f0200000000e13b6d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007808c0100001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00000e00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000001000900000000c7542300f2f1d204dededede6f6f6f6f19de1140000001003700004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c8001;
    s_axis_tkeep <= 64'h000000000000001f;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010f09000000000fe23700f2f1d204dededede6f6f6f6f05de1140000001004b00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000080ffffffffffffffff00000000ffffffffffffffffffffffff;
    s_axis_tkeep <= 64'h0000000001ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000000000a00000000ed613800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000000f0a0000000053e06d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00100c00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000001000a00000000fd603800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010f0a0000000053e06d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00000c00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000002000a000000000d603800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000020f0a0000000073b76d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008d00000e00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000001001100000000474e2300f2f1d204dededede6f6f6f6f19de1140000001003700004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c0000;
    s_axis_tkeep <= 64'h000000000000001f;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010f11000000000fda3700f2f1d204dededede6f6f6f6f05de1140000001004b00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000080ffff0000ffffffffffffffffffffffffffffffffffffffff;
    s_axis_tkeep <= 64'h0000000001ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000000001200000000fd593800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000000f120000000053f16d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00900800300800700000f00001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00000e00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010012000000000d593800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010f120000000053f26d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00700800300800700000f00001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00000e00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000001001900000000c7452300f2f1d204dededede6f6f6f6f19de1140000001003700004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c8000;
    s_axis_tkeep <= 64'h000000000000001f;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010f19000000000fd23700f2f1d204dededede6f6f6f6f05de1140000001004b00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000080ffffffffffffffff00000000ffffffffffffffffffffffff;
    s_axis_tkeep <= 64'h0000000001ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000000001a00000000cd513800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000000f1a00000000bbb16d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c01b00000700000f00001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00000e00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000001001a00000000dd503800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010f1a00000000bfb06d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c01700000700000f00001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00000e00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000001002100000000473d2300f2f1d204dededede6f6f6f6f19de1140000001003700004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c0001;
    s_axis_tkeep <= 64'h000000000000001f;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010f21000000000fca3700f2f1d204dededede6f6f6f6f05de1140000001004b00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000080ffffffffffffffff00000000ffffffffffffffffffffffff;
    s_axis_tkeep <= 64'h0000000001ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000000002200000000ad493800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000000f2200000000e11c6d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007808c0100001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00000e00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000001002200000000bd483800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000500000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010f2200000000e11b6d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007808c0100001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00000e00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000001002900000000c7342300f2f1d204dededede6f6f6f6f19de1140000001003700004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c8001;
    s_axis_tkeep <= 64'h000000000000001f;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010f29000000000fc23700f2f1d204dededede6f6f6f6f05de1140000001004b00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000080ffffffffffffffff00000000ffffffffffffffffffffffff;
    s_axis_tkeep <= 64'h0000000001ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000000002a00000000ad413800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000000f2a000000009fa16d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c03700000700000f00001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00000e00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000001002a000000006d403800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010f2a00000000a3a06d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c03300000700000f00001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00000e00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000001003100000000472d2300f2f1d204dededede6f6f6f6f19de1140000001003700004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c0001;
    s_axis_tkeep <= 64'h000000000000001f;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010f31000000000fba3700f2f1d204dededede6f6f6f6f05de1140000001004b00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000080ffffffffffffffff00000000ffffffffffffffffffffffff;
    s_axis_tkeep <= 64'h0000000001ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000000032000000003d393800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d00000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000000f3200000000e00c6d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007808c0200001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00000e00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010032000000004d383800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010f3200000000e10b6d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007808c0100001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00000e00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000001003900000000c7242300f2f1d204dededede6f6f6f6f19de1140000001003700004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c8001;
    s_axis_tkeep <= 64'h000000000000001f;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000010f39000000000fb23700f2f1d204dededede6f6f6f6f05de1140000001004b00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000080ffffffffffffffff00000000ffffffffffffffffffffffff;
    s_axis_tkeep <= 64'h0000000001ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h00000000000000000000000000000000003a000000000d323800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000000f3a0000000073896d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008d00000e00100c00300800700;
    s_axis_tkeep <= 64'h0000000000007fff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);


    // stateconf.txt:
    s_axis_tdata <= 512'h000000000000000000000000000000010013000000004d542000f2f1d204dededede6f6f6f6f1cde1140000001003400004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004;
    s_axis_tkeep <= 64'h0000000000000003;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h0000000000000000000000000000000200130000000049532000f2f1d204dededede6f6f6f6f1cde1140000001003400004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000404;
    s_axis_tkeep <= 64'h0000000000000003;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h0000000000000000000000000000000300130000000045522000f2f1d204dededede6f6f6f6f1cde1140000001003400004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000804;
    s_axis_tkeep <= 64'h0000000000000003;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h0000000000000000000000000000000400130000000041512000f2f1d204dededede6f6f6f6f1cde1140000001003400004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c04;
    s_axis_tkeep <= 64'h0000000000000003;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    
    
    s_axis_tdata <= 512'h000000002800000002000000000000000100000000004c4d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    
    // Check result
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
    if (m_axis_tdata == TARGET_VALUE_STAGES) begin
        $display ("STAGES TEST PASSED");
    end else begin
        $display ("STAGES TEST FAILED");
        @(CYCLE);
        $finish(0);
    end
    #CYCLE
    $finish(0);
end


rmt_wrapper #(
	.C_S_AXI_DATA_WIDTH(),
	.C_S_AXI_ADDR_WIDTH(),
	.C_BASEADDR(),
	.C_S_AXIS_DATA_WIDTH(C_S_AXIS_DATA_WIDTH),
	.C_S_AXIS_TUSER_WIDTH(),
	.C_M_AXIS_DATA_WIDTH(C_M_AXIS_DATA_WIDTH),
	.PHV_ADDR_WIDTH(),
	.NUM_OF_STAGES(16)
)rmt_wrapper_ins
(
	.clk(clk),		// axis clk
	.aresetn(aresetn),	

	// input Slave AXI Stream
	.s_axis_tdata(s_axis_tdata),
	.s_axis_tkeep(s_axis_tkeep),
	.s_axis_tuser(s_axis_tuser),
	.s_axis_tvalid(s_axis_tvalid),
	.s_axis_tready(s_axis_tready),
	.s_axis_tlast(s_axis_tlast),

	// output Master AXI Stream
	.m_axis_tdata(m_axis_tdata),
	.m_axis_tkeep(m_axis_tkeep),
	.m_axis_tuser(m_axis_tuser),
	.m_axis_tvalid(m_axis_tvalid),
	.m_axis_tready(m_axis_tready),
	.m_axis_tlast(m_axis_tlast)
	
);

endmodule
