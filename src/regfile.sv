module regfile (
    input clk_i,
    input rst_ni,

    input        [ 4:0] rs_addr_a_i,
    output logic [31:0] rs_data_a_o,

    input        [ 4:0] rs_addr_b_i,
    output logic [31:0] rs_data_b_o,

    input        [ 4:0] rd_addr_i,
    input        [31:0] rd_data_i,

    input               rd_we_i

);
    logic [31:0] reg_array [31:0];

    assign rs_data_a_o = reg_array[rs_addr_a_i];
    assign rs_data_b_o = reg_array[rs_addr_b_i];

    assign reg_array[0] = 32'h0;

    for (genvar i = 1; i < 32; i++) begin
        always_ff @(posedge clk_i) begin : regfile_reset
            if ( !rst_ni ) begin
                reg_array[i] <= 32'h0;
            end else if ( rd_we_i && ( rd_addr_i == 5'(i) ) ) begin
                reg_array[i] <= rd_data_i;
            end
        end
    end
endmodule