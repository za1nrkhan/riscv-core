// TODO
// 1. Should be able to track how many cycles does reset take
// 2. Value of address must be cross checked with simluation time

module counter_tb;
    logic        clk_i;
    logic        rst_ni;
    logic [31:0] addr_o;

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
        #100;
        rst_ni = 0;
        #10;
        rst_ni = 1;
    end

    counter dut(
        .clk_i  (  clk_i ),
        .rst_ni ( rst_ni ),
        .addr_o ( addr_o )
    );

    initial begin
        wait( addr_o == 32'h00 );
        wait( addr_o == 32'h04 );
        wait( !rst_ni );
        wait( addr_o == 32'h00 );
        wait( !rst_ni );
        wait( addr_o == 32'h00 );
        wait( addr_o == 32'h08 );
        wait( addr_o == 32'h0C );
        wait( addr_o == 32'h10 );
        wait( addr_o == 32'h14 );
        wait( addr_o == 32'h18 );
        wait( addr_o == 32'hFFC );
        $display( "TEST PASSED" );
	    $finish;
    end

    always @( rst_ni ) begin
        #1 $display( "time=%0d ns address=%d reset=%b",
                        $time-1,
                        addr_o,
                        rst_ni );
        
    end

    initial begin
        repeat (300) begin
            repeat (1000) @(posedge clk_i);
		end
        $display( "TEST FAILED" );
    end
endmodule