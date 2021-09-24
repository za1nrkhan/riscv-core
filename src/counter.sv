module counter (
    input               clk_i,
    input               rst_ni,
    
    input        [31:0] next_addr_i,
    output logic [31:0] addr_o
);

    always @(posedge clk_i) begin
        if ( !rst_ni ) begin
            addr_o <= 32'b0;
        end else begin
            addr_o <= next_addr_i;
        end 
    end

endmodule