
`timescale 1ns / 1ps

module tb_opennic_stages #(
parameter DATA_WIDTH=512
)();

wire                        clk;
wire                        axil_clk;
reg                         aresetn;
wire [31:0]                 shell_rst_done;
wire [31:0]                 user_rst_done;
wire                        rst_done;

reg [DATA_WIDTH-1:0]        s_axis_tdata;
reg [5:0]                   s_axis_tuser_mty;
reg [31:0]                  s_axis_tuser;
reg                         s_axis_tvalid;
wire                        s_axis_tready;
reg                         s_axis_tlast;
reg [31:0]                  s_axis_tcrc;

wire [DATA_WIDTH-1:0]       m_axis_tdata;
wire [((DATA_WIDTH/8))-1:0] m_axis_tkeep;
wire                        m_axis_tuser;
wire                        m_axis_tvalid;
reg                         m_axis_tready;
wire                        m_axis_tlast;
reg                         tuser_error;
reg                         tuser_zero_byte;
reg [10:0]                  tuser_qid;
reg [2:0]                   tuser_port_id;

reg                         axil_awvalid;
reg [31:0]                  axil_awaddr;
wire                        axil_awready;
reg                         axil_wvalid;
reg [31:0]                  axil_wdata;
wire                        axil_wready;
wire                        axil_bvalid;
wire [1:0]                  axil_bresp;
reg                         axil_bready;
reg                         axil_arvalid;
reg [31:0]                  axil_araddr;
wire                        axil_arready;
wire                        axil_rvalid;
wire [31:0]                 axil_rdata;
wire [1:0]                  axil_rresp;
reg                         axil_rready;

assign rst_done = (&shell_rst_done) & (&user_rst_done);
assign s_axis_tuser = {{26{1'b0}}, s_axis_tuser_mty};

initial begin
    tuser_error = 0;
    tuser_zero_byte = 0;
    tuser_port_id = 0;
    tuser_qid = 0;
    
    axil_awvalid <= 0;
    axil_awaddr <= 0;
    axil_wvalid <= 0;
    axil_wdata <= 0;
    axil_bready <= 0;
    axil_arvalid <= 0;
    axil_araddr <= 0;
    axil_rready <= 0;
    
    aresetn = 1;
    @(clk == 1'b0);
    @(clk == 1'b1);
    aresetn = 0;
    @(posedge clk);
    aresetn = 1;
    @(rst_done == 1'b1);
    while(~s_axis_tready)
        @(posedge clk);
    repeat(40)
        @(posedge clk);
    
    
    register_setup(32'h00001000, 32'h00000001);    
    configuration();
    
    
    // test packet
    // padding: 00000000 bit
    // res    : 82000000 = 40 	
    // op_a   : a0000000 = 10
    // op_b   : 50000000 = 5
    // op     : 1a00 = - / 0d00 = +
    //s_axis_tdata <= 512'h0000000026000000050000000a0000000d004c4d1a00e110d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;	
    s_axis_tdata <= 512'h0000000028000000050000000a0000000d004c4d1a00e110d204dededede6f6f6f6f22de1140000001002e000045000801000081050403020100090000000000;	
    s_axis_tuser_mty <= 6'b000000;
    s_axis_tvalid <= 1'b1;
    s_axis_tlast <= 1'b1;
    @(posedge clk);
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    
    // Check result
	@(m_axis_tvalid == 1'b1)
	assert (m_axis_tdata[479:472] == 8'h50) $display ("TEST PASSED");
	$finish;
end


// Tasks:
task configuration;
int fd;
begin
    repeat(40)
        @(posedge clk);
    s_axis_tcrc <= 32'b0;
    m_axis_tready <= 1'b1;
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    repeat(3)
        @(posedge clk);
    
    fd = $fopen("stages_conf.txt", "r");
    while(!$feof(fd))
    begin
        $fscanf(fd, "%h\n%b\n", s_axis_tdata, s_axis_tuser_mty);
        s_axis_tvalid <= 1'b1;
        if(s_axis_tuser_mty != 6'b000000)
        begin
            s_axis_tlast <= 1'b1;
            $fscanf(fd, "%b\n\n", s_axis_tcrc);
            @(posedge clk);
            s_axis_tvalid <= 1'b0;
            s_axis_tlast <= 1'b0;
            repeat(30)
                @(posedge clk);
        end
        else
        begin
            s_axis_tlast <= 1'b0;
            @(posedge clk);
        end
    end
    $fclose(fd);
end
endtask

task register_setup(input [31:0] reg_addr, reg_val);
begin
    // set register for qdma with axi4 lite     
    axil_awvalid <= 1'b1;
    axil_awaddr <= reg_addr;
    axil_wvalid <= 1'b1;
    axil_wdata <= reg_val;
    axil_bready <= 1'b1;
    @(axil_awready == 1'b1);
    @(posedge axil_clk);
    axil_awvalid <= 1'b0;
    @(axil_wready == 1'b1);
    @(posedge axil_clk);
    axil_wvalid <= 1'b0;
    axil_awaddr <= 32'h00000000;
    axil_wdata <= 32'h00000000;
    axil_bready <= 1'b0;
    @(axil_bvalid == 1'b1);
end
endtask

open_nic_shell #()
open_nic_shell_ins
(
	.axis_aclk(clk),		// axis clk
	.axil_aclk(axil_clk),		// axis clk
	.powerup_rstn(aresetn),
	.shell_rst_done(shell_rst_done),
	.user_rst_done(user_rst_done),

	// input Slave AXI Stream
	.s_axis_qdma_h2c_sim_tdata(s_axis_tdata),
	.s_axis_qdma_h2c_sim_tvalid(s_axis_tvalid),
	.s_axis_qdma_h2c_sim_tready(s_axis_tready),
	.s_axis_qdma_h2c_sim_tlast(s_axis_tlast),
	.s_axis_qdma_h2c_sim_tuser_err(tuser_error),
	.s_axis_qdma_h2c_sim_tuser_zero_byte(tuser_zero_byte),
	.s_axis_qdma_h2c_sim_tuser_mty(s_axis_tuser_mty),
	.s_axis_qdma_h2c_sim_tuser_mdata(s_axis_tuser),
	.s_axis_qdma_h2c_sim_tuser_qid(tuser_qid),
	.s_axis_qdma_h2c_sim_tuser_port_id(tuser_port_id),
	.s_axis_qdma_h2c_sim_tcrc(s_axis_tcrc),

	// output Master AXI Stream
	.m_axis_cmac_tx_sim_tdata(m_axis_tdata),
	.m_axis_cmac_tx_sim_tkeep(m_axis_tkeep),
	.m_axis_cmac_tx_sim_tvalid(m_axis_tvalid),
	.m_axis_cmac_tx_sim_tuser_err(m_axis_tuser),
	.m_axis_cmac_tx_sim_tready(m_axis_tready),
	.m_axis_cmac_tx_sim_tlast(m_axis_tlast),
	
	.s_axil_sim_awvalid(axil_awvalid),
	.s_axil_sim_awaddr(axil_awaddr),
	.s_axil_sim_awready(axil_awready),
	.s_axil_sim_wvalid(axil_wvalid),
	.s_axil_sim_wdata(axil_wdata),
	.s_axil_sim_wready(axil_wready),
	.s_axil_sim_bvalid(axil_bvalid),
	.s_axil_sim_bresp(axil_bresp),
	.s_axil_sim_bready(axil_bready),
	.s_axil_sim_arvalid(axil_arvalid),
	.s_axil_sim_araddr(axil_araddr),
	.s_axil_sim_arready(axil_arready),
	.s_axil_sim_rvalid(axil_rvalid),
	.s_axil_sim_rdata(axil_rdata),
	.s_axil_sim_rresp(axil_rresp),
	.s_axil_sim_rready(axil_rready)
);

endmodule
