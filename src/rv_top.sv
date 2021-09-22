module rv_top (
    input               clk_i,
    input               rst_ni,

    output logic [31:0] addr_o,
    input        [31:0] instr_i
);
    import rv_pkg::*;
    logic [ 4:0] rs_addr_a_i;
    logic [31:0] rs_data_a_o;

    logic [ 4:0] rs_addr_b_i;
    logic [31:0] rs_data_b_o;

    logic [ 4:0] rd_addr_i;
    logic [31:0] rd_data_i;

    logic        rd_we_i;

    assign rs_addr_a_i = instr_i[19:15];
    assign rs_addr_b_i = instr_i[24:20];

    counter u_counter(
        .clk_i  (  clk_i ),
        .rst_ni ( rst_ni ),
        .addr_o ( addr_o )
    );

    logic [31:0]     result_o;
    logic            zero_o;

    rv_alu u_alu (
        .alu_ctrl_i  (      OP_ADD ),
        .operand_a_i ( rs_data_a_o ), // operand_a_i
        .operand_b_i ( rs_data_b_o ), // operand_b_i
        .result_o    (    result_o ),
        .zero_o      (      zero_o )
    );

    regfile u_regfile(
        .clk_i       (       clk_i ),
        .rst_ni      (      rst_ni ),
        .rs_addr_a_i ( rs_addr_a_i ),
        .rs_data_a_o ( rs_data_a_o ),
        .rs_addr_b_i ( rs_addr_b_i ),
        .rs_data_b_o ( rs_data_b_o ),
        .rd_addr_i   (   rd_addr_i ),
        .rd_data_i   (   rd_data_i ),
        .rd_we_i     (        1'b0 )
    );

    

endmodule