module rv_top_tb;
    logic clk_i;
    logic rst_ni;

    logic [31:0] instr_i;
    logic [31:0] addr_o;
    
    logic [31:0] rdata;
    logic        data_we;
    logic [31:0] wdata;
    logic [31:0] data_addr;

    always #1 clk_i <= ( clk_i === 1'b0 );
    
    initial begin
        clk_i = 0;
        rst_ni = 0;
        #10;
        rst_ni = 1;
        #100;
        rst_ni = 0;
        #2;
        rst_ni = 1;
        #30;
        $finish;
    end

    rv_top dut(
        .clk_i   (   clk_i ),
        .rst_ni  (  rst_ni ),
        .addr_o  (  addr_o ),
        .instr_i ( instr_i ),
        .data_i      (     rdata ),
        .data_we_o   (   data_we ),
        .data_o      (     wdata ),
        .data_addr_o ( data_addr )
    );

    logic [3:0] WE;
    assign WE = {4{data_we}};

    DFFRAM u_iccm(
        .CLK (   clk_i      ),
        .WE  (    4'b0      ),
        .EN  (    1'b1      ),
        .Di  (   32'h0      ),
        .Do  ( instr_i      ),
        .A   (  addr_o[9:2] )
    );
    
    DFFRAM u_dccm(
        .CLK (     clk_i      ),
        .WE  (        WE      ),
        .EN  (      1'b1      ),
        .Di  (     wdata      ),
        .Do  (     rdata      ),
        .A   ( data_addr[9:2] )
    );

    initial begin
        $readmemh("program.hex", u_iccm.mem);
    end
    
endmodule