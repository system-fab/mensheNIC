
`timescale 1ns / 1ps

module tb_rmt_wrapper_drop #(
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
reg                                     finished_config;

//clk signal
localparam CYCLE = 4;

always begin
    #(CYCLE/2) clk = ~clk;
end

//reset signal
initial begin
    finished_config = 0;
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
    s_axis_tdata <= 512'h000000000000000000000000000000000f020000000073c16d00f2f1d204dededede6f6f6f6fcfdd1140000001008100004500080504030201000b0a09080706;
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
    
    
    finished_config <= 1;
    s_axis_tdata <= 512'h000000000000000002000000030000001a00000000004c4d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
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


// Output validation
//sequence no_output;
//    s_axis_tvalid ##1 (m_axis_tvalid == 0) throughout (!s_axis_tvalid);
//endsequence

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
