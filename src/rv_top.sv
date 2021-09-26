module rv_top (
    input               clk_i,
    input               rst_ni,

    output logic [31:0] addr_o,
    input        [31:0] instr_i
);
    import rv_pkg::*;
    
    alu_operations_e alu_ctrl;
    
    logic        alu_zero;

    logic [ 4:0] rs_addr_a;
    logic [31:0] rs_data_a;

    logic [ 4:0] rs_addr_b;
    logic [31:0] rs_data_b;

    logic [ 4:0] rd_addr;
    logic [31:0] rd_data;

    logic        rd_we;

    logic        operand_b_sel;
    logic [31:0] operand_b;
    logic [31:0] rs_imm_b;
    logic [31:0] rd_imm;

    assign operand_b = operand_b_sel ? rs_imm_b : rs_data_b;
    
    logic        alu_dst;
    logic [31:0] alu_result;

    assign rd_data = alu_dst ? rd_imm : alu_result;
    
    logic [31:0] next_addr;
    logic        branch_instr;
    logic [31:0] branch_target;
    logic        test_next_addr;

    assign test_next_addr = branch_instr & alu_zero;
    assign next_addr = test_next_addr ? (addr_o + branch_target) : (addr_o + 'h4);
    
    counter u_counter(
        .clk_i       (     clk_i ),
        .rst_ni      (    rst_ni ),
        .next_addr_i ( next_addr ),
        .addr_o      (    addr_o )
    );

    rv_decoder u_decoder(
        .instr_i     (       instr_i ),
        .rs_addr_a_o (     rs_addr_a ),
        .rs_addr_b_o (     rs_addr_b ),
        .rd_addr_o   (       rd_addr ),
        .rs_imm_b_o  (      rs_imm_b ),
        .rd_imm_o    (        rd_imm ),
        .alu_src_o   ( operand_b_sel ),
        .alu_ctrl_o  (      alu_ctrl ),
        .rd_we_o     (         rd_we ),
        .branch_target_o ( branch_target ),
        .branch_o    (  branch_instr ),
        .alu_dst_o   (       alu_dst )
    );

    rv_alu u_alu (
        .alu_ctrl_i  (   alu_ctrl ),
        .operand_a_i (  rs_data_a ),
        .operand_b_i (  operand_b ),
        .result_o    ( alu_result ),
        .zero_o      (   alu_zero )
    );

    regfile u_regfile(
        .clk_i       (     clk_i ),
        .rst_ni      (    rst_ni ),
        .rs_addr_a_i ( rs_addr_a ),
        .rs_data_a_o ( rs_data_a ),
        .rs_addr_b_i ( rs_addr_b ),
        .rs_data_b_o ( rs_data_b ),
        .rd_addr_i   (   rd_addr ),
        .rd_data_i   (   rd_data ),
        .rd_we_i     (     rd_we )
    );

endmodule