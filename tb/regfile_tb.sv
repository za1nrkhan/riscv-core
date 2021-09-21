module regfile_tb;
    logic        clk_i;
    logic        rst_ni;

    logic [ 4:0] rs_addr_a_i;
    logic [31:0] rs_data_a_o;

    logic [ 4:0] rs_addr_b_i;
    logic [31:0] rs_data_b_o;

    logic [ 4:0] rd_addr_i;
    logic [31:0] rd_data_i;

    logic        rd_we_i;

    regfile dut(
        .clk_i       (       clk_i ),
        .rst_ni      (      rst_ni ),
        .rs_addr_a_i ( rs_addr_a_i ),
        .rs_data_a_o ( rs_data_a_o ),
        .rs_addr_b_i ( rs_addr_b_i ),
        .rs_data_b_o ( rs_data_b_o ),
        .rd_addr_i   (   rd_addr_i ),
        .rd_data_i   (   rd_data_i ),
        .rd_we_i     (     rd_we_i )
    );

    always #1 clk_i <= ( clk_i === 1'b0 );

    initial begin
        clk_i = 0;
        rst_ni = 0;
        #10;
        rst_ni = 1;
        rd_we_i = 1;
        load_regfile(4); 
        rd_we_i = 0;
        rs_addr_a_i = 5'd0; rs_addr_b_i = 5'd16; @(posedge clk_i); expect_values( 5'd0, 5'd12);
        #1 ;
        $display ( "TEST PASSED" ) ;
        $finish;
    end

    task load_regfile(
        input [4:0] start_reg
    ); 
        for (int i = start_reg; i<32 ; i++) begin
            @(posedge clk_i) begin
                rd_addr_i = i;
                rd_data_i = (i - start_reg);
            end
        end
    endtask

    task expect_values (
        input [31:0] data_a,
        input [31:0] data_b
    );
        begin
            $display( "time=%0d ns addr_a=%d data_a=%d addr_b=%d data_b=%d",
                        $time, 
                        rs_addr_a_i,
                        rs_data_a_o,
                        rs_addr_b_i,
                        rs_data_b_o);
            if ((rs_data_a_o !== data_a) || (rs_data_b_o !== data_b)) begin
                $display ( "WANT:             data_a=%d data_b=%d", data_a, data_b );
                $display ( "TEST FAILED" ) ;
                $finish;
            end
        end
    endtask





endmodule