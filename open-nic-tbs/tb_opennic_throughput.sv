
`timescale 1ns / 1ps

module tb_opennic_throughput #(
parameter DATA_WIDTH=512,
parameter NUM_CMAC_PORT=1
)();


/************************************************************************************************************************************************************************************************/
// Output validation
localparam logic [DATA_WIDTH-1:0] TARGET_VALUE_1 = 512'h000000000100000002000000030000001a00000000004c4d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;

localparam logic [DATA_WIDTH-1:0] TARGET_VALUE_2 = 512'h000000000500000002000000030000000d0000000000594d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;

localparam logic [DATA_WIDTH-1:0] TARGET_VALUE_3 = 512'h000000000200000002000000040000001a0000000000abcdef000010d204dededede8f8f8f8f22de1140000001002e0000450008050403020100090000000000;

localparam logic [DATA_WIDTH-1:0] TARGET_VALUE_4 = 512'h000000000600000002000000040000000d0000000000444444000010d204dededede7f7f7f7f22de1140000001002e0000450008050403020100090000000000;

localparam logic [DATA_WIDTH-1:0] TARGET_VALUE_5 = 512'h000000000100000003000000040000001a00000000004c4d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;

localparam logic [DATA_WIDTH-1:0] TARGET_VALUE_6 = 512'h00000000225843020d21021d2f79451f1a00000000006ff66f000010d204dededede5ee5e5e522de1140000001002e0000450008050403020100090000000000;

localparam logic [DATA_WIDTH-1:0] TARGET_VALUE_7 = 512'h000000000200000000000000020000001a0000000000cbdfef000010d204dededededadadada22de1140000001002e0000450008050403020100090000000000;

localparam logic [DATA_WIDTH-1:0] TARGET_VALUE_8 = 512'h000000000700000000000000070000000d0000000000333333000010d204dededede5b5b5b5b22de1140000001002e0000450008050403020100090000000000;

localparam logic [DATA_WIDTH-1:0] TARGET_VALUE_9 = 512'h000000000000000005000000050000001a00000000004c4d1b000010d204dededede6f6f6f8f22de1140000001332e0000450008151413121110090000000000;

localparam logic [DATA_WIDTH-1:0] TARGET_VALUE_10 =512'h000000000a00000003000000070000000d0000000000594d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;

localparam logic [DATA_WIDTH-1:0] TARGET_VALUE_11 =512'h000000000400000003000000070000001a0000000000abcdef000010d204dededede8f8f8f8f22de1140000001002e0000450008050403020100090000000000;

localparam logic [DATA_WIDTH-1:0] TARGET_VALUE_12 =512'h000000000b0000000a000000010000000d0000000000444444000010d204dededede7f7f7f7f22de1140000001002e0000450008050403020100090000000000;

localparam logic [DATA_WIDTH-1:0] TARGET_VALUE_13 =512'h000000000a000000010000000b0000001a00000000004c4d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;

localparam logic [DATA_WIDTH-1:0] TARGET_VALUE_14 =512'h000000000000000000000000000000001a0000000000cbdfef000010d204dededededadadada22de1140000001002e0000450008050403020100090000000000;

localparam logic [DATA_WIDTH-1:0] TARGET_VALUE_15 =512'h000000000f000000000000000f0000000d0000000000333333000010d204dededede5b5b5b5b22de1140000001002e0000450008050403020100090000000000;

localparam logic [DATA_WIDTH-1:0] PAYLOAD_1 = 512'hcad85d0347dbf3eab912e0641c46636f95b77e5a04e28912526dafa5fbe56f95b77e5a04e28912526dafa5fbe5d0096788aae201790b04733863da896f95b770;
localparam logic [DATA_WIDTH-1:0] PAYLOAD_2 = 512'h0000000000000000000000000000000000000000000000000000000000000000b77e5a04e28912526dafa5fbe5d0096788aae201790b04733863da896f95b770;
localparam logic [DATA_WIDTH-1:0] PAYLOAD_3 = 512'he1dc896b518e38ec377ccad61581727e7e7d8611cd207d49274759f13c827c58b667d33903de09c9775421b1f1d7ac8a640be1c066ba772cbd7016d2264a5cc9;
localparam logic [DATA_WIDTH-1:0] PAYLOAD_4 = 512'h000000000000000000000000000000000000fc9780fd740dfec900c7a2e1e1e7b34c8d08117029f5fca39609174a739b77b4ab19c458414687b0a6286f2c3fc1;
localparam logic [DATA_WIDTH-1:0] PAYLOAD_5 = 512'h26f2aa1d9df75409f7ea90cc0b39bd456495fcdab9d1071b98f66328cec0c56cba61172a6df751974c7a1244f5c53d4225b7fb056310ae10a382bd1dc0b9bd45;
localparam logic [DATA_WIDTH-1:0] PAYLOAD_6 = 512'h655c8fe8ed82fea0c6ba5b9344b5556152a98a4148762163a05fb6184092193f865e119bd7a9fdd8533dd2584876afda068af5592bce7b45e2300dadf62fb708;
localparam logic [DATA_WIDTH-1:0] PAYLOAD_7 = 512'h278d0c45104406320049389f98a50f809dacf932f84310b95261ad832c1932fa45fd647127a67b4e23db4f58c3858384cbf89b061f7226473ab35bfb022c300f;
localparam logic [DATA_WIDTH-1:0] PAYLOAD_8 = 512'h0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000acbd1234acbd1234;
/************************************************************************************************************************************************************************************************/
// Control signals
int counter;
int internal_conter;
int tready_flag;
/************************************************************************************************************************************************************************************************/


wire                        clk;
wire [NUM_CMAC_PORT-1:0]    cmac_clk;
wire                        axil_clk;
reg                         aresetn;
wire [31:0]                 shell_rst_done;
wire [31:0]                 user_rst_done;
wire                        rst_done;


reg [DATA_WIDTH-1:0]        s_axis_h2c_tdata;
reg                         s_axis_h2c_tvalid;
wire                        s_axis_h2c_tready;
reg                         s_axis_h2c_tlast;
reg [5:0]                   s_axis_h2c_tuser_mty;
reg [31:0]                  s_axis_h2c_tcrc;
reg [10:0]                  s_axis_h2c_tuser_qid;
reg [2:0]                   s_axis_h2c_tuser_port_id;
reg                         s_axis_h2c_tuser_error;
reg                         s_axis_h2c_tuser_zero_byte;
reg [31:0]                  s_axis_h2c_tuser;

wire [DATA_WIDTH-1:0]       m_axis_tdata;
wire                        m_axis_tvalid;
reg                         m_axis_tready;
wire                        m_axis_tlast;
wire [5:0]                  m_axis_c2h_mty;
wire [31:0]                 m_axis_c2h_tcrc;
wire [10:0]                 m_axis_c2h_ctrl_qid;
wire [2:0]                  m_axis_c2h_ctrl_port_id;
wire [6:0]                  m_axis_c2h_ctrl_ecc;
wire [15:0]                 m_axis_c2h_ctrl_len;
wire                        m_axis_c2h_ctrl_marker;
wire                        m_axis_c2h_ctrl_has_cmpt;

wire [NUM_CMAC_PORT-1:0][DATA_WIDTH-1:0]     m_axis_tx_tdata;
wire [NUM_CMAC_PORT-1:0][(DATA_WIDTH/8)-1:0] m_axis_tx_tkeep;
wire [NUM_CMAC_PORT-1:0]                     m_axis_tx_tuser;
wire [NUM_CMAC_PORT-1:0]                     m_axis_tx_tvalid;
reg  [NUM_CMAC_PORT-1:0]                     m_axis_tx_tready;
wire [NUM_CMAC_PORT-1:0]                     m_axis_tx_tlast;

reg [NUM_CMAC_PORT-1:0][DATA_WIDTH-1:0]      s_axis_tdata;// s_axis_rx_tdata;
reg [NUM_CMAC_PORT-1:0][(DATA_WIDTH/8)-1:0]  s_axis_tkeep;// s_axis_rx_tkeep;
reg [NUM_CMAC_PORT-1:0]                      s_axis_rx_tuser_err;
reg [NUM_CMAC_PORT-1:0]                      s_axis_tvalid;// s_axis_rx_tvalid;
reg [NUM_CMAC_PORT-1:0]                      s_axis_tlast;// s_axis_rx_tlast;


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

logic [NUM_CMAC_PORT-1:0]   cmac_clock;

assign cmac_clock = cmac_clk;
assign rst_done = (&shell_rst_done) & (&user_rst_done);

assign s_axis_h2c_tuser = {{26{1'b0}}, s_axis_h2c_tuser_mty};

initial begin
    s_axis_h2c_tuser_error = 0;
    s_axis_h2c_tuser_zero_byte = 0;
    s_axis_h2c_tuser_port_id = 0;
    s_axis_h2c_tuser_qid = 0;
    s_axis_rx_tuser_err = 0;
    
    axil_awvalid <= 0;
    axil_awaddr <= 0;
    axil_wvalid <= 0;
    axil_wdata <= 0;
    axil_bready <= 0;
    axil_arvalid <= 0;
    axil_araddr <= 0;
    axil_rready <= 0;
    
    internal_conter = 0;
    tready_flag = 0;
    s_axis_tdata <= 512'b0; 
    s_axis_tkeep <= 64'h0;
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    
    aresetn = 1;
    @(clk == 1'b0);
    @(clk == 1'b1);
    aresetn = 0;
    @(posedge clk);
    aresetn = 1;
    @(rst_done == 1'b1);
    while(~s_axis_h2c_tready)
        @(posedge clk);
    repeat(100)
        @(posedge clk);
    
    
    register_setup(32'h00001000, 32'h00000001);
    
    
    
    repeat(4)
    begin
        internal_conter = 0;
        repeat(500)
        begin
            s_axis_tdata <= TARGET_VALUE_1;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_1;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_2;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            internal_conter = internal_conter+1;
            if(internal_conter == 100)
                tready_flag = 1;
            s_axis_tdata <= PAYLOAD_3;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_4;
            s_axis_tkeep <= 64'h00003fffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            @(posedge cmac_clock[0]);
        end
        s_axis_tvalid <= 1'b0;
        repeat(2)
            @(posedge cmac_clock[0]);
        
        internal_conter = 0;
        repeat(500)
        begin
            internal_conter = internal_conter+1;
            if(internal_conter == 30)
                tready_flag = 2;
            s_axis_tdata <= TARGET_VALUE_2;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_1;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_2;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_3;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_4;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_5;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_6;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            @(posedge cmac_clock[0]);
        end
        s_axis_tvalid <= 1'b0;
        repeat(2)
            @(posedge cmac_clock[0]);
        
        internal_conter = 0;
        repeat(500)
        begin
            s_axis_tdata <= TARGET_VALUE_3;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_1;
            s_axis_tkeep <= 64'h00003fffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            @(posedge cmac_clock[0]);
            internal_conter = internal_conter+1;
            if(internal_conter == 350)
                tready_flag = 3;
        end
        s_axis_tvalid <= 1'b0;
        repeat(2)
            @(posedge cmac_clock[0]);
        
        internal_conter = 0;
        repeat(500)
        begin
            s_axis_tdata <= TARGET_VALUE_4;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_1;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_2;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_3;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_4;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_5;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_6;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_7;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            internal_conter = internal_conter+1;
            if(internal_conter == 100)
                tready_flag = 4;
            s_axis_tdata <= PAYLOAD_8;
            s_axis_tkeep <= 64'h0000000000000007;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            @(posedge cmac_clock[0]);
        end
        s_axis_tvalid <= 1'b0;
        repeat(2)
            @(posedge cmac_clock[0]);
        
        internal_conter = 0;
        repeat(500)
        begin
            s_axis_tdata <= TARGET_VALUE_5;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            @(posedge cmac_clock[0]);
            internal_conter = internal_conter+1;
            if(internal_conter == 200)
                tready_flag = 5;
        end
        s_axis_tvalid <= 1'b0;
        repeat(2)
            @(posedge cmac_clock[0]);
        
        internal_conter = 0;
        repeat(500)
        begin
            internal_conter = internal_conter+1;
            s_axis_tdata <= TARGET_VALUE_15;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_7;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            if(internal_conter == 10)
                tready_flag = 3;
            s_axis_tdata <= PAYLOAD_6;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_2;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_4;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_5;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_8;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            if(internal_conter == 400)
                tready_flag = 1;
            s_axis_tdata <= PAYLOAD_1;
            s_axis_tkeep <= 64'h0000000000000007;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= TARGET_VALUE_14;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_3;
            s_axis_tkeep <= 64'h00003fffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= TARGET_VALUE_13;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_6;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_8;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_2;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_1;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_2;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_6;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            @(posedge cmac_clock[0]);
            if(internal_conter == 180)
                tready_flag = 5;
            s_axis_tdata <= TARGET_VALUE_12;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_1;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            if(internal_conter == 300)
                tready_flag = 2;
            s_axis_tdata <= PAYLOAD_3;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_8;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            @(posedge cmac_clock[0]);
            s_axis_tdata <= PAYLOAD_4;
            s_axis_tkeep <= 64'h00003fffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            @(posedge cmac_clock[0]);
        end
        s_axis_tvalid <= 1'b0;
        repeat(2)
            @(posedge cmac_clock[0]);
    end
    
    repeat(1000)
        @(posedge cmac_clock[0]);
    $finish(0);
end


// control processes:
initial begin
    counter = 0;
    repeat(50)
        @(posedge clk);
    while(1) begin
        @(posedge clk);
        if(m_axis_tlast && m_axis_tvalid && m_axis_tready)
            counter = counter + 1;
    end
end


initial begin
    m_axis_tready <= 1'b1;
    repeat(50)
        @(posedge clk);
    while(1) begin
        @(posedge clk);
        case(tready_flag)
            1: begin
                @(negedge clk);
                m_axis_tready <= 1'b0;
                repeat(300)
                    @(posedge clk);
                @(negedge clk);
                m_axis_tready <= 1'b1;
                tready_flag = 0;
            end
            2: begin
                @(negedge clk);
                m_axis_tready <= 1'b0;
                repeat(100)
                    @(posedge clk);
                @(negedge clk);
                m_axis_tready <= 1'b1;
                tready_flag = 0;
            end
            3: begin
                @(negedge clk);
                m_axis_tready <= 1'b0;
                repeat(10)
                    @(posedge clk);
                @(negedge clk);
                m_axis_tready <= 1'b1;
                tready_flag = 0;
            end
            4: begin
                @(negedge clk);
                m_axis_tready <= 1'b0;
                repeat(200)
                    @(posedge clk);
                @(negedge clk);
                m_axis_tready <= 1'b1;
                tready_flag = 0;
            end
            5: begin
                @(negedge clk);
                m_axis_tready <= 1'b0;
                repeat(5)
                    @(posedge clk);
                @(negedge clk);
                m_axis_tready <= 1'b1;
                tready_flag = 0;
            end
        endcase
    end
end



// check correctness
initial begin
    repeat(50)
        @(posedge clk);
    while(1) begin
        if(m_axis_tvalid) begin
            if(m_axis_tdata == TARGET_VALUE_1)
                pkt_type_1();
            else if(m_axis_tdata == TARGET_VALUE_2)
                pkt_type_2();
            else if(m_axis_tdata == TARGET_VALUE_3)
                pkt_type_3;
            else if(m_axis_tdata == TARGET_VALUE_4)
                pkt_type_4;
            else if(m_axis_tdata == TARGET_VALUE_5)
                pkt_type_5;
            else if(m_axis_tdata == TARGET_VALUE_15)
                pkt_type_15;
            else if(m_axis_tdata == TARGET_VALUE_14)
                pkt_type_14;
            else if(m_axis_tdata == TARGET_VALUE_13)
                pkt_type_13;
            else if(m_axis_tdata == TARGET_VALUE_12)
                pkt_type_12;
            else begin
                $display("Unrecognized packet ERROR");
                $finish(0);
            end
        end
        else begin
            @(posedge clk);
        end
    end
end

logic check_again;

task pkt_type_1;
begin
    do begin
        check_again = 0;
        if(m_axis_tdata!=TARGET_VALUE_1)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_1)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_2)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_3)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_4)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b010010)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(!m_axis_tlast)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
end
endtask

task pkt_type_2;
begin
    do begin
        check_again = 0;
        if(m_axis_tdata!=TARGET_VALUE_2)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_1)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_2)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_3)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_4)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_5)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_6)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(!m_axis_tlast)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
end
endtask

task pkt_type_3;
begin
    do begin
        check_again = 0;
        if(m_axis_tdata!=TARGET_VALUE_3)
            begin $display("pkt_type_3 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_3 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_1)
            begin $display("pkt_type_3 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b010010)
            begin $display("pkt_type_3 ERROR"); $finish(0); end
        if(!m_axis_tlast)
            begin $display("pkt_type_3 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
end
endtask

task pkt_type_4;
begin
    do begin
        check_again = 0;
        if(m_axis_tdata!=TARGET_VALUE_4)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_1)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_2)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_3)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_4)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_5)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_6)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_7)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_8)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b111101)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!m_axis_tlast)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
end
endtask

task pkt_type_5;
begin
    do begin
        check_again = 0;
        if(m_axis_tdata!=TARGET_VALUE_5)
            begin $display("pkt_type_5 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_5 ERROR"); $finish(0); end
        if(!m_axis_tlast)
            begin $display("pkt_type_5 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
end
endtask

task pkt_type_15;
begin
    do begin
        check_again = 0;
        if(m_axis_tdata!=TARGET_VALUE_15)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_7)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_6)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_2)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_4)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_5)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_8)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_1)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b111101)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!m_axis_tlast)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
end
endtask

task pkt_type_14;
begin
    do begin
        check_again = 0;
        if(m_axis_tdata!=TARGET_VALUE_14)
            begin $display("pkt_type_14 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_14 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_3)
            begin $display("pkt_type_14 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b010010)
            begin $display("pkt_type_14 ERROR"); $finish(0); end
        if(!m_axis_tlast)
            begin $display("pkt_type_14 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
end
endtask

task pkt_type_13;
begin
    do begin
        check_again = 0;
        if(m_axis_tdata!=TARGET_VALUE_13)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_6)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_8)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_2)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_1)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_2)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_6)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(!m_axis_tlast)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
end
endtask

task pkt_type_12;
begin
    do begin
        check_again = 0;
        if(m_axis_tdata!=TARGET_VALUE_12)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_1)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_3)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_8)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b000000)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tdata!=PAYLOAD_4)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(m_axis_c2h_mty!=6'b010010)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(!m_axis_tlast)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
end
endtask



// open nic registers initialization:
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
	.axis_aclk(clk),                // axis qdma clk
	.cmac_clk(cmac_clk),            // axis cmac clk
	.axil_aclk(axil_clk),           // axil clk
	.powerup_rstn(aresetn),
	.shell_rst_done(shell_rst_done),
	.user_rst_done(user_rst_done),

	// input Slave AXI Stream
	.s_axis_qdma_h2c_sim_tdata(s_axis_h2c_tdata),
	.s_axis_qdma_h2c_sim_tvalid(s_axis_h2c_tvalid),
	.s_axis_qdma_h2c_sim_tready(s_axis_h2c_tready),
	.s_axis_qdma_h2c_sim_tlast(s_axis_h2c_tlast),
	.s_axis_qdma_h2c_sim_tuser_err(s_axis_h2c_tuser_error),
	.s_axis_qdma_h2c_sim_tuser_zero_byte(s_axis_h2c_tuser_zero_byte),
	.s_axis_qdma_h2c_sim_tuser_mty(s_axis_h2c_tuser_mty),
	.s_axis_qdma_h2c_sim_tuser_mdata(s_axis_h2c_tuser),
	.s_axis_qdma_h2c_sim_tuser_qid(s_axis_h2c_tuser_qid),
	.s_axis_qdma_h2c_sim_tuser_port_id(s_axis_h2c_tuser_port_id),
	.s_axis_qdma_h2c_sim_tcrc(s_axis_h2c_tcrc),
	
	.m_axis_qdma_c2h_sim_tdata(m_axis_tdata),
	.m_axis_qdma_c2h_sim_tvalid(m_axis_tvalid),
	.m_axis_qdma_c2h_sim_tready(m_axis_tready),
	.m_axis_qdma_c2h_sim_tlast(m_axis_tlast),
	.m_axis_qdma_c2h_sim_ctrl_marker(m_axis_c2h_ctrl_marker),
	.m_axis_qdma_c2h_sim_ctrl_port_id(m_axis_c2h_ctrl_port_id),
	.m_axis_qdma_c2h_sim_ctrl_ecc(m_axis_c2h_ctrl_ecc),
	.m_axis_qdma_c2h_sim_ctrl_len(m_axis_c2h_ctrl_len),
	.m_axis_qdma_c2h_sim_ctrl_qid(m_axis_c2h_ctrl_qid),
	.m_axis_qdma_c2h_sim_ctrl_has_cmpt(m_axis_c2h_ctrl_has_cmpt),
	.m_axis_qdma_c2h_sim_mty(m_axis_c2h_mty),
	.m_axis_qdma_c2h_sim_tcrc(m_axis_c2h_tcrc),

	// output Master AXI Stream
	.m_axis_cmac_tx_sim_tdata(m_axis_tx_tdata),
	.m_axis_cmac_tx_sim_tkeep(m_axis_tx_tkeep),
	.m_axis_cmac_tx_sim_tvalid(m_axis_tx_tvalid),
	.m_axis_cmac_tx_sim_tuser_err(m_axis_tx_tuser),
	.m_axis_cmac_tx_sim_tready(m_axis_tx_tready),
	.m_axis_cmac_tx_sim_tlast(m_axis_tx_tlast),
	
	.s_axis_cmac_rx_sim_tdata(s_axis_tdata),
	.s_axis_cmac_rx_sim_tkeep(s_axis_tkeep),
	.s_axis_cmac_rx_sim_tvalid(s_axis_tvalid),
	.s_axis_cmac_rx_sim_tuser_err(s_axis_rx_tuser_err),
	.s_axis_cmac_rx_sim_tlast(s_axis_tlast),
	
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
