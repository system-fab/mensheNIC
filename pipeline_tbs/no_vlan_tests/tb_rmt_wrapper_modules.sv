
`timescale 1ns / 1ps

module tb_rmt_wrapper_modules #(
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

// Output validation
// Define the target value you are looking for
// SUB EXPECTED OUTPUT
localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_SUB = 512'h000000000100000002000000030000001a00000000004c4d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;
// ADD EXPECTED OUTPUT
localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_ADD = 512'h000000000500000002000000030000000d0000000000594d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;
// TB_STAGES EXPECTED OUTPUT
localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_STAGES = 512'h0000000050000000050000000a0000000d00000000004c4d1a000030d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;

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
reg                                     finished_config;

//clk signal
localparam CYCLE = 4;

always begin
    #(CYCLE/2) clk = ~clk;
end

//reset signal
initial begin
    finished_config <= 1'b0;
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
    s_axis_tdata <= 512'h000000000000000000000000000000000002000000006d683800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000a00100000000000000000000000000000000000000001000;
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
    s_axis_tdata <= 512'h000000000000000000000000000000010002000000003d683800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000d00000000000000000000000000000000000000000001000;
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


    // conf2.txt:
    s_axis_tdata <= 512'h00000000000000000000000000000002000000000000882e3200f2f1d204dededede6f6f6f6f0ade1140000001004600004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h0000000000000000000000000000000200050000000088293200f2f1d204dededede6f6f6f6f0ade1140000001004600004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h00000000000000000000000000000002000100000000475d2300f2f1d204dededede6f6f6f6f19de1140000001003700004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h000000000000000000000000000000020f01000000000fe93700f2f1d204dededede6f6f6f6f05de1140000001004b00004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h000000000000000000000000000000040002000000005d643800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000a00100000000000000000000000000000000000000002000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000040f020000000073bd6d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h000000000000000000000000000000050002000000002d643800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000d00000000000000000000000000000000000000000002000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000050f0200000000e1376d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
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


    // conf3.txt:
    s_axis_tdata <= 512'h00000000000000000000000000000003000000000000882d3200f2f1d204dededede6f6f6f6f0ade1140000001004600004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h0000000000000000000000000000000300050000000088283200f2f1d204dededede6f6f6f6f0ade1140000001004600004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h00000000000000000000000000000003000100000000475c2300f2f1d204dededede6f6f6f6f19de1140000001003700004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h000000000000000000000000000000030f01000000000fe83700f2f1d204dededede6f6f6f6f05de1140000001004b00004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h000000000000000000000000000000080002000000004d603800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000a00100000000000000000000000000000000000000003000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000080f020000000020256d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007409c0200001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
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
    s_axis_tdata <= 512'h000000000000000000000000000000090002000000001d603800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000d00000000000000000000000000000000000000000003000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000090f020000000021246d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007409c0100001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
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
    s_axis_tdata <= 512'h00000000000000000000000000000003000900000000c7522300f2f1d204dededede6f6f6f6f19de1140000001003700004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h000000000000000000000000000000030f09000000000fe03700f2f1d204dededede6f6f6f6f05de1140000001004b00004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h00000000000000000000000000000008000a000000000d583800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e00100000000000000000000000000003000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000080f0a00000000e01c6d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007809c0200001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
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
    s_axis_tdata <= 512'h00000000000000000000000000000009000a00000000cd553800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200300000000000000000000000000003000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000090f0a00000000e11b6d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007809c0100001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
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
    s_axis_tdata <= 512'h00000000000000000000000000000003001100000000c74a2300f2f1d204dededede6f6f6f6f19de1140000001003700004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h000000000000000000000000000000030f11000000000fd83700f2f1d204dededede6f6f6f6f05de1140000001004b00004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h000000000000000000000000000000080012000000005d503800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900100000000000000000000000000003000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000080f120000000020156d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007409c0200001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
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
    s_axis_tdata <= 512'h000000000000000000000000000000090012000000007d4d3800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700300000000000000000000000000003000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000090f120000000021146d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007409c0100001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
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
    s_axis_tdata <= 512'h00000000000000000000000000000003001900000000c7422300f2f1d204dededede6f6f6f6f19de1140000001003700004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h000000000000000000000000000000030f19000000000fd03700f2f1d204dededede6f6f6f6f05de1140000001004b00004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h00000000000000000000000000000008001a00000000fd483800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f00000000000000000000000000000003000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000080f1a00000000e00c6d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007809c0200001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
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
    s_axis_tdata <= 512'h00000000000000000000000000000009001a00000000dd443800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100400000000000000000000000000003000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000090f1a00000000e10b6d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007809c0100001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
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
    s_axis_tdata <= 512'h00000000000000000000000000000003002100000000c73a2300f2f1d204dededede6f6f6f6f19de1140000001003700004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h000000000000000000000000000000030f21000000000fc83700f2f1d204dededede6f6f6f6f05de1140000001004b00004500080504030201000b0a09080706;
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
    s_axis_tdata <= 512'h000000000000000000000000000000080022000000004d413800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000003000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000080f220000000020056d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007409c0200001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
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
    s_axis_tdata <= 512'h000000000000000000000000000000090022000000008d3c3800f2f1d204dededede6f6f6f6f04de1140000001004c00004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600400000000000000000000000000003000;
    s_axis_tkeep <= 64'h0000000003ffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    s_axis_tdata <= 512'h000000000000000000000000000000090f220000000021046d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #(CYCLE)
    s_axis_tdata <= 512'h000f00001e00003c0000780000f00000e00100c003008007409c0100001e00003c0000780000f00000e00100c00300800700000f00001e00003c0000780000f0;
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
    
    
    // TEST SUB    
    s_axis_tdata <= 512'h000000000000000002000000030000001a00000000004c4d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata == TARGET_VALUE_SUB) begin 
        $display ("SUB TEST PASSED"); 
    end else begin
        $display ("SUB TEST FAILED");
    end
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);;
    // TEST ADD
    s_axis_tdata <= 512'h000000000000000002000000030000000d0000000000594d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata == TARGET_VALUE_ADD) begin 
        $display ("ADD TEST PASSED"); 
    end else begin
        $display ("ADD TEST FAILED");
    end
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);;
    
    s_axis_tdata <= 512'h0000000028000000050000000a0000000d00000000004c4d1a000030d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;	
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata == TARGET_VALUE_STAGES) begin 
        $display ("STAGES TEST PASSED"); 
    end else begin
        $display ("STAGES TEST FAILED");
    end
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);;
    
    s_axis_tdata <= 512'h000000000000000002000000030000001a00000000004c4d1a000020d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(4*CYCLE)
    finished_config <= 1'b1;
    repeat(1000)
    begin
        #(CYCLE);
        if(m_axis_tvalid == 1'b1)
        begin
            $display ("DROP TEST FAILED");
            $finish(0);
        end
    end
    $display ("DROP TEST PASSED");
    
    $finish(0);
end

property no_output_sim;
    @(posedge clk) finished_config |-> !m_axis_tvalid;
endproperty

assert property (no_output_sim) else $fatal("The module tries to write an output, it should discard everything!");

rmt_wrapper #(
	.C_S_AXI_DATA_WIDTH(),
	.C_S_AXI_ADDR_WIDTH(),
	.C_BASEADDR(),
	.C_S_AXIS_DATA_WIDTH(C_S_AXIS_DATA_WIDTH),
	.C_S_AXIS_TUSER_WIDTH(),
	.C_M_AXIS_DATA_WIDTH(C_M_AXIS_DATA_WIDTH),
	.PHV_ADDR_WIDTH()
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
