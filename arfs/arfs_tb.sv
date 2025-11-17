`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/13/2025 09:51:06 AM
// Design Name: 
// Module Name: arfs_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module arfs_tb();

reg                                 clk;
reg                                 axil_clk;
reg                                 aresetn;

reg          s_axis_c2h_tvalid;
reg  [511:0] s_axis_c2h_tdata;
reg   [63:0] s_axis_c2h_tkeep;
reg          s_axis_c2h_tlast;
reg   [15:0] s_axis_c2h_tuser_size;
reg   [15:0] s_axis_c2h_tuser_src;
reg   [15:0] s_axis_c2h_tuser_dst;
wire         s_axis_c2h_tready;

wire         m_axis_c2h_tvalid;
wire [511:0] m_axis_c2h_tdata;
wire         m_axis_c2h_tlast;
wire  [15:0] m_axis_c2h_tuser_size;
wire  [10:0] m_axis_c2h_tuser_qid;
reg          m_axis_c2h_tready;

localparam CYCLE = 4;
localparam INPUT_PACKET = 512'h1234123412341234123412341234123412341234123412341234123412341234123412341234123412341234123412340f001234123412341234123412341234;

always begin
    #(CYCLE/2) clk = ~clk;
end

always_ff @(posedge clk or negedge aresetn) begin
    if(aresetn)
        axil_clk <= ~axil_clk;
    else
        axil_clk <= 0;
end

initial begin
    clk = 0;
    aresetn = 1;
    #(CYCLE);
    aresetn = 0; //reset all the values
    #(CYCLE);
    aresetn = 1;
    #(30*CYCLE);
    while(~s_axis_c2h_tready)
        #(CYCLE);
    @(negedge clk);
    
    m_axis_c2h_tready <= 1;
    s_axis_c2h_tuser_dst <= 0;
    s_axis_c2h_tuser_src <= 1;
    s_axis_c2h_tkeep <= 0;
    #(10*CYCLE);
    
    s_axis_c2h_tdata <= INPUT_PACKET;
    s_axis_c2h_tuser_size <= 16'd128;
    s_axis_c2h_tvalid <= 1;
    s_axis_c2h_tlast <= 1;
    #(CYCLE);
    s_axis_c2h_tvalid <= 0;
    #(CYCLE);
    // first insert of entry "0x00fa" for v_lan id "0x00f0"
    s_axis_c2h_tdata <= 512'h0000000000000000000000000000000100fa902f2e00f2f2d204dededede6f6f6f6f0ede1140000001004200004500080f0000810504030201000b0a09080706;
    s_axis_c2h_tuser_size <= 16'd128;
    s_axis_c2h_tvalid <= 1;
    s_axis_c2h_tlast <= 1;
    #(CYCLE);
    s_axis_c2h_tvalid <= 0;
    #(CYCLE);
    s_axis_c2h_tdata <= 512'h0000000000000000000000000000000000fd902f2e00f2f2d204dededede6f6f6f6f0ede1140000001004200004500080f0000810504030201000b0a09080706;
    s_axis_c2h_tuser_size <= 16'd128;
    s_axis_c2h_tvalid <= 1;
    s_axis_c2h_tlast <= 1;
    #(CYCLE);
    s_axis_c2h_tvalid <= 0;
    #(60*CYCLE);
    s_axis_c2h_tdata <= INPUT_PACKET;
    s_axis_c2h_tuser_size <= 16'd128;
    s_axis_c2h_tvalid <= 1;
    s_axis_c2h_tlast <= 1;
    #(CYCLE);
    s_axis_c2h_tvalid <= 0;
    #(CYCLE);
    s_axis_c2h_tdata <= INPUT_PACKET;
    s_axis_c2h_tuser_size <= 16'd128;
    s_axis_c2h_tvalid <= 1;
    s_axis_c2h_tlast <= 1;
    #(CYCLE);
    s_axis_c2h_tvalid <= 0;
    #(CYCLE);
    s_axis_c2h_tdata <= INPUT_PACKET;
    s_axis_c2h_tuser_size <= 16'd128;
    s_axis_c2h_tvalid <= 1;
    s_axis_c2h_tlast <= 0;
    #(CYCLE);
    s_axis_c2h_tdata <= INPUT_PACKET;
    s_axis_c2h_tuser_size <= 16'd128;
    s_axis_c2h_tvalid <= 1;
    s_axis_c2h_tlast <= 1;
    #(CYCLE);
    s_axis_c2h_tvalid <= 0;
    #(CYCLE);
    @(posedge m_axis_c2h_tvalid);
    if (m_axis_c2h_tuser_qid == 16'h00fa && m_axis_c2h_tdata == INPUT_PACKET) begin 
        $display ("INSERT TEST PASSED"); 
    end else begin
        $display ("INSERT TEST FAILED");
    end
    // update of entry "0x00fa" for v_lan id "0x00f0" in new entry "0x00fb" for v_lan id "0x00f0"
    s_axis_c2h_tdata <= 512'h0000000000000000000000000000000000fb902f2e00f2f2d204dededede6f6f6f6f0ede1140000001004200004500080f0000810504030201000b0a09080706;
    s_axis_c2h_tuser_size <= 16'd128;
    s_axis_c2h_tvalid <= 1;
    s_axis_c2h_tlast <= 1;
    #(CYCLE);
    s_axis_c2h_tvalid <= 0;
    #(CYCLE);
    s_axis_c2h_tdata <= 512'h0000000000000000000000000000000000fd902f2e00f2f2d204dededede6f6f6f6f0ede1140000001004200004500080f0000810504030201000b0a09080706;
    s_axis_c2h_tuser_size <= 16'd128;
    s_axis_c2h_tvalid <= 1;
    s_axis_c2h_tlast <= 1;
    #(CYCLE);
    s_axis_c2h_tvalid <= 0;
    #(60*CYCLE);
    s_axis_c2h_tdata <= INPUT_PACKET;
    s_axis_c2h_tuser_size <= 16'd128;
    s_axis_c2h_tvalid <= 1;
    s_axis_c2h_tlast <= 1;
    #(CYCLE);
    s_axis_c2h_tvalid <= 0;
    #(CYCLE);
    s_axis_c2h_tdata <= INPUT_PACKET;
    s_axis_c2h_tuser_size <= 16'd128;
    s_axis_c2h_tvalid <= 1;
    s_axis_c2h_tlast <= 1;
    #(CYCLE);
    s_axis_c2h_tvalid <= 0;
    #(CYCLE);
    s_axis_c2h_tdata <= INPUT_PACKET;
    s_axis_c2h_tuser_size <= 16'd128;
    s_axis_c2h_tvalid <= 1;
    s_axis_c2h_tlast <= 0;
    #(CYCLE);
    s_axis_c2h_tdata <= INPUT_PACKET;
    s_axis_c2h_tuser_size <= 16'd128;
    s_axis_c2h_tvalid <= 1;
    s_axis_c2h_tlast <= 1;
    #(CYCLE);
    s_axis_c2h_tvalid <= 0;
    #(CYCLE);
    @(posedge m_axis_c2h_tvalid);
    if (m_axis_c2h_tuser_qid == 16'h00fb && m_axis_c2h_tdata == INPUT_PACKET) begin 
        $display ("UPDATE TEST PASSED"); 
    end else begin
        $display ("UPDATE TEST FAILED");
    end
    $finish(0);
end


qdma_subsystem_function main_mod(
    .s_axis_c2h_tvalid(s_axis_c2h_tvalid),
    .s_axis_c2h_tdata(s_axis_c2h_tdata),
    .s_axis_c2h_tkeep(s_axis_c2h_tkeep),
    .s_axis_c2h_tlast(s_axis_c2h_tlast),
    .s_axis_c2h_tuser_size(s_axis_c2h_tuser_size),
    .s_axis_c2h_tuser_src(s_axis_c2h_tuser_src),
    .s_axis_c2h_tuser_dst(s_axis_c2h_tuser_dst),
    .s_axis_c2h_tready(s_axis_c2h_tready),
    
    .m_axis_c2h_tvalid(m_axis_c2h_tvalid),
    .m_axis_c2h_tdata(m_axis_c2h_tdata),
    .m_axis_c2h_tlast(m_axis_c2h_tlast),
    .m_axis_c2h_tuser_size(m_axis_c2h_tuser_size),
    .m_axis_c2h_tuser_qid(m_axis_c2h_tuser_qid),
    .m_axis_c2h_tready(m_axis_c2h_tready),
    
    .axil_aclk(axil_clk),
    .axis_aclk(clk),
    .axis_master_aclk(clk),
    .axil_aresetn(aresetn)
);
endmodule
