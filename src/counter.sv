module counter (
    input               clk_i,
    input               rst_ni,

    output logic [31:0] addr_o
);

    always @(posedge clk_i) begin
        if ( !rst_ni ) begin
            addr_o <= 32'b0;
        end else begin
            addr_o <= addr_o + 'h4;
        end 
    end

endmodule