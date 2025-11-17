
`timescale 1ns / 1ps

module tb_rmt_wrapper_tready #(
    // Slave AXI parameters
    parameter C_S_AXI_DATA_WIDTH = 32,
    parameter C_S_AXI_ADDR_WIDTH = 12,
    parameter C_BASEADDR = 32'h80000000,
    // AXI Stream parameters
    // Slave
    parameter C_S_AXIS_DATA_WIDTH = 512,
    parameter C_S_AXIS_TUSER_WIDTH = 48,
    // Master
    parameter C_M_AXIS_DATA_WIDTH = 512,
    // self-defined
    parameter PHV_ADDR_WIDTH = 4
)();


// Output validation
localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_1 = 512'h000000000100000002000000030000001a00000000004c4d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_2 = 512'h000000000500000002000000030000000d0000000000594d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_3 = 512'h000000000200000002000000040000001a0000000000abcdef000010d204dededede8f8f8f8f22de1140000001002e0000450008050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_4 = 512'h000000000600000002000000040000000d0000000000444444000010d204dededede7f7f7f7f22de1140000001002e0000450008050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_5 = 512'h000000000100000003000000040000001a00000000004c4d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_6 = 512'h00000000225843020d21021d2f79451f1a00000000006ff66f000010d204dededede5ee5e5e522de1140000001002e0000450008050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_7 = 512'h000000000200000000000000020000001a0000000000cbdfef000010d204dededededadadada22de1140000001002e0000450008050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_8 = 512'h000000000700000000000000070000000d0000000000333333000010d204dededede5b5b5b5b22de1140000001002e0000450008050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_9 = 512'h000000000000000005000000050000001a00000000004c4d1b000010d204dededede6f6f6f8f22de1140000001332e0000450008151413121110090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_10 =512'h000000000a00000003000000070000000d0000000000594d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_11 =512'h000000000400000003000000070000001a0000000000abcdef000010d204dededede8f8f8f8f22de1140000001002e0000450008050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_12 =512'h000000000b0000000a000000010000000d0000000000444444000010d204dededede7f7f7f7f22de1140000001002e0000450008050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_13 =512'h000000000a000000010000000b0000001a00000000004c4d1a000010d204dededede6f6f6f6f22de1140000001002e0000450008050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_14 =512'h000000000000000000000000000000001a0000000000cbdfef000010d204dededededadadada22de1140000001002e0000450008050403020100090000000000;

localparam logic [C_S_AXIS_DATA_WIDTH-1:0] TARGET_VALUE_15 =512'h000000000f000000000000000f0000000d0000000000333333000010d204dededede5b5b5b5b22de1140000001002e0000450008050403020100090000000000;

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

reg [C_S_AXIS_DATA_WIDTH-1:0]        s_axis_tdata;
reg [((C_S_AXIS_DATA_WIDTH/8))-1:0]    s_axis_tkeep;
reg [C_S_AXIS_TUSER_WIDTH-1:0]        s_axis_tuser;
reg                                    s_axis_tvalid;
wire                                s_axis_tready;
reg                                    s_axis_tlast;

wire [C_S_AXIS_DATA_WIDTH-1:0]            m_axis_tdata;
wire [((C_S_AXIS_DATA_WIDTH/8))-1:0]    m_axis_tkeep;
wire [C_S_AXIS_TUSER_WIDTH-1:0]            m_axis_tuser;
wire                                    m_axis_tvalid;
reg                                        m_axis_tready;
wire                                    m_axis_tlast;

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


int counter;
int internal_conter;
int tready_flag;
initial begin
    counter = 0;
    #(70* CYCLE)
    while(1) begin
        @(negedge m_axis_tlast);
        counter = counter + 1;
    end
end

initial begin
    counter = 0;
    m_axis_tready <= 1'b1;
    #(70* CYCLE)
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

initial begin
    #(40* CYCLE)
    internal_conter = 0;
    tready_flag = 0;
    s_axis_tdata <= 512'b0; 
    s_axis_tkeep <= 64'h0;
    s_axis_tuser <= 128'h0;
    s_axis_tvalid <= 1'b0;
    s_axis_tlast <= 1'b0;
    #(3*CYCLE)
    while(~s_axis_tready)
        #(CYCLE);
    #(30*CYCLE)
    while(~s_axis_tready)
        @(posedge clk);
    
    // finished configuration, starting throughput tests:
    repeat(4)
    begin
        internal_conter = 0;
        repeat(500)
        begin
            s_axis_tuser <= 128'hABC;
            s_axis_tdata <= TARGET_VALUE_1;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_1;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_2;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            internal_conter = internal_conter+1;
            if(internal_conter == 100)
                tready_flag = 1;
            s_axis_tdata <= PAYLOAD_3;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_4;
            s_axis_tkeep <= 64'h00003fffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
        end
        s_axis_tvalid <= 1'b0;
        repeat(2)
            @(posedge clk);
        
        internal_conter = 0;
        repeat(500)
        begin
            internal_conter = internal_conter+1;
            if(internal_conter == 30)
                tready_flag = 2;
            s_axis_tuser <= 128'hDEF;
            s_axis_tdata <= TARGET_VALUE_2;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_1;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_2;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_3;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_4;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_5;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_6;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
        end
        s_axis_tvalid <= 1'b0;
        repeat(2)
            @(posedge clk);
        
        internal_conter = 0;
        repeat(500)
        begin
            s_axis_tuser <= 128'h123;
            s_axis_tdata <= TARGET_VALUE_3;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_1;
            s_axis_tkeep <= 64'h00003fffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            internal_conter = internal_conter+1;
            if(internal_conter == 350)
                tready_flag = 3;
        end
        s_axis_tvalid <= 1'b0;
        repeat(2)
            @(posedge clk);
        
        internal_conter = 0;
        repeat(500)
        begin
            s_axis_tuser <= 128'h456;
            s_axis_tdata <= TARGET_VALUE_4;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_1;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_2;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_3;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_4;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_5;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_6;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_7;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            internal_conter = internal_conter+1;
            if(internal_conter == 100)
                tready_flag = 4;
            s_axis_tdata <= PAYLOAD_8;
            s_axis_tkeep <= 64'h0000000000000005;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
        end
        s_axis_tvalid <= 1'b0;
        repeat(2)
            @(posedge clk);
        
        internal_conter = 0;
        repeat(500)
        begin
            s_axis_tuser <= 128'hfff;
            s_axis_tdata <= TARGET_VALUE_5;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            internal_conter = internal_conter+1;
            if(internal_conter == 200)
                tready_flag = 5;
        end
        s_axis_tvalid <= 1'b0;
        repeat(2)
            @(posedge clk);
        
        internal_conter = 0;
        repeat(500)
        begin
            internal_conter = internal_conter+1;
            s_axis_tuser <= 128'h246;
            s_axis_tdata <= TARGET_VALUE_15;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_7;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            if(internal_conter == 10)
                tready_flag = 3;
            s_axis_tdata <= PAYLOAD_6;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_2;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_4;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_5;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_8;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            if(internal_conter == 400)
                tready_flag = 1;
            s_axis_tdata <= PAYLOAD_1;
            s_axis_tkeep <= 64'h0000000000000005;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tuser <= 128'h357;
            s_axis_tdata <= TARGET_VALUE_14;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_3;
            s_axis_tkeep <= 64'h00003fffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tuser <= 128'hACE;
            s_axis_tdata <= TARGET_VALUE_13;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_6;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_8;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_2;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_1;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_2;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_6;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            if(internal_conter == 180)
                tready_flag = 5;
            s_axis_tuser <= 128'h013;
            s_axis_tdata <= TARGET_VALUE_12;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_1;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            if(internal_conter == 300)
                tready_flag = 2;
            s_axis_tdata <= PAYLOAD_3;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_8;
            s_axis_tkeep <= 64'hffffffffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b0;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
            s_axis_tdata <= PAYLOAD_4;
            s_axis_tkeep <= 64'h00003fffffffffff;
            s_axis_tvalid <= 1'b1;
            s_axis_tlast <= 1'b1;
            do begin
                @(posedge clk);
            end while(s_axis_tready!=1);
        end
        s_axis_tvalid <= 1'b0;
        repeat(2)
            @(posedge clk);
    end
    
    repeat(1000)
        @(posedge clk);
    $finish(0);
end

// check correctness
initial begin
    #(70* CYCLE)
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
        if(m_axis_tuser!=128'hABC)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(m_axis_tdata!=TARGET_VALUE_1)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hABC)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_1)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hABC)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_2)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hABC)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_3)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hABC)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_4)
            begin $display("pkt_type_1 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'h00003fffffffffff)
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
        if(m_axis_tuser!=128'hDEF)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_tdata!=TARGET_VALUE_2)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hDEF)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_1)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hDEF)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_2)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hDEF)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_3)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hDEF)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_4)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hDEF)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_5)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hDEF)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_6)
            begin $display("pkt_type_2 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
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
        if(m_axis_tuser!=128'h123)
            begin $display("pkt_type_3 ERROR"); $finish(0); end
        if(m_axis_tdata!=TARGET_VALUE_3)
            begin $display("pkt_type_3 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_3 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h123)
            begin $display("pkt_type_3 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_1)
            begin $display("pkt_type_3 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'h00003fffffffffff)
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
        if(m_axis_tuser!=128'h456)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tdata!=TARGET_VALUE_4)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h456)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_1)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h456)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_2)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h456)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_3)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h456)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_4)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h456)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_5)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h456)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_6)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h456)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_7)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h456)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_8)
            begin $display("pkt_type_4 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'h0000000000000005)
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
        if(m_axis_tuser!=128'hfff)
            begin $display("pkt_type_5 ERROR"); $finish(0); end
        if(m_axis_tdata!=TARGET_VALUE_5)
            begin $display("pkt_type_5 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
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
        if(m_axis_tuser!=128'h246)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tdata!=TARGET_VALUE_15)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h246)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_7)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h246)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_6)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h246)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_2)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h246)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_4)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h246)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_5)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h246)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_8)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h246)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_1)
            begin $display("pkt_type_15 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'h0000000000000005)
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
        if(m_axis_tuser!=128'h357)
            begin $display("pkt_type_14 ERROR"); $finish(0); end
        if(m_axis_tdata!=TARGET_VALUE_14)
            begin $display("pkt_type_14 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_14 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h357)
            begin $display("pkt_type_14 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_3)
            begin $display("pkt_type_14 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'h00003fffffffffff)
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
        if(m_axis_tuser!=128'hACE)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_tdata!=TARGET_VALUE_13)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hACE)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_6)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hACE)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_8)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hACE)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_2)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hACE)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_1)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hACE)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_2)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'hACE)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_6)
            begin $display("pkt_type_13 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
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
        if(m_axis_tuser!=128'h013)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(m_axis_tdata!=TARGET_VALUE_12)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h013)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_1)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h013)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_3)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h013)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_8)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'hffffffffffffffff)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
    do begin
        check_again = 0;
        if(m_axis_tuser!=128'h013)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(m_axis_tdata!=PAYLOAD_4)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(m_axis_tkeep!=64'h00003fffffffffff)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(!m_axis_tlast)
            begin $display("pkt_type_12 ERROR"); $finish(0); end
        if(!(m_axis_tvalid==1 && m_axis_tready==1))
            check_again = 1;
        @(posedge clk);
    end while(check_again);
end
endtask


rmt_wrapper #(
    .C_S_AXIS_DATA_WIDTH(C_S_AXIS_DATA_WIDTH),
    .C_S_AXIS_TUSER_WIDTH(C_S_AXIS_TUSER_WIDTH)
)rmt_wrapper_ins
(
    .clk(clk),        // axis clk
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
