
`timescale 1ns / 1ps

module tb_rmt_wrapper_calc #(
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
reg                                     value_detected_add;
reg                                     value_detected_sub;

//clk signal
localparam CYCLE = 10;

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
    
    
    finished_config <= 1;
    s_axis_tdata <= 512'h000000000000000002000000030000001a004c4d1a00e110d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(1000*CYCLE);
    if (value_detected_sub) begin
        $display("SUB Test passed");
    end else begin
        $display("SUB Test failed");
        $display("%h", m_axis_tdata);
        $finish(0);
    end
    
    // some time has passed   
    #(1000*CYCLE)
    s_axis_tdata <= 512'h000000000000000002000000030000000d00594d1a00e110d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;
    s_axis_tkeep <= 64'hffffffffffffffff;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    #CYCLE
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(1000*CYCLE);
    if (value_detected_add) begin
        $display("ADD Test passed");
    end else begin
        $display("ADD Test failed");
        $display("%h", m_axis_tdata);
        $finish(0);
    end
    $finish(0);
end

// Output validation
// Define the target value you are looking for
// SUB EXPECTED OUTPUT
localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_SUB = 512'h000000000100000002000000030000001a004c4d1a00e110d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;
// ADD EXPECTED OUTPUT
localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_ADD = 512'h000000000500000002000000030000000d00594d1a00e110d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;


// LOGIC TO CHECK IF THE SUB TARGET VALUE IS DETECTED
always_ff @(posedge clk) begin
    if (finished_config && m_axis_tvalid && m_axis_tdata == TARGET_VALUE_SUB) begin
        value_detected_sub <= 1;
    end
    else begin
        value_detected_sub <= aresetn & value_detected_sub;
    end
end

// LOGIC TO CHECK IF THE ADD TARGET VALUE IS DETECTED
always_ff @(posedge clk) begin
    if (finished_config && m_axis_tvalid && m_axis_tdata == TARGET_VALUE_ADD) begin
        value_detected_add <= 1;
    end
    else begin
        value_detected_add <= aresetn & value_detected_add;
    end
end


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
