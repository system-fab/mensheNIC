
`timescale 1ns / 1ps

module tb_rmt_wrapper_throughput #(
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
localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_1 = 512'h000000000100000002000000030000001a004c4d1a000010d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_2 = 512'h000000000500000002000000030000000d00594d1a000010d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_3 = 512'h000000000200000002000000040000001a00abcdef000010d204dededede8f8f8f8f22de1140000001002e000045000801000081050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_4 = 512'h000000000600000002000000040000000d00444444000010d204dededede7f7f7f7f22de1140000001002e000045000801000081050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_5 = 512'h000000000100000003000000040000001a004c4d1a000010d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_6 = 512'h00000000225843020d21021d2f79451f1a006ff66f000010d204dededede5ee5e5e522de1140000001002e000045000801000081050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_7 = 512'h000000000200000000000000020000001a00cbdfef000010d204dededededadadada22de1140000001002e000045000801000081050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_8 = 512'h000000000700000000000000070000000d00333333000010d204dededede5b5b5b5b22de1140000001002e000045000801000081050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_9 = 512'h000000000000000005000000050000001a004c4d1b000010d204dededede6f6f6f8f22de1140000001332e000045000801000081151413121110090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_10 =512'h000000000a00000003000000070000000d00594d1a000010d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_11 =512'h000000000400000003000000070000001a00abcdef000010d204dededede8f8f8f8f22de1140000001002e000045000801000081050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_12 =512'h000000000b0000000a000000010000000d00444444000010d204dededede7f7f7f7f22de1140000001002e000045000801000081050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_13 =512'h000000000a000000010000000b0000001a004c4d1a000010d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_14 =512'h000000000000000000000000000000001a00cbdfef000010d204dededededadadada22de1140000001002e000045000801000081050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_15 =512'h000000000f000000000000000f0000000d00333333000010d204dededede5b5b5b5b22de1140000001002e000045000801000081050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] PAYLOAD_1 = 512'hcad85d0347dbf3eab912e0641c46636f95b77e5a04e28912526dafa5fbe56f95b77e5a04e28912526dafa5fbe5d0096788aae201790b04733863da896f95b770;
localparam logic [C_S_AXIS_DATA_WIDTH-1:0] PAYLOAD_2 = 512'h0000000000000000000000000000000000000000000000000000000000000000b77e5a04e28912526dafa5fbe5d0096788aae201790b04733863da896f95b770;
localparam logic [C_S_AXIS_DATA_WIDTH-1:0] PAYLOAD_3 = 512'he1dc896b518e38ec377ccad61581727e7e7d8611cd207d49274759f13c827c58b667d33903de09c9775421b1f1d7ac8a640be1c066ba772cbd7016d2264a5cc9;
localparam logic [C_S_AXIS_DATA_WIDTH-1:0] PAYLOAD_4 = 512'h000000000000000000000000000000000000fc9780fd740dfec900c7a2e1e1e7b34c8d08117029f5fca39609174a739b77b4ab19c458414687b0a6286f2c3fc1;
localparam logic [C_S_AXIS_DATA_WIDTH-1:0] PAYLOAD_5 = 512'h26f2aa1d9df75409f7ea90cc0b39bd456495fcdab9d1071b98f66328cec0c56cba61172a6df751974c7a1244f5c53d4225b7fb056310ae10a382bd1dc0b9bd45;
localparam logic [C_S_AXIS_DATA_WIDTH-1:0] PAYLOAD_6 = 512'h655c8fe8ed82fea0c6ba5b9344b5556152a98a4148762163a05fb6184092193f865e119bd7a9fdd8533dd2584876afda068af5592bce7b45e2300dadf62fb708;
localparam logic [C_S_AXIS_DATA_WIDTH-1:0] PAYLOAD_7 = 512'h278d0c45104406320049389f98a50f809dacf932f84310b95261ad832c1932fa45fd647127a67b4e23db4f58c3858384cbf89b061f7226473ab35bfb022c300f;
localparam logic [C_S_AXIS_DATA_WIDTH-1:0] PAYLOAD_8 = 512'h0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000acbd1234acbd1234;

reg err_flag = 0;



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
    s_axis_tdata <= 512'h000000000000000000000000000000010000902f2e00f2f1d204dededede6f6f6f6f0ede1140000001004200004500080f0000810504030201000b0a09080706;
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
    s_axis_tdata <= 512'h000000000000000000000000000000010005902a2e00f2f1d204dededede6f6f6f6f0ede1140000001004200004500080f0000810504030201000b0a09080706;
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
    s_axis_tdata <= 512'h0000000000000000000000000000000100014f5e1f00f2f1d204dededede6f6f6f6f1dde1140000001003300004500080f0000810504030201000b0a09080706;
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
    s_axis_tdata <= 512'h000000000000000000000000000000010f0117ea3300f2f1d204dededede6f6f6f6f09de1140000001004700004500080f0000810504030201000b0a09080706;
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
    s_axis_tdata <= 512'h00000000000000000000000000000000000275683400f2f1d204dededede6f6f6f6f08de1140000001004800004500080f0000810504030201000b0a09080706;
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
    s_axis_tdata <= 512'h000000000000000000000000000000000f02e83c6900f2f1d204dededede6f6f6f6fd3dd1140000001007d00004500080f0000810504030201000b0a09080706;
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
    s_axis_tdata <= 512'h00000000000000000000000000000001000245683400f2f1d204dededede6f6f6f6f08de1140000001004800004500080f0000810504030201000b0a09080706;
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
    s_axis_tdata <= 512'h000000000000000000000000000000010f02e93b6900f2f1d204dededede6f6f6f6fd3dd1140000001007d00004500080f0000810504030201000b0a09080706;
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
    
    
    // stateconf.txt:
    s_axis_tdata <= 512'h00000000000000000000000000000001001355541c00f2f1d204dededede6f6f6f6f20de1140000001003000004500080f0000810504030201000b0a09080706;
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
    s_axis_tdata <= 512'h00000000000000000000000000000002001351531c00f2f1d204dededede6f6f6f6f20de1140000001003000004500080f0000810504030201000b0a09080706;
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
    s_axis_tdata <= 512'h0000000000000000000000000000000300134d521c00f2f1d204dededede6f6f6f6f20de1140000001003000004500080f0000810504030201000b0a09080706;
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
    s_axis_tdata <= 512'h00000000000000000000000000000004001349511c00f2f1d204dededede6f6f6f6f20de1140000001003000004500080f0000810504030201000b0a09080706;
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
    
    
    
    // finished configuration, starting throughput tests:
    s_axis_tdata <= 512'h000000000000000002000000030000001a004c4d1a000010d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #CYCLE
    s_axis_tdata <= 512'h000000000000000002000000030000000d00594d1a000010d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #CYCLE
    s_axis_tdata <= 512'h000000000000000002000000040000001a00abcdef000010d204dededede8f8f8f8f22de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #CYCLE
    s_axis_tdata <= 512'h000000000000000002000000040000000d00444444000010d204dededede7f7f7f7f22de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    
    #CYCLE
    s_axis_tdata <= 512'h000000000000000003000000040000001a004c4d1a000010d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #CYCLE
    s_axis_tdata <= 512'h00000000000000000d21021d2f79451f1a006ff66f000010d204dededede5ee5e5e522de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #CYCLE
    s_axis_tdata <= 512'h000000000000000000000000020000001a00cbdfef000010d204dededededadadada22de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #CYCLE
    s_axis_tdata <= 512'h000000000000000000000000070000000d00333333000010d204dededede5b5b5b5b22de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(3*CYCLE)
    
    // throughput tests with bigger packets:
    s_axis_tdata <= 512'h000000000000000005000000050000001a004c4d1b000010d204dededede6f6f6f8f22de1140000001332e000045000801000081151413121110090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #CYCLE
    s_axis_tdata <= PAYLOAD_1;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #CYCLE
    s_axis_tdata <= PAYLOAD_2;
    s_axis_tkeep <= 64'h00000000ffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    
    s_axis_tdata <= 512'h000000000000000003000000070000000d00594d1a000010d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #CYCLE
    s_axis_tdata <= PAYLOAD_3;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    
    s_axis_tdata <= 512'h000000000000000003000000070000001a00abcdef000010d204dededede8f8f8f8f22de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #CYCLE
    s_axis_tdata <= PAYLOAD_4;
    s_axis_tkeep <= 64'h00003fffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    
    s_axis_tdata <= 512'h00000000000000000a000000010000000d00444444000010d204dededede7f7f7f7f22de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #CYCLE
    
    s_axis_tdata <= 512'h0000000000000000010000000b0000001a004c4d1a000010d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #CYCLE
    s_axis_tdata <= PAYLOAD_5;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    
    s_axis_tdata <= 512'h000000000000000000000000000000001a00cbdfef000010d204dededededadadada22de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #CYCLE
    s_axis_tdata <= PAYLOAD_6;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #CYCLE
    s_axis_tdata <= PAYLOAD_7;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    
    s_axis_tdata <= 512'h0000000000000000000000000f0000000d00333333000010d204dededede5b5b5b5b22de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b0;
    #CYCLE
    s_axis_tdata <= PAYLOAD_8;
    s_axis_tkeep <= 64'h00000000000000ff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    
    
    // validation
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata == TARGET_VALUE_1) begin 
        $display ("TEST 1 PASSED"); 
    end else begin
        $display ("TEST 1 FAILED");
    end
    @(m_axis_tvalid == 1'b0)
    
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata == TARGET_VALUE_2) begin 
        $display ("TEST 2 PASSED"); 
    end else begin
        $display ("TEST 2 FAILED");
    end
    @(m_axis_tvalid == 1'b0)
    
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata == TARGET_VALUE_3) begin 
        $display ("TEST 3 PASSED"); 
    end else begin
        $display ("TEST 3 FAILED");
    end
    @(m_axis_tvalid == 1'b0)
    
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata == TARGET_VALUE_4) begin 
        $display ("TEST 4 PASSED"); 
    end else begin
        $display ("TEST 4 FAILED");
    end
    @(m_axis_tvalid == 1'b0)
    
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata == TARGET_VALUE_5) begin 
        $display ("TEST 5 PASSED"); 
    end else begin
        $display ("TEST 5 FAILED");
    end
    @(m_axis_tvalid == 1'b0)
    
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata == TARGET_VALUE_6) begin 
        $display ("TEST 6 PASSED"); 
    end else begin
        $display ("TEST 6 FAILED");
    end
    @(m_axis_tvalid == 1'b0)
    
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata == TARGET_VALUE_7) begin 
        $display ("TEST 7 PASSED"); 
    end else begin
        $display ("TEST 7 FAILED");
    end
    @(m_axis_tvalid == 1'b0)
    
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata == TARGET_VALUE_8) begin 
        $display ("TEST 8 PASSED"); 
    end else begin
        $display ("TEST 8 FAILED");
    end
    @(m_axis_tvalid == 1'b0)
    
    
    
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata != TARGET_VALUE_9 || m_axis_tkeep != 64'hffffffffffffffff)
	    err_flag = 1;
	#CYCLE
	if (m_axis_tdata != PAYLOAD_1 || m_axis_tkeep != 64'hffffffffffffffff)
	    err_flag = 1;
	#CYCLE
	if (m_axis_tdata != PAYLOAD_2 || m_axis_tkeep != 64'h00000000ffffffff)
	    err_flag = 1;
	if (err_flag)
        $display ("TEST 9 FAILED"); 
    else
        $display ("TEST 9 PASSED");
    err_flag = 0;
    @(m_axis_tvalid == 1'b0)
    
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata != TARGET_VALUE_10 || m_axis_tkeep != 64'hffffffffffffffff)
	    err_flag = 1;
	#CYCLE
	if (m_axis_tdata != PAYLOAD_3 || m_axis_tkeep != 64'hffffffffffffffff)
	    err_flag = 1;
	if (err_flag)
        $display ("TEST 10 FAILED"); 
    else
        $display ("TEST 10 PASSED");
    err_flag = 0;
    @(m_axis_tvalid == 1'b0)
    
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata != TARGET_VALUE_11 || m_axis_tkeep != 64'hffffffffffffffff)
	    err_flag = 1;
	#CYCLE
	if (m_axis_tdata != PAYLOAD_4 || m_axis_tkeep != 64'h00003fffffffffff)
	    err_flag = 1;
	if (err_flag)
        $display ("TEST 11 FAILED"); 
    else
        $display ("TEST 11 PASSED");
    err_flag = 0;
    @(m_axis_tvalid == 1'b0)
    
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata == TARGET_VALUE_12) begin 
        $display ("TEST 12 PASSED"); 
    end else begin
        $display ("TEST 12 FAILED");
    end
    err_flag = 0;
    @(m_axis_tvalid == 1'b0)
    
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata != TARGET_VALUE_13 || m_axis_tkeep != 64'hffffffffffffffff)
	    err_flag = 1;
	#CYCLE
	if (m_axis_tdata != PAYLOAD_5 || m_axis_tkeep != 64'hffffffffffffffff)
	    err_flag = 1;
	if (err_flag)
        $display ("TEST 13 FAILED"); 
    else
        $display ("TEST 13 PASSED");
    err_flag = 0;
    @(m_axis_tvalid == 1'b0)
    
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata != TARGET_VALUE_14 || m_axis_tkeep != 64'hffffffffffffffff)
	    err_flag = 1;
	#CYCLE
	if (m_axis_tdata != PAYLOAD_6 || m_axis_tkeep != 64'hffffffffffffffff)
	    err_flag = 1;
	#CYCLE
	if (m_axis_tdata != PAYLOAD_7 || m_axis_tkeep != 64'hffffffffffffffff)
	    err_flag = 1;
	if (err_flag)
        $display ("TEST 14 FAILED"); 
    else
        $display ("TEST 14 PASSED");
    err_flag = 0;
    @(m_axis_tvalid == 1'b0)
    
    @(m_axis_tvalid == 1'b1)
    #(CYCLE/2)
	if (m_axis_tdata != TARGET_VALUE_15 || m_axis_tkeep != 64'hffffffffffffffff)
	    err_flag = 1;
	#CYCLE
	if (m_axis_tdata != PAYLOAD_8 || m_axis_tkeep != 64'h00000000000000ff)
	    err_flag = 1;
	if (err_flag)
        $display ("TEST 15 FAILED"); 
    else
        $display ("TEST 15 PASSED");
    err_flag = 0;
    @(m_axis_tvalid == 1'b0)
    $finish(0);
end


rmt_wrapper #(
	.C_S_AXIS_DATA_WIDTH(C_S_AXIS_DATA_WIDTH),
	.C_S_AXIS_TUSER_WIDTH(C_S_AXIS_TUSER_WIDTH)
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
